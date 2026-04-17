// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script} from "forge-std/Script.sol";
import {MockPolygonMigration} from "./MockPolygonMigration.sol";
import {MockRootChainManager} from "./MockRootChainManager.sol";

/// @title DeployMocksScript
/// @notice Foundry script that deploys MockPolygonMigration and MockRootChainManager on L1
/// and writes their addresses to script/mockAddresses.json for the LST deploy script
/// to read back into SPOL_* environment variables.
contract DeployMocksScript is Script {
    function run() public {
        uint256 deployerKey = vm.envUint("DEPLOYER_PRIVATE_KEY");
        vm.startBroadcast(deployerKey);

        MockPolygonMigration polygonMigration = new MockPolygonMigration();
        MockRootChainManager rootChainManager = new MockRootChainManager();

        vm.stopBroadcast();

        // Write deployed addresses to JSON for consumption by the LST deploy script.
        string memory json = string(
            abi.encodePacked(
                '{"polygonMigration":"',
                vm.toString(address(polygonMigration)),
                '","rootChainManager":"',
                vm.toString(address(rootChainManager)),
                '"}'
            )
        );

        // Write within script/ — foundry.toml only grants fs_permissions for script/ and test/.
        // The bash script reads from this path after forge finishes.
        vm.writeFile("script/mockAddresses.json", json);
    }
}
