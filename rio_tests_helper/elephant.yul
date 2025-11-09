{
        // We'll ignore the first four bytes because we can use them as a selctor of sorts if we want. The calldata will hold the mode used to decide what we'll do
        let mode := calldataload(4)

        // The seed is essentially a nonce for this contract. We increment this every time we call the contract. The idea is that each successive call to this contract can have a different "seed" that we'll use for arbitrarily starting operations
        let seed := sload(0xd92df11fabd7d8636fbfb22aee645a61960b71c2411090093485dc53516cf03c)
        sstore(0xd92df11fabd7d8636fbfb22aee645a61960b71c2411090093485dc53516cf03c, add(seed, 1))

        // The latest index is stored in slot 0. This is essentially a counter that indicates how many storage slots have been created / initialized
        let currentIndex := sload(0)
        if iszero(currentIndex) {
                currentIndex := 1
                sstore(currentIndex, 1)
        }

        // We'll concatenate the random value for this block and the seed and then hash that and modulo the last index to get a randome number in the range of initialized slots
        mstore(0, prevrandao())
        mstore(32, seed)
        let startIndex := mod(keccak256(0, 64), currentIndex)

        switch mode
        // We'll start at a "random" index and do an SLOAD / SSTORE
        case 1 {
                for {} gt(gas(), 26000) {} {
                        let curValue := sload(startIndex)
                        sstore(startIndex, add(curValue, 1))
                        startIndex := add(startIndex, 1)
                }
        }
        // We'll start at a "random" index and do SSTORE to delete the slot
        case 2 {
                for {} gt(gas(), 26000) {} {
                        sstore(startIndex, 0)
                        startIndex := add(startIndex, 1)
                }
        }

        // by default we'll just initialize more storage slots
        default {
                for {} gt(gas(), 50000) {} {
                        currentIndex := add(currentIndex, 1)
                        sstore(currentIndex, 1)
                }
                sstore(0, currentIndex)
        }
}