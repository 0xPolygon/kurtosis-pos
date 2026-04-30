// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {sPOLController} from "../../src/sPOLController.sol";
import {sPOL} from "../../src/sPOL.sol";

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
/// Mirrors mainnet's SetupInitialValidators by buying an initial sPOL deposit
/// and locking it at 0xdead — the e2e tests invoke buySPOL on top of this
/// bootstrap, so the controller is in a known non-zero state when they run.
/// This works because upgrade-validator-share.sh has already pointed
/// Registry.contractMap['validatorShare'] at the pos-contracts/main impl that
/// ships restakeAndStakePOL(uint256). Without that upstream upgrade step,
/// buySPOL would revert with empty data deep inside the delegation chain.
contract SetupInitialValidators is Script {
    uint256 constant VALIDATOR_COUNT = {{.validator_count}};
    uint256 constant INITIAL_DEPOSIT = 100 ether;
    address constant DEAD = address(0xdead);

    function run() public {
        require(VALIDATOR_COUNT > 0, "VALIDATOR_COUNT must be > 0");
        require(VALIDATOR_COUNT <= 100, "VALIDATOR_COUNT must be <= 100 (uint8 share constraint)");

        string memory json = vm.readFile("script/deployment.json");

        address controllerAddr = vm.parseJsonAddress(json, ".sPOL_L1.sPOLControllerProxy");
        address spolAddr = vm.parseJsonAddress(json, ".sPOL_L1.sPOLProxy");
        sPOLController controller = sPOLController(controllerAddr);
        sPOL spolToken = sPOL(spolAddr);
        // polToken on the controller is an `ERC20Permit` immutable; the
        // bootstrap only needs the IERC20 surface (approve + transfer).
        IERC20 polToken = IERC20(address(controller.polToken()));
        require(address(polToken) != address(0), "polToken not set on controller");

        uint256 pk = vm.envUint("DEPLOYER_PRIVATE_KEY");
        address deployer = vm.addr(pk);

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

        // 3. Bootstrap deposit so the controller has non-zero state when the
        //    e2e tests start. Mirrors mainnet's bootstrap.
        polToken.approve(controllerAddr, INITIAL_DEPOSIT);
        controller.buySPOL(INITIAL_DEPOSIT);
        uint256 spolBalance = spolToken.balanceOf(deployer);
        console.log("sPOL minted to deployer:", spolBalance);

        // 4. Lock the bootstrap sPOL at 0xdead — it is not meant to be redeemed.
        spolToken.transfer(DEAD, spolBalance);
        console.log("sPOL locked at 0xdead:", spolBalance);

        vm.stopBroadcast();

        // Verify state.
        for (uint256 i = 0; i < VALIDATOR_COUNT; i++) {
            require(controller.activeValidators(i) == valIds[i], "Validator order mismatch");
        }
        require(spolToken.balanceOf(DEAD) > 0, "No sPOL at dead address");
        require(spolToken.balanceOf(deployer) == 0, "Deployer should hold 0 sPOL after lock");
        console.log("Kurtosis devnet validator setup complete!");
    }
}
