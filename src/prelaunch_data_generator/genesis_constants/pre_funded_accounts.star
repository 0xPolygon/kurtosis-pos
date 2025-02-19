account = import_module("./account.star")

PRE_FUNDED_ACCOUNTS = [
    # m/44'/60'/0'/0/0
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x97538585a02A3f1B1297EB9979cE1b34ff953f1E",
            "0x93e8717f46b146ebfb99159eb13a5d044c191998656c8b79007b16051bb1ff762d09884e43783d898dd47f6220af040206cabbd45c9a26bb278a522c3d538a1f",
            "2a4ae8c4c250917781d38d95dafbb0abe87ae2c9aea02ed7c7524685358e49c2",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x97538585a02A3f1B1297EB9979cE1b34ff953f1E",
            "BJPocX9GsUbr+5kVnrE6XQRMGRmYZWyLeQB7FgUbsf92LQmITkN4PYmN1H9iIK8EAgbKu9Rcmia7J4pSLD1Tih8=",
            "KkroxMJQkXeB042V2vuwq+h64smuoC7Xx1JGhTWOScI=",
        ),
    ),
    # m/44'/60'/0'/0/1
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0xeeE6f79486542f85290920073947bc9672C6ACE5",
            "0x0f554daf002c359281a9c5c3cb6639cab12259f570d6d10cb15e3f82a79e75aa4924f01f530068b4a0113f77e69ba5434ca01100a182fbca2609e29c4a9de91f",
            "f92738db8be69a9694b08acfc8e8fa843578da5adfcf4de77482c5a2b15681ad",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0xeeE6f79486542f85290920073947bc9672C6ACE5",
            "BA9VTa8ALDWSganFw8tmOcqxIln1cNbRDLFeP4KnnnWqSSTwH1MAaLSgET935pulQ0ygEQChgvvKJgninEqd6R8=",
            "+Sc424vmmpaUsIrPyOj6hDV42lrfz03ndILForFWga0=",
        ),
    ),
    # m/44'/60'/0'/0/2
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0xA831F4E702F374aBf14d8005e21DC6d17d84DfCc",
            "0xcc0eeb4abe520999ee310aa0a9a485527edd584c1fd9e9981144ff2c574e5bf87b5549902afd05ab2b5c50bd8b1f2c6f648da71723fdf5721afe39c6fe491a45",
            "8f723ed84785cbb3202643d986c4ec6052ec9c55af8cbb84046eab7104ad0e75",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0xA831F4E702F374aBf14d8005e21DC6d17d84DfCc",
            "BMwO60q+UgmZ7jEKoKmkhVJ+3VhMH9npmBFE/yxXTlv4e1VJkCr9BasrXFC9ix8sb2SNpxcj/fVyGv45xv5JGkU=",
            "j3I+2EeFy7MgJkPZhsTsYFLsnFWvjLuEBG6rcQStDnU=",
        ),
    ),
    # m/44'/60'/0'/0/3
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0xd3cc855bDb41498920792b77aBCB7431617fA9a4",
            "0x79e9c953100c624ffc7f32f61fb378f28141bebc00d51376fd96d5c1b31517cb13182f489b0e4578430d9d8e72de1be51c0c624f7aea86e650bf86d3d5da063a",
            "0b8a62723fa93e4da7b3f09845d0c2c23d2807bd9f6b15ffb9037768e45ceca1",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0xd3cc855bDb41498920792b77aBCB7431617fA9a4",
            "BHnpyVMQDGJP/H8y9h+zePKBQb68ANUTdv2W1cGzFRfLExgvSJsORXhDDZ2Oct4b5RwMYk966obmUL+G09XaBjo=",
            "C4picj+pPk2ns/CYRdDCwj0oB72faxX/uQN3aORc7KE=",
        ),
    ),
    # m/44'/60'/0'/0/4
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0xF2dBc05C1f99b6E3442Dbd5524d1fAB7959Fc939",
            "0x22997e0dc45b54926a12b5e668347979df3abc8c1d2bc2cec388e40c569b35be3cb907d15e5eb616afcf3279e8d0901373e81e1b25149e497036c7646542f492",
            "d160c2a27d6724c946082baeee53fd12d3053d95ddcea692db7ab24eaeee668c",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0xF2dBc05C1f99b6E3442Dbd5524d1fAB7959Fc939",
            "BCKZfg3EW1SSahK15mg0eXnfOryMHSvCzsOI5AxWmzW+PLkH0V5ethavzzJ56NCQE3PoHhslFJ5JcDbHZGVC9JI=",
            "0WDCon1nJMlGCCuu7lP9EtMFPZXdzqaS23qyTq7uZow=",
        ),
    ),
    # m/44'/60'/0'/0/5
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x9bDc763175f3506dEdb5F139854730E23cA82F69",
            "0x72aff4b816c1ab1a2b58f2b22ae6f2547197f06419dd82b1aa7ebf9bc4cd6c679b8f616fa6669dc236c212b2c5894dec62516239fd33788dc24f8cdaed9bf0fa",
            "bca5312c2a0d4cd192d6ed46dadeeb04df40de4e08b1c1757b07fff42b4b951b",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x9bDc763175f3506dEdb5F139854730E23cA82F69",
            "BHKv9LgWwasaK1jysirm8lRxl/BkGd2Csap+v5vEzWxnm49hb6ZmncI2whKyxYlN7GJRYjn9M3iNwk+M2u2b8Po=",
            "vKUxLCoNTNGS1u1G2t7rBN9A3k4IscF1ewf/9CtLlRs=",
        ),
    ),
    # m/44'/60'/0'/0/6
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x307f0aA1456F0B3EDec56D6bA7ebC817D09483cC",
            "0x5499522100dd63e08eadb19aa547ec775b21d8de43e127973a65404224343dd8086c266e651ea9553c2b9db633b74754198c9b233adf7faa1c7f42613d0d18cd",
            "c76fcf0d1a590a60e619a92929848d836975eb9270daf91baeb06449211d62cb",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x307f0aA1456F0B3EDec56D6bA7ebC817D09483cC",
            "BFSZUiEA3WPgjq2xmqVH7HdbIdjeQ+EnlzplQEIkND3YCGwmbmUeqVU8K522M7dHVBmMmyM633+qHH9CYT0NGM0=",
            "x2/PDRpZCmDmGakpKYSNg2l165Jw2vkbrrBkSSEdYss=",
        ),
    ),
    # m/44'/60'/0'/0/7
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x2c64Cab78F2A9AAb96514c5151Afa571301D45d9",
            "0x98050375761d6e2dd76d7dee10fa6eb7c6c2ff50870983eddb939b7d21ed000001e419bd73619c77ce049b9511fb3df85e4965d7365cc783f5f48f41071d09c2",
            "ab2e777a68e3976dfd099114ca296ea21c14562ae662cc2f093917a842b1d2d3",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x2c64Cab78F2A9AAb96514c5151Afa571301D45d9",
            "BJgFA3V2HW4t12197hD6brfGwv9QhwmD7duTm30h7QAAAeQZvXNhnHfOBJuVEfs9+F5JZdc2XMeD9fSPQQcdCcI=",
            "qy53emjjl239CZEUyiluohwUVirmYswvCTkXqEKx0tM=",
        ),
    ),
    # m/44'/60'/0'/0/8
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0xB14908C693fb97dd65bFf82161c2Bdf442B0C952",
            "0x48cc364c82d72238fd94b3a02deaefb05ac8be2da1f8e28d79f7a04a48a656de84abd0f4a03dcb18802f8b8887c649dad0493956a4e947b29f79da29830f038c",
            "92a496c090beb90eac20b8436717f8943e05aff216dbfd3ddcab5463cf2a937f",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0xB14908C693fb97dd65bFf82161c2Bdf442B0C952",
            "BEjMNkyC1yI4/ZSzoC3q77BayL4tofjijXn3oEpIplbehKvQ9KA9yxiAL4uIh8ZJ2tBJOVak6Ueyn3naKYMPA4w=",
            "kqSWwJC+uQ6sILhDZxf4lD4Fr/IW2/093KtUY88qk38=",
        ),
    ),
    # m/44'/60'/0'/0/9
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x3d3e0AdB250437A85013EdD735Af309D29FC6b09",
            "0xa9cd729e66235cc5b32379d24eef7db703b1e552854c02f3abd2bf6633279bc81d5619163d252b8ed718a3080f5b093370fb6135ae6ddde9f7b9a8a0a548328b",
            "0dd4644d7ac1c3a4b210132e694ef6e5121e79bdc75e5eb2383f85af3f9b8c22",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x3d3e0AdB250437A85013EdD735Af309D29FC6b09",
            "BKnNcp5mI1zFsyN50k7vfbcDseVShUwC86vSv2YzJ5vIHVYZFj0lK47XGKMID1sJM3D7YTWubd3p97mooKVIMos=",
            "DdRkTXrBw6SyEBMuaU725RIeeb3HXl6yOD+Frz+bjCI=",
        ),
    ),
    # m/44'/60'/0'/0/10
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x3857C1b962cd62f2c45196b319493cEd7bB2b580",
            "0xa9182f349f6696c9409244a0c68b366ff0242550dfcf42c0ed2fbb6f4d7576addb6d744910ec6fbd59f529933b0c93a54e04de4f20eb1e2db32d3be96442b839",
            "c4189cdedadb8a4e191f190de6f056eed3cf9aa7c003d146558a9e9979e7dd99",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x3857C1b962cd62f2c45196b319493cEd7bB2b580",
            "BKkYLzSfZpbJQJJEoMaLNm/wJCVQ389CwO0vu29NdXat2210SRDsb71Z9SmTOwyTpU4E3k8g6x4tsy076WRCuDk=",
            "xBic3trbik4ZHxkN5vBW7tPPmqfAA9FGVYqemXnn3Zk=",
        ),
    ),
    # m/44'/60'/0'/0/11
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x37B6d1C512ffD61242c69863da2CADDBA89f06a1",
            "0x75911c34f7f0d4032e7b90a8fb8f8dec6e5639c3c58ac0e50634fe5350a3a7b1906620b6e12a513d71b0d665a462521602d56a8ac3320777c896223ff85aced1",
            "fe991dc58ae456b7e44eabddd475dace31dbbcc709c0dd26c73f1bf9efe9e6ef",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x37B6d1C512ffD61242c69863da2CADDBA89f06a1",
            "BHWRHDT38NQDLnuQqPuPjexuVjnDxYrA5QY0/lNQo6exkGYgtuEqUT1xsNZlpGJSFgLVaorDMgd3yJYiP/haztE=",
            "/pkdxYrkVrfkTqvd1HXazjHbvMcJwN0mxz8b+e/p5u8=",
        ),
    ),
    # m/44'/60'/0'/0/12
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x230fbC3D831bADa13df3F91ac6143FaFf595367A",
            "0x1c5cd9439d8ad6f72bc4a4e0623f1521c5a2634f2afd51454f44b045581910aab8c3eed7fdfa9764c2ece1527b83ac580f9e83201d81ffdabe9c5ad37c5b4b34",
            "4560a7941500b694f880f73de5e85886f90a4a59264aeec5dc74e6468fb6e7c3",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x230fbC3D831bADa13df3F91ac6143FaFf595367A",
            "BBxc2UOditb3K8Sk4GI/FSHFomNPKv1RRU9EsEVYGRCquMPu1/36l2TC7OFSe4OsWA+egyAdgf/avpxa03xbSzQ=",
            "RWCnlBUAtpT4gPc95ehYhvkKSlkmSu7F3HTmRo+258M=",
        ),
    ),
    # m/44'/60'/0'/0/13
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x22b15948E0925214E959Fca360ffdfA74780dF93",
            "0x52ee83dc0ba83f0c12cd8061a7174666f7b1718ac011adc1b2e742f6ec3d2e0a99a33c170b0202c29381611ef2254186808667385384aa927760167043e6f486",
            "2cdae5202d2fcee6ff93ad695e5046ebd89d95d75cddee7f89e1306b0c841eba",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x22b15948E0925214E959Fca360ffdfA74780dF93",
            "BFLug9wLqD8MEs2AYacXRmb3sXGKwBGtwbLnQvbsPS4KmaM8FwsCAsKTgWEe8iVBhoCGZzhThKqSd2AWcEPm9IY=",
            "LNrlIC0vzub/k61pXlBG69idlddc3e5/ieEwawyEHro=",
        ),
    ),
    # m/44'/60'/0'/0/14
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0xf3DB09Faf87062b10e4e65000897d0e06e7BECd4",
            "0x8115ba7ae42a0b4427ef598ab3b7adca32549783b6b4317ceaf53fb51dc0b543200c8935ddf85816252857b3cef2ccab2768d92ecf3a2c162769096fd8d06aff",
            "5d3af80cb644f2e3323cc9ae274acc471c63977ebd1bbb9c0f52a8607b8cdf5a",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0xf3DB09Faf87062b10e4e65000897d0e06e7BECd4",
            "BIEVunrkKgtEJ+9ZirO3rcoyVJeDtrQxfOr1P7UdwLVDIAyJNd34WBYlKFezzvLMqydo2S7POiwWJ2kJb9jQav8=",
            "XTr4DLZE8uMyPMmuJ0rMRxxjl369G7ucD1KoYHuM31o=",
        ),
    ),
    # m/44'/60'/0'/0/15
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x67f6074cd99d55a3587dCF745bC72AA64585C927",
            "0xd828760cc874e8c2ed91af9ffc5d06892b8441fbc4538978cd0764c5137e25455913ef5a39947ac7dfe7bc7134738017842a178d6fe1c50d593253f77c49d4e0",
            "95eb7846413fb242606bd4ecc05f327ed0548bde68077f746c201a3f94caf025",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x67f6074cd99d55a3587dCF745bC72AA64585C927",
            "BNgodgzIdOjC7ZGvn/xdBokrhEH7xFOJeM0HZMUTfiVFWRPvWjmUesff57xxNHOAF4QqF41v4cUNWTJT93xJ1OA=",
            "let4RkE/skJga9TswF8yftBUi95oB390bCAaP5TK8CU=",
        ),
    ),
    # m/44'/60'/0'/0/16
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0xe06dcDdcf4eC8932FeeD78A6f0170Ca1F783927C",
            "0x9e393f7aba401b52f923864c741586d8a2e0baab346a53f1f8a730a5b06cdab38a942608cdb685f9b489aa175299f9e72e093045f80bffba500e9d75623ab546",
            "e179a53c5d09f522b0fa627c8f4aa62d5f9191cb187cf498d151d4f1ebd3bca2",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0xe06dcDdcf4eC8932FeeD78A6f0170Ca1F783927C",
            "BJ45P3q6QBtS+SOGTHQVhtii4LqrNGpT8finMKWwbNqzipQmCM22hfm0iaoXUpn55y4JMEX4C/+6UA6ddWI6tUY=",
            "4XmlPF0J9SKw+mJ8j0qmLV+RkcsYfPSY0VHU8evTvKI=",
        ),
    ),
    # m/44'/60'/0'/0/17
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x0dC6e87ac93c46fB6724220e9DF084Ffbd02c2a9",
            "0xbbf5fd6e7591d868178354b5bf2caf1254ebf6efd6b89255d27a6cec0f4e5b10689fec08200077903c2d44ce1cc8f8525a962b4c1880a352ab1147d0fa865839",
            "24115bec2c77044f7a3fdf5fd690bb102a7f4ee091b1ec3570818c763a749905",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x0dC6e87ac93c46fB6724220e9DF084Ffbd02c2a9",
            "BLv1/W51kdhoF4NUtb8srxJU6/bv1riSVdJ6bOwPTlsQaJ/sCCAAd5A8LUTOHMj4UlqWK0wYgKNSqxFH0PqGWDk=",
            "JBFb7Cx3BE96P99f1pC7ECp/TuCRsew1cIGMdjp0mQU=",
        ),
    ),
    # m/44'/60'/0'/0/18
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x56aBACAB4Bc41B6f8FA15b49B244C59FCc152D09",
            "0x1db327a8bc8bea06a84ed55786ab894c154f4856739bf65d26db013e40ddf9f8ed96c0a8d14ca8d3e63341303b07504c331fb1900480edbda98d47558413c27a",
            "5a3ac29a7ffaedc8dcc2a00c09c43271d116572d18fd66a6b05b4e0c65180ecb",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x56aBACAB4Bc41B6f8FA15b49B244C59FCc152D09",
            "BB2zJ6i8i+oGqE7VV4ariUwVT0hWc5v2XSbbAT5A3fn47ZbAqNFMqNPmM0EwOwdQTDMfsZAEgO29qY1HVYQTwno=",
            "WjrCmn/67cjcwqAMCcQycdEWVy0Y/WamsFtODGUYDss=",
        ),
    ),
    # m/44'/60'/0'/0/19
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0xa4ce59D3d8687938cdcAc9Fd73b74e43a6405fB5",
            "0x02643ae6ac8e86e956288476a9aa6e085578229856e5c041270e255163656907c50ed45c59568c20abd2c1a4f28cba8a98699612d52fd554267100cc84cd0441",
            "b86c932e205594b7bda97488ee43a2d1c7acc99837640644976c8690a4b5ddb2",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0xa4ce59D3d8687938cdcAc9Fd73b74e43a6405fB5",
            "BAJkOuasjobpViiEdqmqbghVeCKYVuXAQScOJVFjZWkHxQ7UXFlWjCCr0sGk8oy6iphplhLVL9VUJnEAzITNBEE=",
            "uGyTLiBVlLe9qXSI7kOi0cesyZg3ZAZEl2yGkKS13bI=",
        ),
    ),
    # m/44'/60'/0'/0/20
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0xD8141868ccaD89D50D1338AaC7bD0D23C60dB6d9",
            "0x27fd66893472e32bb3914d9ced304fd198d830c1bd471a7dfd0dd5d680658950bb80cd0b03985d4f235d7b37c8243d9f24ff3971a72a3427073710ece196f018",
            "09c2b3eb3e6fbf268b2481eed8e84fad986bc0c6fd7bbb346e7345ac1436638d",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0xD8141868ccaD89D50D1338AaC7bD0D23C60dB6d9",
            "BCf9Zok0cuMrs5FNnO0wT9GY2DDBvUcaff0N1daAZYlQu4DNCwOYXU8jXXs3yCQ9nyT/OXGnKjQnBzcQ7OGW8Bg=",
            "CcKz6z5vvyaLJIHu2OhPrZhrwMb9e7s0bnNFrBQ2Y40=",
        ),
    ),
    # m/44'/60'/0'/0/21
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x77EDa8182bA4e9F4913da08AE006756Ba0FffBa6",
            "0xbb509fa90e5bf61b4ddf25e36b7a5b704b7885d89690664ed63141b3ba1b0c88dc158c5fdf0e6a1e6e508ecfca4518459c0ae754e31730bb86845c5c57a810d1",
            "aa6b5e1f2d32be87b1e2af8ce419e4ea9a4bdfcb70d3c69ddf51d23f7c766a99",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x77EDa8182bA4e9F4913da08AE006756Ba0FffBa6",
            "BLtQn6kOW/YbTd8l42t6W3BLeIXYlpBmTtYxQbO6GwyI3BWMX98Oah5uUI7PykUYRZwK51TjFzC7hoRcXFeoENE=",
            "qmteHy0yvoex4q+M5Bnk6ppL38tw08ad31HSP3x2apk=",
        ),
    ),
    # m/44'/60'/0'/0/22
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x605574FcF17A28B66Ac896283CB5Dd581E808788",
            "0x38e5c89feb751777e37739d98fd71b73c2d512cd639b5a215a2ba760b266c5bfa7213c5f537e1e8c4490b37e4fa0bc18dfb090d48e1ccc2fbb2acdf23d785641",
            "150eb652947f1c892b9c5fbedce69c01b996ac326a3c2938245a25729c5487cf",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x605574FcF17A28B66Ac896283CB5Dd581E808788",
            "BDjlyJ/rdRd343c52Y/XG3PC1RLNY5taIVorp2CyZsW/pyE8X1N+HoxEkLN+T6C8GN+wkNSOHMwvuyrN8j14VkE=",
            "FQ62UpR/HIkrnF++3OacAbmWrDJqPCk4JFolcpxUh88=",
        ),
    ),
    # m/44'/60'/0'/0/23
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x3103E3fEf7791587d9DcAc8B8049D77B0aF0441a",
            "0x0d037aad357fcb0816bafaa3c73ac3ad5e57f02dbdeef53b93d27c2996183c8d8bdc18ad2eaae0bd388b96e1252b987b32127f2c1d7a76eb0c619f2c4aae2b6a",
            "fd5aea9401551e108d9bf781f1a4b4a6c883dcf00c1f8798cd465833e26816ec",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x3103E3fEf7791587d9DcAc8B8049D77B0aF0441a",
            "BA0Deq01f8sIFrr6o8c6w61eV/Atve71O5PSfCmWGDyNi9wYrS6q4L04i5bhJSuYezISfywdenbrDGGfLEquK2o=",
            "/VrqlAFVHhCNm/eB8aS0psiD3PAMH4eYzUZYM+JoFuw=",
        ),
    ),
    # m/44'/60'/0'/0/24
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x58Bada522AD1036B3300BfaaCCC4f03E973211ef",
            "0xfe2756d52905b6f17abfe72e4dc56cbae5e65cb18fc19174a484cbdc145df350876cd810c1667d1a48d786cd4097ee3c583fbd5ce043613b99adb92590a51da0",
            "8c173b74ba5f658c8cbcfa42123487e9144b51d2aaeb4117cd4865ef2c0d31a4",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x58Bada522AD1036B3300BfaaCCC4f03E973211ef",
            "BP4nVtUpBbbxer/nLk3FbLrl5lyxj8GRdKSEy9wUXfNQh2zYEMFmfRpI14bNQJfuPFg/vVzgQ2E7ma25JZClHaA=",
            "jBc7dLpfZYyMvPpCEjSH6RRLUdKq60EXzUhl7ywNMaQ=",
        ),
    ),
    # m/44'/60'/0'/0/25
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0xbC885aeB83089F7782505024fc14eC77D32350d1",
            "0xc2a0cddcaf78075d71db36f472fc356c2a9c04a9cd9874e5383af8f0b3ca84e8f66f46f9ac9ae25333b242161850fb8da5517b22a86bd77aa61f6d4b4d29dae3",
            "7c47eb50afb9622238f305ceb90473086b4971f102f9b6042a4fcce73f7d5f3f",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0xbC885aeB83089F7782505024fc14eC77D32350d1",
            "BMKgzdyveAddcds29HL8NWwqnASpzZh05Tg6+PCzyoTo9m9G+aya4lMzskIWGFD7jaVReyKoa9d6ph9tS00p2uM=",
            "fEfrUK+5YiI48wXOuQRzCGtJcfEC+bYEKk/M5z99Xz8=",
        ),
    ),
    # m/44'/60'/0'/0/26
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x574333025c78616B443A14b58C02800C808f0f6e",
            "0x012f220e7faeb6f2af82ff562ac2a57b5f1eef906bf99c50802514ae800620c0c7ca64b28c03fd8b07053b17d1a68fd7672d71bc9934efaf2d10f2397383cc41",
            "fb96e051978f85792171b701563d94548134d76216d6c620e87abbb3141b6263",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x574333025c78616B443A14b58C02800C808f0f6e",
            "BAEvIg5/rrbyr4L/VirCpXtfHu+Qa/mcUIAlFK6ABiDAx8pksowD/YsHBTsX0aaP12ctcbyZNO+vLRDyOXODzEE=",
            "+5bgUZePhXkhcbcBVj2UVIE012IW1sYg6Hq7sxQbYmM=",
        ),
    ),
    # m/44'/60'/0'/0/27
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x6c45934659cEF46a1e5ADBEdEEF28a28a0ccadCD",
            "0x40699c95684110a1dc72daf6b8fac67aaf63ce53d9f65718b45665ed69b995125d2d387644b454461fbbbbbc364795a05c9ef3005afc391e5340cf171f5ab86a",
            "e3c104df19c787665e3425549b7c4b45d318720a068cedda19a0969a0d5be4b1",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x6c45934659cEF46a1e5ADBEdEEF28a28a0ccadCD",
            "BEBpnJVoQRCh3HLa9rj6xnqvY85T2fZXGLRWZe1puZUSXS04dkS0VEYfu7u8NkeVoFye8wBa/DkeU0DPFx9auGo=",
            "48EE3xnHh2ZeNCVUm3xLRdMYcgoGjO3aGaCWmg1b5LE=",
        ),
    ),
    # m/44'/60'/0'/0/28
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x986fBFacA286a41A9797660b9007cedA0d8b5544",
            "0x6a46fcc3cf8864c59c3697bcdee8ae366d58d9ff15de0b0eb54631dd5042efe25971ce877c60f05958615610d9fc297061c3e1610c0ae84a0a310ea5eae72a7d",
            "66a3a2e5feeca58b838e10f7603e01dd39592ea7ceb074bcf92378265b7f3d5f",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x986fBFacA286a41A9797660b9007cedA0d8b5544",
            "BGpG/MPPiGTFnDaXvN7orjZtWNn/Fd4LDrVGMd1QQu/iWXHOh3xg8FlYYVYQ2fwpcGHD4WEMCuhKCjEOpernKn0=",
            "ZqOi5f7spYuDjhD3YD4B3TlZLqfOsHS8+SN4Jlt/PV8=",
        ),
    ),
    # m/44'/60'/0'/0/29
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x03CB13fC1AdaFbC58271aE17B82de6baD79eDC81",
            "0x843e79d8d9846dd92d14a1ba4fdae79ccf05989b6c670fb8f89c75bc9ad76a990d9172d677c972f8b6dad2864d42fd22bd8ed3c0229e8096b06ffb350a15570c",
            "f0fc8092126b0f27b4ec9f0beac91be1f273dd710a407d7b767baaefc14b0864",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x03CB13fC1AdaFbC58271aE17B82de6baD79eDC81",
            "BIQ+edjZhG3ZLRShuk/a55zPBZibbGcPuPicdbya12qZDZFy1nfJcvi22tKGTUL9Ir2O08AinoCWsG/7NQoVVww=",
            "8PyAkhJrDye07J8L6skb4fJz3XEKQH17dnuq78FLCGQ=",
        ),
    ),
    # m/44'/60'/0'/0/30
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x6520A67d45AAb34B38CeFF8540bc96a3b02cf1C8",
            "0x2d01d5780fc99ee798138a26da49ebbcc16fb7aafbd0d5a349367d789ae399d3eaf6fc38dab85f448939aacd6470ec7f3e696f3326e33e11996c92378f8701c1",
            "a03fe24ce0285e4598f3baa47bce499a19b1e6dcbcf7fa52671c5b3c2d09d9ac",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x6520A67d45AAb34B38CeFF8540bc96a3b02cf1C8",
            "BC0B1XgPyZ7nmBOKJtpJ67zBb7eq+9DVo0k2fXia45nT6vb8ONq4X0SJOarNZHDsfz5pbzMm4z4RmWySN4+HAcE=",
            "oD/iTOAoXkWY87qke85Jmhmx5ty89/pSZxxbPC0J2aw=",
        ),
    ),
    # m/44'/60'/0'/0/31
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x437b736B390790Efd8D736cF97470d4197dd27d8",
            "0x7a91c382202e9c2616c32d649aa326cf4e1aea670294a1f4073c97d2d43be8044cc3617ac3da48d64118f4e305e76a0f9c79ab83b2fe775f494e20feb76ecaa1",
            "49f7182d63fa2d36fa640bba8b4c64b286080e26cbe59df7b610777dd9b108f3",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x437b736B390790Efd8D736cF97470d4197dd27d8",
            "BHqRw4IgLpwmFsMtZJqjJs9OGupnApSh9Ac8l9LUO+gETMNhesPaSNZBGPTjBedqD5x5q4Oy/ndfSU4g/rduyqE=",
            "SfcYLWP6LTb6ZAu6i0xksoYIDibL5Z33thB3fdmxCPM=",
        ),
    ),
    # m/44'/60'/0'/0/32
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0xFd67f44B8c1a6F81C214452C87Ab17A05A944D08",
            "0x191f19ad9468ac9ff5038941cedc1d6571f3f11c2f263ba6d85ee76d761ae62c56ce5554ada4c4bb98e9b10423b43de6a1584880c870821e09688cc982864ec2",
            "a7a07eaccd85c0e3dedd6aecbb3e03c9313f3535d9bc0db2e63c4f7f894b6d4e",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0xFd67f44B8c1a6F81C214452C87Ab17A05A944D08",
            "BBkfGa2UaKyf9QOJQc7cHWVx8/EcLyY7pthe5212GuYsVs5VVK2kxLuY6bEEI7Q95qFYSIDIcIIeCWiMyYKGTsI=",
            "p6B+rM2FwOPe3Wrsuz4DyTE/NTXZvA2y5jxPf4lLbU4=",
        ),
    ),
    # m/44'/60'/0'/0/33
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0xbd6D0Cb5046dA0c7a13083C9C8E6A591dA92C8F0",
            "0x296675020a7ebfdb2cd5216c0d795b7764780399c3fbf53335237581e65be31a224b6319120b8af98ade1e2404edb0a132e37b429b3415ee8ea0e0536576068b",
            "84e09989f74708bcf68b730517ffcf6a62ed300150f705ed0320eb9806f31b73",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0xbd6D0Cb5046dA0c7a13083C9C8E6A591dA92C8F0",
            "BClmdQIKfr/bLNUhbA15W3dkeAOZw/v1MzUjdYHmW+MaIktjGRILivmK3h4kBO2woTLje0KbNBXujqDgU2V2Bos=",
            "hOCZifdHCLz2i3MFF//PamLtMAFQ9wXtAyDrmAbzG3M=",
        ),
    ),
    # m/44'/60'/0'/0/34
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0xc6f46EC9F3Da34B6E21010D7C8b8eC858B0e42B7",
            "0x47bda454318af11b3c5aec038318c19edbc0ae0b948cca103767e953c1ebb44e0dfb563c3ed9d138f86b98daa6795ec56079fee54d647f7812312c8fd4a1446c",
            "5533cc2ae89b66846c8d6fb783be1cee793182a89eae4665567c4b765516de6c",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0xc6f46EC9F3Da34B6E21010D7C8b8eC858B0e42B7",
            "BEe9pFQxivEbPFrsA4MYwZ7bwK4LlIzKEDdn6VPB67RODftWPD7Z0Tj4a5japnlexWB5/uVNZH94EjEsj9ShRGw=",
            "VTPMKuibZoRsjW+3g74c7nkxgqierkZlVnxLdlUW3mw=",
        ),
    ),
    # m/44'/60'/0'/0/35
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x90fC94FdF632CdfaCcDcAe50ADb9bfF40Ea8e7b7",
            "0x72c26efdcc38ffd73620bd6b0c6ccfe9fefc2b8ea371e2434c7b01dcf85c968e6692ecdc7e6ae45a02e4df7679d17cf07f0eb768f876fe46ff0edc64773ea188",
            "4c02bb317bb069f726d07baf22b138c9e393c8417c3be3c166b5c8b838be2c5b",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x90fC94FdF632CdfaCcDcAe50ADb9bfF40Ea8e7b7",
            "BHLCbv3MOP/XNiC9awxsz+n+/CuOo3HiQ0x7Adz4XJaOZpLs3H5q5FoC5N92edF88H8Ot2j4dv5G/w7cZHc+oYg=",
            "TAK7MXuwafcm0HuvIrE4yeOTyEF8O+PBZrXIuDi+LFs=",
        ),
    ),
    # m/44'/60'/0'/0/36
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0xE4781bbe3b350C3956c73a2945E283B5bAF5cdfa",
            "0xa1b30764d8078268f17e837af0095ec02a67b001b3a2bd32da5799e6998166ab465bf6977c21947499a0ca0985796368a28db43b4c7882bdabbdf6a0fbdff4e3",
            "5ca5e60d980aef22656be2720eb4c4e0bc5b93c2402577de1c2d0602af484305",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0xE4781bbe3b350C3956c73a2945E283B5bAF5cdfa",
            "BKGzB2TYB4Jo8X6DevAJXsAqZ7ABs6K9MtpXmeaZgWarRlv2l3whlHSZoMoJhXljaKKNtDtMeIK9q732oPvf9OM=",
            "XKXmDZgK7yJla+JyDrTE4Lxbk8JAJXfeHC0GAq9IQwU=",
        ),
    ),
    # m/44'/60'/0'/0/37
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x28067d88616e70d2C8b62A9E36f36D16A6829b00",
            "0xe82f76c206d70c90b4c7f5a004d6be7056314b0bfd16af8543ab7e5458330a7baf76655563d5c346674313514eacf39469c24bc53fa82cdc02966443529ce78b",
            "1192c1f35195f7dfe8ea7119e876b83a9d068edc47a243cb6eaaf4d20360cee6",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x28067d88616e70d2C8b62A9E36f36D16A6829b00",
            "BOgvdsIG1wyQtMf1oATWvnBWMUsL/RavhUOrflRYMwp7r3ZlVWPVw0ZnQxNRTqzzlGnCS8U/qCzcApZkQ1Kc54s=",
            "EZLB81GV99/o6nEZ6Ha4Op0GjtxHokPLbqr00gNgzuY=",
        ),
    ),
    # m/44'/60'/0'/0/38
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x5c48574194DCA0Ed50bcf24806fd532f2A5f8895",
            "0xc9b07c1b58bbfcf84f64f66db5d6362eac6c8f0ffa91d59fce8f50e24c4faf514af85e5e95d67ddf0822da64c1f9a5b0bd8453e48440b60a2d554c5f3ae44ec3",
            "67f8bb80688518e4cfa7e668dd4dff6991930c714b5a11ead2bd33180266bccd",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x5c48574194DCA0Ed50bcf24806fd532f2A5f8895",
            "BMmwfBtYu/z4T2T2bbXWNi6sbI8P+pHVn86PUOJMT69RSvheXpXWfd8IItpkwfmlsL2EU+SEQLYKLVVMXzrkTsM=",
            "Z/i7gGiFGOTPp+Zo3U3/aZGTDHFLWhHq0r0zGAJmvM0=",
        ),
    ),
    # m/44'/60'/0'/0/39
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x66C2ADf7F190E1D639a629dbCfdFE296FC3d6a6b",
            "0x25119e040073c43e4ab13108461e87b68a6b3f1e3c7e68394923aa43a2f3e06b4fc390295f5ec6c7c5ebda49ea29f07d88b9f6ee779fe2ca60655f892822a5f8",
            "afbe7a7cf694b92125156c6b34edf7a5e2a29eea25636ed990ca545838c6fba4",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x66C2ADf7F190E1D639a629dbCfdFE296FC3d6a6b",
            "BCURngQAc8Q+SrExCEYeh7aKaz8ePH5oOUkjqkOi8+BrT8OQKV9exsfF69pJ6inwfYi59u53n+LKYGVfiSgipfg=",
            "r756fPaUuSElFWxrNO33peKinuolY27ZkMpUWDjG+6Q=",
        ),
    ),
    # m/44'/60'/0'/0/40
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x892f73DeE8E8Be9bc4E0Fc590D72189Bb5E4391e",
            "0x5ac37dd0e32f623dce77ae4db1a97855fe4f116880ac49184b305a5613e60a1d11834f1ad926d2c6838fb6b9a03d369e06ffaabc37a21d45a6612eb09aed8f58",
            "42fc388c45431a894f688867758f7f9eca5bbaec51f8161d707f8f4dc0000e60",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x892f73DeE8E8Be9bc4E0Fc590D72189Bb5E4391e",
            "BFrDfdDjL2I9zneuTbGpeFX+TxFogKxJGEswWlYT5godEYNPGtkm0saDj7a5oD02ngb/qrw3oh1FpmEusJrtj1g=",
            "Qvw4jEVDGolPaIhndY9/nspbuuxR+BYdcH+PTcAADmA=",
        ),
    ),
    # m/44'/60'/0'/0/41
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0xad351A57678111F6FB2D480B8625cAa1E36744F3",
            "0x10b1eda8af65ece322755c2392ae481c904f529691a506581519d857138475ac0b78f3abd00b0505fbf7af3b90efc03e62427bfe0c2dc4779907b92388b00957",
            "944d3c2f9f6033cc30655098bc0ea590b6edc3fffed6abc49d774cf0700d79f9",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0xad351A57678111F6FB2D480B8625cAa1E36744F3",
            "BBCx7aivZezjInVcI5KuSByQT1KWkaUGWBUZ2FcThHWsC3jzq9ALBQX79687kO/APmJCe/4MLcR3mQe5I4iwCVc=",
            "lE08L59gM8wwZVCYvA6lkLbtw//+1qvEnXdM8HANefk=",
        ),
    ),
    # m/44'/60'/0'/0/42
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x636058Ec9432e994947c3A5BbC213BF46F57447b",
            "0x08fafb158353445c0b00383e30e536aa72771731d715fb0db43859d10d2d3609bd8f67d1c00f0be8fcf6af00c846a0de4d599bb7de644f276daf23a2f1ab61a4",
            "d9dbbd6ad76feeaf1866823757b2be7cb1da8ec0636113cf2c7d1a9e2401245c",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x636058Ec9432e994947c3A5BbC213BF46F57447b",
            "BAj6+xWDU0RcCwA4PjDlNqpydxcx1xX7DbQ4WdENLTYJvY9n0cAPC+j89q8AyEag3k1Zm7feZE8nba8jovGrYaQ=",
            "2du9atdv7q8YZoI3V7K+fLHajsBjYRPPLH0aniQBJFw=",
        ),
    ),
    # m/44'/60'/0'/0/43
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0xB395D0c7BcB466776c1e543196b0cDaE03db9547",
            "0x75cff5e23688d9e182020dcf97d35e82f887b22dc70670693141582a1edd6842023ba89561146a44da9b9be935501da7857a5a2cf171fea8ff971f010c39ada7",
            "874cd6d629345c44a1bf6aea00d49178a8c27f1eedb407b1f6b68f928b65bcee",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0xB395D0c7BcB466776c1e543196b0cDaE03db9547",
            "BHXP9eI2iNnhggINz5fTXoL4h7ItxwZwaTFBWCoe3WhCAjuolWEUakTam5vpNVAdp4V6Wizxcf6o/5cfAQw5rac=",
            "h0zW1ik0XEShv2rqANSReKjCfx7ttAex9raPkotlvO4=",
        ),
    ),
    # m/44'/60'/0'/0/44
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x0C55fd03705ef43030F1A7108Ba85E5D215ac8f1",
            "0x25d28f0716fd3f678c9d6709804fd1023e5b54fa3e891d04ae3ef638bf79e821b781f207844e3a03b24fa25151ac1143cf251a72c6fd28856f428dc7d536e1c1",
            "0c87522cb5864590804a9e36f5760e0bfce3c7ee977a909f671d9a7d43720eee",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x0C55fd03705ef43030F1A7108Ba85E5D215ac8f1",
            "BCXSjwcW/T9njJ1nCYBP0QI+W1T6PokdBK4+9ji/eeght4HyB4ROOgOyT6JRUawRQ88lGnLG/SiFb0KNx9U24cE=",
            "DIdSLLWGRZCASp429XYOC/zjx+6XepCfZx2afUNyDu4=",
        ),
    ),
    # m/44'/60'/0'/0/45
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0xA99E0447509e96c98d88896AF2D22F0cD6dC9DE4",
            "0xd164a1f068c06b9c0157f5c16228d15aea78a4910e1f32e6d2a3cb981bab3cf8879b940e3ae35f31c135283fb0d6b8e6d7f9e9ebc42a56d4d8e5a16a6fb5bf24",
            "370703ea457ce7de71909034077da57f5473277306c60be809ccdf9092e3ce22",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0xA99E0447509e96c98d88896AF2D22F0cD6dC9DE4",
            "BNFkofBowGucAVf1wWIo0VrqeKSRDh8y5tKjy5gbqzz4h5uUDjrjXzHBNSg/sNa45tf56evEKlbU2OWham+1vyQ=",
            "NwcD6kV8595xkJA0B32lf1RzJ3MGxgvoCczfkJLjziI=",
        ),
    ),
    # m/44'/60'/0'/0/46
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0xB33Ab023B1e70211E848B8e079885aC5fE5A0F35",
            "0xa7c4bd3f71df07b448295f5c809e9befb89c0b61d50a7f3719e651d4644895f5e23da3745c100203d3e601307700fd726398875d47aac9c5eb73ef2934b718c9",
            "c0e0d05975e86ec15a90e2e1bb11a64435616a24d46deef9a9696d4bef78884d",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0xB33Ab023B1e70211E848B8e079885aC5fE5A0F35",
            "BKfEvT9x3we0SClfXICem++4nAth1Qp/NxnmUdRkSJX14j2jdFwQAgPT5gEwdwD9cmOYh11HqsnF63PvKTS3GMk=",
            "wODQWXXobsFakOLhuxGmRDVhaiTUbe75qWltS+94iE0=",
        ),
    ),
    # m/44'/60'/0'/0/47
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x57EC6EfC5906BFFC0c24708cA48898eDbD41D427",
            "0xb7b5f6113cee980970fea149fb44f486390fe1965bd200ec4b291a68d6e135d464ae74adddd180762bf12dfc9d98a2a7dfc152d38c589b30f6633b94a7862d41",
            "81d861fc56d7978a9d54547d469fa06de12da53ecbb8a2b3b6c3d1afe63f03d5",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x57EC6EfC5906BFFC0c24708cA48898eDbD41D427",
            "BLe19hE87pgJcP6hSftE9IY5D+GWW9IA7EspGmjW4TXUZK50rd3RgHYr8S38nZiip9/BUtOMWJsw9mM7lKeGLUE=",
            "gdhh/FbXl4qdVFR9Rp+gbeEtpT7LuKKztsPRr+Y/A9U=",
        ),
    ),
    # m/44'/60'/0'/0/48
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0xdFD7a8aEeC072E7860645568d75Df27c16Ac80F4",
            "0x9056606168b365686d22898f3aaa1a9f1f2250a248d12125c01d176d38929a80c32db1aee92c728dbe8aae2c06b194808efbd5b00f6e22bedfc265d00bb126a9",
            "464563ac0504afb06668828426145cba4b18aff63b3a8551917f3edb60ae6888",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0xdFD7a8aEeC072E7860645568d75Df27c16Ac80F4",
            "BJBWYGFos2VobSKJjzqqGp8fIlCiSNEhJcAdF204kpqAwy2xruksco2+iq4sBrGUgI771bAPbiK+38Jl0AuxJqk=",
            "RkVjrAUEr7BmaIKEJhRcuksYr/Y7OoVRkX8+22CuaIg=",
        ),
    ),
    # m/44'/60'/0'/0/49
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0xFD0a733E3a6E1480E4934FBcB4c55FD8Dc5EacD1",
            "0x34c6ed79a5e6a0b8875b3165d3f511710c5da3fd328e7f7f2ada98e0ff0c743afdb546ebcf8840d92589fb36696458a65dace9909cee84e4e8724b1c3a03428b",
            "81dc4377d7d9143647a7fc438259b32477509c59862d1a1d6dd4202dd8fcb21a",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0xFD0a733E3a6E1480E4934FBcB4c55FD8Dc5EacD1",
            "BDTG7Xml5qC4h1sxZdP1EXEMXaP9Mo5/fyramOD/DHQ6/bVG68+IQNklifs2aWRYpl2s6ZCc7oTk6HJLHDoDQos=",
            "gdxDd9fZFDZHp/xDglmzJHdQnFmGLRodbdQgLdj8sho=",
        ),
    ),
    # m/44'/60'/0'/0/50
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0xF76FA1957C5c46203349A286577a07F9F8447d65",
            "0x9168946ab7e4a7855c21c28ec4fd6f50bb0ca4a237efc95e962f842f317f290d911ea84beed54ea111e4188f51b37a080ce1ea320b1278239adb13c6bd0eb60d",
            "c910784f9536645dfdd347311ce4a1e3394637c3c32230481b85fc6ebab012e6",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0xF76FA1957C5c46203349A286577a07F9F8447d65",
            "BJFolGq35KeFXCHCjsT9b1C7DKSiN+/JXpYvhC8xfykNkR6oS+7VTqER5BiPUbN6CAzh6jILEngjmtsTxr0Otg0=",
            "yRB4T5U2ZF3900cxHOSh4zlGN8PDIjBIG4X8brqwEuY=",
        ),
    ),
    # m/44'/60'/0'/0/51
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0xAd392Ce62D683209bD414D49167f65C8728B6e52",
            "0xc69f2b247e5408caaab8619f89f6aa1ae3ebcff801f2db04188cf4f7252333641445edd545b8e0b8a574d82c2c32e1c39de33d6ee451f0eb326dd395d629cfcb",
            "3ca642843759663d882f9db67a0789aa50425365437a0f64b0b07549ece6038d",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0xAd392Ce62D683209bD414D49167f65C8728B6e52",
            "BMafKyR+VAjKqrhhn4n2qhrj68/4AfLbBBiM9PclIzNkFEXt1UW44LildNgsLDLhw53jPW7kUfDrMm3TldYpz8s=",
            "PKZChDdZZj2IL522egeJqlBCU2VDeg9ksLB1SezmA40=",
        ),
    ),
    # m/44'/60'/0'/0/52
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0xdB8f08eb207888FfE0e9d715e4909E7Bdb409035",
            "0x4b60a3a25851f61b0b986b167d34a5df9f02f55e39e456f5d7530c7c46008adacfe2def97e6685290e873e088e807f93edf3eba0ad01bbdc2cb29d05a4ac04ba",
            "1f20d96d1bd75d97e27e3c0e700c894ba4f29766aa798d260fe2f795226b25ce",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0xdB8f08eb207888FfE0e9d715e4909E7Bdb409035",
            "BEtgo6JYUfYbC5hrFn00pd+fAvVeOeRW9ddTDHxGAIraz+Le+X5mhSkOhz4IjoB/k+3z66CtAbvcLLKdBaSsBLo=",
            "HyDZbRvXXZfifjwOcAyJS6Tyl2aqeY0mD+L3lSJrJc4=",
        ),
    ),
    # m/44'/60'/0'/0/53
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x91FDe64B7c4cE7248528B711E0Cac17240BE3c96",
            "0x3ff892dc042df433a34ab4df5f61e9014aeb32c6bdacf97306bcee7f34931f7a4cf6440ea79f80c0e5ee8b1b4b12987aad22bb89878e051d5b25e55d0dce8874",
            "218fabd2842014769e7efb5242415213efde59acdc14faec7758b94810020517",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x91FDe64B7c4cE7248528B711E0Cac17240BE3c96",
            "BD/4ktwELfQzo0q0319h6QFK6zLGvaz5cwa87n80kx96TPZEDqefgMDl7osbSxKYeq0iu4mHjgUdWyXlXQ3OiHQ=",
            "IY+r0oQgFHaefvtSQkFSE+/eWazcFPrsd1i5SBACBRc=",
        ),
    ),
    # m/44'/60'/0'/0/54
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0xb1ac8A575FA33Fa176C1AE966c976c0F4dC3d8c3",
            "0x20da26b24ed461727586f92ae52f8a2b40c941025eedac7caa431e6237a8d498272b4b329eafe7ed830d78fa8b9a9adab91b993f8a9c214676595b22217b7931",
            "3277832a3b5d18a0a29124335cf40869f024cec40eda99c1cced493d3adb447b",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0xb1ac8A575FA33Fa176C1AE966c976c0F4dC3d8c3",
            "BCDaJrJO1GFydYb5KuUviitAyUECXu2sfKpDHmI3qNSYJytLMp6v5+2DDXj6i5qa2rkbmT+KnCFGdllbIiF7eTE=",
            "MneDKjtdGKCikSQzXPQIafAkzsQO2pnBzO1JPTrbRHs=",
        ),
    ),
    # m/44'/60'/0'/0/55
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x53074b3553c63dF522C1881acCe05aF016b3c931",
            "0x916cabf0e43fd5bc4973ed342e1b3f99ff560340a3b942b50fdfac68659f9794903749d4b352f349599456a328d81a0356dde902c789dd4066daac46a77df90f",
            "2d4de2a32f5a9822f1e0c22cbaa34328c008e9379228c4995661c28ce724d610",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x53074b3553c63dF522C1881acCe05aF016b3c931",
            "BJFsq/DkP9W8SXPtNC4bP5n/VgNAo7lCtQ/frGhln5eUkDdJ1LNS80lZlFajKNgaA1bd6QLHid1AZtqsRqd9+Q8=",
            "LU3ioy9amCLx4MIsuqNDKMAI6TeSKMSZVmHCjOck1hA=",
        ),
    ),
    # m/44'/60'/0'/0/56
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x164090d53e2a42e07Bf0bfB4Ba61876a71b18859",
            "0xe62ca68974dc5aa5ceb820fdc9d08eba81877fd1516dd3cc2cce7daed350f6af4582fb3f80750b79ad2f46829a1123d2ab9cf11d46e0c63a549d3aefe65a98ba",
            "240560eaca11348c5f0a70b55d5d21218271b47eac8a8b75aaa9d99e018c0e44",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x164090d53e2a42e07Bf0bfB4Ba61876a71b18859",
            "BOYspol03Fqlzrgg/cnQjrqBh3/RUW3TzCzOfa7TUPavRYL7P4B1C3mtL0aCmhEj0quc8R1G4MY6VJ067+ZamLo=",
            "JAVg6soRNIxfCnC1XV0hIYJxtH6siot1qqnZngGMDkQ=",
        ),
    ),
    # m/44'/60'/0'/0/57
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0xC3E1d84c8C97677F62A1e0cCbAd2466cfbDC004F",
            "0x5feb12fdfdf2db14fbc32ee597ac0d02acc07d530ede4a091533e54f17dd0e296b203cccc4673f28d20728908c30723f8a7e2c08d9fc7870b196a5c995e24a76",
            "2ef4241b13666cd0bf43e899b12eada30841857a008999222fe969c09f50a7e8",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0xC3E1d84c8C97677F62A1e0cCbAd2466cfbDC004F",
            "BF/rEv398tsU+8Mu5ZesDQKswH1TDt5KCRUz5U8X3Q4payA8zMRnPyjSByiQjDByP4p+LAjZ/HhwsZalyZXiSnY=",
            "LvQkGxNmbNC/Q+iZsS6towhBhXoAiZkiL+lpwJ9Qp+g=",
        ),
    ),
    # m/44'/60'/0'/0/58
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x67959a19c1269C033A1cc029CaFE9ce65Fd66977",
            "0x4e914ad3139c041b13cf5b7d185afa9f190bbdab106fb3bc0f8ae80b949ceb99eea5a813ca712ae9cdb2cfdbaad9f3294aa91a5f200869a30b7e5435818692aa",
            "1cb9df2b4341a1501d9777cf75a7d29b0cae47ffcad23193abc9a37a6e631dd9",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x67959a19c1269C033A1cc029CaFE9ce65Fd66977",
            "BE6RStMTnAQbE89bfRha+p8ZC72rEG+zvA+K6AuUnOuZ7qWoE8pxKunNss/bqtnzKUqpGl8gCGmjC35UNYGGkqo=",
            "HLnfK0NBoVAdl3fPdafSmwyuR//K0jGTq8mjem5jHdk=",
        ),
    ),
    # m/44'/60'/0'/0/59
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0xfb79574ec8510B054585ca6DF42E2532D69E4186",
            "0x39cea64565b1667c51afe3bf67bdcd1173f12181578ee6fe2a913a41923e902532ece593cac6135012f97545e972e4281dd7ab3273b69cd61301a234719be82d",
            "d6ed2a3569540f419337bae7b3c15d46a107ed80c27533d33521054b7e82bbb1",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0xfb79574ec8510B054585ca6DF42E2532D69E4186",
            "BDnOpkVlsWZ8Ua/jv2e9zRFz8SGBV47m/iqROkGSPpAlMuzlk8rGE1AS+XVF6XLkKB3XqzJztpzWEwGiNHGb6C0=",
            "1u0qNWlUD0GTN7rns8FdRqEH7YDCdTPTNSEFS36Cu7E=",
        ),
    ),
    # m/44'/60'/0'/0/60
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0xBc39041833DB3743167d68d0bA80CBa4901a2868",
            "0x3d5ce1afe77e0eacdcfef9757ed3d509d784d433c189a2fd329eb5a1dcbde43cd121811fbf1aa8c84cc6fef8e59c6bd72c712824a4a0bbec1479eeea3a2ef424",
            "87666e77a30f1c6e37a50df115ea96cec1157c1c1345b9cc1ebf04f9cf8f7c3e",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0xBc39041833DB3743167d68d0bA80CBa4901a2868",
            "BD1c4a/nfg6s3P75dX7T1QnXhNQzwYmi/TKetaHcveQ80SGBH78aqMhMxv745Zxr1yxxKCSkoLvsFHnu6jou9CQ=",
            "h2Zud6MPHG43pQ3xFeqWzsEVfBwTRbnMHr8E+c+PfD4=",
        ),
    ),
    # m/44'/60'/0'/0/61
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0xddfBF34d9637Ce86930B3379Ec1d386C3a35b95F",
            "0xa225ae6f75db25aae04fb00779856881cb5c7243ae81a5184c6c5208012651e3f44f63af6aad17d99c961f0ffc55026719d4102695fe5362e7e0b0c5678ca71a",
            "2f3553918197dbbd927b4f4a95ff99752a92b9687adc476af60796341cac2669",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0xddfBF34d9637Ce86930B3379Ec1d386C3a35b95F",
            "BKIlrm912yWq4E+wB3mFaIHLXHJDroGlGExsUggBJlHj9E9jr2qtF9mclh8P/FUCZxnUECaV/lNi5+CwxWeMpxo=",
            "LzVTkYGX272Se09Klf+ZdSqSuWh63Edq9geWNBysJmk=",
        ),
    ),
    # m/44'/60'/0'/0/62
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x5e9f1Cb0Bd5943CD2D193cB8df2b587482A07E58",
            "0x7630daeedafa3004f92a7bdbc8a38a6ce7f30b5b90bc976e75bb3ab03ccbb030b0d7b3806ca720cdf77e6babf557928827ae1348b5a3796d9aaa0048a7fb38c7",
            "d7596918c4aa7e33daa3b5f30bb75e4b531755e8bd836051738761d40039e0a4",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x5e9f1Cb0Bd5943CD2D193cB8df2b587482A07E58",
            "BHYw2u7a+jAE+Sp728ijimzn8wtbkLyXbnW7OrA8y7AwsNezgGynIM33fmur9VeSiCeuE0i1o3ltmqoASKf7OMc=",
            "11lpGMSqfjPao7XzC7deS1MXVei9g2BRc4dh1AA54KQ=",
        ),
    ),
    # m/44'/60'/0'/0/63
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0xf0a0F114d70eC023ac7e1c043a5f9bDDE691fC9c",
            "0x7adb750b34e6d93bb148e96b9077d5eca9c34101b20cab1ce11ae7121f19c5e966c795c3fd35d1dcf4cce378ae577956fbbd14dfa677d16698af019b532b5b5d",
            "b880ed840c77f1e324eacf6963a790e204974aca433099e911941d8ac41760a6",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0xf0a0F114d70eC023ac7e1c043a5f9bDDE691fC9c",
            "BHrbdQs05tk7sUjpa5B31eypw0EBsgyrHOEa5xIfGcXpZseVw/010dz0zON4rld5Vvu9FN+md9FmmK8Bm1MrW10=",
            "uIDthAx38eMk6s9pY6eQ4gSXSspDMJnpEZQdisQXYKY=",
        ),
    ),
    # m/44'/60'/0'/0/64
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0xFB5aD3fE9cAf0C1d11a6E588e90d7AC8F2919F04",
            "0x4a2c321cd9e078007a0f865c4f92e74336800fcfde2951fb4663f87826f3fe2490c98c4787d4581fb7f163efa6a2718c647e82671718d12efacfebcf8553b0ea",
            "b839c66269afda55cee2b716c9e08fb8259128fb58871cb79dbb6b0b80056ca0",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0xFB5aD3fE9cAf0C1d11a6E588e90d7AC8F2919F04",
            "BEosMhzZ4HgAeg+GXE+S50M2gA/P3ilR+0Zj+Hgm8/4kkMmMR4fUWB+38WPvpqJxjGR+gmcXGNEu+s/rz4VTsOo=",
            "uDnGYmmv2lXO4rcWyeCPuCWRKPtYhxy3nbtrC4AFbKA=",
        ),
    ),
    # m/44'/60'/0'/0/65
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x3E3A2C16F2FC6fDEc4Ea177f1DFa09d03cD3b5a2",
            "0x6b61132906d5d3287e6a8c109dd1e00e9d7d3b388d94be7881c04f7e9cb66b076cc7f20f5c74e465cc925ecdfc4bd21b09f82a603a776ea1aa5ef67cbc66402e",
            "0cb126b77b26d38c99bddcba899fa15b18c5b64f48d2a1075f4682ec0ae741c0",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x3E3A2C16F2FC6fDEc4Ea177f1DFa09d03cD3b5a2",
            "BGthEykG1dMofmqMEJ3R4A6dfTs4jZS+eIHAT36ctmsHbMfyD1x05GXMkl7N/EvSGwn4KmA6d26hql72fLxmQC4=",
            "DLEmt3sm04yZvdy6iZ+hWxjFtk9I0qEHX0aC7ArnQcA=",
        ),
    ),
    # m/44'/60'/0'/0/66
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x83F2D35b467b2104DBdfb6fFc355B249C44EA061",
            "0xe78b024f4c45c3d9bb0f25ef3de61439c13a892c0f89a8753c6edf101e243a34a88d4e9511fc1e0b90eb110386d3accb785179e734ac38620d56c8c2e3c2d0b6",
            "d4ae62cbf501347909d599d8c46ace38bdcb7f46ab69d76755af069a70b83817",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x83F2D35b467b2104DBdfb6fFc355B249C44EA061",
            "BOeLAk9MRcPZuw8l7z3mFDnBOoksD4modTxu3xAeJDo0qI1OlRH8HguQ6xEDhtOsy3hReec0rDhiDVbIwuPC0LY=",
            "1K5iy/UBNHkJ1ZnYxGrOOL3Lf0araddnVa8GmnC4OBc=",
        ),
    ),
    # m/44'/60'/0'/0/67
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x7B9a41F726729952f4DA24bC9d23C582Dc9b51Fe",
            "0x720c644c352dba8331d320c89bef2ab0fe949a26ca5aa7032d45ef3d4ffe727b8e4f3f8e834e73babeda015a97f9bc72e48d850c4b69d91d3c5a3be3bad29bba",
            "077234e31c368c6fdda5b04d7ea39105e65bd9e69e0239417f00aef48823255e",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x7B9a41F726729952f4DA24bC9d23C582Dc9b51Fe",
            "BHIMZEw1LbqDMdMgyJvvKrD+lJomylqnAy1F7z1P/nJ7jk8/joNOc7q+2gFal/m8cuSNhQxLadkdPFo747rSm7o=",
            "B3I04xw2jG/dpbBNfqORBeZb2eaeAjlBfwCu9IgjJV4=",
        ),
    ),
    # m/44'/60'/0'/0/68
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x0F28Ab680ebeCFBC003B9Cf2742881C86DA45514",
            "0x14c175026b4c5735630ad7a8a2db13dab3c74bdf58784b0452afb8d17560aabfe395c2dea87b83b9bfae7d03b3b1f71a76a0635183edda669d6a2cad6227ee98",
            "e119620994375721f9e3bcf8a27b45f007ecf238837baf561e26f9a30ff8d155",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x0F28Ab680ebeCFBC003B9Cf2742881C86DA45514",
            "BBTBdQJrTFc1YwrXqKLbE9qzx0vfWHhLBFKvuNF1YKq/45XC3qh7g7m/rn0Ds7H3GnagY1GD7dpmnWosrWIn7pg=",
            "4RliCZQ3VyH547z4ontF8Afs8jiDe69WHib5ow/40VU=",
        ),
    ),
    # m/44'/60'/0'/0/69
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0xd86114705f4dbC7e3Fe620f3ef31EAb16c2CDf7C",
            "0xe3cad3079f475aca0cd817897c024dd54e90177a4c6c8af69c1738540714b34469e4c577bfd4f7ce0b8ba39512f6711f82b26a03bf0a8778ae2152061bbeed8a",
            "3361924d4334d4ed1d514bbcba5ad97d6e04296c981b8ca46a0ced236ea9b14f",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0xd86114705f4dbC7e3Fe620f3ef31EAb16c2CDf7C",
            "BOPK0wefR1rKDNgXiXwCTdVOkBd6TGyK9pwXOFQHFLNEaeTFd7/U984Li6OVEvZxH4KyagO/Cod4riFSBhu+7Yo=",
            "M2GSTUM01O0dUUu8ulrZfW4EKWyYG4ykagztI26psU8=",
        ),
    ),
    # m/44'/60'/0'/0/70
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x52a7a83E89De907e6d17F3979920a5dE76531391",
            "0x4c93f43f249f3824e8646266945eecf692212a0f83641452fdab965eaf15bd09475d43717ce878b7ddec2c40df4de6534c3702830fb6f0a49aa4ddc53be1aaf6",
            "877037b42809baf632e91e40fde3999347227ba851453544c5ddb2d005c83497",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x52a7a83E89De907e6d17F3979920a5dE76531391",
            "BEyT9D8knzgk6GRiZpRe7PaSISoPg2QUUv2rll6vFb0JR11DcXzoeLfd7CxA303mU0w3AoMPtvCkmqTdxTvhqvY=",
            "h3A3tCgJuvYy6R5A/eOZk0cie6hRRTVExd2y0AXINJc=",
        ),
    ),
    # m/44'/60'/0'/0/71
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x84762a992316995462C5A49429130042E21Feb24",
            "0x7df21d6d5f0eea86b2118b709d7605c300da3fd277f58cde9bb442c0bf0b7191db533fca3c08c9f3c3eb9e228be9921251a7bdfaef7b16e6ed0a0972c85199ca",
            "8c03e50b7f82518155ee0c2f0ac0ca41591f491170b2d32d5ef16dda84a2899d",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x84762a992316995462C5A49429130042E21Feb24",
            "BH3yHW1fDuqGshGLcJ12BcMA2j/Sd/WM3pu0QsC/C3GR21M/yjwIyfPD654ii+mSElGnvfrvexbm7QoJcshRmco=",
            "jAPlC3+CUYFV7gwvCsDKQVkfSRFwstMtXvFt2oSiiZ0=",
        ),
    ),
    # m/44'/60'/0'/0/72
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x623b8Aed2828630c4f70f973aa5fDf16097a4626",
            "0xcbef4b1d2f2d646ef963eb3f45b94ed2e5f9f77f772658ec454869815889209da12f5bcb5ddc206aa4602edf6ca3595de3665e27fa45acbb463fae918c1c0a9b",
            "b5d04e50194f3ac01cada3077d9716b663eebe06a015122e7b0372e798954333",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x623b8Aed2828630c4f70f973aa5fDf16097a4626",
            "BMvvSx0vLWRu+WPrP0W5TtLl+fd/dyZY7EVIaYFYiSCdoS9by13cIGqkYC7fbKNZXeNmXif6Ray7Rj+ukYwcCps=",
            "tdBOUBlPOsAcraMHfZcWtmPuvgagFRIuewNy55iVQzM=",
        ),
    ),
    # m/44'/60'/0'/0/73
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x05b34aD8BA4F8c611cF43ffD051013bD3BE3af55",
            "0x290e65c9362f0d250347f7359f03136672fa4e3c2b853d33184752731b694205d509f29871026548c9c73280a8b10f252403452ea25118591010c1983315a95e",
            "9ff9171752fb749de81c75779406b2b0072cb1c88a86c3e170bc37dde84661c8",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x05b34aD8BA4F8c611cF43ffD051013bD3BE3af55",
            "BCkOZck2Lw0lA0f3NZ8DE2Zy+k48K4U9MxhHUnMbaUIF1QnymHECZUjJxzKAqLEPJSQDRS6iURhZEBDBmDMVqV4=",
            "n/kXF1L7dJ3oHHV3lAaysAcssciKhsPhcLw33ehGYcg=",
        ),
    ),
    # m/44'/60'/0'/0/74
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x956a76461c300E81f42dA53bA711F57b928E4E04",
            "0xd3a96ab5a3e30234b20fc99551012db3e15cc22e73f198695458e6229e2d40428660f444e03b60378daf8b42a6586a24f557cb65aabd26e6f8e5ed9a00bf0f57",
            "5b686790a8ee5589d6ef098c6e7659097185c6f43d813bad25f35da53024a36e",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x956a76461c300E81f42dA53bA711F57b928E4E04",
            "BNOparWj4wI0sg/JlVEBLbPhXMIuc/GYaVRY5iKeLUBChmD0ROA7YDeNr4tCplhqJPVXy2WqvSbm+OXtmgC/D1c=",
            "W2hnkKjuVYnW7wmMbnZZCXGFxvQ9gTutJfNdpTAko24=",
        ),
    ),
    # m/44'/60'/0'/0/75
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x51C55970Ce0ae13166fD16DE5F58be2309563364",
            "0x01e46292614e7b1b73474af451e539b7825e424245b27a28e249f0dd62938abbdf2df7bd4f38e3024decf480fa417d156aee67f8ae32918fd061cdc9b7e04439",
            "174e2a43af071dab614503eaf65e2741ead1718d7552fa7955fd4b1e1ed00aed",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x51C55970Ce0ae13166fD16DE5F58be2309563364",
            "BAHkYpJhTnsbc0dK9FHlObeCXkJCRbJ6KOJJ8N1ik4q73y33vU844wJN7PSA+kF9FWruZ/iuMpGP0GHNybfgRDk=",
            "F04qQ68HHathRQPq9l4nQerRcY11Uvp5Vf1LHh7QCu0=",
        ),
    ),
    # m/44'/60'/0'/0/76
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x945021CE5C876e153f2D5d7204C4486e125bb52B",
            "0xef2e4732bf96afe99d0c9b8150e5eb7c3fb73b9c87e0803bf83c0a7cc5f41dd761154b30468add4692560f2043dece442833a03cd50502235292f7b3c9ea5a95",
            "0de541c26ac014244ef72b7af559fa8c6d8f797b3c0983a72c7a7f8b31e00ffe",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x945021CE5C876e153f2D5d7204C4486e125bb52B",
            "BO8uRzK/lq/pnQybgVDl63w/tzuch+CAO/g8CnzF9B3XYRVLMEaK3UaSVg8gQ97ORCgzoDzVBQIjUpL3s8nqWpU=",
            "DeVBwmrAFCRO9yt69Vn6jG2PeXs8CYOnLHp/izHgD/4=",
        ),
    ),
    # m/44'/60'/0'/0/77
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x6552400848Bd54Af0e0B076803F9c9fb711fAE18",
            "0x5207cd026b848cf033df9c94aa280926ab09fe08b6474e57e0a936142d404ff009a9d797c935d47009d4dbb6ac71d07a75a8f521b8e2b7f50b4110aefc5c0681",
            "301934cd66566f0ea0de77ec7c6f6442d84b948a821bbcce3649e379bfcd99f3",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x6552400848Bd54Af0e0B076803F9c9fb711fAE18",
            "BFIHzQJrhIzwM9+clKooCSarCf4ItkdOV+CpNhQtQE/wCanXl8k11HAJ1Nu2rHHQenWo9SG44rf1C0EQrvxcBoE=",
            "MBk0zWZWbw6g3nfsfG9kQthLlIqCG7zONknjeb/NmfM=",
        ),
    ),
    # m/44'/60'/0'/0/78
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x764e4d64090B545bB884B9Fd26cE734e362042B7",
            "0x0cd2cfd8b889fdc06d865f644bb4f8e0e212d3769de994d77401a40b766f1836b974f5197094aa616283b48e571f309545d001f35843f5f43fd49e552eaa34b2",
            "a00b17e91eaa044b82441115b40233a0028f017d7f5c83c59cedff5c5b5c0fef",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x764e4d64090B545bB884B9Fd26cE734e362042B7",
            "BAzSz9i4if3AbYZfZEu0+ODiEtN2nemU13QBpAt2bxg2uXT1GXCUqmFig7SOVx8wlUXQAfNYQ/X0P9SeVS6qNLI=",
            "oAsX6R6qBEuCRBEVtAIzoAKPAX1/XIPFnO3/XFtcD+8=",
        ),
    ),
    # m/44'/60'/0'/0/79
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x429Fe9934A554EbB0d992f8dd0ef7CbbB8cdC48C",
            "0x77ed660914912e14c9b453e11d79bdcd63acdec0f906089af3a455773a73f46beb2300c1247c938b1f0d43e4c94d6029e7e1383a5691b4eaff322a57b6e876f4",
            "fdbe7f37c4e40d574469581f92210286a4a94f96f467b82d9358b20e55a9bd7f",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x429Fe9934A554EbB0d992f8dd0ef7CbbB8cdC48C",
            "BHftZgkUkS4UybRT4R15vc1jrN7A+QYImvOkVXc6c/Rr6yMAwSR8k4sfDUPkyU1gKefhODpWkbTq/zIqV7bodvQ=",
            "/b5/N8TkDVdEaVgfkiEChqSpT5b0Z7gtk1iyDlWpvX8=",
        ),
    ),
    # m/44'/60'/0'/0/80
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0xD8348cb61F78BF0BdaB6a6A224E8c939830CE7b3",
            "0x69a6e07da709837448b3e19fd021e45ac4e1894fd3b6ac30493545ed7eff6562d70ed0bcdd741f1de4dea1bd0bd0060dfe42709c05361faeb9b4954de3b41c8f",
            "1eed9aaec5e59e46b58bf7fccf3307b83b40aa6494cace4c3698eebbbec7af5f",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0xD8348cb61F78BF0BdaB6a6A224E8c939830CE7b3",
            "BGmm4H2nCYN0SLPhn9Ah5FrE4YlP07asMEk1Re1+/2Vi1w7QvN10Hx3k3qG9C9AGDf5CcJwFNh+uubSVTeO0HI8=",
            "Hu2arsXlnka1i/f8zzMHuDtAqmSUys5MNpjuu77Hr18=",
        ),
    ),
    # m/44'/60'/0'/0/81
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x66983f7EEb7346603Cd580a3c45EF3ceF1Ab58dd",
            "0x51134a2b844362af618876608baf7444e6d1bd310a395112f533d8e90a215b4df188fb822cfad80c53379f28452af609375a2b7c86aaa59f47faa2fcd7c9e2d8",
            "07634baeb12eb1dc1a4d15b346566f65c42d3eeac3099db93bce9c5d1b5d5577",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x66983f7EEb7346603Cd580a3c45EF3ceF1Ab58dd",
            "BFETSiuEQ2KvYYh2YIuvdETm0b0xCjlREvUz2OkKIVtN8Yj7giz62AxTN58oRSr2CTdaK3yGqqWfR/qi/NfJ4tg=",
            "B2NLrrEusdwaTRWzRlZvZcQtPurDCZ25O86cXRtdVXc=",
        ),
    ),
    # m/44'/60'/0'/0/82
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x96cb80Ea07acC199f95f73D330E5026E8FE31b99",
            "0x407ad8a1d0f4d5d488f0a47ae6e32363adafa47780e8bc594807620d03cc378619973c165d11272f8288c74733e8e0132c666366850856c3703e593106b0539b",
            "e8f0238ac9592c9d4aa8aa441cc94137d2c96e658b7055f33312d2ca232eeb48",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x96cb80Ea07acC199f95f73D330E5026E8FE31b99",
            "BEB62KHQ9NXUiPCkeubjI2Otr6R3gOi8WUgHYg0DzDeGGZc8Fl0RJy+CiMdHM+jgEyxmY2aFCFbDcD5ZMQawU5s=",
            "6PAjislZLJ1KqKpEHMlBN9LJbmWLcFXzMxLSyiMu60g=",
        ),
    ),
    # m/44'/60'/0'/0/83
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x83D72E0eD72dA5467D4ca996e6E47A25Efb2F4C1",
            "0x5b69f249d62109880039930dfbf955a3ba85e80d42a7a7dad7821efe84361d838f3f351bd5aa54c47173a1c82c78c12a64559c57470692dfc1e91bf69b828546",
            "32e0589a09995e139906553c11b50b184fe1b67916c58faf7570b5e89ed0eee1",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x83D72E0eD72dA5467D4ca996e6E47A25Efb2F4C1",
            "BFtp8knWIQmIADmTDfv5VaO6hegNQqen2teCHv6ENh2Djz81G9WqVMRxc6HILHjBKmRVnFdHBpLfwekb9puChUY=",
            "MuBYmgmZXhOZBlU8EbULGE/htnkWxY+vdXC16J7Q7uE=",
        ),
    ),
    # m/44'/60'/0'/0/84
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x76443cEBc18d86FFBA21bc26F537e2ba8a882555",
            "0x4b42f51d6f76e450d498e493cbfa3dbbb19a3d372bf684e551bddf989d51c7f7b9a5bc96530c32e2ac1277a0f4de06c1a4d02ac28ad0d72e264bd842e6b94d25",
            "214111817a78c53f6fd19c109e2a4ed61d316a9bfc60774bf73b477d68d466ac",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x76443cEBc18d86FFBA21bc26F537e2ba8a882555",
            "BEtC9R1vduRQ1Jjkk8v6Pbuxmj03K/aE5VG935idUcf3uaW8llMMMuKsEneg9N4GwaTQKsKK0NcuJkvYQua5TSU=",
            "IUERgXp4xT9v0ZwQnipO1h0xapv8YHdL9ztHfWjUZqw=",
        ),
    ),
    # m/44'/60'/0'/0/85
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0xf2cC85782B44f7828BA2a4d9Ea87Bec508B33357",
            "0x358cbfb2770a768e29c07091d6db6159f2410557306b731949d58b74869b8b68b9681ebbf07550930e0b0148bd87d8a388598c61b1db680d0f4c09cf77316e2f",
            "a0835f1357a989e623292edc290d2936d1030f64f93384c08ed52de2ae379167",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0xf2cC85782B44f7828BA2a4d9Ea87Bec508B33357",
            "BDWMv7J3CnaOKcBwkdbbYVnyQQVXMGtzGUnVi3SGm4touWgeu/B1UJMOCwFIvYfYo4hZjGGx22gND0wJz3cxbi8=",
            "oINfE1epieYjKS7cKQ0pNtEDD2T5M4TAjtUt4q43kWc=",
        ),
    ),
    # m/44'/60'/0'/0/86
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0xA58EC24FC1eb389717FB63b6e39c2933c1cFF684",
            "0xa9054de1cafaeac6f54755542835edccb9f433691f58b65828a541aae0849e8763ea0d0f81176c41c143c7db9d126ccd97d630e8a71dcda45b66cf7622be183e",
            "4dcd8cbfff843b0741839ce9c69684e35063bda69800b9fecb622bace3212cc3",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0xA58EC24FC1eb389717FB63b6e39c2933c1cFF684",
            "BKkFTeHK+urG9UdVVCg17cy59DNpH1i2WCilQarghJ6HY+oND4EXbEHBQ8fbnRJszZfWMOinHc2kW2bPdiK+GD4=",
            "Tc2Mv/+EOwdBg5zpxpaE41BjvaaYALn+y2IrrOMhLMM=",
        ),
    ),
    # m/44'/60'/0'/0/87
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x1E7C89De5bB8E6E020dA89E255ADa29b2fdd24b1",
            "0xe299041035390b575bc4ee4a992e8cb229f2353207c013a0e0dd8d02294e01b6104a41fb0faa7aef8a8dc821f2bcc98aadadf3203a22acb78b96048f18d6c21b",
            "f89e01678bbc6c922d27ba9e3a5da4985c99ce5d3ab73edd8a9aeca9f93a4804",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x1E7C89De5bB8E6E020dA89E255ADa29b2fdd24b1",
            "BOKZBBA1OQtXW8TuSpkujLIp8jUyB8AToODdjQIpTgG2EEpB+w+qeu+Kjcgh8rzJiq2t8yA6Iqy3i5YEjxjWwhs=",
            "+J4BZ4u8bJItJ7qeOl2kmFyZzl06tz7diprsqfk6SAQ=",
        ),
    ),
    # m/44'/60'/0'/0/88
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0xE1a0CD85481F03a643Ef56DD45485C90bacA5Ed7",
            "0x49b41d091bb19a6261581329321d8b190c7c73f83667a49e3d86af60c7c32a3216c0e86c2be735e3384ec0a75ab68f7bb6fdcf6b7a87d060bd99b955f4862853",
            "af63aa22689bba7aa5f2a7079574e65d6847b3656ba9af464173b4d9b277b699",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0xE1a0CD85481F03a643Ef56DD45485C90bacA5Ed7",
            "BEm0HQkbsZpiYVgTKTIdixkMfHP4Nmeknj2Gr2DHwyoyFsDobCvnNeM4TsCnWraPe7b9z2t6h9BgvZm5VfSGKFM=",
            "r2OqImibunql8qcHlXTmXWhHs2Vrqa9GQXO02bJ3tpk=",
        ),
    ),
    # m/44'/60'/0'/0/89
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x82CE251D4Db35b434CD246D0762dff4A85dB73D8",
            "0x8367f337ba111eef04fc3dbcde4238b3956ad26fb967cb2878a6936b5b4d32e620a82123de33989c1cd74dc5d5077d00dd1ebb562a73c8dc07416e6874635434",
            "06df08e8bf7fcaa88859d528dc91181c6d7eb3d9c36b7a4341ef1b61389238b7",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x82CE251D4Db35b434CD246D0762dff4A85dB73D8",
            "BINn8ze6ER7vBPw9vN5COLOVatJvuWfLKHimk2tbTTLmIKghI94zmJwc103F1Qd9AN0eu1Yqc8jcB0FuaHRjVDQ=",
            "Bt8I6L9/yqiIWdUo3JEYHG1+s9nDa3pDQe8bYTiSOLc=",
        ),
    ),
    # m/44'/60'/0'/0/90
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x9815f14De23a864D878F857D6A9c40E4b71c38c9",
            "0x1103c0412121228b2061e74315451d331df3149044ff9f025859393ad1c78823c2d429a4b7368ce8a4626a72923cfcde2d946bbabeca71eccd8ccad87772621c",
            "cc980bf3a46b4e109428782f8c1f7a395097dfeb1ab54d7d8342275f3d917c0c",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x9815f14De23a864D878F857D6A9c40E4b71c38c9",
            "BBEDwEEhISKLIGHnQxVFHTMd8xSQRP+fAlhZOTrRx4gjwtQppLc2jOikYmpykjz83i2Ua7q+ynHszYzK2HdyYhw=",
            "zJgL86RrThCUKHgvjB96OVCX3+satU19g0InXz2RfAw=",
        ),
    ),
    # m/44'/60'/0'/0/91
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x6bd9C38EA0d2D125Bb37EE8923077EB1311C0838",
            "0x1c59cca46d6eb30b22a68da76515c5b0112f372ab1f7979c7c090af721ad7d24f1132c643a70a59fb4fc79be966f794c3348c5e9a7586845e059e36afdc17623",
            "1fe682d437c1612353459833078d63402c03230ba34274cf04fd7fc6b266a5dc",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x6bd9C38EA0d2D125Bb37EE8923077EB1311C0838",
            "BBxZzKRtbrMLIqaNp2UVxbARLzcqsfeXnHwJCvchrX0k8RMsZDpwpZ+0/Hm+lm95TDNIxemnWGhF4Fnjav3BdiM=",
            "H+aC1DfBYSNTRZgzB41jQCwDIwujQnTPBP1/xrJmpdw=",
        ),
    ),
    # m/44'/60'/0'/0/92
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0xf13a16B8CD06037E0edD7f17FE2f26cDAeF9F11a",
            "0xe8718504c5ca0db7acafa51bacb5cd775a9b542937647f9563e3505b55d201ffe44c17dfde600a5c359492322fd38c6ccb29def87a93db5ea501491438493b47",
            "dee279457e5f2b3c15457be9cf69ef4d02956d865ca8f02a6f00bbc1e744c76a",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0xf13a16B8CD06037E0edD7f17FE2f26cDAeF9F11a",
            "BOhxhQTFyg23rK+lG6y1zXdam1QpN2R/lWPjUFtV0gH/5EwX395gClw1lJIyL9OMbMsp3vh6k9tepQFJFDhJO0c=",
            "3uJ5RX5fKzwVRXvpz2nvTQKVbYZcqPAqbwC7wedEx2o=",
        ),
    ),
    # m/44'/60'/0'/0/93
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x9da00a6A3a35Fc002a285de85Ac4083327A96a50",
            "0xd06df0be0864d2d8b34ab451f6a0f6a49d864975291e7c68725b0480d9355af625ecd078a7c03b3278656f729c005244d88be5bf8e4f3c18d728f55ca7cb95a8",
            "51faba73f416e48937b389f4c877ce63e3c3c7f2b8c690ec0700cfb978297996",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x9da00a6A3a35Fc002a285de85Ac4083327A96a50",
            "BNBt8L4IZNLYs0q0Ufag9qSdhkl1KR58aHJbBIDZNVr2JezQeKfAOzJ4ZW9ynABSRNiL5b+OTzwY1yj1XKfLlag=",
            "Ufq6c/QW5Ik3s4n0yHfOY+PDx/K4xpDsBwDPuXgpeZY=",
        ),
    ),
    # m/44'/60'/0'/0/94
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x53c3A99F6FA910461c2bbe1AD4dEd24bBc1F0047",
            "0x38cc8dc4bf279ac67f31a904a5bec2a86668e9878e0f6549bd5981ffa2fecc869b6a5ab35f39e7456a142f44d93a2454653b3758de10ebda13a2a86eeec24933",
            "57c605a240adf4d6b5ac73c08ef4fb35e32471ddb52a011020da96d03487e8e5",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x53c3A99F6FA910461c2bbe1AD4dEd24bBc1F0047",
            "BDjMjcS/J5rGfzGpBKW+wqhmaOmHjg9lSb1Zgf+i/syGm2pas18550VqFC9E2TokVGU7N1jeEOvaE6Kobu7CSTM=",
            "V8YFokCt9Na1rHPAjvT7NeMkcd21KgEQINqW0DSH6OU=",
        ),
    ),
    # m/44'/60'/0'/0/95
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0xC82f246AE9AA5547eE5DDCC60C91A8e3C9254Ea5",
            "0x57367b4320ca1fe1b16be708784775f76ad10f2c9deb5162a557074075ce4fb24139c7c22d311687e1376fb8358c7374e3759d500832f163c1f5d2b966763452",
            "805782985e23872722bf9f0474a230735c4a960bcf22b9dfc2366b6ea890d2a1",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0xC82f246AE9AA5547eE5DDCC60C91A8e3C9254Ea5",
            "BFc2e0Mgyh/hsWvnCHhHdfdq0Q8snetRYqVXB0B1zk+yQTnHwi0xFofhN2+4NYxzdON1nVAIMvFjwfXSuWZ2NFI=",
            "gFeCmF4jhyciv58EdKIwc1xKlgvPIrnfwjZrbqiQ0qE=",
        ),
    ),
    # m/44'/60'/0'/0/96
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x8fD4dd171eCc1E78444E192023E65965c9914Bc3",
            "0xf18e12e36c502e6fe183da97154e0d65f57a7e9fc596c3839ac31b0a70f270d5fba0b8789cf94839af7c850dfa8bf5477d6d1dd4db325e5374a312119fe48200",
            "825f1813feee6d2b6106b0a742a6830d3a75f4f35a22fa901ef3427fee9b7ad6",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x8fD4dd171eCc1E78444E192023E65965c9914Bc3",
            "BPGOEuNsUC5v4YPalxVODWX1en6fxZbDg5rDGwpw8nDV+6C4eJz5SDmvfIUN+ov1R31tHdTbMl5TdKMSEZ/kggA=",
            "gl8YE/7ubSthBrCnQqaDDTp19PNaIvqQHvNCf+6betY=",
        ),
    ),
    # m/44'/60'/0'/0/97
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x1F064F92cA6833FE86409D609527ACA5C8b5cB43",
            "0x347bbf53d0ba784d739e0a1e3704ba209322ee1b6dfbadcd4bc8e506cd1b6ae9c8054c585da6f554875fd0a3baf15ae292109cbcca812f643a21adfe7f9766",
            "099dc55eb9ccee41739d5889c9656cf263988c9c332e0c4250b1730ac974a2ed",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x1F064F92cA6833FE86409D609527ACA5C8b5cB43",
            "BDR7v1PQunhNc54KHjcEuiCTIu4bbfutzUvI5QbNG2rpyAVMWF2m9VSHX9CjuvFa4pIQnLzKgS9kOiGt/n+XZg==",
            "CZ3FXrnM7kFznViJyWVs8mOYjJwzLgxCULFzCsl0ou0=",
        ),
    ),
    # m/44'/60'/0'/0/98
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0xcD8D5477Bc1557545F2673110ee200B34599ffd0",
            "0xd58c347e6361b135e190024f9e7fd45a22e74f827db9126734239a1e9f69cf9207ea7279538eb1cf7971d19201eb6a4090b143aba69ac62fcf9989e53ac86488",
            "dada460d6d9ad6d175c1ce5ff0f6ee60fbac5ead4c5a50022b56a41a5c46594d",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0xcD8D5477Bc1557545F2673110ee200B34599ffd0",
            "BNWMNH5jYbE14ZACT55/1Foi50+CfbkSZzQjmh6fac+SB+pyeVOOsc95cdGSAetqQJCxQ6ummsYvz5mJ5TrIZIg=",
            "2tpGDW2a1tF1wc5f8PbuYPusXq1MWlACK1akGlxGWU0=",
        ),
    ),
    # m/44'/60'/0'/0/99
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0xf4095e845e78B0e0304b3E4c3D8708D8CF1FAAe0",
            "0x2198b3e65f7ab30351f0fe70f4364001e0f1a091523e404fa0733425109f967de128b7230a0a17c907b7fe50d368786e8f7b74acf65d7fc7b31b6d4339856835",
            "8990a165648f9c4f9eef05da826c7a7781b501fb48834d5c5b118928feefbef6",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0xf4095e845e78B0e0304b3E4c3D8708D8CF1FAAe0",
            "BCGYs+ZferMDUfD+cPQ2QAHg8aCRUj5AT6BzNCUQn5Z94Si3IwoKF8kHt/5Q02h4bo97dKz2XX/HsxttQzmFaDU=",
            "iZChZWSPnE+e7wXagmx6d4G1AftIg01cWxGJKP7vvvY=",
        ),
    ),
]
