// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/// @title MockPolygonMigration
/// @notice Minimal mock of the MATIC->POL migration contract for kurtosis devnet use.
/// The real PolygonMigration exists only on Ethereum mainnet. In the devnet the sPOLController
/// constructor requires an IPolygonMigration address but never calls migrate/unmigrate during
/// staking/unstaking flows, so no-op implementations are sufficient.
contract MockPolygonMigration {
    event Migrated(address indexed account, uint256 amount);
    event Unmigrated(address indexed account, uint256 amount);

    function migrate(uint256 amount) external {
        emit Migrated(msg.sender, amount);
    }

    function unmigrate(uint256 amount) external {
        emit Unmigrated(msg.sender, amount);
    }
}
