// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import {Script, stdJson, console} from "forge-std/Script.sol";

// Deploys the L1 (root) side of pos-portal and wires its intra-L1 state.
//
// Mirrors scripts/2_deploy_root_chain_contracts.js + 4_initialize_root_chain_contracts.js
// from maticnetwork/pos-portal at pin 3402faa, minus cross-chain mapTokens (those live in
// the finalize script because they need L2 addresses).
//
// Reads: .root.RootChainProxy and .root.StateSender from contractAddresses.json
//        (these come from the pos-contracts L1 deploy).
// Writes: .root.posPortal.* and .root.posPortal.tokens.*
contract DeployPosPortalRootScript is Script {
    using stdJson for string;

    // Token type ids expected by RootChainManager.registerPredicate(bytes32,address).
    bytes32 constant ERC20_TYPE = keccak256("ERC20");
    bytes32 constant ERC721_TYPE = keccak256("ERC721");
    bytes32 constant ERC1155_TYPE = keccak256("ERC1155");
    bytes32 constant ETHER_TYPE = keccak256("Ether");
    bytes32 constant MINTABLE_ERC20_TYPE = keccak256("MintableERC20");
    // The mainnet-deployed MintableERC721Predicate hardcodes this value rather than keccak256("MintableERC721");
    // matching pos-portal/contracts/root/TokenPredicates/MintableERC721Predicate.sol:17.
    bytes32 constant MINTABLE_ERC721_TYPE = 0xd4392723c111fcb98b073fe55873efb447bcd23cd3e49ec9ea2581930cd01ddc;
    bytes32 constant MINTABLE_ERC1155_TYPE = keccak256("MintableERC1155");

    // Deployed addresses, collected as we go so we can serialise at the end.
    struct Addrs {
        address rcmImpl;
        address rcmProxy;
        address erc20Impl;
        address erc20Proxy;
        address mintableErc20Impl;
        address mintableErc20Proxy;
        address erc721Impl;
        address erc721Proxy;
        address mintableErc721Impl;
        address mintableErc721Proxy;
        address erc1155Impl;
        address erc1155Proxy;
        address mintableErc1155Impl;
        address mintableErc1155Proxy;
        address etherImpl;
        address etherProxy;
        address dummyStateSender;
        address dummyErc20;
        address dummyMintableErc20;
        address dummyErc721;
        address dummyMintableErc721;
        address dummyErc1155;
        address dummyMintableErc1155;
    }

    function run() public {
        uint256 pk = vm.envUint("DEPLOYER_PRIVATE_KEY");
        address owner = vm.addr(pk);

        string memory path = "contractAddresses.json";
        string memory json = vm.readFile(path);
        address checkpointManager = json.readAddress(".root.RootChainProxy");
        address stateSender = json.readAddress(".root.StateSender");

        Addrs memory a;

        vm.startBroadcast(pk);

        a = _deployRootChainManager(a, owner);
        a = _deployPredicates(a, owner);
        a.dummyStateSender = deployCode("out/DummyStateSender.sol/DummyStateSender.json");
        a = _deployDummyTokens(a);

        _configureRootChainManager(a, checkpointManager, stateSender);
        _grantManagerRoles(a);
        _grantMintablePredicateRoles(a);
        _registerPredicates(a);

        vm.stopBroadcast();

        _persist(a, path);
        console.log("pos-portal root deploy complete:");
        console.log("  RootChainManagerProxy:", a.rcmProxy);
    }

    function _deployRootChainManager(Addrs memory a, address owner) internal returns (Addrs memory) {
        a.rcmImpl = deployCode("out/RootChainManager.sol/RootChainManager.json");
        a.rcmProxy = deployCode("out/RootChainManagerProxy.sol/RootChainManagerProxy.json", abi.encode(address(0)));
        _updateAndCall(a.rcmProxy, a.rcmImpl, abi.encodeWithSignature("initialize(address)", owner));
        return a;
    }

    function _deployPredicates(Addrs memory a, address owner) internal returns (Addrs memory) {
        (a.erc20Impl, a.erc20Proxy) = _deployPredicate("ERC20Predicate", owner);
        (a.mintableErc20Impl, a.mintableErc20Proxy) = _deployPredicate("MintableERC20Predicate", owner);
        (a.erc721Impl, a.erc721Proxy) = _deployPredicate("ERC721Predicate", owner);
        (a.mintableErc721Impl, a.mintableErc721Proxy) = _deployPredicate("MintableERC721Predicate", owner);
        (a.erc1155Impl, a.erc1155Proxy) = _deployPredicate("ERC1155Predicate", owner);
        (a.mintableErc1155Impl, a.mintableErc1155Proxy) = _deployPredicate("MintableERC1155Predicate", owner);
        (a.etherImpl, a.etherProxy) = _deployPredicate("EtherPredicate", owner);
        return a;
    }

    function _deployPredicate(string memory name, address owner) internal returns (address impl, address proxy) {
        impl = deployCode(string.concat("out/", name, ".sol/", name, ".json"));
        proxy = deployCode(
            string.concat("out/", name, "Proxy.sol/", name, "Proxy.json"),
            abi.encode(address(0))
        );
        _updateAndCall(proxy, impl, abi.encodeWithSignature("initialize(address)", owner));
    }

    function _deployDummyTokens(Addrs memory a) internal returns (Addrs memory) {
        a.dummyErc20 = deployCode(
            "out/DummyERC20.sol/DummyERC20.json", abi.encode("Dummy ERC20", "DERC20")
        );
        a.dummyMintableErc20 = deployCode(
            "out/DummyMintableERC20.sol/DummyMintableERC20.json",
            abi.encode("Dummy Mintable ERC20", "DERC20")
        );
        a.dummyErc721 = deployCode(
            "out/DummyERC721.sol/DummyERC721.json", abi.encode("Dummy ERC721", "DERC721")
        );
        a.dummyMintableErc721 = deployCode(
            "out/DummyMintableERC721.sol/DummyMintableERC721.json",
            abi.encode("Dummy Mintable ERC721", "DMERC721")
        );
        a.dummyErc1155 = deployCode("out/DummyERC1155.sol/DummyERC1155.json", abi.encode("Dummy ERC1155"));
        a.dummyMintableErc1155 = deployCode(
            "out/DummyMintableERC1155.sol/DummyMintableERC1155.json", abi.encode("Dummy Mintable ERC1155")
        );
        return a;
    }

    function _configureRootChainManager(Addrs memory a, address checkpointManager, address stateSender) internal {
        (bool ok1,) = a.rcmProxy.call(abi.encodeWithSignature("setStateSender(address)", stateSender));
        require(ok1, "setStateSender failed");
        (bool ok2,) = a.rcmProxy.call(
            abi.encodeWithSignature("setCheckpointManager(address)", checkpointManager)
        );
        require(ok2, "setCheckpointManager failed");
    }

    // MANAGER_ROLE on each predicate lets RootChainManager drive deposits.
    function _grantManagerRoles(Addrs memory a) internal {
        bytes32 managerRole = keccak256("MANAGER_ROLE");
        _grantRole(a.erc20Proxy, managerRole, a.rcmProxy);
        _grantRole(a.mintableErc20Proxy, managerRole, a.rcmProxy);
        _grantRole(a.erc721Proxy, managerRole, a.rcmProxy);
        _grantRole(a.mintableErc721Proxy, managerRole, a.rcmProxy);
        _grantRole(a.erc1155Proxy, managerRole, a.rcmProxy);
        _grantRole(a.mintableErc1155Proxy, managerRole, a.rcmProxy);
        _grantRole(a.etherProxy, managerRole, a.rcmProxy);
    }

    // PREDICATE_ROLE lets the mintable predicate mint the dummy token on the L1 side during exits.
    function _grantMintablePredicateRoles(Addrs memory a) internal {
        bytes32 predicateRole = keccak256("PREDICATE_ROLE");
        _grantRole(a.dummyMintableErc20, predicateRole, a.mintableErc20Proxy);
        _grantRole(a.dummyMintableErc721, predicateRole, a.mintableErc721Proxy);
        _grantRole(a.dummyMintableErc1155, predicateRole, a.mintableErc1155Proxy);
    }

    function _registerPredicates(Addrs memory a) internal {
        _registerPredicate(a.rcmProxy, ERC20_TYPE, a.erc20Proxy);
        _registerPredicate(a.rcmProxy, MINTABLE_ERC20_TYPE, a.mintableErc20Proxy);
        _registerPredicate(a.rcmProxy, ERC721_TYPE, a.erc721Proxy);
        _registerPredicate(a.rcmProxy, MINTABLE_ERC721_TYPE, a.mintableErc721Proxy);
        _registerPredicate(a.rcmProxy, ERC1155_TYPE, a.erc1155Proxy);
        _registerPredicate(a.rcmProxy, MINTABLE_ERC1155_TYPE, a.mintableErc1155Proxy);
        _registerPredicate(a.rcmProxy, ETHER_TYPE, a.etherProxy);
    }

    function _registerPredicate(address rcm, bytes32 tokenType, address predicate) internal {
        (bool ok,) = rcm.call(abi.encodeWithSignature("registerPredicate(bytes32,address)", tokenType, predicate));
        require(ok, "registerPredicate failed");
    }

    function _grantRole(address target, bytes32 role, address account) internal {
        (bool ok,) = target.call(abi.encodeWithSignature("grantRole(bytes32,address)", role, account));
        require(ok, "grantRole failed");
    }

    function _updateAndCall(address proxy, address impl, bytes memory data) internal {
        (bool ok,) = proxy.call(abi.encodeWithSignature("updateAndCall(address,bytes)", impl, data));
        require(ok, "updateAndCall failed");
    }

    function _persist(Addrs memory a, string memory path) internal {
        string memory k = "posPortal";
        vm.serializeAddress(k, "RootChainManager", a.rcmImpl);
        vm.serializeAddress(k, "RootChainManagerProxy", a.rcmProxy);
        vm.serializeAddress(k, "ERC20Predicate", a.erc20Impl);
        vm.serializeAddress(k, "ERC20PredicateProxy", a.erc20Proxy);
        vm.serializeAddress(k, "MintableERC20Predicate", a.mintableErc20Impl);
        vm.serializeAddress(k, "MintableERC20PredicateProxy", a.mintableErc20Proxy);
        vm.serializeAddress(k, "ERC721Predicate", a.erc721Impl);
        vm.serializeAddress(k, "ERC721PredicateProxy", a.erc721Proxy);
        vm.serializeAddress(k, "MintableERC721Predicate", a.mintableErc721Impl);
        vm.serializeAddress(k, "MintableERC721PredicateProxy", a.mintableErc721Proxy);
        vm.serializeAddress(k, "ERC1155Predicate", a.erc1155Impl);
        vm.serializeAddress(k, "ERC1155PredicateProxy", a.erc1155Proxy);
        vm.serializeAddress(k, "MintableERC1155Predicate", a.mintableErc1155Impl);
        vm.serializeAddress(k, "MintableERC1155PredicateProxy", a.mintableErc1155Proxy);
        vm.serializeAddress(k, "EtherPredicate", a.etherImpl);
        vm.serializeAddress(k, "EtherPredicateProxy", a.etherProxy);
        vm.serializeAddress(k, "DummyStateSender", a.dummyStateSender);
        vm.serializeAddress(k, "DummyERC20", a.dummyErc20);
        vm.serializeAddress(k, "DummyMintableERC20", a.dummyMintableErc20);
        vm.serializeAddress(k, "DummyERC721", a.dummyErc721);
        vm.serializeAddress(k, "DummyMintableERC721", a.dummyMintableErc721);
        vm.serializeAddress(k, "DummyERC1155", a.dummyErc1155);
        string memory serialized = vm.serializeAddress(k, "DummyMintableERC1155", a.dummyMintableErc1155);
        vm.writeJson(serialized, path, ".root.posPortal");
    }
}
