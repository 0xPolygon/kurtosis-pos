// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import {sPOLController} from "../../src/sPOLController.sol";

/// @notice Devnet validator setup for sPOLController.
///
/// VALIDATOR_COUNT is baked at devnet-launch time by the kurtosis starlark
/// flow (this file is a Mustache template — `{{.validator_count}}` is replaced
/// before the .sol is dropped into spol-contracts/script/kurtosis/), so the
/// script always matches the actual number of validators staked on-chain.
/// Pos-contracts assigns ids sequentially starting at 1, so iterating 1..N
/// matches on-chain state. Distributes deposit shares equally; any remainder
/// from integer division goes to validator 1 so shares always sum to 100.
///
/// Uses dynamic ids rather than the mainnet/testnet ids (188, 92) hardcoded
/// in upstream's SetupInitialValidators script.
///
/// We intentionally do NOT call buySPOL here. Internally
/// sPOLController._buySharesFromValidator calls
/// validatorContract.restakeAndStakePOL(_amount), but the pos-contracts
/// ValidatorShare bundled with the kurtosis devnet has restakePOL() and
/// buyVoucherPOL(...) as separate functions — not the fused restakeAndStakePOL
/// that sPOL was built against. Calling buySPOL would revert with an unknown
/// selector. The e2e integration tests exercise buySPOL against environments
/// that ship the matching ValidatorShare.
contract SetupInitialValidators is Script {
    uint256 constant VALIDATOR_COUNT = {{.validator_count}};

    function run() public {
        require(VALIDATOR_COUNT > 0, "VALIDATOR_COUNT must be > 0");
        require(VALIDATOR_COUNT <= 100, "VALIDATOR_COUNT must be <= 100 (uint8 share constraint)");

        string memory json = vm.readFile("script/deployment.json");

        address controllerAddr = vm.parseJsonAddress(json, ".sPOL_L1.sPOLControllerProxy");
        sPOLController controller = sPOLController(controllerAddr);

        uint256 pk = vm.envUint("DEPLOYER_PRIVATE_KEY");

        vm.startBroadcast(pk);

        // 1. Add every kurtosis-registered validator (ids are 1..N).
        uint16[] memory valIds = new uint16[](VALIDATOR_COUNT);
        for (uint256 i = 0; i < VALIDATOR_COUNT; i++) {
            uint16 id = uint16(i + 1);
            controller.addValidator(id);
            valIds[i] = id;
            console.log("Validator added:", id);
        }

        // 2. Distribute shares equally across validators. Remainder from integer
        //    division goes to validator 1 so the shares always sum to 100.
        uint8 baseShare = uint8(100 / VALIDATOR_COUNT);
        uint8 remainder = uint8(100 - (baseShare * VALIDATOR_COUNT));
        uint8[] memory shares = new uint8[](VALIDATOR_COUNT);
        shares[0] = baseShare + remainder;
        for (uint256 i = 1; i < VALIDATOR_COUNT; i++) {
            shares[i] = baseShare;
        }
        controller.updateValidatorTargetShare(valIds, shares);
        console.log("Deposit shares set across", VALIDATOR_COUNT, "validators");

        vm.stopBroadcast();

        // Verify state.
        for (uint256 i = 0; i < VALIDATOR_COUNT; i++) {
            require(controller.activeValidators(i) == valIds[i], "Validator order mismatch");
        }
        console.log("Kurtosis devnet validator setup complete!");
        console.log("Note: buySPOL bootstrap skipped due to kurtosis pos-contracts compatibility.");
        console.log("The e2e tests invoke buySPOL directly.");
    }
}
