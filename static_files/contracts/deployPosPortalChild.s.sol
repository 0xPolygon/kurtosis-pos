// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import {Script, stdJson, console} from "forge-std/Script.sol";

// Deploys the L2 (child) side of pos-portal. Mirrors scripts/3_deploy_child_chain_contracts.js +
// 5_initialize_child_chain_contracts.js from maticnetwork/pos-portal at pin 3402faa.
//
// Reads: .root.posPortal.* from contractAddresses.json (root-side dummy tokens,
//        produced by deployPosPortalRoot.s.sol).
// Writes: .child.posPortal.*
contract DeployPosPortalChildScript is Script {
    using stdJson for string;

    // Pre-deployed state-sync precompile on L2 bor. CCM must grant it STATE_SYNCER_ROLE
    // so bridged deposits land on the child chain.
    address constant STATE_RECEIVER = 0x0000000000000000000000000000000000001001;
    // Canonical L1 Ether sentinel used for Ether bridging (same as mainnet).
    address constant ETHER_ROOT = 0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE;

    struct Addrs {
        address ccmImpl;
        address ccmProxy;
        address dummyErc20;
        address dummyMintableErc20;
        address dummyErc721;
        address dummyMintableErc721;
        address dummyErc1155;
        address dummyMintableErc1155;
        address maticWeth;
    }

    function run() public {
        uint256 pk = vm.envUint("DEPLOYER_PRIVATE_KEY");
        address owner = vm.addr(pk);

        string memory path = "contractAddresses.json";
        string memory json = vm.readFile(path);

        // Root-side dummies (used for mapToken pairs).
        address rootErc20 = json.readAddress(".root.posPortal.DummyERC20");
        address rootMintableErc20 = json.readAddress(".root.posPortal.DummyMintableERC20");
        address rootErc721 = json.readAddress(".root.posPortal.DummyERC721");
        address rootMintableErc721 = json.readAddress(".root.posPortal.DummyMintableERC721");
        address rootErc1155 = json.readAddress(".root.posPortal.DummyERC1155");
        address rootMintableErc1155 = json.readAddress(".root.posPortal.DummyMintableERC1155");

        Addrs memory a;

        vm.startBroadcast(pk);

        a.ccmImpl = deployCode("out/ChildChainManager.sol/ChildChainManager.json");
        a.ccmProxy =
            deployCode("out/ChildChainManagerProxy.sol/ChildChainManagerProxy.json", abi.encode(address(0)));
        _updateAndCall(a.ccmProxy, a.ccmImpl, abi.encodeWithSignature("initialize(address)", owner));

        // Child tokens — each takes the CCM proxy in its constructor so CCM can mint/burn on bridge events.
        a.dummyErc20 = deployCode(
            "out/ChildERC20.sol/ChildERC20.json",
            abi.encode("Dummy ERC20", "DERC20", uint8(18), a.ccmProxy)
        );
        a.dummyMintableErc20 = deployCode(
            "out/ChildMintableERC20.sol/ChildMintableERC20.json",
            abi.encode("Dummy Mintable ERC20", "DMERC20", uint8(18), a.ccmProxy)
        );
        a.dummyErc721 = deployCode(
            "out/ChildERC721.sol/ChildERC721.json",
            abi.encode("Dummy ERC721", "DERC721", a.ccmProxy)
        );
        a.dummyMintableErc721 = deployCode(
            "out/ChildMintableERC721.sol/ChildMintableERC721.json",
            abi.encode("Dummy Mintable ERC721", "DMERC721", a.ccmProxy)
        );
        a.dummyErc1155 = deployCode(
            "out/ChildERC1155.sol/ChildERC1155.json", abi.encode("Dummy ERC1155", a.ccmProxy)
        );
        a.dummyMintableErc1155 = deployCode(
            "out/ChildMintableERC1155.sol/ChildMintableERC1155.json",
            abi.encode("Dummy Mintable ERC1155", a.ccmProxy)
        );
        a.maticWeth = deployCode("out/MaticWETH.sol/MaticWETH.json", abi.encode(a.ccmProxy));

        // STATE_SYNCER_ROLE = keccak256("STATE_SYNCER_ROLE") per ChildChainManager storage layout.
        bytes32 stateSyncerRole = keccak256("STATE_SYNCER_ROLE");
        _grantRole(a.ccmProxy, stateSyncerRole, STATE_RECEIVER);

        // L2-side token mapping (matches scripts/5_initialize_child_chain_contracts.js).
        _mapChild(a.ccmProxy, rootErc20, a.dummyErc20);
        _mapChild(a.ccmProxy, rootMintableErc20, a.dummyMintableErc20);
        _mapChild(a.ccmProxy, rootErc721, a.dummyErc721);
        _mapChild(a.ccmProxy, rootMintableErc721, a.dummyMintableErc721);
        _mapChild(a.ccmProxy, rootErc1155, a.dummyErc1155);
        _mapChild(a.ccmProxy, rootMintableErc1155, a.dummyMintableErc1155);
        _mapChild(a.ccmProxy, ETHER_ROOT, a.maticWeth);

        vm.stopBroadcast();

        _persist(a, path);
        console.log("pos-portal child deploy complete:");
        console.log("  ChildChainManagerProxy:", a.ccmProxy);
    }

    function _updateAndCall(address proxy, address impl, bytes memory data) internal {
        (bool ok,) = proxy.call(abi.encodeWithSignature("updateAndCall(address,bytes)", impl, data));
        require(ok, "updateAndCall failed");
    }

    function _grantRole(address target, bytes32 role, address account) internal {
        (bool ok,) = target.call(abi.encodeWithSignature("grantRole(bytes32,address)", role, account));
        require(ok, "grantRole failed");
    }

    function _mapChild(address ccm, address rootToken, address childToken) internal {
        (bool ok,) = ccm.call(abi.encodeWithSignature("mapToken(address,address)", rootToken, childToken));
        require(ok, "CCM mapToken failed");
    }

    function _persist(Addrs memory a, string memory path) internal {
        string memory k = "posPortalChild";
        vm.serializeAddress(k, "ChildChainManager", a.ccmImpl);
        vm.serializeAddress(k, "ChildChainManagerProxy", a.ccmProxy);
        vm.serializeAddress(k, "DummyERC20", a.dummyErc20);
        vm.serializeAddress(k, "DummyMintableERC20", a.dummyMintableErc20);
        vm.serializeAddress(k, "DummyERC721", a.dummyErc721);
        vm.serializeAddress(k, "DummyMintableERC721", a.dummyMintableErc721);
        vm.serializeAddress(k, "DummyERC1155", a.dummyErc1155);
        vm.serializeAddress(k, "DummyMintableERC1155", a.dummyMintableErc1155);
        string memory serialized = vm.serializeAddress(k, "MaticWETH", a.maticWeth);
        vm.writeJson(serialized, path, ".child.posPortal");
    }
}
