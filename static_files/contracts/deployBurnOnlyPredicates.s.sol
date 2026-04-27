// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import {Script, stdJson, console} from "forge-std/Script.sol";

// Swaps ERC20Predicate / ERC721Predicate (old, no typed-tx support) for their
// *BurnOnly variants (which use ExitPayloadReader and handle EIP-1559 / typed-tx
// receipts). This mirrors mainnet, which registered the burn-only predicates.
// Without this swap, startExitWithBurntTokens reverts silently on EIP-1559 burns
// because the old predicates call toList() on the raw typed-tx receipt bytes.
contract DeployBurnOnlyPredicatesScript is Script {
    function run() public {
        uint256 deployerPrivateKey = vm.envUint("DEPLOYER_PRIVATE_KEY");

        string memory path = "contractAddresses.json";
        string memory json = vm.readFile(path);
        address withdrawManagerProxy = vm.parseJsonAddress(json, ".root.WithdrawManagerProxy");
        address depositManagerProxy = vm.parseJsonAddress(json, ".root.DepositManagerProxy");
        address registry = vm.parseJsonAddress(json, ".root.Registry");
        address governance = vm.parseJsonAddress(json, ".root.GovernanceProxy");

        vm.startBroadcast(deployerPrivateKey);

        address erc20Predicate = deployCode(
            "out/ERC20PredicateBurnOnly.sol/ERC20PredicateBurnOnly.json",
            abi.encode(withdrawManagerProxy, depositManagerProxy)
        );
        console.log("ERC20PredicateBurnOnly:", erc20Predicate);

        address erc721Predicate = deployCode(
            "out/ERC721PredicateBurnOnly.sol/ERC721PredicateBurnOnly.json",
            abi.encode(withdrawManagerProxy, depositManagerProxy)
        );
        console.log("ERC721PredicateBurnOnly:", erc721Predicate);

        // Register via governance.update. addErc20Predicate / addErc721Predicate
        // overwrite the singleton and add the new address to Registry.predicates;
        // the old predicate entries in that mapping are harmless (nothing calls them).
        (bool okErc20,) = governance.call(
            abi.encodeWithSignature(
                "update(address,bytes)",
                registry,
                abi.encodeWithSignature("addErc20Predicate(address)", erc20Predicate)
            )
        );
        require(okErc20, "addErc20Predicate failed");

        (bool okErc721,) = governance.call(
            abi.encodeWithSignature(
                "update(address,bytes)",
                registry,
                abi.encodeWithSignature("addErc721Predicate(address)", erc721Predicate)
            )
        );
        require(okErc721, "addErc721Predicate failed");

        vm.stopBroadcast();

        vm.writeJson(vm.toString(erc20Predicate), path, ".root.predicates.ERC20Predicate");
        vm.writeJson(vm.toString(erc721Predicate), path, ".root.predicates.ERC721Predicate");
    }
}
