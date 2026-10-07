// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Deploy} from "./Deploy.s.sol";
import {TransparentUpgradeableProxy} from "@openzeppelin/contracts/proxy/transparent/TransparentUpgradeableProxy.sol";

// Splits Deploy.run into one forge run per chain, so each run can simulate with
// its own chain's hardfork (FOUNDRY_HARDFORK is global to a forge script).
contract DeployPerChain is Deploy {
    function runL1(string memory _scenarioName) public {
        uint256 pk = vm.envUint("DEPLOYER_PRIVATE_KEY");
        loadConfigFromJson(_scenarioName);
        vm.startBroadcast(pk);
        deployContractsL1(vm.addr(pk));
        vm.stopBroadcast();
        writeDeploymentInfoToJSON();
    }

    // deployContractsL2 reads the L1 messenger proxy address from storage.
    function runL2(string memory _scenarioName, address _sPOLMessengerProxy) public {
        uint256 pk = vm.envUint("DEPLOYER_PRIVATE_KEY");
        loadConfigFromJson(_scenarioName);
        sPOLMessengerProxy = TransparentUpgradeableProxy(payable(_sPOLMessengerProxy));
        vm.startBroadcast(pk);
        deployContractsL2(vm.addr(pk));
        vm.stopBroadcast();
        writeDeploymentInfoToJSON();
    }
}
