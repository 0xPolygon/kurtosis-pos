// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import {Script, console} from "forge-std/Script.sol";

// Minimal interface for the ERC20Permit/TestToken deployed as POL.
interface IERC20Like {
    function transfer(address to, uint256 amount) external returns (bool);
    function totalSupply() external view returns (uint256);
}

// Deploys ERC20Permit as POL token and PolygonMigration, then funds the migration contract.
// All contracts already exist in pos-contracts; deployed from compiled artifacts via deployCode.
// Keeps 10M POL for the deployer so bridge tests can deposit POL from L1.
contract DeployPolAndMigrationScript is Script {
    uint256 constant DEPLOYER_POL_RESERVE = 10_000_000 * 1e18;

    function run() public {
        uint256 deployerPrivateKey = vm.envUint("DEPLOYER_PRIVATE_KEY");

        string memory path = "contractAddresses.json";
        string memory json = vm.readFile(path);
        address maticToken = vm.parseJsonAddress(json, ".root.tokens.MaticToken");

        vm.startBroadcast(deployerPrivateKey);

        // Deploy POL token (ERC20Permit extends TestToken which mints 10B to msg.sender).
        address polToken = deployCode(
            "out/ERC20Permit.sol/ERC20Permit.json",
            abi.encode("POL", "POL", "1")
        );
        console.log("POL token deployed at:", polToken);

        // Deploy PolygonMigration (legacy=MATIC, staking=POL).
        address migration = deployCode(
            "out/PolygonMigration.sol/PolygonMigration.json",
            abi.encode(maticToken, polToken)
        );
        console.log("PolygonMigration deployed at:", migration);

        // Fund migration with all but 10M POL — migration needs POL to exchange MATIC 1:1.
        uint256 migrationPol = IERC20Like(polToken).totalSupply() - DEPLOYER_POL_RESERVE;
        IERC20Like(polToken).transfer(migration, migrationPol);
        console.log("Migration funded with POL:", migrationPol);

        vm.stopBroadcast();
    }
}
