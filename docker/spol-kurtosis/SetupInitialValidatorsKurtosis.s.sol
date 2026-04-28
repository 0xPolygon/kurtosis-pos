// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import {sPOLController} from "../../src/sPOLController.sol";

/// @notice Kurtosis devnet validator setup for sPOLController.
///
/// Uses validator ID 1 (the single validator registered in the kurtosis devnet)
/// rather than the mainnet/testnet IDs (188, 92) hardcoded in the production
/// SetupInitialValidators script.
///
/// We intentionally do NOT call buySPOL here because the delegationDepositPOL
/// flow in the kurtosis PoS contracts is incompatible with the sPOL staking
/// path (the kurtosis devnet uses an older variant of the staking contracts).
/// The e2e integration test exercises buySPOL directly against live on-chain state.
contract SetupInitialValidatorsKurtosis is Script {
    // The kurtosis devnet registers one validator starting at ID 1.
    uint16 constant VALIDATOR_ID = 1;
    uint8 constant SHARE = 100;

    function run() public {
        string memory json = vm.readFile("script/deployment.json");

        address controllerAddr = vm.parseJsonAddress(json, ".sPOL_L1.sPOLControllerProxy");
        sPOLController controller = sPOLController(controllerAddr);

        uint256 pk = vm.envUint("DEPLOYER_PRIVATE_KEY");

        vm.startBroadcast(pk);

        // 1. Add validator 1 (the kurtosis devnet's single registered validator)
        controller.addValidator(VALIDATOR_ID);
        console.log("Validator added:", VALIDATOR_ID);

        // 2. Set deposit share to 100% for the single validator
        uint16[] memory valIds = new uint16[](1);
        valIds[0] = VALIDATOR_ID;
        uint8[] memory shares = new uint8[](1);
        shares[0] = SHARE;
        controller.updateValidatorTargetShare(valIds, shares);
        console.log("Deposit share set to 100%");

        vm.stopBroadcast();

        // Verify state
        require(controller.activeValidators(0) == VALIDATOR_ID, "Validator not at index 0");
        console.log("Kurtosis devnet validator setup complete!");
        console.log("Note: buySPOL bootstrap skipped due to kurtosis pos-contracts compatibility.");
        console.log("The e2e tests invoke buySPOL directly.");
    }
}
