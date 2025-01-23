genesis_constants = import_module("./genesis_constants.star")

PRE_FUNDED_ACCOUNTS = [
    # m/44'/60'/0'/0/0
    genesis_constants.new_prefunded_account(
        # ETH/Tendermint account - used by heimdall validators.
        genesis_constants.new_account(
            "0x97538585a02A3f1B1297EB9979cE1b34ff953f1E",
            "0x93e8717f46b146ebfb99159eb13a5d044c191998656c8b79007b16051bb1ff762d09884e43783d898dd47f6220af040206cabbd45c9a26bb278a522c3d538a1f",
            "2a4ae8c4c250917781d38d95dafbb0abe87ae2c9aea02ed7c7524685358e49c2",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        genesis_constants.new_account(
            "0x99AA9FC116C1E5E741E9EC18BD1FD232130A5C44",
            "BBNYN0nMJsgo0Fp3kVW85PRGBNe7Gdz1XBFuTWQ7D8FnKRb2JYO3i3FK2UiA5+gTSxYu1K66KdYjQYP1mOkH09g=",
            "OP72E0D7GEi/4VySpolVudLW7uPJm+6PWEtFKJmvp1M=",
        ),
    ),
    # m/44'/60'/0'/0/1
    genesis_constants.new_prefunded_account(
        # ETH/Tendermint account - used by heimdall validators.
        genesis_constants.new_account(
            "0xeeE6f79486542f85290920073947bc9672C6ACE5",
            "0x0f554daf002c359281a9c5c3cb6639cab12259f570d6d10cb15e3f82a79e75aa4924f01f530068b4a0113f77e69ba5434ca01100a182fbca2609e29c4a9de91f",
            "f92738db8be69a9694b08acfc8e8fa843578da5adfcf4de77482c5a2b15681ad",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        genesis_constants.new_account(
            "0x4A1944A4B8A4BE56220D132D971A8DE74543AAD3",
            "BNPWXoLfaCc3x/ln5gA525biIjkDoz9njB9AGyluokwqJRgdw/R0DzI4AtmweRyBc52j2ctLLF6mZPkJLkhbDmI=",
            "4dgx+SPKWmTjMxXgfc2+MfNwrf+7UavfCuL3Zb3YVLY=",
        ),
    ),
    # m/44'/60'/0'/0/2
    genesis_constants.new_prefunded_account(
        # ETH/Tendermint account - used by heimdall validators.
        genesis_constants.new_account(
            "0xA831F4E702F374aBf14d8005e21DC6d17d84DfCc",
            "0xcc0eeb4abe520999ee310aa0a9a485527edd584c1fd9e9981144ff2c574e5bf87b5549902afd05ab2b5c50bd8b1f2c6f648da71723fdf5721afe39c6fe491a45",
            "8f723ed84785cbb3202643d986c4ec6052ec9c55af8cbb84046eab7104ad0e75",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        genesis_constants.new_account(
            "0xE4B22D40506E095A6F1F77919D6F5054B191D0F1",
            "BN5GH8274CPXHunsbXNyIFVqq303JU7vO9EfQ3Vl8Zi+eI3faDHLIiL9aysldHFBZxjOlzjrjTysDhtZHXe3t7k=",
            "YJn/T0tXOuCM/ejCk6vjJIlGAJa4qzuuO8excN4Dohg=",
        ),
    ),
    # m/44'/60'/0'/0/3
    genesis_constants.new_prefunded_account(
        # ETH/Tendermint account - used by heimdall validators.
        genesis_constants.new_account(
            "0xd3cc855bDb41498920792b77aBCB7431617fA9a4",
            "0x79e9c953100c624ffc7f32f61fb378f28141bebc00d51376fd96d5c1b31517cb13182f489b0e4578430d9d8e72de1be51c0c624f7aea86e650bf86d3d5da063a",
            "0b8a62723fa93e4da7b3f09845d0c2c23d2807bd9f6b15ffb9037768e45ceca1",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        genesis_constants.new_account(
            "0x893B20B0DA3572D070BB0FF487443B1FBDBA0C9E",
            "BJcyJPPfGCyVWZB5SrX9nPgrYe3Gq1WKEw+76Pf1k2lIzsSGaJ8jc8DW+Pw/KdRbmJldHjjtkyAnO/ZqLvW53Uo=",
            "yGeQrudkl2NeMpHso+VtovHa9UPDeM77M1n2ckSWubg=",
        ),
    ),
    # m/44'/60'/0'/0/4
    genesis_constants.new_prefunded_account(
        # ETH/Tendermint account - used by heimdall validators.
        genesis_constants.new_account(
            "0xF2dBc05C1f99b6E3442Dbd5524d1fAB7959Fc939",
            "0x22997e0dc45b54926a12b5e668347979df3abc8c1d2bc2cec388e40c569b35be3cb907d15e5eb616afcf3279e8d0901373e81e1b25149e497036c7646542f492",
            "d160c2a27d6724c946082baeee53fd12d3053d95ddcea692db7ab24eaeee668c",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        genesis_constants.new_account(
            "0x489E92C76479512BD9DF65F5143CD852BB8F4895",
            "BHCwHj6gUrDlm6FAmGUYkmyr4yYCEf6WS1SBHf86MWls3iODCfXz5ejBd+xMi6iFKHBtDcaaGOIZXPuh9cVcyM8=",
            "m1fi1IjSnkYPxUna5kKiR7hVu2JiqJJIDiHwqnVSppU=",
        ),
    ),
    # m/44'/60'/0'/0/5
    genesis_constants.new_prefunded_account(
        # ETH/Tendermint account - used by heimdall validators.
        genesis_constants.new_account(
            "0x9bDc763175f3506dEdb5F139854730E23cA82F69",
            "0x72aff4b816c1ab1a2b58f2b22ae6f2547197f06419dd82b1aa7ebf9bc4cd6c679b8f616fa6669dc236c212b2c5894dec62516239fd33788dc24f8cdaed9bf0fa",
            "bca5312c2a0d4cd192d6ed46dadeeb04df40de4e08b1c1757b07fff42b4b951b",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        genesis_constants.new_account(
            "0x71C670B96F3EEE0F915463AFAD08987CD4A25BC5",
            "BNQlh+0LVAh59o/dE3hHBkNsrKzt2VLY5JJBDl4Kx6pE0bkIhnXNYWU50NAyiKJyy7PJgc4Jj5EY270i/ZQw/SM=",
            "X4pt6sMIF3yewtD4Uhr3Fk0zvlzpab4ezXhAXQ4voxc=",
        ),
    ),
    # m/44'/60'/0'/0/6
    genesis_constants.new_prefunded_account(
        # ETH/Tendermint account - used by heimdall validators.
        genesis_constants.new_account(
            "0x307f0aA1456F0B3EDec56D6bA7ebC817D09483cC",
            "0x5499522100dd63e08eadb19aa547ec775b21d8de43e127973a65404224343dd8086c266e651ea9553c2b9db633b74754198c9b233adf7faa1c7f42613d0d18cd",
            "c76fcf0d1a590a60e619a92929848d836975eb9270daf91baeb06449211d62cb",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        genesis_constants.new_account(
            "0xD3DCC37D163F1C3978CE03F5BECC763609144318",
            "BC3xGC1M6iZcv+ODkpTxy498oHJDVIK/bTSQuoUTy3yB3qwb5a1lZZIGZAORvzvTTrYEbqGAl1xftoownm9/k9Q=",
            "O8jA4h/EuLdQ5neFZTRH7FJl1rsCIvRzs/Vl3PK46AQ=",
        ),
    ),
    # m/44'/60'/0'/0/7
    genesis_constants.new_prefunded_account(
        # ETH/Tendermint account - used by heimdall validators.
        genesis_constants.new_account(
            "0x2c64Cab78F2A9AAb96514c5151Afa571301D45d9",
            "0x98050375761d6e2dd76d7dee10fa6eb7c6c2ff50870983eddb939b7d21ed000001e419bd73619c77ce049b9511fb3df85e4965d7365cc783f5f48f41071d09c2",
            "ab2e777a68e3976dfd099114ca296ea21c14562ae662cc2f093917a842b1d2d3",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        genesis_constants.new_account(
            "0xC96BDCD8F2E32D45DBBEACBF4BCC8717DE18F81B",
            "BA1/MiJ2fnHkKXpv6auPzK5yqr4ut3cxMoxblvjCsmwzgSa3isbNqBf/1zEliDRWAX2W6minG6cmzGB3dJrU3sI=",
            "c4UjrvacP5li1x8ilwBZ7GUZopuEuqCLPusQyYJvDM4=",
        ),
    ),
    # m/44'/60'/0'/0/8
    genesis_constants.new_prefunded_account(
        # ETH/Tendermint account - used by heimdall validators.
        genesis_constants.new_account(
            "0xB14908C693fb97dd65bFf82161c2Bdf442B0C952",
            "0x48cc364c82d72238fd94b3a02deaefb05ac8be2da1f8e28d79f7a04a48a656de84abd0f4a03dcb18802f8b8887c649dad0493956a4e947b29f79da29830f038c",
            "92a496c090beb90eac20b8436717f8943e05aff216dbfd3ddcab5463cf2a937f",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        genesis_constants.new_account(
            "0x92AE69B3DFE8AC8F0023444BD3BDA60B34344EFB",
            "BOZyAuU0TW/6VLlKzStIMef0BUlmpLIsi1m3YKfDLu/GGh/T1AdBblHKdpmb6AjHH8RuWoQkTMiro/b5aeIjaFU=",
            "6FQllohqNHsfIH2eciHaALIzYszKB9DbJMpV4meTQnQ=",
        ),
    ),
    # m/44'/60'/0'/0/9
    genesis_constants.new_prefunded_account(
        # ETH/Tendermint account - used by heimdall validators.
        genesis_constants.new_account(
            "0x3d3e0AdB250437A85013EdD735Af309D29FC6b09",
            "0xa9cd729e66235cc5b32379d24eef7db703b1e552854c02f3abd2bf6633279bc81d5619163d252b8ed718a3080f5b093370fb6135ae6ddde9f7b9a8a0a548328b",
            "0dd4644d7ac1c3a4b210132e694ef6e5121e79bdc75e5eb2383f85af3f9b8c22",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        genesis_constants.new_account(
            "0xAC4984B2861C51FFBD9C8BEED763C1FFE830CCBD",
            "BFtEV3SSKdRDPMsAtd6c3O9IzUPgcF3dr9iZ/232pl9KAXl9teffrNWYBqTNoUAljA07U2ZXOFo78Q5hFBmFHMo=",
            "YRhmSt6k/LpU4vV9YloySjfrJESRhOi0VCRLahpxOZw=",
        ),
    ),
    # m/44'/60'/0'/0/10
    genesis_constants.new_prefunded_account(
        # ETH/Tendermint account - used by heimdall validators.
        genesis_constants.new_account(
            "0x3857C1b962cd62f2c45196b319493cEd7bB2b580",
            "0xa9182f349f6696c9409244a0c68b366ff0242550dfcf42c0ed2fbb6f4d7576addb6d744910ec6fbd59f529933b0c93a54e04de4f20eb1e2db32d3be96442b839",
            "c4189cdedadb8a4e191f190de6f056eed3cf9aa7c003d146558a9e9979e7dd99",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        genesis_constants.new_account(
            "0x17475D15125F79EE4D486E104678D42319E961F4",
            "BPFPSIdpgm8Ek82lLkxNxLDdBYfdCsTUKotVmnxM993VwdPJneEKoDKK5R+BvObtERx5gjXCglqGyy/8Wxm/fT0=",
            "8SI7D2PKDYschluskP0k7UVgOnpkKSP971ooNxu8Bto=",
        ),
    ),
    # m/44'/60'/0'/0/11
    genesis_constants.new_prefunded_account(
        # ETH/Tendermint account - used by heimdall validators.
        genesis_constants.new_account(
            "0x37B6d1C512ffD61242c69863da2CADDBA89f06a1",
            "0x75911c34f7f0d4032e7b90a8fb8f8dec6e5639c3c58ac0e50634fe5350a3a7b1906620b6e12a513d71b0d665a462521602d56a8ac3320777c896223ff85aced1",
            "fe991dc58ae456b7e44eabddd475dace31dbbcc709c0dd26c73f1bf9efe9e6ef",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        genesis_constants.new_account(
            "0x9EDB08DF06A7F2267D08A9AE8C2D24EF6F8586A1",
            "BFFM3hI8hi52AUrCCTwGU2eaWIM2Ms6aXU+QDv2zD37gY8DxBKaP585dcwK9h/hssc09QWmoAKr4N3+yLxjrMF4=",
            "XbLrIpwnyiesOVdS0L3i6WoRi9lFIo5wTmpLXuZ8Tjg=",
        ),
    ),
    # m/44'/60'/0'/0/12
    genesis_constants.new_prefunded_account(
        # ETH/Tendermint account - used by heimdall validators.
        genesis_constants.new_account(
            "0x230fbC3D831bADa13df3F91ac6143FaFf595367A",
            "0x1c5cd9439d8ad6f72bc4a4e0623f1521c5a2634f2afd51454f44b045581910aab8c3eed7fdfa9764c2ece1527b83ac580f9e83201d81ffdabe9c5ad37c5b4b34",
            "4560a7941500b694f880f73de5e85886f90a4a59264aeec5dc74e6468fb6e7c3",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        genesis_constants.new_account(
            "0x43F3BB24DB51741AD962875A043CB7D45D5167B8",
            "BOTcIJ1B4dsLatjQWbicDqh1RVVGb4EsFb0ZT9EbXvqjCFuRLKJeJObAdZwU8+X0Tbhlc/dyA8SbZGwv7Gs7mL4=",
            "px3C9wTYKoaQdRewoyNXeyUvOni4pwzKRhLlxfdABLQ=",
        ),
    ),
    # m/44'/60'/0'/0/13
    genesis_constants.new_prefunded_account(
        # ETH/Tendermint account - used by heimdall validators.
        genesis_constants.new_account(
            "0x22b15948E0925214E959Fca360ffdfA74780dF93",
            "0x52ee83dc0ba83f0c12cd8061a7174666f7b1718ac011adc1b2e742f6ec3d2e0a99a33c170b0202c29381611ef2254186808667385384aa927760167043e6f486",
            "2cdae5202d2fcee6ff93ad695e5046ebd89d95d75cddee7f89e1306b0c841eba",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        genesis_constants.new_account(
            "0x5AC4630C7FF88056E85592DC74806AB8EF22B796",
            "BIo0vg2/xFjbPev9YKzuZZi+Lld/XyhcQr/k40YTIv2aOSEh3DsCJl/7fgKhgseN2MT50abIg+qVyBShLSf9Rlo=",
            "qkDPZYHxY5JO2uTdPWUwfygqwyvaiyKTidPXn2jXNKY=",
        ),
    ),
    # m/44'/60'/0'/0/14
    genesis_constants.new_prefunded_account(
        # ETH/Tendermint account - used by heimdall validators.
        genesis_constants.new_account(
            "0xf3DB09Faf87062b10e4e65000897d0e06e7BECd4",
            "0x8115ba7ae42a0b4427ef598ab3b7adca32549783b6b4317ceaf53fb51dc0b543200c8935ddf85816252857b3cef2ccab2768d92ecf3a2c162769096fd8d06aff",
            "5d3af80cb644f2e3323cc9ae274acc471c63977ebd1bbb9c0f52a8607b8cdf5a",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        genesis_constants.new_account(
            "0xD813AC9374B09E83FB80A00A0F2BC91DB9D95F43",
            "BD42d0KjR79VRZ6+9gjmrbDRp8aT7pNMpKGhSh5SUyyakAf/djUs8sONWTVYVJTAJbyB4gF29DDcRZZ0CuT6qZ8=",
            "eAObYoTpUzrbzNOr5fAkdvC3HKDtzdt4vxXevs1DHC8=",
        ),
    ),
    # m/44'/60'/0'/0/15
    genesis_constants.new_prefunded_account(
        # ETH/Tendermint account - used by heimdall validators.
        genesis_constants.new_account(
            "0x67f6074cd99d55a3587dCF745bC72AA64585C927",
            "0xd828760cc874e8c2ed91af9ffc5d06892b8441fbc4538978cd0764c5137e25455913ef5a39947ac7dfe7bc7134738017842a178d6fe1c50d593253f77c49d4e0",
            "95eb7846413fb242606bd4ecc05f327ed0548bde68077f746c201a3f94caf025",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        genesis_constants.new_account(
            "0xA52A6A308679B1DDFBAC87FCF1DA61E40AF310DD",
            "BJRY0i9OW2wKWMMqJ1g7nS5YOjD9sdviTm4HFmZy3/IHP6p6jGoZkXYweryGNzM22SRAl4x7Esh63i4RwMEKq44=",
            "/l9AVmC7nwUvooAL0yVwIQr2VfTkakkENz/5XJeAnes=",
        ),
    ),
    # m/44'/60'/0'/0/16
    genesis_constants.new_prefunded_account(
        # ETH/Tendermint account - used by heimdall validators.
        genesis_constants.new_account(
            "0xe06dcDdcf4eC8932FeeD78A6f0170Ca1F783927C",
            "0x9e393f7aba401b52f923864c741586d8a2e0baab346a53f1f8a730a5b06cdab38a942608cdb685f9b489aa175299f9e72e093045f80bffba500e9d75623ab546",
            "e179a53c5d09f522b0fa627c8f4aa62d5f9191cb187cf498d151d4f1ebd3bca2",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        genesis_constants.new_account(
            "0x68E777CA852EFF8F69C2071392435373840E0BE7",
            "BL72ykg2CUa877wFat4m9c5XfSTGg1WFPLXwi439aC0GC9QrGOKEqzgb4E/zb9U76e78RzmGCN7IOF60pJLsXdk=",
            "U6NG7vqnQ8f/ubUDET8RYks00o5MXBcteSgjXVB7b0I=",
        ),
    ),
    # m/44'/60'/0'/0/17
    genesis_constants.new_prefunded_account(
        # ETH/Tendermint account - used by heimdall validators.
        genesis_constants.new_account(
            "0x0dC6e87ac93c46fB6724220e9DF084Ffbd02c2a9",
            "0xbbf5fd6e7591d868178354b5bf2caf1254ebf6efd6b89255d27a6cec0f4e5b10689fec08200077903c2d44ce1cc8f8525a962b4c1880a352ab1147d0fa865839",
            "24115bec2c77044f7a3fdf5fd690bb102a7f4ee091b1ec3570818c763a749905",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        genesis_constants.new_account(
            "0x571EDA5BE0F4964972A2E343360711085F486CA1",
            "BNnUYOnprdT4jbenrIW8A146jLiKeQu1TrNzCJOkRYq7SL8obyirEu6bk1zn+sM5yqNJu8LV8H0vnGM/QqCiOEc=",
            "OVVfxD7ceukTTrBsyvpwJ2gACsfIPo/u3dUXKEkLxKE=",
        ),
    ),
    # m/44'/60'/0'/0/18
    genesis_constants.new_prefunded_account(
        # ETH/Tendermint account - used by heimdall validators.
        genesis_constants.new_account(
            "0x56aBACAB4Bc41B6f8FA15b49B244C59FCc152D09",
            "0x1db327a8bc8bea06a84ed55786ab894c154f4856739bf65d26db013e40ddf9f8ed96c0a8d14ca8d3e63341303b07504c331fb1900480edbda98d47558413c27a",
            "5a3ac29a7ffaedc8dcc2a00c09c43271d116572d18fd66a6b05b4e0c65180ecb",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        genesis_constants.new_account(
            "0x0AA59E470718329DE2C0D797BEA98F0D40F48747",
            "BFyOjcz7c823D0w5NOFN2p8W+7ldJjf/EnGbgG6KJO3LA2gapCGqDvkIoTEctsLW6Y0b2/tuCwTkbZJvSd9cgmI=",
            "VUixMugXxj0XfHfWRucc7QslbqUj9FlczvykWGaj2T4=",
        ),
    ),
    # m/44'/60'/0'/0/19
    genesis_constants.new_prefunded_account(
        # ETH/Tendermint account - used by heimdall validators.
        genesis_constants.new_account(
            "0xa4ce59D3d8687938cdcAc9Fd73b74e43a6405fB5",
            "0x02643ae6ac8e86e956288476a9aa6e085578229856e5c041270e255163656907c50ed45c59568c20abd2c1a4f28cba8a98699612d52fd554267100cc84cd0441",
            "b86c932e205594b7bda97488ee43a2d1c7acc99837640644976c8690a4b5ddb2",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        genesis_constants.new_account(
            "0xAC0B299BF3674EDA8390D355D9DF4CC9253587AE",
            "BBCSUehvRFqDHCHv6VXz+d697oxibMH/9hyNld1Ti9ayvQS9Xr8ppJLcjD5GVSckL8dLoOL5q+/UOfggIEYTQQM=",
            "ka7h2wyFuQTjduhCEbemw8E020+08nzmB9cC5Ei1gao=",
        ),
    ),
    # m/44'/60'/0'/0/20
    genesis_constants.new_prefunded_account(
        # ETH/Tendermint account - used by heimdall validators.
        genesis_constants.new_account(
            "0xD8141868ccaD89D50D1338AaC7bD0D23C60dB6d9",
            "0x27fd66893472e32bb3914d9ced304fd198d830c1bd471a7dfd0dd5d680658950bb80cd0b03985d4f235d7b37c8243d9f24ff3971a72a3427073710ece196f018",
            "09c2b3eb3e6fbf268b2481eed8e84fad986bc0c6fd7bbb346e7345ac1436638d",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        genesis_constants.new_account(
            "0x437C8F076FA35593606967B2B05C6F28907C8E8C",
            "BGtFtbtRCYHow+GINg7e0cLu8PGjACj/GBtmw0Tte0N4l8HwCPukHUo/YdyQRNL0EGUQZIHITtMgwfVPSEHGgKQ=",
            "fyhc7PoEQTYUYcAItNC3GbMGpxrg+X4KRMVGA/ZKgwQ=",
        ),
    ),
    # m/44'/60'/0'/0/21
    genesis_constants.new_prefunded_account(
        # ETH/Tendermint account - used by heimdall validators.
        genesis_constants.new_account(
            "0x77EDa8182bA4e9F4913da08AE006756Ba0FffBa6",
            "0xbb509fa90e5bf61b4ddf25e36b7a5b704b7885d89690664ed63141b3ba1b0c88dc158c5fdf0e6a1e6e508ecfca4518459c0ae754e31730bb86845c5c57a810d1",
            "aa6b5e1f2d32be87b1e2af8ce419e4ea9a4bdfcb70d3c69ddf51d23f7c766a99",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        genesis_constants.new_account(
            "0x2E660C854FB1E88AB09EA4F7009800D1772A0BAB",
            "BOBC7ANzT0p87ZfDpbsxSvsqKexQSgMs2L6OTdQzRcJ1JfPqMaQFaL7kbL0bal2pqV49yFJ6brarceSEzOArsk8=",
            "Sy3aDDE779ymv8/VxHkynYfgjj31NfSXYoQOnmyzhB4=",
        ),
    ),
    # m/44'/60'/0'/0/22
    genesis_constants.new_prefunded_account(
        # ETH/Tendermint account - used by heimdall validators.
        genesis_constants.new_account(
            "0x605574FcF17A28B66Ac896283CB5Dd581E808788",
            "0x38e5c89feb751777e37739d98fd71b73c2d512cd639b5a215a2ba760b266c5bfa7213c5f537e1e8c4490b37e4fa0bc18dfb090d48e1ccc2fbb2acdf23d785641",
            "150eb652947f1c892b9c5fbedce69c01b996ac326a3c2938245a25729c5487cf",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        genesis_constants.new_account(
            "0x731A8F843AD0FFEDE1A15CA248FBF2D30E7BFBF7",
            "BCvMiEvzpiP5IfupJ5wqHtpxm6PLPhK8baUqK2K+ZVF8EmwFS3nMi5+ZiN63qFr9RBraF55TC0pYRaqlldds+6o=",
            "zb3MXI27zXr3GjY+NIzW8kjhZDoP63BLXReSugSkhgI=",
        ),
    ),
    # m/44'/60'/0'/0/23
    genesis_constants.new_prefunded_account(
        # ETH/Tendermint account - used by heimdall validators.
        genesis_constants.new_account(
            "0x3103E3fEf7791587d9DcAc8B8049D77B0aF0441a",
            "0x0d037aad357fcb0816bafaa3c73ac3ad5e57f02dbdeef53b93d27c2996183c8d8bdc18ad2eaae0bd388b96e1252b987b32127f2c1d7a76eb0c619f2c4aae2b6a",
            "fd5aea9401551e108d9bf781f1a4b4a6c883dcf00c1f8798cd465833e26816ec",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        genesis_constants.new_account(
            "0x4FF72C691C263203BA5A8BFBA83D92F34B1DD5FC",
            "BIZFwuk40Xires7+BxPmkGeWT8m2LrQXPhX38YJrzftkY6uiLi415/NJhaEhRvMvNpOLoM42S0JdoWaTglD94Gw=",
            "22z7tlybgIaIs+piNMu6Zkk9NARaXGukoNiKucsQtO8=",
        ),
    ),
    # m/44'/60'/0'/0/24
    genesis_constants.new_prefunded_account(
        # ETH/Tendermint account - used by heimdall validators.
        genesis_constants.new_account(
            "0x58Bada522AD1036B3300BfaaCCC4f03E973211ef",
            "0xfe2756d52905b6f17abfe72e4dc56cbae5e65cb18fc19174a484cbdc145df350876cd810c1667d1a48d786cd4097ee3c583fbd5ce043613b99adb92590a51da0",
            "8c173b74ba5f658c8cbcfa42123487e9144b51d2aaeb4117cd4865ef2c0d31a4",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        genesis_constants.new_account(
            "0x9060DCB24E9FDD7A7F20B0B8BB85D9CD7581E5A9",
            "BIGSTPJJ82N5wW8oa7RgHhMWFxRmNjxzXUe4jidc8uj3TOUs5gLGZeo0XX0s3Ym2gxgq2ZTtNvglNhccbUpgoFc=",
            "XASG6ZEy2B9WpRbeBpnVC3Tr5AeeQK5ziMKYoyhroP4=",
        ),
    ),
    # m/44'/60'/0'/0/25
    genesis_constants.new_prefunded_account(
        # ETH/Tendermint account - used by heimdall validators.
        genesis_constants.new_account(
            "0xbC885aeB83089F7782505024fc14eC77D32350d1",
            "0xc2a0cddcaf78075d71db36f472fc356c2a9c04a9cd9874e5383af8f0b3ca84e8f66f46f9ac9ae25333b242161850fb8da5517b22a86bd77aa61f6d4b4d29dae3",
            "7c47eb50afb9622238f305ceb90473086b4971f102f9b6042a4fcce73f7d5f3f",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        genesis_constants.new_account(
            "0x28AD3C27F9E9BFC21687009B7695F73C1494C248",
            "BGhafyaRZy0YFahuArp7j0tc+hTf1KyEPx/p3hsHKiLdqDuwAbxXMbOS92NwAnCWYdQ/kFhgEpEe5q7ZaD/nGL4=",
            "jDTUXKdA2oFFfdC3BBNwmHA5jx7qq3RPUf/9G1kC52s=",
        ),
    ),
    # m/44'/60'/0'/0/26
    genesis_constants.new_prefunded_account(
        # ETH/Tendermint account - used by heimdall validators.
        genesis_constants.new_account(
            "0x574333025c78616B443A14b58C02800C808f0f6e",
            "0x012f220e7faeb6f2af82ff562ac2a57b5f1eef906bf99c50802514ae800620c0c7ca64b28c03fd8b07053b17d1a68fd7672d71bc9934efaf2d10f2397383cc41",
            "fb96e051978f85792171b701563d94548134d76216d6c620e87abbb3141b6263",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        genesis_constants.new_account(
            "0xD103108147D44C3C063832F85A6054D366FBA1B7",
            "BH1gcl6vskBSIRfImNKQwfKyra4bMeYUhV5byZ2as6xhtgl5orK7r0l2Luw4XlnRpmV2/04Tdlu/554tucOXEFw=",
            "dOJ3H55yaVA3Sth2FrspWcqborn52DhA2ArVr3t14R4=",
        ),
    ),
    # m/44'/60'/0'/0/27
    genesis_constants.new_prefunded_account(
        # ETH/Tendermint account - used by heimdall validators.
        genesis_constants.new_account(
            "0x6c45934659cEF46a1e5ADBEdEEF28a28a0ccadCD",
            "0x40699c95684110a1dc72daf6b8fac67aaf63ce53d9f65718b45665ed69b995125d2d387644b454461fbbbbbc364795a05c9ef3005afc391e5340cf171f5ab86a",
            "e3c104df19c787665e3425549b7c4b45d318720a068cedda19a0969a0d5be4b1",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        genesis_constants.new_account(
            "0xEF5663DD50E424876E097B3315D008742BD3A154",
            "BIrQC94tEpr9pJP+KKR7M/DvN8UCmcdl/suIw11rGfCTXwnhXanX0uZBjanSIARNHqiQ/9HceNP8rXA0zwImBfc=",
            "jWxPvSAjV7G6PabuNd44o4fxQ0/kwRHHci6bIZICIMs=",
        ),
    ),
    # m/44'/60'/0'/0/28
    genesis_constants.new_prefunded_account(
        # ETH/Tendermint account - used by heimdall validators.
        genesis_constants.new_account(
            "0x986fBFacA286a41A9797660b9007cedA0d8b5544",
            "0x6a46fcc3cf8864c59c3697bcdee8ae366d58d9ff15de0b0eb54631dd5042efe25971ce877c60f05958615610d9fc297061c3e1610c0ae84a0a310ea5eae72a7d",
            "66a3a2e5feeca58b838e10f7603e01dd39592ea7ceb074bcf92378265b7f3d5f",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        genesis_constants.new_account(
            "0xFAFE5C627D8B38D063F08FE107702F850C78B486",
            "BLbGG/KlQ8LWpBORAjn8Mku02iSfXPOxS11GByQji+wgsDs58zK+w/wqvlKjOoIzpd3w42o6HkNOYe3gCIzy2rk=",
            "EN0P6anjZLxhGe+IJRfvGYWma+elXonEsPVeNyC1miw=",
        ),
    ),
    # m/44'/60'/0'/0/29
    genesis_constants.new_prefunded_account(
        # ETH/Tendermint account - used by heimdall validators.
        genesis_constants.new_account(
            "0x03CB13fC1AdaFbC58271aE17B82de6baD79eDC81",
            "0x843e79d8d9846dd92d14a1ba4fdae79ccf05989b6c670fb8f89c75bc9ad76a990d9172d677c972f8b6dad2864d42fd22bd8ed3c0229e8096b06ffb350a15570c",
            "f0fc8092126b0f27b4ec9f0beac91be1f273dd710a407d7b767baaefc14b0864",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        genesis_constants.new_account(
            "0x00B4F7425341B0C1271B8FAD3D5DEC50973B22D6",
            "BMeY8vWLdOhYqp5zosDKJgj6sqvE8eZGirenpij9IoWvQpYBfo3cqudSkvVNuL47Q5/dSfBnUe27DkhFNuwOMIY=",
            "BAtxUpwanMlIx5xXK9eHUuYHDrB+VCrdq+T0o5hxKfQ=",
        ),
    ),
    # m/44'/60'/0'/0/30
    genesis_constants.new_prefunded_account(
        # ETH/Tendermint account - used by heimdall validators.
        genesis_constants.new_account(
            "0x6520A67d45AAb34B38CeFF8540bc96a3b02cf1C8",
            "0x2d01d5780fc99ee798138a26da49ebbcc16fb7aafbd0d5a349367d789ae399d3eaf6fc38dab85f448939aacd6470ec7f3e696f3326e33e11996c92378f8701c1",
            "a03fe24ce0285e4598f3baa47bce499a19b1e6dcbcf7fa52671c5b3c2d09d9ac",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        genesis_constants.new_account(
            "0xAE1064E9A8DAE30C2C5746C891B1431B82C2C0F3",
            "BEjdri4H10P0O/d/JSR4QTw0yxKulGmJbUlZz0Uizen8lO2mL9xiCNXekLVXu7p9mvXeuTsAubLsramKlSzsBl8=",
            "J5wiPisC18fkY6wujcw1k2oNnJ8JjdkDiQElOtOIUfc=",
        ),
    ),
    # m/44'/60'/0'/0/31
    genesis_constants.new_prefunded_account(
        # ETH/Tendermint account - used by heimdall validators.
        genesis_constants.new_account(
            "0x437b736B390790Efd8D736cF97470d4197dd27d8",
            "0x7a91c382202e9c2616c32d649aa326cf4e1aea670294a1f4073c97d2d43be8044cc3617ac3da48d64118f4e305e76a0f9c79ab83b2fe775f494e20feb76ecaa1",
            "49f7182d63fa2d36fa640bba8b4c64b286080e26cbe59df7b610777dd9b108f3",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        genesis_constants.new_account(
            "0x86FDAB1E56B9EBD1350FABC79BFA7F241ABF99F4",
            "BE08P7MpU3a9Y0nRGBdifibaHQoX30MAG86JiwpOazfxORtq4323/PjoqhaMzNhrJQFzo6F6OjoO9mRkWxF4wuQ=",
            "/lYcVTwQO+8X3gIzhFW0uV+gAqUPTbi72RePtzD5h78=",
        ),
    ),
    # m/44'/60'/0'/0/32
    genesis_constants.new_prefunded_account(
        # ETH/Tendermint account - used by heimdall validators.
        genesis_constants.new_account(
            "0xFd67f44B8c1a6F81C214452C87Ab17A05A944D08",
            "0x191f19ad9468ac9ff5038941cedc1d6571f3f11c2f263ba6d85ee76d761ae62c56ce5554ada4c4bb98e9b10423b43de6a1584880c870821e09688cc982864ec2",
            "a7a07eaccd85c0e3dedd6aecbb3e03c9313f3535d9bc0db2e63c4f7f894b6d4e",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        genesis_constants.new_account(
            "0x3BDEC822D3ACC942F3808D0C9F6259DB9AD33787",
            "BBzzPWzPuS3/Wdr+QZHaWI7H+qSscQWnWPVF8K2LNGXkJwqmfQ6fFcP/7ZjAB6TVo9PjAtqKfMuv4BgyVVstU0I=",
            "H3VwnsvYfMzhZZgzCO1lhdH7B4stzBnln78EatvLvyc=",
        ),
    ),
    # m/44'/60'/0'/0/33
    genesis_constants.new_prefunded_account(
        # ETH/Tendermint account - used by heimdall validators.
        genesis_constants.new_account(
            "0xbd6D0Cb5046dA0c7a13083C9C8E6A591dA92C8F0",
            "0x296675020a7ebfdb2cd5216c0d795b7764780399c3fbf53335237581e65be31a224b6319120b8af98ade1e2404edb0a132e37b429b3415ee8ea0e0536576068b",
            "84e09989f74708bcf68b730517ffcf6a62ed300150f705ed0320eb9806f31b73",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        genesis_constants.new_account(
            "0x4B40D4B881E6B68DAEC45FC77959F5C77402103D",
            "BFHiWFnDr0KppJbtFjERJesbqs04P4dL5GcqX53U7JDzCRSqL5i1zQDzqc4PhjER/jm/HM3APlq0I5WC66uCp9A=",
            "L/xgEgtVyYnOZln/tyLizR0Pwdv3EGPSx5BhCI2g1hs=",
        ),
    ),
    # m/44'/60'/0'/0/34
    genesis_constants.new_prefunded_account(
        # ETH/Tendermint account - used by heimdall validators.
        genesis_constants.new_account(
            "0xc6f46EC9F3Da34B6E21010D7C8b8eC858B0e42B7",
            "0x47bda454318af11b3c5aec038318c19edbc0ae0b948cca103767e953c1ebb44e0dfb563c3ed9d138f86b98daa6795ec56079fee54d647f7812312c8fd4a1446c",
            "5533cc2ae89b66846c8d6fb783be1cee793182a89eae4665567c4b765516de6c",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        genesis_constants.new_account(
            "0x5A36D03F5124CE62EA9A5E46C97B2C3CD28C577B",
            "BKeElJIeLuxCltgo/Zuumt9IHu10FlX6Unb3Hj5537yCM6leWx4HebGHzrvy9xmbn+N5jdlvX+yYIyU6yV+K3dI=",
            "IJA2GFJiynj36u/W10tyyPyUnM7XOz/mZU01MqJUDvU=",
        ),
    ),
    # m/44'/60'/0'/0/35
    genesis_constants.new_prefunded_account(
        # ETH/Tendermint account - used by heimdall validators.
        genesis_constants.new_account(
            "0x90fC94FdF632CdfaCcDcAe50ADb9bfF40Ea8e7b7",
            "0x72c26efdcc38ffd73620bd6b0c6ccfe9fefc2b8ea371e2434c7b01dcf85c968e6692ecdc7e6ae45a02e4df7679d17cf07f0eb768f876fe46ff0edc64773ea188",
            "4c02bb317bb069f726d07baf22b138c9e393c8417c3be3c166b5c8b838be2c5b",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        genesis_constants.new_account(
            "0x041D7D628C641A49923A79D6B6DC7275C34FA1B2",
            "BORosA+XoeVZmQuoz1gu98JX9aCILWFuyBvP0oNbONMZ52GfQ0be0S1kMOKVmRSN6I4xliMRN1OsMtyLO01TXLc=",
            "jyr4x4svGdb+cmtJQiRf/gxxlgsKfk5iQ3MT09+XFwU=",
        ),
    ),
    # m/44'/60'/0'/0/36
    genesis_constants.new_prefunded_account(
        # ETH/Tendermint account - used by heimdall validators.
        genesis_constants.new_account(
            "0xE4781bbe3b350C3956c73a2945E283B5bAF5cdfa",
            "0xa1b30764d8078268f17e837af0095ec02a67b001b3a2bd32da5799e6998166ab465bf6977c21947499a0ca0985796368a28db43b4c7882bdabbdf6a0fbdff4e3",
            "5ca5e60d980aef22656be2720eb4c4e0bc5b93c2402577de1c2d0602af484305",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        genesis_constants.new_account(
            "0x0E87E2B9EF33C43AE8FAB01A3165D69A803BF3C9",
            "BOulEQtp2YWH1yZf7VbgGCAXnOjcwhlPXWwt7aDyDytw0k93suFDQY7D2I3xPmUy/Fqzs005eh+keaGfZebMGTk=",
            "Ty9+tGH411XQXpcKifNo6RAve4uK0ujhu9vhPeHmL3Y=",
        ),
    ),
    # m/44'/60'/0'/0/37
    genesis_constants.new_prefunded_account(
        # ETH/Tendermint account - used by heimdall validators.
        genesis_constants.new_account(
            "0x28067d88616e70d2C8b62A9E36f36D16A6829b00",
            "0xe82f76c206d70c90b4c7f5a004d6be7056314b0bfd16af8543ab7e5458330a7baf76655563d5c346674313514eacf39469c24bc53fa82cdc02966443529ce78b",
            "1192c1f35195f7dfe8ea7119e876b83a9d068edc47a243cb6eaaf4d20360cee6",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        genesis_constants.new_account(
            "0x25A0331177FF5734BDCE65DB7D22653B16E18D6D",
            "BPycuwGKKXr2CDxzQKgCvR/qxyWOxA33vWOh9NcHKG7+ZmuV3F0Pf1lUabF9talGyZi8dntBZ8KeSuWIPtiW8G4=",
            "lEAlq7SxOlWpGI6R/JGqhDb/fG3S2bU3GJdYLdpUJ/4=",
        ),
    ),
    # m/44'/60'/0'/0/38
    genesis_constants.new_prefunded_account(
        # ETH/Tendermint account - used by heimdall validators.
        genesis_constants.new_account(
            "0x5c48574194DCA0Ed50bcf24806fd532f2A5f8895",
            "0xc9b07c1b58bbfcf84f64f66db5d6362eac6c8f0ffa91d59fce8f50e24c4faf514af85e5e95d67ddf0822da64c1f9a5b0bd8453e48440b60a2d554c5f3ae44ec3",
            "67f8bb80688518e4cfa7e668dd4dff6991930c714b5a11ead2bd33180266bccd",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        genesis_constants.new_account(
            "0x240D27D52AC714A15EFC8E3E82FC1FCCED381CC6",
            "BDjxNlAxGJBB0RCvfKcfikbUwrABO4aMp+OPDOtWO34dlDC8neKKpu8c+NNCj9JCB3sYF6E81iDBsyzm15VdtV8=",
            "iH/FdDHH88VfVWjWjpymXgPylGFgVWfPavSyGdCrJaI=",
        ),
    ),
    # m/44'/60'/0'/0/39
    genesis_constants.new_prefunded_account(
        # ETH/Tendermint account - used by heimdall validators.
        genesis_constants.new_account(
            "0x66C2ADf7F190E1D639a629dbCfdFE296FC3d6a6b",
            "0x25119e040073c43e4ab13108461e87b68a6b3f1e3c7e68394923aa43a2f3e06b4fc390295f5ec6c7c5ebda49ea29f07d88b9f6ee779fe2ca60655f892822a5f8",
            "afbe7a7cf694b92125156c6b34edf7a5e2a29eea25636ed990ca545838c6fba4",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        genesis_constants.new_account(
            "0xD8D585606A45BE04999E4BB5F0CC0B29DDD8395B",
            "BETLAwk0QmjD7Xj6gidAL/2CxFzby4cDgndTG0/lZzqIa/r7wUHbTjDpQbNedNspwkwyYv5o5EDcfOF2pn0MT54=",
            "n008ArS7wV0TJR8E2EdSZ6S6ZlfQBuEpmUaU7FTXcz4=",
        ),
    ),
    # m/44'/60'/0'/0/40
    genesis_constants.new_prefunded_account(
        # ETH/Tendermint account - used by heimdall validators.
        genesis_constants.new_account(
            "0x892f73DeE8E8Be9bc4E0Fc590D72189Bb5E4391e",
            "0x5ac37dd0e32f623dce77ae4db1a97855fe4f116880ac49184b305a5613e60a1d11834f1ad926d2c6838fb6b9a03d369e06ffaabc37a21d45a6612eb09aed8f58",
            "42fc388c45431a894f688867758f7f9eca5bbaec51f8161d707f8f4dc0000e60",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        genesis_constants.new_account(
            "0x7B7CD05380FC8DD7A8BA1C8FCE74BFD6BAE83464",
            "BAlUVmbUJS5dt1v2Oy+Ohyjim0M88lk30m09+vQ01W64w7OpIF3rgJhEeq/ZojUiS/BlAwZTKwnGAdMuw3u6IPo=",
            "5Krvsthrndf993TEFjjRNs9HG0eFxLjdWmFCpIBro94=",
        ),
    ),
    # m/44'/60'/0'/0/41
    genesis_constants.new_prefunded_account(
        # ETH/Tendermint account - used by heimdall validators.
        genesis_constants.new_account(
            "0xad351A57678111F6FB2D480B8625cAa1E36744F3",
            "0x10b1eda8af65ece322755c2392ae481c904f529691a506581519d857138475ac0b78f3abd00b0505fbf7af3b90efc03e62427bfe0c2dc4779907b92388b00957",
            "944d3c2f9f6033cc30655098bc0ea590b6edc3fffed6abc49d774cf0700d79f9",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        genesis_constants.new_account(
            "0x881D9CDD0180086B0500B5C7F4AA7C3F36D7BE63",
            "BLMtGB5R/vE/iHH6kbf9qf96I+VFOqojPqUcg+4HCKtWrb3pu1IHXtT5M7bDDmfDZfziyjXwiUW9H6ivSoleKZg=",
            "oworNvvBVA8u/ieIeirbXdHiXHhGQ2GxhBsGTQ2t1nQ=",
        ),
    ),
    # m/44'/60'/0'/0/42
    genesis_constants.new_prefunded_account(
        # ETH/Tendermint account - used by heimdall validators.
        genesis_constants.new_account(
            "0x636058Ec9432e994947c3A5BbC213BF46F57447b",
            "0x08fafb158353445c0b00383e30e536aa72771731d715fb0db43859d10d2d3609bd8f67d1c00f0be8fcf6af00c846a0de4d599bb7de644f276daf23a2f1ab61a4",
            "d9dbbd6ad76feeaf1866823757b2be7cb1da8ec0636113cf2c7d1a9e2401245c",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        genesis_constants.new_account(
            "0xAD0CBF1076347231A3CF0088C50E9D2407E01416",
            "BH2Lx6hxCQUJzWKtfqFE0t3Y8TCa64KJwFDs7tfP60zC5TYWSg7VFLs14vTUYAzSn3YIG/eSzLxy5Dj4vseiSYc=",
            "fV8jWwpK7f1AjDCvSnIxh5o3S71IDGP2XHyOZdydrLM=",
        ),
    ),
    # m/44'/60'/0'/0/43
    genesis_constants.new_prefunded_account(
        # ETH/Tendermint account - used by heimdall validators.
        genesis_constants.new_account(
            "0xB395D0c7BcB466776c1e543196b0cDaE03db9547",
            "0x75cff5e23688d9e182020dcf97d35e82f887b22dc70670693141582a1edd6842023ba89561146a44da9b9be935501da7857a5a2cf171fea8ff971f010c39ada7",
            "874cd6d629345c44a1bf6aea00d49178a8c27f1eedb407b1f6b68f928b65bcee",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        genesis_constants.new_account(
            "0xD7051CB287407A31687AD20BFB7A63B24764CE18",
            "BFK1lQ3mzxPKf5ug+rRaJi/sGRCNvjn8qzWkEvAhhtjWOJHjYonlOBIoocDUPMWZQyjBI/3InGM60r+gFZvx98Q=",
            "+QERgJUWfIoVFdogoQJf+rXm717aunvo5p8u47sxkwE=",
        ),
    ),
    # m/44'/60'/0'/0/44
    genesis_constants.new_prefunded_account(
        # ETH/Tendermint account - used by heimdall validators.
        genesis_constants.new_account(
            "0x0C55fd03705ef43030F1A7108Ba85E5D215ac8f1",
            "0x25d28f0716fd3f678c9d6709804fd1023e5b54fa3e891d04ae3ef638bf79e821b781f207844e3a03b24fa25151ac1143cf251a72c6fd28856f428dc7d536e1c1",
            "0c87522cb5864590804a9e36f5760e0bfce3c7ee977a909f671d9a7d43720eee",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        genesis_constants.new_account(
            "0x433D1B270DBA0320E8731963C4E1954D557E8D8B",
            "BNDIRQvTMgyOK5Huv4Niav5pGsJOYnxY86Itz6heJs5GqErQMs0DdGvRkLSkjVmnnp3pq5J7YEqnOpeVP8vT9rU=",
            "xL8CNzsgkmpM/YxoXsr1sleuKKHG3MHVOlzele1zsbQ=",
        ),
    ),
    # m/44'/60'/0'/0/45
    genesis_constants.new_prefunded_account(
        # ETH/Tendermint account - used by heimdall validators.
        genesis_constants.new_account(
            "0xA99E0447509e96c98d88896AF2D22F0cD6dC9DE4",
            "0xd164a1f068c06b9c0157f5c16228d15aea78a4910e1f32e6d2a3cb981bab3cf8879b940e3ae35f31c135283fb0d6b8e6d7f9e9ebc42a56d4d8e5a16a6fb5bf24",
            "370703ea457ce7de71909034077da57f5473277306c60be809ccdf9092e3ce22",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        genesis_constants.new_account(
            "0xD5E15586136142EE61E7153F919F690683261592",
            "BGNL6M9HRHvYLAdZVfc2FCCyYYNU9mL7/SAv3aYAi7TtlJ0wfAkmf8NKmFWP8K5tcDlriGeLxzO8ps84MoPDt0Y=",
            "Ol5fkdNAmd+T10eMbjfMZ2ddYGiDoRFFijhSDO16W3g=",
        ),
    ),
    # m/44'/60'/0'/0/46
    genesis_constants.new_prefunded_account(
        # ETH/Tendermint account - used by heimdall validators.
        genesis_constants.new_account(
            "0xB33Ab023B1e70211E848B8e079885aC5fE5A0F35",
            "0xa7c4bd3f71df07b448295f5c809e9befb89c0b61d50a7f3719e651d4644895f5e23da3745c100203d3e601307700fd726398875d47aac9c5eb73ef2934b718c9",
            "c0e0d05975e86ec15a90e2e1bb11a64435616a24d46deef9a9696d4bef78884d",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        genesis_constants.new_account(
            "0x1897C0CCFEE11822151EAE98DF682600CBB271E1",
            "BG0rtFUUcIWcHhjxd0yUXszDZtd4BWScJ/KDyo4mcHoA6WK/Jn0DsZjMQdPEJ574VIoYBDlPUQx08lvsKHUuOzI=",
            "FYB7hFDvtuqIwvVH5beOLuvYyNekaml2LpY+fyksiq8=",
        ),
    ),
    # m/44'/60'/0'/0/47
    genesis_constants.new_prefunded_account(
        # ETH/Tendermint account - used by heimdall validators.
        genesis_constants.new_account(
            "0x57EC6EfC5906BFFC0c24708cA48898eDbD41D427",
            "0xb7b5f6113cee980970fea149fb44f486390fe1965bd200ec4b291a68d6e135d464ae74adddd180762bf12dfc9d98a2a7dfc152d38c589b30f6633b94a7862d41",
            "81d861fc56d7978a9d54547d469fa06de12da53ecbb8a2b3b6c3d1afe63f03d5",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        genesis_constants.new_account(
            "0x27C87478AF8AD696B2C13EF4BF6A8D1126CB0A7A",
            "BCeD0dXEiaP57smoxSyZRINr2+i3nDzfq3tQoGBl5/b96Lbd7iMNjN/uNsmfcQNlv+hTubkDaNp8v5uax62V7lk=",
            "lFQn4XV82YZkQL+v6CbbfT6MYS/J/Ho6fhWQdSGQTVA=",
        ),
    ),
    # m/44'/60'/0'/0/48
    genesis_constants.new_prefunded_account(
        # ETH/Tendermint account - used by heimdall validators.
        genesis_constants.new_account(
            "0xdFD7a8aEeC072E7860645568d75Df27c16Ac80F4",
            "0x9056606168b365686d22898f3aaa1a9f1f2250a248d12125c01d176d38929a80c32db1aee92c728dbe8aae2c06b194808efbd5b00f6e22bedfc265d00bb126a9",
            "464563ac0504afb06668828426145cba4b18aff63b3a8551917f3edb60ae6888",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        genesis_constants.new_account(
            "0x61A4C4B95203C7CDCC6F29EB8D4D8830922A050F",
            "BNvx9cQHm+MaO5WZl55lfz+p8a6SvO+Op5wHxFlVxDSNDCrJA1cpYiMMKNNxOYlI9szvHewNolYiSigABCZVJtM=",
            "1KZAXqMPwqmHq2alihcJo5Ic6Ed9mwTovgdIGyEybo8=",
        ),
    ),
    # m/44'/60'/0'/0/49
    genesis_constants.new_prefunded_account(
        # ETH/Tendermint account - used by heimdall validators.
        genesis_constants.new_account(
            "0xFD0a733E3a6E1480E4934FBcB4c55FD8Dc5EacD1",
            "0x34c6ed79a5e6a0b8875b3165d3f511710c5da3fd328e7f7f2ada98e0ff0c743afdb546ebcf8840d92589fb36696458a65dace9909cee84e4e8724b1c3a03428b",
            "81dc4377d7d9143647a7fc438259b32477509c59862d1a1d6dd4202dd8fcb21a",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        genesis_constants.new_account(
            "0x223FBB05914A3B37A5FDBE2F326420BBFEA6B859",
            "BChKVkF0HYyBinSYXdJelp52j20x7+5Rlew+07vaBKSjwxX1RzyC7MuEAGNBUl4qtLOXwqxAbUY2UgS4aJxKEWw=",
            "t2NOolk2ePaDkFWHAxgDnCVxegUDgx/Ddx9nWKiM6b8=",
        ),
    ),
    # m/44'/60'/0'/0/50
    genesis_constants.new_prefunded_account(
        # ETH/Tendermint account - used by heimdall validators.
        genesis_constants.new_account(
            "0xF76FA1957C5c46203349A286577a07F9F8447d65",
            "0x9168946ab7e4a7855c21c28ec4fd6f50bb0ca4a237efc95e962f842f317f290d911ea84beed54ea111e4188f51b37a080ce1ea320b1278239adb13c6bd0eb60d",
            "c910784f9536645dfdd347311ce4a1e3394637c3c32230481b85fc6ebab012e6",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        genesis_constants.new_account(
            "0xB4604C8F5CB6ACE3FE57586C73ECF669BFBBE86C",
            "BBCB+zFgY5275T4Ev9l1r9L3G/n3ZImzub6OZdLnU8hLb5AciyMOahpjavk1l3GIh9Tc6GWrKb8Ob0COYtXE7lg=",
            "bFlNHtKN9RwLwDyBMkrEQNXercMqbGsz+5yqHniQlxs=",
        ),
    ),
    # m/44'/60'/0'/0/51
    genesis_constants.new_prefunded_account(
        # ETH/Tendermint account - used by heimdall validators.
        genesis_constants.new_account(
            "0xAd392Ce62D683209bD414D49167f65C8728B6e52",
            "0xc69f2b247e5408caaab8619f89f6aa1ae3ebcff801f2db04188cf4f7252333641445edd545b8e0b8a574d82c2c32e1c39de33d6ee451f0eb326dd395d629cfcb",
            "3ca642843759663d882f9db67a0789aa50425365437a0f64b0b07549ece6038d",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        genesis_constants.new_account(
            "0x19A3106C627EA0B6296D8BE9B8A775E7D7484D57",
            "BGDy8w4SOug/0WiOcZ4wzJezLIPFOof2OTOaZ9XHM1Rhyd68sPPHllLorsDh/6m+AMssLjHcSkWS3fjqpPKAJrE=",
            "DWTdADOnn1s9NNGUFqoSfaJM79oBayyDBV+mIbi3it4=",
        ),
    ),
    # m/44'/60'/0'/0/52
    genesis_constants.new_prefunded_account(
        # ETH/Tendermint account - used by heimdall validators.
        genesis_constants.new_account(
            "0xdB8f08eb207888FfE0e9d715e4909E7Bdb409035",
            "0x4b60a3a25851f61b0b986b167d34a5df9f02f55e39e456f5d7530c7c46008adacfe2def97e6685290e873e088e807f93edf3eba0ad01bbdc2cb29d05a4ac04ba",
            "1f20d96d1bd75d97e27e3c0e700c894ba4f29766aa798d260fe2f795226b25ce",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        genesis_constants.new_account(
            "0xACD7DE52298F903C2679018E7871FB41A5F9C32A",
            "BELrn5GbpnPh+9Y7VrdDyk0w9CdnOFmZUOy3hOn22zQA3bIY7VSxVkBnTQQ9u0XfH3LQTEWpKuq11Jo/PUVbibE=",
            "9lU4ER/yUF1VVJMQe2bAQiAi/QP3e+UvTJgj02GWaHY=",
        ),
    ),
    # m/44'/60'/0'/0/53
    genesis_constants.new_prefunded_account(
        # ETH/Tendermint account - used by heimdall validators.
        genesis_constants.new_account(
            "0x91FDe64B7c4cE7248528B711E0Cac17240BE3c96",
            "0x3ff892dc042df433a34ab4df5f61e9014aeb32c6bdacf97306bcee7f34931f7a4cf6440ea79f80c0e5ee8b1b4b12987aad22bb89878e051d5b25e55d0dce8874",
            "218fabd2842014769e7efb5242415213efde59acdc14faec7758b94810020517",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        genesis_constants.new_account(
            "0x16851DCE8629AC6C2D83026402FBAC716F0EFD58",
            "BNEYJCFEkkUTTnvbO+sq6TDdrO0iRbxf2aGQOK7ySQprSR28QnEaO0q5G7/gCIG80K0y7jHGx/62FbFLe0sRdcY=",
            "Bz7XgKYP7Xy1kjUN61LKdq0MqtawGisYicGleQZfnF0=",
        ),
    ),
    # m/44'/60'/0'/0/54
    genesis_constants.new_prefunded_account(
        # ETH/Tendermint account - used by heimdall validators.
        genesis_constants.new_account(
            "0xb1ac8A575FA33Fa176C1AE966c976c0F4dC3d8c3",
            "0x20da26b24ed461727586f92ae52f8a2b40c941025eedac7caa431e6237a8d498272b4b329eafe7ed830d78fa8b9a9adab91b993f8a9c214676595b22217b7931",
            "3277832a3b5d18a0a29124335cf40869f024cec40eda99c1cced493d3adb447b",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        genesis_constants.new_account(
            "0x3C51149CD6BC0B04EA74ACF080CE3DE73132BA45",
            "BCheGDENR2aWG2Jo5NrpCKQ+KMOp/j1oSZ4ZXpliZC2zVG/8rHuZpn6JhmwK/T4/o2SK7HOFPb0oBSzUEadUyGA=",
            "5ZNHGMferBHT99WQlvO7aA/d+wZKAT2VJJz/sjHiXkk=",
        ),
    ),
    # m/44'/60'/0'/0/55
    genesis_constants.new_prefunded_account(
        # ETH/Tendermint account - used by heimdall validators.
        genesis_constants.new_account(
            "0x53074b3553c63dF522C1881acCe05aF016b3c931",
            "0x916cabf0e43fd5bc4973ed342e1b3f99ff560340a3b942b50fdfac68659f9794903749d4b352f349599456a328d81a0356dde902c789dd4066daac46a77df90f",
            "2d4de2a32f5a9822f1e0c22cbaa34328c008e9379228c4995661c28ce724d610",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        genesis_constants.new_account(
            "0x1CFE260F78F1A42A0AA8F07B589D6A873F50A310",
            "BDdT9IS+5A1I3f3twCK3iyacnewrMI8UUhDqs3qNr6L70RCjscvH4UVzISeXt7uARai0IL1lB1LjNOUO9mhLNJw=",
            "vNpL95lrdhUcNoFF6J94HNAXCOIuLX8MaytkP8eSqpU=",
        ),
    ),
    # m/44'/60'/0'/0/56
    genesis_constants.new_prefunded_account(
        # ETH/Tendermint account - used by heimdall validators.
        genesis_constants.new_account(
            "0x164090d53e2a42e07Bf0bfB4Ba61876a71b18859",
            "0xe62ca68974dc5aa5ceb820fdc9d08eba81877fd1516dd3cc2cce7daed350f6af4582fb3f80750b79ad2f46829a1123d2ab9cf11d46e0c63a549d3aefe65a98ba",
            "240560eaca11348c5f0a70b55d5d21218271b47eac8a8b75aaa9d99e018c0e44",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        genesis_constants.new_account(
            "0x4216BCA9B49CE3AC8654F9E82CA475BCE460E580",
            "BBBgEEECbkH/4E5Wlz+pIEf+Mt6N34qBeUqHaIUU904EYVJIKfGHRMAnHrv3QpaosycHObsZoLUwfd0FU/y3deE=",
            "iSss4HdzOs/EFacfJBPhnbnt3kbtNnTJJ9SF8+HBSHw=",
        ),
    ),
    # m/44'/60'/0'/0/57
    genesis_constants.new_prefunded_account(
        # ETH/Tendermint account - used by heimdall validators.
        genesis_constants.new_account(
            "0xC3E1d84c8C97677F62A1e0cCbAd2466cfbDC004F",
            "0x5feb12fdfdf2db14fbc32ee597ac0d02acc07d530ede4a091533e54f17dd0e296b203cccc4673f28d20728908c30723f8a7e2c08d9fc7870b196a5c995e24a76",
            "2ef4241b13666cd0bf43e899b12eada30841857a008999222fe969c09f50a7e8",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        genesis_constants.new_account(
            "0xBE607D5C78F5CD0B8109E544207FC147AD7A0B38",
            "BJlyjK4s01ofg+nmCzR2V31/CQBwT/nthUl0FX2MD0tRZyExaJUQhuoHDGW6sEH/bmVvKvILPXpDBJBz0pYrv9o=",
            "DATkmrrJbE+z22te27PgyjNXti3YFLjnwMsfhrYWUMs=",
        ),
    ),
    # m/44'/60'/0'/0/58
    genesis_constants.new_prefunded_account(
        # ETH/Tendermint account - used by heimdall validators.
        genesis_constants.new_account(
            "0x67959a19c1269C033A1cc029CaFE9ce65Fd66977",
            "0x4e914ad3139c041b13cf5b7d185afa9f190bbdab106fb3bc0f8ae80b949ceb99eea5a813ca712ae9cdb2cfdbaad9f3294aa91a5f200869a30b7e5435818692aa",
            "1cb9df2b4341a1501d9777cf75a7d29b0cae47ffcad23193abc9a37a6e631dd9",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        genesis_constants.new_account(
            "0x3DB5050803A438D5DDF53998677FCFE237A55367",
            "BBzSCJvFnEGBniFmhtv0NWvGgGrrcxT+nY1HOiT+iGvGe0cTZKHLCZeJz/s11afvXzCr1Mpb+q9a/pcdYNItLfQ=",
            "U/R/a8yIs7AR9vaC9k8SbnCihcuFHBoZNaEc3yk2ir8=",
        ),
    ),
    # m/44'/60'/0'/0/59
    genesis_constants.new_prefunded_account(
        # ETH/Tendermint account - used by heimdall validators.
        genesis_constants.new_account(
            "0xfb79574ec8510B054585ca6DF42E2532D69E4186",
            "0x39cea64565b1667c51afe3bf67bdcd1173f12181578ee6fe2a913a41923e902532ece593cac6135012f97545e972e4281dd7ab3273b69cd61301a234719be82d",
            "d6ed2a3569540f419337bae7b3c15d46a107ed80c27533d33521054b7e82bbb1",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        genesis_constants.new_account(
            "0x4756E559C868BC44E63CBF689ADDD73BAAAD570C",
            "BJDGnEakIuJK9qOjqjjR9EVqdoBWqbasnlpeSqqyyoe/YNkv24weAlp9WiuukrzDqIwZjRNThL6KtF8niy5lHSI=",
            "VXjqR/4lsnNWpaOTYh9wFcICnK+UbqnZfenFJqxI89s=",
        ),
    ),
    # m/44'/60'/0'/0/60
    genesis_constants.new_prefunded_account(
        # ETH/Tendermint account - used by heimdall validators.
        genesis_constants.new_account(
            "0xBc39041833DB3743167d68d0bA80CBa4901a2868",
            "0x3d5ce1afe77e0eacdcfef9757ed3d509d784d433c189a2fd329eb5a1dcbde43cd121811fbf1aa8c84cc6fef8e59c6bd72c712824a4a0bbec1479eeea3a2ef424",
            "87666e77a30f1c6e37a50df115ea96cec1157c1c1345b9cc1ebf04f9cf8f7c3e",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        genesis_constants.new_account(
            "0x1272D0FC2E9CA2371D44B8224C6B89FF1DCC0329",
            "BGJR1TCHHVkWSrcDTFvSnG8DuCC9XmtHO2evn5qife0sQq0pQ9g1DRbSmUfZCFhA2d6JGgyqVchNR9jTlocxptI=",
            "bytPvAp/zKfIeuvMR48Wt/n+7m1JNcRp1vENGnD7yqo=",
        ),
    ),
    # m/44'/60'/0'/0/61
    genesis_constants.new_prefunded_account(
        # ETH/Tendermint account - used by heimdall validators.
        genesis_constants.new_account(
            "0xddfBF34d9637Ce86930B3379Ec1d386C3a35b95F",
            "0xa225ae6f75db25aae04fb00779856881cb5c7243ae81a5184c6c5208012651e3f44f63af6aad17d99c961f0ffc55026719d4102695fe5362e7e0b0c5678ca71a",
            "2f3553918197dbbd927b4f4a95ff99752a92b9687adc476af60796341cac2669",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        genesis_constants.new_account(
            "0x62E14300C281666F864192E6136924B3532D9705",
            "BC1IBK+r6oGRltrZ1eEvxnQnFiTpm/88xReC1TIMEXnX1ECRzlrWJIqHcunUtJvpi5OuCuaN1+vwg6K5bFQoJ44=",
            "JgS1MO0aDl2fY4k1Xq3HcP0wcPnI1WTmZWS/vY1K5SM=",
        ),
    ),
    # m/44'/60'/0'/0/62
    genesis_constants.new_prefunded_account(
        # ETH/Tendermint account - used by heimdall validators.
        genesis_constants.new_account(
            "0x5e9f1Cb0Bd5943CD2D193cB8df2b587482A07E58",
            "0x7630daeedafa3004f92a7bdbc8a38a6ce7f30b5b90bc976e75bb3ab03ccbb030b0d7b3806ca720cdf77e6babf557928827ae1348b5a3796d9aaa0048a7fb38c7",
            "d7596918c4aa7e33daa3b5f30bb75e4b531755e8bd836051738761d40039e0a4",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        genesis_constants.new_account(
            "0xCEE5E8FE208020F555B6A2899BA9653A258996BB",
            "BPAncYGSnHpT1eDlLfv57m6GnJc4Wga1t1memA89QJeCJQv8p5ekcRmu4xhw7b8H1RYvakBSUdzQr6k6tW6lP5E=",
            "e1AmD6I5HnlBayJW1VSIM2jBO+rFkOmX8yudaE3I/qM=",
        ),
    ),
    # m/44'/60'/0'/0/63
    genesis_constants.new_prefunded_account(
        # ETH/Tendermint account - used by heimdall validators.
        genesis_constants.new_account(
            "0xf0a0F114d70eC023ac7e1c043a5f9bDDE691fC9c",
            "0x7adb750b34e6d93bb148e96b9077d5eca9c34101b20cab1ce11ae7121f19c5e966c795c3fd35d1dcf4cce378ae577956fbbd14dfa677d16698af019b532b5b5d",
            "b880ed840c77f1e324eacf6963a790e204974aca433099e911941d8ac41760a6",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        genesis_constants.new_account(
            "0x059966FEA5EB5A38E0FBCCB4F5DA70EFEBAABC2D",
            "BFW4jWSyeMrzUXcGGAE5wT4tJBowSReNowsHjVm9hjy2eJjrBZL/h0y4Zig4347alQ4Vr+zv/YQD31wwAtBxx8w=",
            "226NJDQJ1AIfkz4C2oDKgKjT9n9lIWzEXh3ho7Huv5w=",
        ),
    ),
    # m/44'/60'/0'/0/64
    genesis_constants.new_prefunded_account(
        # ETH/Tendermint account - used by heimdall validators.
        genesis_constants.new_account(
            "0xFB5aD3fE9cAf0C1d11a6E588e90d7AC8F2919F04",
            "0x4a2c321cd9e078007a0f865c4f92e74336800fcfde2951fb4663f87826f3fe2490c98c4787d4581fb7f163efa6a2718c647e82671718d12efacfebcf8553b0ea",
            "b839c66269afda55cee2b716c9e08fb8259128fb58871cb79dbb6b0b80056ca0",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        genesis_constants.new_account(
            "0x289DB0E96C332EC98944F065833B092A1B79D11A",
            "BEbVIe3usKd9wqOAS3Fpv2JIjoqbj4V293aBlZDnAvt/UvprbPtXgcrDAFFjn9KrviM+j58yVQYf0LPM4+XYUVI=",
            "tJ9L3kXl3zKY4TCrMxmXYbl+ebC7jS/OADYZhnzuoHc=",
        ),
    ),
    # m/44'/60'/0'/0/65
    genesis_constants.new_prefunded_account(
        # ETH/Tendermint account - used by heimdall validators.
        genesis_constants.new_account(
            "0x3E3A2C16F2FC6fDEc4Ea177f1DFa09d03cD3b5a2",
            "0x6b61132906d5d3287e6a8c109dd1e00e9d7d3b388d94be7881c04f7e9cb66b076cc7f20f5c74e465cc925ecdfc4bd21b09f82a603a776ea1aa5ef67cbc66402e",
            "0cb126b77b26d38c99bddcba899fa15b18c5b64f48d2a1075f4682ec0ae741c0",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        genesis_constants.new_account(
            "0x1DE043FB7F96C71ABA43B8BB5228F81A9BCB7098",
            "BFDdLIPIPQNeTzMjLyGLXlBzvkXwjGafzZiAxmI2nlO6rXu96u+yTQbYacYFgiYFNs9RRCmHF6DoxVJuGEtAyrw=",
            "n7gYBmkUnreHY/E7YPjl7WCQCouA0UaixG7dPAcGR6o=",
        ),
    ),
    # m/44'/60'/0'/0/66
    genesis_constants.new_prefunded_account(
        # ETH/Tendermint account - used by heimdall validators.
        genesis_constants.new_account(
            "0x83F2D35b467b2104DBdfb6fFc355B249C44EA061",
            "0xe78b024f4c45c3d9bb0f25ef3de61439c13a892c0f89a8753c6edf101e243a34a88d4e9511fc1e0b90eb110386d3accb785179e734ac38620d56c8c2e3c2d0b6",
            "d4ae62cbf501347909d599d8c46ace38bdcb7f46ab69d76755af069a70b83817",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        genesis_constants.new_account(
            "0xB902402E4B411C1912C35E867280C0565D8ADB28",
            "BBfXNWeyAG0ztTZpUH0kS6bs9WS0DWKYlq+LHTagSWkUUF3s4Za0XCw+rXI3qcTNoFMC+XIUndAEa2TiUS3rsVs=",
            "zAf9qxM7PUzDHUoLZPse2L2/yrg07ZklwQ6POrrmVng=",
        ),
    ),
    # m/44'/60'/0'/0/67
    genesis_constants.new_prefunded_account(
        # ETH/Tendermint account - used by heimdall validators.
        genesis_constants.new_account(
            "0x7B9a41F726729952f4DA24bC9d23C582Dc9b51Fe",
            "0x720c644c352dba8331d320c89bef2ab0fe949a26ca5aa7032d45ef3d4ffe727b8e4f3f8e834e73babeda015a97f9bc72e48d850c4b69d91d3c5a3be3bad29bba",
            "077234e31c368c6fdda5b04d7ea39105e65bd9e69e0239417f00aef48823255e",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        genesis_constants.new_account(
            "0x443FF8247BBB337AC778DF18B0685863BB9D2B38",
            "BNpdPKwiwKoZWhlalPuE119BWkn8P+gmpkVoNUGy7p7Qj83ox/Z7g5gJo0H/2rWIFcgmOrjYopAJfsFfH3IzjLY=",
            "BoGLShgQ8Vdy1NvjIWq13X0f+qEUVW/5fUs9GAfGP+Q=",
        ),
    ),
    # m/44'/60'/0'/0/68
    genesis_constants.new_prefunded_account(
        # ETH/Tendermint account - used by heimdall validators.
        genesis_constants.new_account(
            "0x0F28Ab680ebeCFBC003B9Cf2742881C86DA45514",
            "0x14c175026b4c5735630ad7a8a2db13dab3c74bdf58784b0452afb8d17560aabfe395c2dea87b83b9bfae7d03b3b1f71a76a0635183edda669d6a2cad6227ee98",
            "e119620994375721f9e3bcf8a27b45f007ecf238837baf561e26f9a30ff8d155",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        genesis_constants.new_account(
            "0x2B095F1161A86CBD5CE65CDD84F5822A667C6D58",
            "BGoXUsnj2oVVUDjiv4X9ZWYT0vxlpLDwuMXEFPPWmKj0Yc+y6b8H8xunGi2NT4zaIR1rAtbPxFdEy3D5FQJtF/s=",
            "J5g197y4rYFRvDKHjRQA6BPgR0+7PyXnMfq6zXZxh9I=",
        ),
    ),
    # m/44'/60'/0'/0/69
    genesis_constants.new_prefunded_account(
        # ETH/Tendermint account - used by heimdall validators.
        genesis_constants.new_account(
            "0xd86114705f4dbC7e3Fe620f3ef31EAb16c2CDf7C",
            "0xe3cad3079f475aca0cd817897c024dd54e90177a4c6c8af69c1738540714b34469e4c577bfd4f7ce0b8ba39512f6711f82b26a03bf0a8778ae2152061bbeed8a",
            "3361924d4334d4ed1d514bbcba5ad97d6e04296c981b8ca46a0ced236ea9b14f",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        genesis_constants.new_account(
            "0x962849FA8F321BBD079CEB0E84901CB39B320B44",
            "BP+xxAkT61n+34Yh6Wc9GA+s/jFDi6JnBtiZ6c/9JojEs4IPmI2CJRA0HSKgvYKYFKr8YE0uw6S5XRzHFpqLPhQ=",
            "0wqdF+OWcf50zZVuZoU2N4a8soZdX4ybUdK+FF5734A=",
        ),
    ),
    # m/44'/60'/0'/0/70
    genesis_constants.new_prefunded_account(
        # ETH/Tendermint account - used by heimdall validators.
        genesis_constants.new_account(
            "0x52a7a83E89De907e6d17F3979920a5dE76531391",
            "0x4c93f43f249f3824e8646266945eecf692212a0f83641452fdab965eaf15bd09475d43717ce878b7ddec2c40df4de6534c3702830fb6f0a49aa4ddc53be1aaf6",
            "877037b42809baf632e91e40fde3999347227ba851453544c5ddb2d005c83497",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        genesis_constants.new_account(
            "0x19A0B944C5423F9A064582CC1D963AB194D0DBD2",
            "BED2m+OAeqj2wVsGJ7tDIrHIxPLjm320jQQ81L9sOIQ93TjFFWqU7JpS40JssKV/PSoAKzll7hogkeLHKATj2JQ=",
            "KkSm1KGPt8kZvthlrGA3GV1L4L89PptE2Kaqsv5nwjA=",
        ),
    ),
    # m/44'/60'/0'/0/71
    genesis_constants.new_prefunded_account(
        # ETH/Tendermint account - used by heimdall validators.
        genesis_constants.new_account(
            "0x84762a992316995462C5A49429130042E21Feb24",
            "0x7df21d6d5f0eea86b2118b709d7605c300da3fd277f58cde9bb442c0bf0b7191db533fca3c08c9f3c3eb9e228be9921251a7bdfaef7b16e6ed0a0972c85199ca",
            "8c03e50b7f82518155ee0c2f0ac0ca41591f491170b2d32d5ef16dda84a2899d",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        genesis_constants.new_account(
            "0x02FC67F4607983946825126D959818F25BCE07EA",
            "BPuY8wj/IoTNXYZV8dQCGyYMZpSicq5/nFleHtQJLo5ShDMwsv3Wm4rY6Kdcm2jLmkkKQWbEfQZE+XnHZpvHfUA=",
            "G50CMzo+a0klPXd2J0lgQr1L7I6MY5wrGxCyNlVz50Q=",
        ),
    ),
    # m/44'/60'/0'/0/72
    genesis_constants.new_prefunded_account(
        # ETH/Tendermint account - used by heimdall validators.
        genesis_constants.new_account(
            "0x623b8Aed2828630c4f70f973aa5fDf16097a4626",
            "0xcbef4b1d2f2d646ef963eb3f45b94ed2e5f9f77f772658ec454869815889209da12f5bcb5ddc206aa4602edf6ca3595de3665e27fa45acbb463fae918c1c0a9b",
            "b5d04e50194f3ac01cada3077d9716b663eebe06a015122e7b0372e798954333",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        genesis_constants.new_account(
            "0x8ADDCA75D8BD4DF4FD025000AD33EA77E745F61F",
            "BHtwMezL9KyWSCgfZxzGQkbYK91+dh4SHWAnRhjvngRNp9W9gryGV/Ez88Eu1fPgImZ6BvMjeF8xt+Yn8CLS0gc=",
            "r8NFfPZCxXWHU/SYT6RSufrb0bNpTaJl/G3wWGMlW3I=",
        ),
    ),
    # m/44'/60'/0'/0/73
    genesis_constants.new_prefunded_account(
        # ETH/Tendermint account - used by heimdall validators.
        genesis_constants.new_account(
            "0x05b34aD8BA4F8c611cF43ffD051013bD3BE3af55",
            "0x290e65c9362f0d250347f7359f03136672fa4e3c2b853d33184752731b694205d509f29871026548c9c73280a8b10f252403452ea25118591010c1983315a95e",
            "9ff9171752fb749de81c75779406b2b0072cb1c88a86c3e170bc37dde84661c8",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        genesis_constants.new_account(
            "0x9251EB895C72CFEAEB1D1E130187BAA7613C3FE5",
            "BIoeiKedCZD7TXAr37gAfH6ovQpKQKdCIneReI2Cwe1qV8RgjdJr+Q+oQChDh26Sk4+SsCQKGNRhfnpbqpIBtTI=",
            "pGNmJuaLsOCNSacvyVkMF+5zXHru5I/9dvDwkr1Ia5w=",
        ),
    ),
    # m/44'/60'/0'/0/74
    genesis_constants.new_prefunded_account(
        # ETH/Tendermint account - used by heimdall validators.
        genesis_constants.new_account(
            "0x956a76461c300E81f42dA53bA711F57b928E4E04",
            "0xd3a96ab5a3e30234b20fc99551012db3e15cc22e73f198695458e6229e2d40428660f444e03b60378daf8b42a6586a24f557cb65aabd26e6f8e5ed9a00bf0f57",
            "5b686790a8ee5589d6ef098c6e7659097185c6f43d813bad25f35da53024a36e",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        genesis_constants.new_account(
            "0xE3A644897135CB796506D9F01DAC0516C60EB2D3",
            "BBH8L/zjzeIY6KK4YG5RzAqSSIOlu+zJVzSGsBpPSUjpLDlvtASr/dMBztQhwS1f33DNwXclQ9C0MEApT2X7Qqk=",
            "yE2a2lz9ifibAIdTHllv/eg69eJ/uIxudKzPOT+sYXQ=",
        ),
    ),
    # m/44'/60'/0'/0/75
    genesis_constants.new_prefunded_account(
        # ETH/Tendermint account - used by heimdall validators.
        genesis_constants.new_account(
            "0x51C55970Ce0ae13166fD16DE5F58be2309563364",
            "0x01e46292614e7b1b73474af451e539b7825e424245b27a28e249f0dd62938abbdf2df7bd4f38e3024decf480fa417d156aee67f8ae32918fd061cdc9b7e04439",
            "174e2a43af071dab614503eaf65e2741ead1718d7552fa7955fd4b1e1ed00aed",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        genesis_constants.new_account(
            "0xD91CBC0B670CC5B1A57F5A09E1F02ED5224CC7F9",
            "BK/OCoff/CaIpjBDOeaQCl4T3DuQncgv3qTD5LxWrnCYSD6enJX3kvPZU+l7l6ZFRaEjLPrr7zC9O8bcH97ePm4=",
            "7Bi1/zQIqF8C3n8b2powYcfLNWzM0yKuU7l5Jjjqo00=",
        ),
    ),
    # m/44'/60'/0'/0/76
    genesis_constants.new_prefunded_account(
        # ETH/Tendermint account - used by heimdall validators.
        genesis_constants.new_account(
            "0x945021CE5C876e153f2D5d7204C4486e125bb52B",
            "0xef2e4732bf96afe99d0c9b8150e5eb7c3fb73b9c87e0803bf83c0a7cc5f41dd761154b30468add4692560f2043dece442833a03cd50502235292f7b3c9ea5a95",
            "0de541c26ac014244ef72b7af559fa8c6d8f797b3c0983a72c7a7f8b31e00ffe",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        genesis_constants.new_account(
            "0x6211857A24A81FDBFA89049DDF204465D29D1247",
            "BN0I6K8In8QHGeKIsMUbLuIQwXnEmGColeVf/xUDcXrPfJID0frbTdHQeFshUmOONGf5Y5oSPHvMHq4lwJgePWg=",
            "CrOs+uxU4qDUFzd8HGKcKDxGedaHF+GLFBksQK2rdu0=",
        ),
    ),
    # m/44'/60'/0'/0/77
    genesis_constants.new_prefunded_account(
        # ETH/Tendermint account - used by heimdall validators.
        genesis_constants.new_account(
            "0x6552400848Bd54Af0e0B076803F9c9fb711fAE18",
            "0x5207cd026b848cf033df9c94aa280926ab09fe08b6474e57e0a936142d404ff009a9d797c935d47009d4dbb6ac71d07a75a8f521b8e2b7f50b4110aefc5c0681",
            "301934cd66566f0ea0de77ec7c6f6442d84b948a821bbcce3649e379bfcd99f3",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        genesis_constants.new_account(
            "0x9515376EDA51421510C6066B809B76F0E3FC7A9C",
            "BOlEAuo1xqPNnQE6toyKEcwKxEXLd0uiat+w98meGDxmN/jyQgr40p/N1/vvfZwiftfncWFzE0YcJDezXbny0qE=",
            "ShzQE3mcjx03/w3mToU+G5+N//UyPQ4aFK9jimmMxZ0=",
        ),
    ),
    # m/44'/60'/0'/0/78
    genesis_constants.new_prefunded_account(
        # ETH/Tendermint account - used by heimdall validators.
        genesis_constants.new_account(
            "0x764e4d64090B545bB884B9Fd26cE734e362042B7",
            "0x0cd2cfd8b889fdc06d865f644bb4f8e0e212d3769de994d77401a40b766f1836b974f5197094aa616283b48e571f309545d001f35843f5f43fd49e552eaa34b2",
            "a00b17e91eaa044b82441115b40233a0028f017d7f5c83c59cedff5c5b5c0fef",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        genesis_constants.new_account(
            "0x9283BBB26218A8A2970728251AB789220FE09C76",
            "BG0wYr7mQg7W4z/Mp8GPDw6tOhHrO8cCcO9/yOFg/GXZMycYjhuyPfJklXXbqAMKPYLNUtNQvIeR85KsOggoVaA=",
            "O6zdKDG0ocVTg8jdoKGrK+p3pJ5vJUFJHzN4GULXZas=",
        ),
    ),
    # m/44'/60'/0'/0/79
    genesis_constants.new_prefunded_account(
        # ETH/Tendermint account - used by heimdall validators.
        genesis_constants.new_account(
            "0x429Fe9934A554EbB0d992f8dd0ef7CbbB8cdC48C",
            "0x77ed660914912e14c9b453e11d79bdcd63acdec0f906089af3a455773a73f46beb2300c1247c938b1f0d43e4c94d6029e7e1383a5691b4eaff322a57b6e876f4",
            "fdbe7f37c4e40d574469581f92210286a4a94f96f467b82d9358b20e55a9bd7f",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        genesis_constants.new_account(
            "0x646184EB31B32CE398A95880227F8A5ED6F473D0",
            "BHCd4d8XqZBB4E44h6rLTM4GPzxXvw+Uxt0LAWyNgLas+cZiqyxABSiNDASJrL2cuH0k6LfrMVVgnIOXVmkW6PQ=",
            "4FszI74wiLXeTAcYXaLUJQkn8wPDLpaza3ZHFINNeJU=",
        ),
    ),
    # m/44'/60'/0'/0/80
    genesis_constants.new_prefunded_account(
        # ETH/Tendermint account - used by heimdall validators.
        genesis_constants.new_account(
            "0xD8348cb61F78BF0BdaB6a6A224E8c939830CE7b3",
            "0x69a6e07da709837448b3e19fd021e45ac4e1894fd3b6ac30493545ed7eff6562d70ed0bcdd741f1de4dea1bd0bd0060dfe42709c05361faeb9b4954de3b41c8f",
            "1eed9aaec5e59e46b58bf7fccf3307b83b40aa6494cace4c3698eebbbec7af5f",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        genesis_constants.new_account(
            "0xC025D5CA8E7241D3C64D9EFF4C7A01486E6D34C0",
            "BEdsJ4sPoKvM75GMccwz6+BdGC9eFck/lrW3y6KK2vkzJvXAsbApAmuiaD6WppyiMJHOd2UxsGDAJi9nPbv1ebE=",
            "NSqFSkS0Y/PoP1bmCIY1R/hyI17x0Zmz4+qgfuXj+WQ=",
        ),
    ),
    # m/44'/60'/0'/0/81
    genesis_constants.new_prefunded_account(
        # ETH/Tendermint account - used by heimdall validators.
        genesis_constants.new_account(
            "0x66983f7EEb7346603Cd580a3c45EF3ceF1Ab58dd",
            "0x51134a2b844362af618876608baf7444e6d1bd310a395112f533d8e90a215b4df188fb822cfad80c53379f28452af609375a2b7c86aaa59f47faa2fcd7c9e2d8",
            "07634baeb12eb1dc1a4d15b346566f65c42d3eeac3099db93bce9c5d1b5d5577",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        genesis_constants.new_account(
            "0xC62D28B44E212F6360C5E5EF830A21A854BF7169",
            "BP2koiLMaPRCdjqmV03k3KKb5bUO6KziURweeXy87fxFAzOznatn1IjWwO2z318inYN4ZbXjbxHKm+Xm5T9WtY8=",
            "OqBreWWJq3wYBGxHi0BnnldREoXJLzlneFnTPzup7BI=",
        ),
    ),
    # m/44'/60'/0'/0/82
    genesis_constants.new_prefunded_account(
        # ETH/Tendermint account - used by heimdall validators.
        genesis_constants.new_account(
            "0x96cb80Ea07acC199f95f73D330E5026E8FE31b99",
            "0x407ad8a1d0f4d5d488f0a47ae6e32363adafa47780e8bc594807620d03cc378619973c165d11272f8288c74733e8e0132c666366850856c3703e593106b0539b",
            "e8f0238ac9592c9d4aa8aa441cc94137d2c96e658b7055f33312d2ca232eeb48",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        genesis_constants.new_account(
            "0xFF90F8F31692BB713C99871D78675029A34FE75B",
            "BMoLz+2i6RQYju859/HesJkFeiFS0hIYX3n0tPIZQVW4hfvblgrOdqUyAdwLnYYd8bB0Kw8yTP2tZOP/YQuDHks=",
            "WVyritZv/DHvJBGq7fkfVJbZJsgXZhONaQjuqmi5prw=",
        ),
    ),
    # m/44'/60'/0'/0/83
    genesis_constants.new_prefunded_account(
        # ETH/Tendermint account - used by heimdall validators.
        genesis_constants.new_account(
            "0x83D72E0eD72dA5467D4ca996e6E47A25Efb2F4C1",
            "0x5b69f249d62109880039930dfbf955a3ba85e80d42a7a7dad7821efe84361d838f3f351bd5aa54c47173a1c82c78c12a64559c57470692dfc1e91bf69b828546",
            "32e0589a09995e139906553c11b50b184fe1b67916c58faf7570b5e89ed0eee1",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        genesis_constants.new_account(
            "0x21F31D4A546E55E55C6FE45D569DD9714732F85B",
            "BKyAsx1nFw9XN+enOmr5U8SA3X/FX9DxmD0o78N3CywownW8cXfiyEwnOcpX7Kngh1xshG+qQZ62GhCO83RoDKE=",
            "hR95u4hDtp5MGBKNuwc3gPxVgFmDwiO2k7vJaRSrKj8=",
        ),
    ),
    # m/44'/60'/0'/0/84
    genesis_constants.new_prefunded_account(
        # ETH/Tendermint account - used by heimdall validators.
        genesis_constants.new_account(
            "0x76443cEBc18d86FFBA21bc26F537e2ba8a882555",
            "0x4b42f51d6f76e450d498e493cbfa3dbbb19a3d372bf684e551bddf989d51c7f7b9a5bc96530c32e2ac1277a0f4de06c1a4d02ac28ad0d72e264bd842e6b94d25",
            "214111817a78c53f6fd19c109e2a4ed61d316a9bfc60774bf73b477d68d466ac",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        genesis_constants.new_account(
            "0xE9B4A9C76ECFEAADF784C2A4B26C1228CC18A98E",
            "BM344qpaWWaPpa7d5rVNclu+r0ne0tcI9I6zbZLHAvvwaaPm2RpMx9USR4iLTW9KhU8OA4LpB6dkmVYXKfRki2c=",
            "WVr8nQ3Wb6AGiFEgiDVdBuhim3FctVgR6N0euOP7GK4=",
        ),
    ),
    # m/44'/60'/0'/0/85
    genesis_constants.new_prefunded_account(
        # ETH/Tendermint account - used by heimdall validators.
        genesis_constants.new_account(
            "0xf2cC85782B44f7828BA2a4d9Ea87Bec508B33357",
            "0x358cbfb2770a768e29c07091d6db6159f2410557306b731949d58b74869b8b68b9681ebbf07550930e0b0148bd87d8a388598c61b1db680d0f4c09cf77316e2f",
            "a0835f1357a989e623292edc290d2936d1030f64f93384c08ed52de2ae379167",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        genesis_constants.new_account(
            "0x028B3760FE39BF2D362F937B01A3A0EF2D0A712F",
            "BDD6vvNJo4xA59AaJucpLU8hYjMxbHQoI4LiuyziaycyJ68ozJgfQPa9xtD5Njp33lQHj1hZNZMnvQa845owO5M=",
            "uFE8523lv0U0gc2SQJ7RyHmlorgCKtlvc3QCCEojHxU=",
        ),
    ),
    # m/44'/60'/0'/0/86
    genesis_constants.new_prefunded_account(
        # ETH/Tendermint account - used by heimdall validators.
        genesis_constants.new_account(
            "0xA58EC24FC1eb389717FB63b6e39c2933c1cFF684",
            "0xa9054de1cafaeac6f54755542835edccb9f433691f58b65828a541aae0849e8763ea0d0f81176c41c143c7db9d126ccd97d630e8a71dcda45b66cf7622be183e",
            "4dcd8cbfff843b0741839ce9c69684e35063bda69800b9fecb622bace3212cc3",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        genesis_constants.new_account(
            "0x90076093CB36C25469D8B4E9DEB0F1935F6D9B30",
            "BEJ6AcGTb7YxzTAZ+lsTJVzVfCqMz4cyfDZ52c/yVgvOTDZrdg/c0TFLFjQGwY6TTzr0vHjr54nBDkSU6A5/oQw=",
            "SGDNloJO3UmhFE3CYvK59ahFP2CFC4Q0H3oaDfrlZe8=",
        ),
    ),
    # m/44'/60'/0'/0/87
    genesis_constants.new_prefunded_account(
        # ETH/Tendermint account - used by heimdall validators.
        genesis_constants.new_account(
            "0x1E7C89De5bB8E6E020dA89E255ADa29b2fdd24b1",
            "0xe299041035390b575bc4ee4a992e8cb229f2353207c013a0e0dd8d02294e01b6104a41fb0faa7aef8a8dc821f2bcc98aadadf3203a22acb78b96048f18d6c21b",
            "f89e01678bbc6c922d27ba9e3a5da4985c99ce5d3ab73edd8a9aeca9f93a4804",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        genesis_constants.new_account(
            "0xEFD18F75E9887E965E803CC140DE42A7E8B0E262",
            "BAXene8kCaKHHjtjqOik6HVPlSgv/lNMYJxX5ZmNSHsAoXi7/go1gXU6RcqvJSSpgqmGSmQjMqkitXNOvIhoPe8=",
            "f6i5ZrylhWBf5/PV6i+fMSGScSGHs+jVXA30TnyWjQw=",
        ),
    ),
    # m/44'/60'/0'/0/88
    genesis_constants.new_prefunded_account(
        # ETH/Tendermint account - used by heimdall validators.
        genesis_constants.new_account(
            "0xE1a0CD85481F03a643Ef56DD45485C90bacA5Ed7",
            "0x49b41d091bb19a6261581329321d8b190c7c73f83667a49e3d86af60c7c32a3216c0e86c2be735e3384ec0a75ab68f7bb6fdcf6b7a87d060bd99b955f4862853",
            "af63aa22689bba7aa5f2a7079574e65d6847b3656ba9af464173b4d9b277b699",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        genesis_constants.new_account(
            "0x7E4E276012A03448F65AF5C263AA6B4C2CF784A3",
            "BBdJ4yw8apG33bP+heALLyESeblnPBxiswH9oozXl9vc28zKTe5QywFFCpYRbnTTft5znIVwOx0p1C8JSc8/qEw=",
            "HRu1I7LA8eccyW6KRQZwYWViUkMl6Ssvvy8GIwg1lqY=",
        ),
    ),
    # m/44'/60'/0'/0/89
    genesis_constants.new_prefunded_account(
        # ETH/Tendermint account - used by heimdall validators.
        genesis_constants.new_account(
            "0x82CE251D4Db35b434CD246D0762dff4A85dB73D8",
            "0x8367f337ba111eef04fc3dbcde4238b3956ad26fb967cb2878a6936b5b4d32e620a82123de33989c1cd74dc5d5077d00dd1ebb562a73c8dc07416e6874635434",
            "06df08e8bf7fcaa88859d528dc91181c6d7eb3d9c36b7a4341ef1b61389238b7",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        genesis_constants.new_account(
            "0xB88742110C46FA33199668DD3124FE35B6E2A3E4",
            "BOrxVef+6e0+ov63PvITpEau7ApVWbdgBtMYFt/KcHIqteGdlrfd+pxmdhtd6vjjlsNRksdLvsE3PZbDTxKxbLo=",
            "xttE+2fGEeJl6yq6VvJS4rbvMlvW7Vhc0UJw38igvYo=",
        ),
    ),
    # m/44'/60'/0'/0/90
    genesis_constants.new_prefunded_account(
        # ETH/Tendermint account - used by heimdall validators.
        genesis_constants.new_account(
            "0x9815f14De23a864D878F857D6A9c40E4b71c38c9",
            "0x1103c0412121228b2061e74315451d331df3149044ff9f025859393ad1c78823c2d429a4b7368ce8a4626a72923cfcde2d946bbabeca71eccd8ccad87772621c",
            "cc980bf3a46b4e109428782f8c1f7a395097dfeb1ab54d7d8342275f3d917c0c",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        genesis_constants.new_account(
            "0xD54218E51F32904DBA529CA85925A41B3BF1EF98",
            "BFj6khui45M5eskmku1e3Go1HImCF59Dus+L5B0lIaWAt2FPyTDYf5q+txtSIduqsN6ck59lTa3p7EiRWBc4YWY=",
            "VlChlun/AGZvu4cUWaMmF2e2/4bkudVY0rxuyAWvbWM=",
        ),
    ),
    # m/44'/60'/0'/0/91
    genesis_constants.new_prefunded_account(
        # ETH/Tendermint account - used by heimdall validators.
        genesis_constants.new_account(
            "0x6bd9C38EA0d2D125Bb37EE8923077EB1311C0838",
            "0x1c59cca46d6eb30b22a68da76515c5b0112f372ab1f7979c7c090af721ad7d24f1132c643a70a59fb4fc79be966f794c3348c5e9a7586845e059e36afdc17623",
            "1fe682d437c1612353459833078d63402c03230ba34274cf04fd7fc6b266a5dc",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        genesis_constants.new_account(
            "0x78ECFC4E52E57B8D817C96F0AA598E477A760834",
            "BKCKqBEqTVAT+TBsHAxf3BqHc6KsH9a7YYJOYK0tNWPbbkdT0cJ7271BJw2t7PRhTyZpG7ZOAb7IE0eV3eXOL44=",
            "agVyF6yVzXhUliM3NzymrNSeg9GWbZO5m13DgzHwKuk=",
        ),
    ),
    # m/44'/60'/0'/0/92
    genesis_constants.new_prefunded_account(
        # ETH/Tendermint account - used by heimdall validators.
        genesis_constants.new_account(
            "0xf13a16B8CD06037E0edD7f17FE2f26cDAeF9F11a",
            "0xe8718504c5ca0db7acafa51bacb5cd775a9b542937647f9563e3505b55d201ffe44c17dfde600a5c359492322fd38c6ccb29def87a93db5ea501491438493b47",
            "dee279457e5f2b3c15457be9cf69ef4d02956d865ca8f02a6f00bbc1e744c76a",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        genesis_constants.new_account(
            "0x52464509B59B2F8EA6E871FC29579F875EA4415B",
            "BJJ+u+5AYAFay8dI0vUlIlSjB+8qUtfWeHENbolqWyYG41o6PYa8VMCeDB9XkZ0lSMEn8GVvymD0fwKAO1Z+IeA=",
            "Xeg7PBQjlNTfFaDOJDE3VWjgHqI5MXeHa8T+XPNUZlg=",
        ),
    ),
    # m/44'/60'/0'/0/93
    genesis_constants.new_prefunded_account(
        # ETH/Tendermint account - used by heimdall validators.
        genesis_constants.new_account(
            "0x9da00a6A3a35Fc002a285de85Ac4083327A96a50",
            "0xd06df0be0864d2d8b34ab451f6a0f6a49d864975291e7c68725b0480d9355af625ecd078a7c03b3278656f729c005244d88be5bf8e4f3c18d728f55ca7cb95a8",
            "51faba73f416e48937b389f4c877ce63e3c3c7f2b8c690ec0700cfb978297996",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        genesis_constants.new_account(
            "0x5003B1BC888C9EE8A182555EBB71FB8F683A8765",
            "BGyC7L9Dr7VL8b3optKG13J6B2xkCm9urmWRGprlLJiXXiRtErbJNszqv4jQvJySCVIiVQzwbAbQrJkptzInDPo=",
            "4jXloEvl4QbcODN/d7az9Gs3RsISNtovBt6+PqKDXiE=",
        ),
    ),
    # m/44'/60'/0'/0/94
    genesis_constants.new_prefunded_account(
        # ETH/Tendermint account - used by heimdall validators.
        genesis_constants.new_account(
            "0x53c3A99F6FA910461c2bbe1AD4dEd24bBc1F0047",
            "0x38cc8dc4bf279ac67f31a904a5bec2a86668e9878e0f6549bd5981ffa2fecc869b6a5ab35f39e7456a142f44d93a2454653b3758de10ebda13a2a86eeec24933",
            "57c605a240adf4d6b5ac73c08ef4fb35e32471ddb52a011020da96d03487e8e5",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        genesis_constants.new_account(
            "0x0F2742C0DCE430BD6E73747806FF1FA36ABE9301",
            "BM4q4K2Y2i5wYXpg8RlLP9lOva21Z6jYTo4m4Trhgo3F3FUJEpuc4qZ1/2ENtIyEGlWLIHUPxSATR6ASdMBQET8=",
            "bSSsPRQxPwYHqIhTxf8aPKzDv3qOnx4cdY6BHWETKVc=",
        ),
    ),
    # m/44'/60'/0'/0/95
    genesis_constants.new_prefunded_account(
        # ETH/Tendermint account - used by heimdall validators.
        genesis_constants.new_account(
            "0xC82f246AE9AA5547eE5DDCC60C91A8e3C9254Ea5",
            "0x57367b4320ca1fe1b16be708784775f76ad10f2c9deb5162a557074075ce4fb24139c7c22d311687e1376fb8358c7374e3759d500832f163c1f5d2b966763452",
            "805782985e23872722bf9f0474a230735c4a960bcf22b9dfc2366b6ea890d2a1",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        genesis_constants.new_account(
            "0x1825B17323C0EBC45C2AF23B9B510BDE416D168E",
            "BE6g2cEtJbBLeVOvf7tLjMsBnrWrMLNfXeKU9+GKRSGR/Wo0wikqbGwjySxhcgkUfxEr10Myi8LZ0qO8SOtZVHM=",
            "3BEORaeFcR3RjqkyY7ypGHrer7nWfGhUgk2BldWL6JE=",
        ),
    ),
    # m/44'/60'/0'/0/96
    genesis_constants.new_prefunded_account(
        # ETH/Tendermint account - used by heimdall validators.
        genesis_constants.new_account(
            "0x8fD4dd171eCc1E78444E192023E65965c9914Bc3",
            "0xf18e12e36c502e6fe183da97154e0d65f57a7e9fc596c3839ac31b0a70f270d5fba0b8789cf94839af7c850dfa8bf5477d6d1dd4db325e5374a312119fe48200",
            "825f1813feee6d2b6106b0a742a6830d3a75f4f35a22fa901ef3427fee9b7ad6",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        genesis_constants.new_account(
            "0x96C013EEF18756E1D3DDC2D60FA834F6A7154FEE",
            "BO9eYJE7Y87nXObkJ8IqIne4rWON6x+arfN0fKVQ+5kSxwyXc7r8aE9QJZHlYvSOYqxOjVKt1sZ5HR9N/tFLrTc=",
            "pbNhWagT9NMA6Ni0o4qEEQ/M645UH/kV1KA1GZqb/BY=",
        ),
    ),
    # m/44'/60'/0'/0/97
    genesis_constants.new_prefunded_account(
        # ETH/Tendermint account - used by heimdall validators.
        genesis_constants.new_account(
            "0x1F064F92cA6833FE86409D609527ACA5C8b5cB43",
            "0x347bbf53d0ba784d739e0a1e3704ba209322ee1b6dfbadcd4bc8e506cd1b6ae9c8054c585da6f554875fd0a3baf15ae292109cbcca812f643a21adfe7f9766",
            "099dc55eb9ccee41739d5889c9656cf263988c9c332e0c4250b1730ac974a2ed",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        genesis_constants.new_account(
            "0x5CCD7089D517307230F666D91DDC9178AE39F0C2",
            "BCknDs0tND/6+Td2zxrhaiASYhr+zpXmNgOGUvxRxx27/Li2Ypm9jGjfpC3ciO5y2wcabju0+Y29Y4FrbtsEBdk=",
            "zUM8XI+9y6JsORLMSHzHdws7/H9ErstA7DqhBsAlGdk=",
        ),
    ),
    # m/44'/60'/0'/0/98
    genesis_constants.new_prefunded_account(
        # ETH/Tendermint account - used by heimdall validators.
        genesis_constants.new_account(
            "0xcD8D5477Bc1557545F2673110ee200B34599ffd0",
            "0xd58c347e6361b135e190024f9e7fd45a22e74f827db9126734239a1e9f69cf9207ea7279538eb1cf7971d19201eb6a4090b143aba69ac62fcf9989e53ac86488",
            "dada460d6d9ad6d175c1ce5ff0f6ee60fbac5ead4c5a50022b56a41a5c46594d",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        genesis_constants.new_account(
            "0xDF2B7BBB733B341259EFC2085B730BDFA148DE5F",
            "BHmv0zaYLnt1E2N/Y9wRa58P081GkKczdQMJQ49g2F6knxT6e4f01WJyfHuXBzs5MdLvL9/POojidm+uYq0j86M=",
            "rqeazOJHo+YTSbThA4sh8GNLQRv0h8SMCgptHrJwjAg=",
        ),
    ),
    # m/44'/60'/0'/0/99
    genesis_constants.new_prefunded_account(
        # ETH/Tendermint account - used by heimdall validators.
        genesis_constants.new_account(
            "0xf4095e845e78B0e0304b3E4c3D8708D8CF1FAAe0",
            "0x2198b3e65f7ab30351f0fe70f4364001e0f1a091523e404fa0733425109f967de128b7230a0a17c907b7fe50d368786e8f7b74acf65d7fc7b31b6d4339856835",
            "8990a165648f9c4f9eef05da826c7a7781b501fb48834d5c5b118928feefbef6",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        genesis_constants.new_account(
            "0x11A3B273AC889201A2A264DC112A8656965710E5",
            "BEUv/xk/EVzUcsH7RqO89YcptMXwNfLO+Hje9yzHoxF1Wh84SohjLQ4lZN+jK0t6d1DKbLvfOpRI34mYPKXH0xk=",
            "+IRJ1kJq09mnnghVtH/YYrgAJkALxZWWACOeNe+Pzg4=",
        ),
    ),
]
