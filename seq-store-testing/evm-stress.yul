// The point of this contract is to have some easy ways to send
// certain types of EVM cycles to the prover to try to stress it
// out. Each action can be called by providing one of the numbers
// based on the switch. If the number is even, we'll attempt to call
// the action with a large input. If the number is odd, we'll call the
// action in a loop with smaller inputs
{
        let action := calldataload(0)
        let limit := calldataload(32)
        let extaddress := calldataload(64)
        let i := 0

        if lt(limit, 100) {
                limit := 10000
        }
        if eq(extaddress, 0) {
                extaddress := address()
        }

        switch action

        // ADD - this is really just for reference puposes, The loop
        // in the next case is essentially the minimal case for this
        // tester.
        case 0x0000 {
                i := add(1, limit)
                mstore(0, i)
        }
        case 0x0001 {
                for {} gt(gas(), limit) {} {
                        i := add(i, 1)
                }
                mstore(0, i)
        }

        // KECCACK256 - In the first case, we're going to hash a lot
        // of data, as defined by the limit. In the loop case, we'll
        // call keccak over and over again in a sponge
        case 0x0002 {
                mstore(limit, extaddress)
                i := keccak256(32,limit)
                mstore(0, i)
        }
        case 0x0003 {
                for {} gt(gas(), limit) {} {
                        i := keccak256(0,32)
                        mstore(0, i)
                }
        }

        // CALLDATACOPY - in the single case, we'll copy the length
        // based on the limit. And in the loop case, we're going to
        // call the opcode in a loop with just the first 32 bytes.
        case 0x0004 {
                calldatacopy(0,0,limit)
        }
        case 0x0005 {
                for {} gt(gas(), limit) {} {
                        calldatacopy(0,0,32)
                }
        }

        // CODECOPY - in the single case, we'll copy all of the code
        // up until the limit. In the loop case, we'll copy the first
        // 32 bytes over and over again.
        case 0x0006 {
                codecopy(0,0,limit)
        }
        case 0x0007 {
                for {} gt(gas(), limit) {} {
                        codecopy(0,0,32)
                }
        }

        // EXTCODECOPY - will work the same way except we use the
        // address provide (or this code's address) to do the copies.
        case 0x0008 {
                extcodecopy(extaddress,0,0,limit)
        }
        case 0x0009 {
                for {} gt(gas(), limit) {} {
                        extcodecopy(extaddress,0,0,32)
                }
        }

        // EXTCODESIZE - will get the size of the code for the given
        // address. In the loop case, we'll do it over and over again.
        case 0x000A {
                i := extcodesize(extaddress)
                mstore(0, i)
        }
        case 0x000B {
                for {} gt(gas(), limit) {} {
                        i := extcodesize(extaddress)
                }
                mstore(0, i)
        }

        // EXTCODEHASH - is mostly the same logic, but getting the
        // code hash rather than the size.
        case 0x000C {
                i := extcodehash(extaddress)
                mstore(0, i)
        }
        case 0x000D {
                for {} gt(gas(), limit) {} {
                        i := extcodehash(extaddress)
                }
                mstore(0, i)
        }

        // BLOCKHASH - in the single case, we'll use the limit to
        // define how many blockhashes back we want to check. In the
        // loop case, we'll start at the current block number and work
        // our way backwards while fetching blockhashes.
        case 0x000E {
                i := blockhash(limit)
                mstore(0, i)
        }
        case 0x000F {
                let bn := number()
                for {} gt(gas(), limit) {} {
                        i := blockhash(bn)
                        bn := sub(bn, 1)
                }
                mstore(0, i)
        }

        // MLOAD - in the single case, we'll load at the limit. In the
        // loop case, we'll keep loading from new offsets.
        case 0x0010 {
                i := mload(limit)
                mstore(0, i)
        }
        case 0x0011 {
                i := 0
                mstore(limit, extaddress)
                for {} gt(gas(), limit) {} {
                        pop(mload(i))
                        i := add(32, i)
                }
                mstore(0, i)
        }

        // MSTORE - in the single case, we'll store some data at the
        // offset determined by limit. In the loop case, we'll
        // continually store data at different offsets
        case 0x0012 {
                mstore(limit, extaddress)
        }
        case 0x0013 {
                i := 0
                for {} gt(gas(), limit) {} {
                        mstore(i, extaddress)
                        i := add(32, i)
                }
        }
        // SLOAD - we'll load based on the limit in the single case,
        // and in the loop case we'll keep loading based on different
        // slots.
        case 0x0014 {
                i := sload(limit)
                mstore(0, i)
        }
        case 0x0015 {
                i := 0
                for {} gt(gas(), limit) {} {
                        pop(sload(i))
                        i := add(i, 1)
                }
                mstore(0, i)
        }

        // SSTORE - works similarly but we'll be storing instead of
        // loading
        case 0x0016 {
                sstore(limit, extaddress)
        }
        case 0x0017 {
                i := 0
                for {} gt(gas(), limit) {} {
                        sstore(i, i)
                        i := add(i, 1)
                }
                mstore(0, i)
        }

        // MCOPY - Copy based on the limit in the single case. In the
        // loop case, we'll keep copying 32 bytes over and over again
        case 0x0018 {
                mstore(limit, extaddress)
                mcopy(0, 32, limit)
        }
        case 0x0019 {
                mstore(limit, extaddress)
                for {} gt(gas(), limit) {} {
                        mcopy(0, i, 32)
                        i := add(i, 32)

                }
                mstore(0, i)
        }
        // LOG4 - in the single case, we're just calling it once and
        // in the case of a loop we're going to call log4 as many
        // times as we can.
        case 0x001A {
                log4(0, limit, 0, 0, 0 ,0)
        }
        case 0x001B {
                for {} gt(gas(), limit) {} {
                        log4(0, 32, 0, 0, 0 ,0)
                }
        }

        // CREATE - in the single case, we'll try to create a large
        // contract based on the limit. In the loop case, we'll call
        // create over and over again.
        case 0x001C {
                mstore(limit, extaddress)
                i := create(0, 0, limit)
                mstore(0, i)
        }
        case 0x001D {
                mstore(0, 0x6300000003630000001560003963000000036000f35f5ff30000000000000000)
                for {} gt(gas(), limit) {} {
                        i := create(0, 0, 24)
                }
                mstore(0, i)
        }

        // CREATE2 - is the same idea as create but using the deterministic opcode
        case 0x001E {
                mstore(limit, extaddress)
                i := create2(0, 0, limit, 0)
                mstore(0, i)
        }
        case 0x001F {
                mstore(0, 0x6300000003630000001560003963000000036000f35f5ff30000000000000000)
                for {} gt(gas(), limit) {} {
                        i := create2(0, 0, 24, i)
                }
                mstore(0, i)
        }

        // ECRECOVER - We'll use a common test vector to call the 0x01 op code in a loop or just once
        case 0x0020 {
                mstore(0, 0x456e9aea5e197a1f1af7a3e85a3212fa4049a3ba34c2289b4c860fc0b0c64ef3)
                mstore(32, 28)
                mstore(64, 0x9242685bf161793cc25603c231bc2f568eb630ea16aa137d2664ac8038825608)
                mstore(96, 0x4f8ae3bd7535248d0bd448298cc2e2071e56992d0774dc340c368ae950852ada)
                pop(call(limit, 0x01, 0, 0, 128, 0, 32))
        }
        case 0x0021 {
                mstore(0, 0x456e9aea5e197a1f1af7a3e85a3212fa4049a3ba34c2289b4c860fc0b0c64ef3)
                mstore(32, 28)
                mstore(64, 0x9242685bf161793cc25603c231bc2f568eb630ea16aa137d2664ac8038825608)
                mstore(96, 0x4f8ae3bd7535248d0bd448298cc2e2071e56992d0774dc340c368ae950852ada)
                for {} gt(gas(), limit) {} {
                        pop(call(gas(), 0x01, 0, 0, 128, 0, 32))
                }
        }
        // SHA2-256 - in the single case, we'll do a memory expansion
        // and then do a large sha2 call. In the loop case, we'll just
        // call the precompile over and over again like a sponge
        case 0x0022 {
                mstore(limit, extaddress)
                pop(call(gas(), 0x02, 0, 0, add(limit,32), 0, 32))
        }
        case 0x0023 {
                for {} gt(gas(), limit) {} {
                        pop(call(gas(), 0x02, 0, 0, 32, 0, 32))
                }
        }

        // RIPEMD-160 - the logic here is meant to be the same!
        case 0x0024 {
                mstore(limit, extaddress)
                pop(call(gas(), 0x03, 0, 0, add(limit,32), 0, 32))
        }
        case 0x0025 {
                for {} gt(gas(), limit) {} {
                        pop(call(gas(), 0x03, 0, 0, 32, 0, 32))
                }
        }

        // MODEXP - we've taken one of the test cases from
        // go-ethereum. We're either running it once or running it
        // again and again in a loop
        case 0x0026 {
                // nagydani-1-square
                // https://github.com/ethereum/go-ethereum/blob/4cda8f06ea688cc3e523ee1e35425393ecad807c/core/vm/testdata/precompiles/modexp.json#L19C14-L19C31
                mstore(0,   0x0000000000000000000000000000000000000000000000000000000000000040)
                mstore(32,  0x0000000000000000000000000000000000000000000000000000000000000001)
                mstore(64,  0x0000000000000000000000000000000000000000000000000000000000000040)
                mstore(96,  0xe09ad9675465c53a109fac66a445c91b292d2bb2c5268addb30cd82f80fcb003)
                mstore(128, 0x3ff97c80a5fc6f39193ae969c6ede6710a6b7ac27078a06d90ef1c72e5c85fb5)
                mstore(160, 0x02fc9e1f6beb81516545975218075ec2af118cd8798df6e08a147c60fd6095ac)
                mstore(192, 0x2bb02c2908cf4dd7c81f11c289e4bce98f3553768f392a80ce22bf5c4f4a248c)
                mstore(224, 0x6b00000000000000000000000000000000000000000000000000000000000000)
                pop(call(gas(), 0x05, 0, 0, 256, 0, 64))
        }
        case 0x0027 {
                mstore(0,   0x0000000000000000000000000000000000000000000000000000000000000040)
                mstore(32,  0x0000000000000000000000000000000000000000000000000000000000000001)
                mstore(64,  0x0000000000000000000000000000000000000000000000000000000000000040)
                mstore(96,  0xe09ad9675465c53a109fac66a445c91b292d2bb2c5268addb30cd82f80fcb003)
                mstore(128, 0x3ff97c80a5fc6f39193ae969c6ede6710a6b7ac27078a06d90ef1c72e5c85fb5)
                mstore(160, 0x02fc9e1f6beb81516545975218075ec2af118cd8798df6e08a147c60fd6095ac)
                mstore(192, 0x2bb02c2908cf4dd7c81f11c289e4bce98f3553768f392a80ce22bf5c4f4a248c)
                mstore(224, 0x6b00000000000000000000000000000000000000000000000000000000000000)

                for {} gt(gas(), limit) {} {
                        pop(call(gas(), 0x05, 0, 0, 256, 0, 64))
                }
        }

        // ECADD - Run once or in a loop
        case 0x0028 {
                mstore(0,   0x0000000000000000000000000000000000000000000000000000000000000001)
                mstore(32,  0x0000000000000000000000000000000000000000000000000000000000000002)
                mstore(64,  0x0000000000000000000000000000000000000000000000000000000000000001)
                mstore(96,  0x0000000000000000000000000000000000000000000000000000000000000002)
                pop(call(gas(), 0x06, 0, 0, 128, 0, 64))
        }
        case 0x0029 {
                mstore(0,   0x0000000000000000000000000000000000000000000000000000000000000001)
                mstore(32,  0x0000000000000000000000000000000000000000000000000000000000000002)
                mstore(64,  0x0000000000000000000000000000000000000000000000000000000000000001)
                mstore(96,  0x0000000000000000000000000000000000000000000000000000000000000002)

                for {} gt(gas(), limit) {} {
                        pop(call(gas(), 0x06, 0, 0, 128, 0, 64))
                }
        }

        // ECMUL - Run once or in a loop
        case 0x002A {
                mstore(0,   0x0000000000000000000000000000000000000000000000000000000000000001)
                mstore(32,  0x0000000000000000000000000000000000000000000000000000000000000002)
                mstore(64,  0x0000000000000000000000000000000000000000000000000000000000000002)
                pop(call(gas(), 0x07, 0, 0, 128, 0, 64))
        }
        case 0x002B {
                mstore(0,   0x0000000000000000000000000000000000000000000000000000000000000001)
                mstore(32,  0x0000000000000000000000000000000000000000000000000000000000000002)
                mstore(64,  0x0000000000000000000000000000000000000000000000000000000000000002)

                for {} gt(gas(), limit) {} {
                        pop(call(gas(), 0x07, 0, 0, 128, 0, 64))
                }
        }

        // ECPAIRING - This will run once or in a loop
        case 0x002C {
                mstore(0, 0x2cf44499d5d27bb186308b7af7af02ac5bc9eeb6a3d147c186b21fb1b76e18da)
                mstore(32, 0x2c0f001f52110ccfe69108924926e45f0b0c868df0e7bde1fe16d3242dc715f6)
                mstore(64, 0x1fb19bb476f6b9e44e2a32234da8212f61cd63919354bc06aef31e3cfaff3ebc)
                mstore(96, 0x22606845ff186793914e03e21df544c34ffe2f2f3504de8a79d9159eca2d98d9)
                mstore(128, 0x2bd368e28381e8eccb5fa81fc26cf3f048eea9abfdd85d7ed3ab3698d63e4f90)
                mstore(160, 0x2fe02e47887507adf0ff1743cbac6ba291e66f59be6bd763950bb16041a0a85e)
                mstore(192, 0x0000000000000000000000000000000000000000000000000000000000000001)
                mstore(224, 0x30644e72e131a029b85045b68181585d97816a916871ca8d3c208c16d87cfd45)
                mstore(256, 0x1971ff0471b09fa93caaf13cbf443c1aede09cc4328f5a62aad45f40ec133eb4)
                mstore(288, 0x091058a3141822985733cbdddfed0fd8d6c104e9e9eff40bf5abfef9ab163bc7)
                mstore(320, 0x2a23af9a5ce2ba2796c1f4e453a370eb0af8c212d9dc9acd8fc02c2e907baea2)
                mstore(352, 0x23a8eb0b0996252cb548a4487da97b02422ebc0e834613f954de6c7e0afdc1fc)

                pop(call(gas(), 0x08, 0, 0, 384, 0, 32))
        }
        case 0x002D {
                mstore(0, 0x2cf44499d5d27bb186308b7af7af02ac5bc9eeb6a3d147c186b21fb1b76e18da)
                mstore(32, 0x2c0f001f52110ccfe69108924926e45f0b0c868df0e7bde1fe16d3242dc715f6)
                mstore(64, 0x1fb19bb476f6b9e44e2a32234da8212f61cd63919354bc06aef31e3cfaff3ebc)
                mstore(96, 0x22606845ff186793914e03e21df544c34ffe2f2f3504de8a79d9159eca2d98d9)
                mstore(128, 0x2bd368e28381e8eccb5fa81fc26cf3f048eea9abfdd85d7ed3ab3698d63e4f90)
                mstore(160, 0x2fe02e47887507adf0ff1743cbac6ba291e66f59be6bd763950bb16041a0a85e)
                mstore(192, 0x0000000000000000000000000000000000000000000000000000000000000001)
                mstore(224, 0x30644e72e131a029b85045b68181585d97816a916871ca8d3c208c16d87cfd45)
                mstore(256, 0x1971ff0471b09fa93caaf13cbf443c1aede09cc4328f5a62aad45f40ec133eb4)
                mstore(288, 0x091058a3141822985733cbdddfed0fd8d6c104e9e9eff40bf5abfef9ab163bc7)
                mstore(320, 0x2a23af9a5ce2ba2796c1f4e453a370eb0af8c212d9dc9acd8fc02c2e907baea2)
                mstore(352, 0x23a8eb0b0996252cb548a4487da97b02422ebc0e834613f954de6c7e0afdc1fc)

                for {} gt(gas(), limit) {} {
                       pop(call(gas(), 0x08, 0, 0, 384, 416, 32))
                }
                i := mload(416)
                mstore(0, i)
        }

        // BLAKE2F - Will run once or in a loop with the final flag set to 0.
        case 0x002E {
                mstore(0,   0x0000000148c9bdf267e6096a3ba7ca8485ae67bb2bf894fe72f36e3cf1361d5f)
                mstore(32,  0x3af54fa5d182e6ad7f520e511f6c3e2b8c68059b6bbd41fbabd9831f79217e13)
                mstore(64,  0x19cde05b61626300000000000000000000000000000000000000000000000000)
                mstore(96,  0x0000000000000000000000000000000000000000000000000000000000000000)
                mstore(128, 0x0000000000000000000000000000000000000000000000000000000000000000)
                mstore(160, 0x0000000000000000000000000000000000000000000000000000000000000000)
                mstore(192, 0x0000000003000000000000000000000000000000010000000000000000000000)
                pop(call(gas(), 0x09, 0, 0, 213, 0, 64))
        }
        case 0x002F {
                mstore(0,   0x0000000148c9bdf267e6096a3ba7ca8485ae67bb2bf894fe72f36e3cf1361d5f)
                mstore(32,  0x3af54fa5d182e6ad7f520e511f6c3e2b8c68059b6bbd41fbabd9831f79217e13)
                mstore(64,  0x19cde05b61626300000000000000000000000000000000000000000000000000)
                mstore(96,  0x0000000000000000000000000000000000000000000000000000000000000000)
                mstore(128, 0x0000000000000000000000000000000000000000000000000000000000000000)
                mstore(160, 0x0000000000000000000000000000000000000000000000000000000000000000)
                mstore(192, 0x0000000003000000000000000000000000000000000000000000000000000000)
                for {} gt(gas(), limit) {} {
                        pop(call(gas(), 0x09, 0, 0, 213, 4, 64))
                }
        }

        // POINT EVALUATION - Same standard logic of running once or in a loop here
        case 0x0030 {
                mstore(0,   0x01e798154708fe7789429634053cbf9f99b619f9f084048927333fce637f549b)
                mstore(32,  0x564c0a11a0f704f4fc3e8acfe0f8245f0ad1347b378fbf96e206da11a5d36306)
                mstore(64,  0x24d25032e67a7e6a4910df5834b8fe70e6bcfeeac0352434196bdf4b2485d5a1)
                mstore(96,  0x8f59a8d2a1a625a17f3fea0fe5eb8c896db3764f3185481bc22f91b4aaffcca2)
                mstore(128, 0x5f26936857bc3a7c2539ea8ec3a952b7873033e038326e87ed3e1276fd140253)
                mstore(160, 0xfa08e9fc25fb2d9a98527fc22a2c9612fbeafdad446cbc7bcdbdcd780af2c16a)
                pop(call(gas(), 0x0a, 0, 0, 192, 0, 64))
                i := mload(32)
                mstore(0, i)
        }
        case 0x0031 {
                mstore(0,   0x01e798154708fe7789429634053cbf9f99b619f9f084048927333fce637f549b)
                mstore(32,  0x564c0a11a0f704f4fc3e8acfe0f8245f0ad1347b378fbf96e206da11a5d36306)
                mstore(64,  0x24d25032e67a7e6a4910df5834b8fe70e6bcfeeac0352434196bdf4b2485d5a1)
                mstore(96,  0x8f59a8d2a1a625a17f3fea0fe5eb8c896db3764f3185481bc22f91b4aaffcca2)
                mstore(128, 0x5f26936857bc3a7c2539ea8ec3a952b7873033e038326e87ed3e1276fd140253)
                mstore(160, 0xfa08e9fc25fb2d9a98527fc22a2c9612fbeafdad446cbc7bcdbdcd780af2c16a)
                for {} gt(gas(), limit) {} {
                        pop(call(gas(), 0x0a, 0, 0, 192, 192, 64))
                }
                i := mload(224)
                mstore(0, i)
        }

        // RIP-7212 - In the case where we can access 0x100, we can
        // validate the this signature in a loop
        case 0x0032 {
                mstore(0,   0xb7b8486d949d2beef140ca44d4c8c0524dd53a250fadefa477b2db15b7d38776)
                mstore(32,  0xbeb9e3aacfdc1408bfe5f876d9ab6f7c50e06a2d5f68aa500b9a2ff896587597)
                mstore(64,  0xba72bb78539ef6de9188a0ce5e6d694e2b0cb5aeda35d7ccbb335f6cb5e97d88)
                mstore(96,  0x32f6471f0e06a4830d24eaecfac34e12ad223211a89c42aaf11f44ce3364233a)
                mstore(128, 0x4cfeddbcb7aa6aad4226715338725398546cb20ba2e8b133b2abae61cfc624d0)

                pop(call(gas(), 0x100, 0, 0, 160, 0, 32))
        }
        case 0x0033 {
                mstore(0,   0xb7b8486d949d2beef140ca44d4c8c0524dd53a250fadefa477b2db15b7d38776)
                mstore(32,  0xbeb9e3aacfdc1408bfe5f876d9ab6f7c50e06a2d5f68aa500b9a2ff896587597)
                mstore(64,  0xba72bb78539ef6de9188a0ce5e6d694e2b0cb5aeda35d7ccbb335f6cb5e97d88)
                mstore(96,  0x32f6471f0e06a4830d24eaecfac34e12ad223211a89c42aaf11f44ce3364233a)
                mstore(128, 0x4cfeddbcb7aa6aad4226715338725398546cb20ba2e8b133b2abae61cfc624d0)

                for {} gt(gas(), limit) {} {
                        pop(call(gas(), 0x100, 0, 0, 160, 0, 32))
                }
        }

        // MISC
        // BLAKE2F variable rounds- Will run once or in a loop with the final flag set to 0.
        case 0x0100 {
                limit := shl(224, limit)
                let blakeInput := 0x0000000148c9bdf267e6096a3ba7ca8485ae67bb2bf894fe72f36e3cf1361d5f
                blakeInput := or(limit, blakeInput)

                mstore(0,   blakeInput)
                mstore(32,  0x3af54fa5d182e6ad7f520e511f6c3e2b8c68059b6bbd41fbabd9831f79217e13)
                mstore(64,  0x19cde05b61626300000000000000000000000000000000000000000000000000)
                mstore(96,  0x0000000000000000000000000000000000000000000000000000000000000000)
                mstore(128, 0x0000000000000000000000000000000000000000000000000000000000000000)
                mstore(160, 0x0000000000000000000000000000000000000000000000000000000000000000)
                mstore(192, 0x0000000003000000000000000000000000000000010000000000000000000000)
                pop(call(gas(), 0x09, 0, 0, 213, 0, 64))
        }

        default {
                // FAIL!
                mstore(0, 0x4641494c21)
                revert(0,0x20)
        }

        // Done, we'll log and return whatever was stored at offset 0
        log0(0, 32)
        return(0, 32)
}
