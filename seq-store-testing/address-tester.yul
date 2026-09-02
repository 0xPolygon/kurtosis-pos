// This contract is meant to help in the testing of various
// edge cases while calling addresses. There are 3 32byte
// inputs:
//
// 1. The action to be performed
// 2. The address that we want to test
// 3. The value that we want to include in the calls
//
// There are a alot of cases to test which is originally inspired from
// the DiffPlaces tests in the Ethereum testsuite:
//
// https://github.com/ethereum/tests/blob/9201075490807f58811078e9bb5ec895b4ac01a5/src/Templates/DiffPlaces/templateGen.js#L22-L57
//
// In our case the actions are similar. Based on the input action this
// is roughly the logic:
//
//  1. 0x0001 CALL the address
//  2. 0x0002 CALLCODE the address
//  3. 0x0003 DELEGATECALL the address
//  4. 0x0004 STATICCALL the address
//  5. 0x0011 CALL ourself then CALL the address
//  6. 0x0012 CALL ourself then CALLCODE the address
//  7. 0x0013 CALL ourself then DELEGATECALL the address
//  8. 0x0014 CALL ourself then STATICCALL the address
//  9. 0x0021 CALLCODE ourself then CALL the address
// 10. 0x0022 CALLCODE ourself then CALLCODE the address
// 11. 0x0023 CALLCODE ourself then DELEGATECALL the address
// 12. 0x0024 CALLCODE ourself then STATICCALL the address
// 13. 0x0031 DELEGATECALL ourself then CALL the address
// 14. 0x0032 DELEGATECALL ourself then CALLCODE the address
// 15. 0x0033 DELEGATECALL ourself then DELEGATECALL the address
// 16. 0x0034 DELEGATECALL ourself then STATICCALL the address
// 17. 0x0041 STATICCALL ourself then CALL the address
// 18. 0x0042 STATICCALL ourself then CALLCODE the address
// 19. 0x0043 STATICCALL ourself then DELEGATECALL the address
// 20. 0x0044 STATICCALL ourself then STATICCALL the address
// 21. 0x0101 CALL then a revert due to insufficient gas then a CALL
// 22. 0x0201 CALL then a revert due to invalid instruction then a CALL
// 23. 0x0301 CALL then a revert due to stack underflow then a CALL
// 24. 0x0401 CALL then a revert due to bad jump destination then a CALL
// 25. 0x0501 CALL then a revert due to a stack overflow then a CALL
// 26. 0x0601 CALL then a revert due to state modification in a static call then a CALL
// 27. 0x0701 CALL then a revert due to gas amount is less than the stipend (eip-2200) then a CALL
// 28. 0x0801 CALL then a valid self destruct then a CALL
// 29. 0x0901 CALL then a revert due to a self destruct in a static call then a CALL
// 30. 0x1XXX CREATE a copy of this contract then XXX
// 31. 0x2XXX CREATE2 a copy of this contract then XXX

// solc --strict-assembly --bin --input-file address-tester.yul
// solc --strict-assembly --bin --input-file contracts/address-tester.yul | tail -n1 > foo.bin


//  1. 0x0001 CALL the address
// ~/code/go-ethereum/build/bin/evm --codefile foo.bin --gas 30000000 --debug run --nomemory=true --json --input 0000000000000000000000000000000000000000000000000000000000000001000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000000000000000000000000000000000000000000000000000000000000000
//  2. 0x0002 CALLCODE the address
// ~/code/go-ethereum/build/bin/evm --codefile foo.bin --gas 30000000 --debug run --nomemory=true --json --input 0000000000000000000000000000000000000000000000000000000000000002000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000000000000000000000000000000000000000000000000000000000000000
//  3. 0x0003 DELEGATECALL the address
// ~/code/go-ethereum/build/bin/evm --codefile foo.bin --gas 30000000 --debug run --nomemory=true --json --input 0000000000000000000000000000000000000000000000000000000000000003000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000000000000000000000000000000000000000000000000000000000000000
//  4. 0x0004 STATICCALL the address
// ~/code/go-ethereum/build/bin/evm --codefile foo.bin --gas 30000000 --debug run --nomemory=true --json --input 0000000000000000000000000000000000000000000000000000000000000004000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000000000000000000000000000000000000000000000000000000000000000
//  5. 0x0011 CALL ourself then CALL the address
// ~/code/go-ethereum/build/bin/evm --codefile foo.bin --gas 30000000 --debug run --nomemory=true --json --input 0000000000000000000000000000000000000000000000000000000000000011000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000000000000000000000000000000000000000000000000000000000000000
//  6. 0x0012 CALL ourself then CALLCODE the address
// ~/code/go-ethereum/build/bin/evm --codefile foo.bin --gas 30000000 --debug run --nomemory=true --json --input 0000000000000000000000000000000000000000000000000000000000000012000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000000000000000000000000000000000000000000000000000000000000000
//  7. 0x0013 CALL ourself then DELEGATECALL the address
// ~/code/go-ethereum/build/bin/evm --codefile foo.bin --gas 30000000 --debug run --nomemory=true --json --input 0000000000000000000000000000000000000000000000000000000000000013000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000000000000000000000000000000000000000000000000000000000000000
//  8. 0x0014 CALL ourself then STATICCALL the address
// ~/code/go-ethereum/build/bin/evm --codefile foo.bin --gas 30000000 --debug run --nomemory=true --json --input 0000000000000000000000000000000000000000000000000000000000000014000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000000000000000000000000000000000000000000000000000000000000000
//  9. 0x0021 CALLCODE ourself then CALL the address
// ~/code/go-ethereum/build/bin/evm --codefile foo.bin --gas 30000000 --debug run --nomemory=true --json --input 0000000000000000000000000000000000000000000000000000000000000021000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000000000000000000000000000000000000000000000000000000000000000
// 10. 0x0022 CALLCODE ourself then CALLCODE the address
// ~/code/go-ethereum/build/bin/evm --codefile foo.bin --gas 30000000 --debug run --nomemory=true --json --input 0000000000000000000000000000000000000000000000000000000000000022000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000000000000000000000000000000000000000000000000000000000000000
// 11. 0x0023 CALLCODE ourself then DELEGATECALL the address
// ~/code/go-ethereum/build/bin/evm --codefile foo.bin --gas 30000000 --debug run --nomemory=true --json --input 0000000000000000000000000000000000000000000000000000000000000023000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000000000000000000000000000000000000000000000000000000000000000
// 12. 0x0024 CALLCODE ourself then STATICCALL the address
// ~/code/go-ethereum/build/bin/evm --codefile foo.bin --gas 30000000 --debug run --nomemory=true --json --input 0000000000000000000000000000000000000000000000000000000000000024000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000000000000000000000000000000000000000000000000000000000000000
// 13. 0x0031 DELEGATECALL ourself then CALL the address
// ~/code/go-ethereum/build/bin/evm --codefile foo.bin --gas 30000000 --debug run --nomemory=true --json --input 0000000000000000000000000000000000000000000000000000000000000031000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000000000000000000000000000000000000000000000000000000000000000
// 14. 0x0032 DELEGATECALL ourself then CALLCODE the address
// ~/code/go-ethereum/build/bin/evm --codefile foo.bin --gas 30000000 --debug run --nomemory=true --json --input 0000000000000000000000000000000000000000000000000000000000000032000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000000000000000000000000000000000000000000000000000000000000000
// 15. 0x0033 DELEGATECALL ourself then DELEGATECALL the address
// ~/code/go-ethereum/build/bin/evm --codefile foo.bin --gas 30000000 --debug run --nomemory=true --json --input 0000000000000000000000000000000000000000000000000000000000000033000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000000000000000000000000000000000000000000000000000000000000000
// 16. 0x0034 DELEGATECALL ourself then STATICCALL the address
// ~/code/go-ethereum/build/bin/evm --codefile foo.bin --gas 30000000 --debug run --nomemory=true --json --input 0000000000000000000000000000000000000000000000000000000000000034000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000000000000000000000000000000000000000000000000000000000000000
// 17. 0x0041 STATICCALL ourself then CALL the address
// ~/code/go-ethereum/build/bin/evm --codefile foo.bin --gas 30000000 --debug run --nomemory=true --json --input 0000000000000000000000000000000000000000000000000000000000000041000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000000000000000000000000000000000000000000000000000000000000000
// 18. 0x0042 STATICCALL ourself then CALLCODE the address
// ~/code/go-ethereum/build/bin/evm --codefile foo.bin --gas 30000000 --debug run --nomemory=true --json --input 0000000000000000000000000000000000000000000000000000000000000042000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000000000000000000000000000000000000000000000000000000000000000
// 19. 0x0043 STATICCALL ourself then DELEGATECALL the address
// ~/code/go-ethereum/build/bin/evm --codefile foo.bin --gas 30000000 --debug run --nomemory=true --json --input 0000000000000000000000000000000000000000000000000000000000000043000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000000000000000000000000000000000000000000000000000000000000000
// 20. 0x0044 STATICCALL ourself then STATICCALL the address
// ~/code/go-ethereum/build/bin/evm --codefile foo.bin --gas 30000000 --debug run --nomemory=true --json --input 0000000000000000000000000000000000000000000000000000000000000044000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000000000000000000000000000000000000000000000000000000000000000
// 21. 0x0101 CALL then a revert due to insufficient gas then a CALL
// ~/code/go-ethereum/build/bin/evm --codefile foo.bin --gas 30000000 --debug run --nomemory=true --json --input 0000000000000000000000000000000000000000000000000000000000000101000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000000000000000000000000000000000000000000000000000000000000000
// 22. 0x0201 CALL then a revert due to invalid instruction then a CALL
// ~/code/go-ethereum/build/bin/evm --codefile foo.bin --gas 30000000 --debug run --nomemory=true --json --input 0000000000000000000000000000000000000000000000000000000000000201000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000000000000000000000000000000000000000000000000000000000000000
// 23. 0x0301 CALL then a revert due to stack underflow then a CALL
// ~/code/go-ethereum/build/bin/evm --codefile foo.bin --gas 30000000 --debug run --nomemory=true --json --input 0000000000000000000000000000000000000000000000000000000000000301000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000000000000000000000000000000000000000000000000000000000000000
// 24. 0x0401 CALL then a revert due to bad jump destination then a CALL
// ~/code/go-ethereum/build/bin/evm --codefile foo.bin --gas 30000000 --debug run --nomemory=true --json --input 0000000000000000000000000000000000000000000000000000000000000401000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000000000000000000000000000000000000000000000000000000000000000
// 25. 0x0501 CALL then a revert due to a stack overflow then a CALL
// ~/code/go-ethereum/build/bin/evm --codefile foo.bin --gas 30000000 --debug run --nomemory=true --json --input 0000000000000000000000000000000000000000000000000000000000000501000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000000000000000000000000000000000000000000000000000000000000000
// 26. 0x0601 CALL then a revert due to state modification in a static call then a CALL
// ~/code/go-ethereum/build/bin/evm --codefile foo.bin --gas 30000000 --debug run --nomemory=true --json --input 0000000000000000000000000000000000000000000000000000000000000601000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000000000000000000000000000000000000000000000000000000000000000
// 27. 0x0701 CALL then a revert due to gas amount is less than the stipend (eip-2200) then a CALL
// ~/code/go-ethereum/build/bin/evm --codefile foo.bin --gas 30000000 --debug run --nomemory=true --json --input 0000000000000000000000000000000000000000000000000000000000000701000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000000000000000000000000000000000000000000000000000000000000000
// 28. 0x0801 CALL then a valid self destruct then a CALL
// ~/code/go-ethereum/build/bin/evm --codefile foo.bin --gas 30000000 --debug run --nomemory=true --json --input 0000000000000000000000000000000000000000000000000000000000000801000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000000000000000000000000000000000000000000000000000000000000000
// 29. 0x0901 CALL then a revert due to a self destruct in a static call then a CALL
// ~/code/go-ethereum/build/bin/evm --codefile foo.bin --gas 30000000 --debug run --nomemory=true --json --input 0000000000000000000000000000000000000000000000000000000000000901000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000000000000000000000000000000000000000000000000000000000000000
// 30. 0x1XXX CREATE a copy of this contract then XXX
// ~/code/go-ethereum/build/bin/evm --codefile foo.bin --gas 30000000 --debug run --nomemory=true --json --input 0000000000000000000000000000000000000000000000000000000000001901000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000000000000000000000000000000000000000000000000000000000000000
// 31. 0x1XXX CREATE2 a copy of this contract then XXX
// ~/code/go-ethereum/build/bin/evm --codefile foo.bin --gas 30000000 --debug run --nomemory=true --json --input 0000000000000000000000000000000000000000000000000000000000002901000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000000000000000000000000000000000000000000000000000000000000000


{
        // This contract requires at least 0x60 bytes of input
        let callDataSize := calldatasize()
        if lt(callDataSize, 0x60) {
                let msg := "not enough calldata"
                mstore(0, msg)
                revert(0, 0x20)
        }

        // this wastes space... but it's simpler to deal with
        let action := calldataload(0) // 32 bytes for the action
        let addr := calldataload(0x20) // 32 bytes for the target address
        let val := calldataload(0x40) // 32 bytes for the value

        let passThroughSize := sub(callDataSize, 0x60)
        calldatacopy(0xc0, 0x60, passThroughSize) // copy the remainder of the calldata to the end of our memory somewhere

        let inputAction

        mstore(0, action)
        mstore(0x20, addr)
        mstore(0x40, val)

        let result := 1

        if and(gt(action, 0x1000), gt(0x2000, action)) {
                inputAction := sub(action, 0x1000)
                action := 0x1001
        }
        if and(gt(action, 0x2000), gt(0x3000, action)) {
                inputAction := sub(action, 0x2000)
                action := 0x2001
        }

        switch action
        case 0x0001 {
                result := call(gas(), addr, val, 0xc0, passThroughSize, 0, 0)
        }
        case 0x0002 {
                result := callcode(gas(), addr, val, 0xc0, passThroughSize, 0, 0)
        }
        case 0x0003 {
                result := delegatecall(gas(), addr, 0xc0, passThroughSize, 0, 0)
        }
        case 0x0004 {
                result := staticcall(gas(), addr, 0xc0, passThroughSize, 0, 0)
        }

        case 0x0011 {
                mstore(0x60, 0x0001)
                mstore(0x80, addr)
                mstore(0xa0, val)
                result := call(gas(), address(), val, 0x60, add(0x60, passThroughSize), 0, 0)
        }
        case 0x0012 {
                mstore(0x60, 0x0002)
                mstore(0x80, addr)
                mstore(0xa0, val)
                result := call(gas(), address(), val, 0x60, add(0x60, passThroughSize), 0, 0)
        }
        case 0x0013 {
                mstore(0x60, 0x0003)
                mstore(0x80, addr)
                mstore(0xa0, val)
                result := call(gas(), address(), val, 0x60, add(0x60, passThroughSize), 0, 0)
        }
        case 0x0014 {
                mstore(0x60, 0x0004)
                mstore(0x80, addr)
                mstore(0xa0, val)
                result := call(gas(), address(), val, 0x60, add(0x60, passThroughSize), 0, 0)
        }

        case 0x0021 {
                mstore(0x60, 0x0001)
                mstore(0x80, addr)
                mstore(0xa0, val)
                result := callcode(gas(), address(), val, 0x60, add(0x60, passThroughSize), 0, 0)
        }
        case 0x0022 {
                mstore(0x60, 0x0002)
                mstore(0x80, addr)
                mstore(0xa0, val)
                result := callcode(gas(), address(), val, 0x60, add(0x60, passThroughSize), 0, 0)
        }
        case 0x0023 {
                mstore(0x60, 0x0003)
                mstore(0x80, addr)
                mstore(0xa0, val)
                result := callcode(gas(), address(), val, 0x60, add(0x60, passThroughSize), 0, 0)
        }
        case 0x0024 {
                mstore(0x60, 0x0004)
                mstore(0x80, addr)
                mstore(0xa0, val)
                result := callcode(gas(), address(), val, 0x60, add(0x60, passThroughSize), 0, 0)
        }

        case 0x0031 {
                mstore(0x60, 0x0001)
                mstore(0x80, addr)
                mstore(0xa0, val)
                result := delegatecall(gas(), address(), 0x60, add(0x60, passThroughSize), 0, 0)
        }
        case 0x0032 {
                mstore(0x60, 0x0002)
                mstore(0x80, addr)
                mstore(0xa0, val)
                result := delegatecall(gas(), address(), 0x60, add(0x60, passThroughSize), 0, 0)
        }
        case 0x0033 {
                mstore(0x60, 0x0003)
                mstore(0x80, addr)
                mstore(0xa0, val)
                result := delegatecall(gas(), address(), 0x60, add(0x60, passThroughSize), 0, 0)
        }
        case 0x0034 {
                mstore(0x60, 0x0004)
                mstore(0x80, addr)
                mstore(0xa0, val)
                result := delegatecall(gas(), address(), 0x60, add(0x60, passThroughSize), 0, 0)
        }

        case 0x0041 {
                mstore(0x60, 0x0001)
                mstore(0x80, addr)
                mstore(0xa0, val)
                result := staticcall(gas(), address(), 0x60, add(0x60, passThroughSize), 0, 0)
        }
        case 0x0042 {
                mstore(0x60, 0x0002)
                mstore(0x80, addr)
                mstore(0xa0, val)
                result := staticcall(gas(), address(), 0x60, add(0x60, passThroughSize), 0, 0)
        }
        case 0x0043 {
                mstore(0x60, 0x0003)
                mstore(0x80, addr)
                mstore(0xa0, val)
                result := staticcall(gas(), address(), 0x60, add(0x60, passThroughSize), 0, 0)
        }
        case 0x0044 {
                mstore(0x60, 0x0004)
                mstore(0x80, addr)
                mstore(0xa0, val)
                result := staticcall(gas(), address(), 0x60, add(0x60, passThroughSize), 0, 0)
        }

        // In these next few calls, we're loading a test smart contract that less than 32 bytes into memorry at offset0. It should be safe to blow away the memory at offset 0 at this point
        case 0x0101 {
                // if there is insufficient gas
                mstore(0x0, 0x600E600C600039600E6000F3600160015B810190630000000456000000000000)
                let tmpAddr := create(0, 0x0, 0x20)
                pop(call(50000, tmpAddr, 0, 0, 0, 0, 0))
                result := call(gas(), addr, val, 0xc0, passThroughSize, 0, 0)
        }
        case 0x0201 {
                // if the instruction is invalid (and therefore its δ subscript is undefined)
                mstore(0x0, 0x6009600C60003960096000F3FE60005260206000F30000000000000000000000)
                let tmpAddr := create(0, 0x0, 0x20)
                pop(call(50000, tmpAddr, 0, 0, 0, 0, 0))
                result := call(gas(), addr, val, 0xc0, passThroughSize, 0, 0)
        }
        case 0x0301 {
                // if there are insufficient stack items
                mstore(0x0, 0x6001600C60003960016000F35000000000000000000000000000000000000000)
                let tmpAddr := create(0, 0x0, 0x20)
                pop(call(50000, tmpAddr, 0, 0, 0, 0, 0))
                result := call(gas(), addr, val, 0xc0, passThroughSize, 0, 0)
        }
        case 0x0401 {
                // if a JUMP/JUMPI destination is invalid
                mstore(0x0, 0x6007600C60003960076000F35B63FFFFFFFF5600000000000000000000000000)
                let tmpAddr := create(0, 0x0, 0x20)
                pop(call(50000, tmpAddr, 0, 0, 0, 0, 0))
                result := call(gas(), addr, val, 0xc0, passThroughSize, 0, 0)
        }
        case 0x0501 {
                // the new stack size would be larger than 1024
                mstore(0x0, 0x6008600C60003960086000F35B5F630000000056000000000000000000000000)
                let tmpAddr := create(0, 0x0, 0x20)
                pop(call(50000, tmpAddr, 0, 0, 0, 0, 0))
                result := call(gas(), addr, val, 0xc0, passThroughSize, 0, 0)
        }
        case 0x0601 {
                // if state modification is attempted during a static call
                mstore(0x0, 0x6003600C60003960036000F35F5F550000000000000000000000000000000000)
                let tmpAddr := create(0, 0x0, 0x20)
                pop(staticcall(50000, tmpAddr, 0, 0, 0, 0))
                result := call(gas(), addr, val, 0xc0, passThroughSize, 0, 0)
        }
        case 0x0701 {
                // if the gas left is less than the stipend
                mstore(0x0, 0x6008600C60003960086000F360015F5560025F55000000000000000000000000)
                let tmpAddr := create(0, 0x0, 0x20)
                pop(call(22210, tmpAddr, 0, 0, 0, 0, 0))
                result := call(gas(), addr, val, 0xc0, passThroughSize, 0, 0)
        }
        case 0x0801 {
                // Valid self destruct
                mstore(0x0, 0x6002600C60003960026000F332FF000000000000000000000000000000000000)
                let tmpAddr := create(0, 0x0, 0x20)
                pop(call(22210, tmpAddr, 0, 0, 0, 0, 0))
                result := call(gas(), addr, val, 0xc0, passThroughSize, 0, 0)
        }
        case 0x0901 {
                // Valid self destruct but in an invalid context
                mstore(0x0, 0x6002600C60003960026000F332FF000000000000000000000000000000000000)
                let tmpAddr := create(0, 0x0, 0x20)
                pop(staticcall(22210, tmpAddr, 0, 0, 0, 0))
                result := call(gas(), addr, val, 0xc0, passThroughSize, 0, 0)
        }

        // This smart contract is meant to copy the code of caller. In
        // this case, we can use it to duplicate this contract and
        // then call whatever address we're testing.
        //
        // 00000000: CALLER
        // 00000001: EXTCODESIZE
        // 00000002: PUSH0
        // 00000003: PUSH0
        // 00000004: CALLER
        // 00000005: EXTCODECOPY
        // 00000006: MSIZE
        // 00000007: PUSH0
        // 00000008: RETURN
        // 333B5F5F333C595FF3
        case 0x1001 {
                mstore(0x60, inputAction)
                mstore(0x80, addr)
                mstore(0xa0, val)

                mstore(0x0, 0x333B5F5F333C595FF30000000000000000000000000000000000000000000000)
                let tmpAddr := create(0, 0x0, 0x20)
                pop(call(gas(), tmpAddr, val, 0x60, add(0x60, passThroughSize), 0, 0))
        }
        case 0x2001 {
                mstore(0x60, inputAction)
                mstore(0x80, addr)
                mstore(0xa0, val)

                mstore(0x0, 0x333B5F5F333C595FF30000000000000000000000000000000000000000000000)
                let tmpAddr := create2(0, 0x0, 0x20, prevrandao())
                pop(call(gas(), tmpAddr, val, 0x60, add(0x60, passThroughSize), 0, 0))
        }

        default {
                result := 0
                // FAIL!
                mstore(0, 0x4641494c21)
        }

        if iszero(result) {
                revert(0,32)
        }
}
