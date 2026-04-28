// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import {sPOLController} from "../../src/sPOLController.sol";

/// @notice Kurtosis devnet validator setup for sPOLController.
///
/// Registers every validator the kurtosis PoS deployment staked, IDs 1..N,
/// where N is taken from the VALIDATOR_COUNT env var. Pos-contracts assigns IDs
/// sequentially starting at 1, so this matches the on-chain state exactly.
/// Distributes deposit shares equally; any remainder from integer division
/// goes to validator 1.
///
/// Uses dynamic IDs rather than the mainnet/testnet IDs (188, 92) hardcoded
/// in upstream's SetupInitialValidators script.
///
/// We intentionally do NOT call buySPOL here because the delegationDepositPOL
/// flow in the kurtosis PoS contracts is incompatible with the sPOL staking
/// path (the kurtosis devnet uses an older variant of the staking contracts).
/// The e2e integration test exercises buySPOL directly against live on-chain state.
contract SetupInitialValidatorsKurtosis is Script {
    function run() public {
        string memory json = vm.readFile("script/deployment.json");

        address controllerAddr = vm.parseJsonAddress(json, ".sPOL_L1.sPOLControllerProxy");
        sPOLController controller = sPOLController(controllerAddr);

        uint256 validatorCount = vm.envUint("VALIDATOR_COUNT");
        require(validatorCount > 0, "VALIDATOR_COUNT must be > 0");
        require(validatorCount <= 100, "VALIDATOR_COUNT must be <= 100 (uint8 share constraint)");

        uint256 pk = vm.envUint("DEPLOYER_PRIVATE_KEY");

        vm.startBroadcast(pk);

        // 1. Add every kurtosis-registered validator (IDs are 1..N).
        uint16[] memory valIds = new uint16[](validatorCount);
        for (uint256 i = 0; i < validatorCount; i++) {
            uint16 id = uint16(i + 1);
            controller.addValidator(id);
            valIds[i] = id;
            console.log("Validator added:", id);
        }

        // 2. Distribute shares equally across validators. Remainder from integer
        //    division goes to validator 1 so the shares always sum to 100.
        uint8 baseShare = uint8(100 / validatorCount);
        uint8 remainder = uint8(100 - (baseShare * validatorCount));
        uint8[] memory shares = new uint8[](validatorCount);
        shares[0] = baseShare + remainder;
        for (uint256 i = 1; i < validatorCount; i++) {
            shares[i] = baseShare;
        }
        controller.updateValidatorTargetShare(valIds, shares);
        console.log("Deposit shares set across", validatorCount, "validators");

        vm.stopBroadcast();

        // Verify state.
        for (uint256 i = 0; i < validatorCount; i++) {
            require(controller.activeValidators(i) == valIds[i], "Validator order mismatch");
        }
        console.log("Kurtosis devnet validator setup complete!");
        console.log("Note: buySPOL bootstrap skipped due to kurtosis pos-contracts compatibility.");
        console.log("The e2e tests invoke buySPOL directly.");
    }
}
