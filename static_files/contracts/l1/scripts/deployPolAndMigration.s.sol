// SPDX-License-Identifier: MIT
pragma solidity 0.8.21;

import {Script, console} from "forge-std/Script.sol";

import {ProxyAdmin, TransparentUpgradeableProxy} from "openzeppelin-contracts/contracts/proxy/transparent/ProxyAdmin.sol";
import {PolygonEcosystemToken} from "../src/PolygonEcosystemToken.sol";
import {PolygonMigration} from "../src/PolygonMigration.sol";

// MATIC on the devnet is pos-contracts' 0.5.x TestToken; only approve is needed here.
interface IMaticLike {
    function approve(address spender, uint256 amount) external returns (bool);
}

// Deploys the production PolygonEcosystemToken (POL) and PolygonMigration from 0xPolygon/pol-token,
// in the mainnet shape (pol-token script/1.0.0/Deploy.goerli.s.sol): ProxyAdmin -> migration impl ->
// TransparentUpgradeableProxy + initialize -> token (mints 10B POL to the migration proxy) ->
// setPolygonToken. The real token carries the production EIP-712 domain ("Polygon Ecosystem Token",
// "1") and ERC-5267 eip712Domain(), so permit signatures built against the devnet match mainnet.
// There is no emission manager contract on the devnet: the emission manager, protocol council and
// emergency council roles all go to the devnet admin (the deployer).
// The deployer then migrates MATIC -> POL exactly as mainnet users do: 10M POL stays with the
// deployer for bridge tests, 1M is forwarded to StakeManager for rewards by the calling shell script.
contract DeployPolAndMigrationScript is Script {
    uint256 constant DEPLOYER_POL_RESERVE = 10_000_000e18;
    uint256 constant STAKE_MANAGER_REWARDS = 1_000_000e18;

    function run() public {
        uint256 deployerPrivateKey = vm.envUint("DEPLOYER_PRIVATE_KEY");
        address admin = vm.addr(deployerPrivateKey);

        string memory json = vm.readFile("contractAddresses.json");
        address matic = vm.parseJsonAddress(json, ".root.tokens.MaticToken");

        vm.startBroadcast(deployerPrivateKey);

        // The deployer must not be the proxy's admin: a TransparentUpgradeableProxy never forwards
        // its admin's calls to the implementation, and the deployer calls setPolygonToken and migrate.
        ProxyAdmin proxyAdmin = new ProxyAdmin();
        console.log("ProxyAdmin deployed at:", address(proxyAdmin));

        address migrationImplementation = address(new PolygonMigration(matic));
        console.log("PolygonMigration implementation deployed at:", migrationImplementation);

        address migration = address(
            new TransparentUpgradeableProxy(
                migrationImplementation,
                address(proxyAdmin),
                abi.encodeWithSelector(PolygonMigration.initialize.selector)
            )
        );
        console.log("PolygonMigration proxy deployed at:", migration);

        PolygonEcosystemToken pol = new PolygonEcosystemToken(migration, admin, admin, admin);
        console.log("POL token deployed at:", address(pol));

        PolygonMigration(migration).setPolygonToken(address(pol));

        uint256 amount = DEPLOYER_POL_RESERVE + STAKE_MANAGER_REWARDS;
        IMaticLike(matic).approve(migration, amount);
        PolygonMigration(migration).migrate(amount);
        console.log("Deployer migrated MATIC to POL:", amount);

        vm.stopBroadcast();
    }
}
