// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/// @title MockRootChainManager
/// @notice Minimal mock of the RootChainManager (new-style ERC20 PoS bridge) for kurtosis devnet.
/// The real RootChainManager is not deployed by pos-contracts. The sPOLMessenger constructor
/// requires an IRootChainManager address; depositFor is called during L1->L2 bridging flows.
/// In the devnet this is a no-op — state sync is handled by the base PoS StateSender instead.
contract MockRootChainManager {
    event DepositFor(address indexed user, address indexed rootToken, bytes depositData);

    /// @notice Maps token type hashes to predicate addresses, matching the real contract's interface.
    mapping(bytes32 => address) public typeToPredicate;

    function depositFor(address user, address rootToken, bytes calldata depositData) external {
        emit DepositFor(user, rootToken, depositData);
    }
}
