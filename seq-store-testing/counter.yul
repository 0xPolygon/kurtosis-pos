// Minimal counter contract. Every call increments the counter in
// storage slot 0 and emits a LOG1 with the new counter value as
// topic 1.

// solc --strict-assembly --bin --input-file counter.yul
{
        let count := add(sload(0), 1)
        sstore(0, count)
        log1(0, 0, count)
}
