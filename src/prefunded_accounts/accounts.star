account = import_module("../account/account.star")

PREFUNDED_ACCOUNTS = [
    # vanity/0x11111
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x11111f7eaa946be186bedc72df002ff166ee9045",
            "0x582376316f3c301290487ce63ee946f96afba0afd82bea0e284e003af49d35e4cbf924b407a5c316c9c9e676b59047b18f5cf2615d842488ebacb9baabdd901a",
            "366e00782dc95330d1e831c05c9acc7b7bf6dd113e3e4e587ab10ce6e788205c",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x11111f7eaa946be186bedc72df002ff166ee9045",
            "BFgjdjFvPDASkEh85j7pRvlq+6Cv2CvqDihOADr0nTXky/kktAelwxbJyeZ2tZBHsY9c8mFdhCSI66y5uqvdkBo=",
            "Nm4AeC3JUzDR6DHAXJrMe3v23RE+Pk5YerEM5ueIIFw=",
        ),
    ),
    # vanity/0x22222
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x22222743b71969b4f3fb87a650ec116548ed740b",
            "0x2616a2f919ca664e629c90f5fefdea08458b5122d9e441f8f7c7bd22212ecfadcc375a96dafc32e6978dca12b87cd4d33cca2cb1e5f0518222ad6cfbc75b5179",
            "d59dd98fb79ecf8eae29a30675fc4b6eef8d894e31450544be683b283bf0c382",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x22222743b71969b4f3fb87a650ec116548ed740b",
            "BCYWovkZymZOYpyQ9f796ghFi1Ei2eRB+PfHvSIhLs+tzDdaltr8MuaXjcoSuHzU0zzKLLHl8FGCIq1s+8dbUXk=",
            "1Z3Zj7eez46uKaMGdfxLbu+NiU4xRQVEvmg7KDvww4I=",
        ),
    ),
    # vanity/0x33333
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x33333fae0b3a33c88f4b9a1313147fc60f721f67",
            "0x8d79e12e6c9789ac51d09d56287c2f17feb8908e0d9a324a6ab054b2bc6a64b6d826bb6823a46bb24b145a2d5bd83ff98888b95d0ad99d697f0be7e4340fc66b",
            "205b9ae0d41353f10c5737c77d1b3150158da3e219f7c1243e61a2d1ca936f72",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x33333fae0b3a33c88f4b9a1313147fc60f721f67",
            "BI154S5sl4msUdCdVih8Lxf+uJCODZoySmqwVLK8amS22Ca7aCOka7JLFFotW9g/+YiIuV0K2Z1pfwvn5DQPxms=",
            "IFua4NQTU/EMVzfHfRsxUBWNo+IZ98EkPmGi0cqTb3I=",
        ),
    ),
    # vanity/0x44444
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x44444baa7e42ed432556acd1e47c546793f9e165",
            "0x2d87ecb4aefc776993cc4129156f7141c15c50bd28bf597e98ecfbd43a9b945921b24e33f8d0fd545f582af1d60abc775baeff66df27f85d15c47939df4e0afc",
            "dfc83bc8ea0cea958c38d471e468e7aa4ebe219fc3c3a6061ec646184ce2c17b",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x44444baa7e42ed432556acd1e47c546793f9e165",
            "BC2H7LSu/Hdpk8xBKRVvcUHBXFC9KL9Zfpjs+9Q6m5RZIbJOM/jQ/VRfWCrx1gq8d1uu/2bfJ/hdFcR5Od9OCvw=",
            "38g7yOoM6pWMONRx5Gjnqk6+IZ/Dw6YGHsZGGEziwXs=",
        ),
    ),
    # vanity/0x55555
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x5555583243bbaaddb38713c6c008701cdae73a75",
            "0x7d4da03729b41a65b2d3bfc8a92d1630105a8fb0125e80a7d7e8fc19d9d3959825c2940f9ec559708c7ce6d8f70cf2dabf2bcc1fff3f8ce3079975bc84d326af",
            "155933e7cf1af24a28846a7f7e72ed3d60ad93027dea25e5a266c063a2dcd649",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x5555583243bbaaddb38713c6c008701cdae73a75",
            "BH1NoDcptBplstO/yKktFjAQWo+wEl6Ap9fo/BnZ05WYJcKUD57FWXCMfObY9wzy2r8rzB//P4zjB5l1vITTJq8=",
            "FVkz588a8koohGp/fnLtPWCtkwJ96iXlombAY6Lc1kk=",
        ),
    ),
    # vanity/0x66666
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x66666f88bc5720214b941fc9c9d3190093c94b4a",
            "0x4aa82a635dc133c6bb377ecddbc5cd75f91cc2929b9be6917d1ce49d46880415daab8816fea49df0c4ab36006e3ed7105b5aec92509b3b0dcff0d817e5647fe1",
            "b791d609d46f34ae68d3b3adfb2b686a189ddf338890335467d228f80d98f519",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x66666f88bc5720214b941fc9c9d3190093c94b4a",
            "BEqoKmNdwTPGuzd+zdvFzXX5HMKSm5vmkX0c5J1GiAQV2quIFv6knfDEqzYAbj7XEFta7JJQmzsNz/DYF+Vkf+E=",
            "t5HWCdRvNK5o07Ot+ytoahid3zOIkDNUZ9Io+A2Y9Rk=",
        ),
    ),
    # vanity/0x77777
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x77777106ea5bec90bc5b52dbeb465f4a6a467960",
            "0x4fef6f6297c0c8af569f004c20642b3a18690780fc44cab1f7397baf3664425966db41ef311e12203b953283a33e07a9637b22d879994c5a1974f336f03649ec",
            "1f6068ae546af14713f9a1e84b2e3147ffeef6e3f0e260b04c3ff693ac4c45d9",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x77777106ea5bec90bc5b52dbeb465f4a6a467960",
            "BE/vb2KXwMivVp8ATCBkKzoYaQeA/ETKsfc5e682ZEJZZttB7zEeEiA7lTKDoz4HqWN7Ith5mUxaGXTzNvA2Sew=",
            "H2BorlRq8UcT+aHoSy4xR//u9uPw4mCwTD/2k6xMRdk=",
        ),
    ),
    # vanity/0x88888
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x888883de3e8fb5c8e9c5ec34106d26aca272b306",
            "0x111190a9137f7aa900c15d8512f1ca68743ab3c9db569708c5866f36da5fb42b5dc8f52aa72b6dc4bc0a379270c3b4989f4830e8e98a7dcd7105061c657f72cc",
            "b3f6667801428ba1be1ee34a424501c1be49f6184170f5138b796af951dcecfb",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x888883de3e8fb5c8e9c5ec34106d26aca272b306",
            "BBERkKkTf3qpAMFdhRLxymh0OrPJ21aXCMWGbzbaX7QrXcj1KqcrbcS8CjeScMO0mJ9IMOjpin3NcQUGHGV/csw=",
            "s/ZmeAFCi6G+HuNKQkUBwb5J9hhBcPUTi3lq+VHc7Ps=",
        ),
    ),
    # vanity/0x99999
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x999998fe132d7c2ee4d568606056c279ed791bf1",
            "0x3e0acd4ec4a001544f79f2ff3194b1803233e30d73bb2289e229484cecf0a50095417c7a32c2be8234073dc873551371539d1ce2a8ae52d24b1e0bcf4014202d",
            "8d1dad54673cf2c00162e1d8dc8438e4e6eabc8191bb0741c90b4eae6449c209",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x999998fe132d7c2ee4d568606056c279ed791bf1",
            "BD4KzU7EoAFUT3ny/zGUsYAyM+MNc7siieIpSEzs8KUAlUF8ejLCvoI0Bz3Ic1UTcVOdHOKorlLSSx4Lz0AUIC0=",
            "jR2tVGc88sABYuHY3IQ45ObqvIGRuwdByQtOrmRJwgk=",
        ),
    ),
    # vanity/0x10101
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x1010104191c700348e4ee44eb3f54287c0e8d5ef",
            "0x7e5b7c4b4e85ea8b5bc4f042d35f6f7e5701b73ef173eb9d1a1aa0ee6238b3f363a59ac8b422ded5d089c2444496681b8e28c02874e5d76a559169ad7b1c74c0",
            "daa950f46266ca12b392baea3060ac62fef9cadd8616d0e60b7422a7470cb2d9",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x1010104191c700348e4ee44eb3f54287c0e8d5ef",
            "BH5bfEtOheqLW8TwQtNfb35XAbc+8XPrnRoaoO5iOLPzY6WayLQi3tXQicJERJZoG44owCh05ddqVZFprXscdMA=",
            "2qlQ9GJmyhKzkrrqMGCsYv75yt2GFtDmC3Qip0cMstk=",
        ),
    ),
    # vanity/0x11111
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x111118270066cba415d78b95d54c4291492adc08",
            "0xbecdb69b1b02dc3df74fed1cce883013e0189f0df017bc32e1fb40bdb0b1dbea5a2a9f2801f5c4112d20a969893fd342f4d57bf9c0d0e192c88f7740db2ca9bc",
            "366a6adb6d5662f44c2cc41b0aac126194455a1840509d17b24b68a975880c61",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x111118270066cba415d78b95d54c4291492adc08",
            "BL7NtpsbAtw990/tHM6IMBPgGJ8N8Be8MuH7QL2wsdvqWiqfKAH1xBEtIKlpiT/TQvTVe/nA0OGSyI93QNssqbw=",
            "Nmpq221WYvRMLMQbCqwSYZRFWhhAUJ0XsktoqXWIDGE=",
        ),
    ),
    # vanity/0x12121
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x121212255d79177bac0532e5887199385c2dde2e",
            "0xfd4caf5c9d566ef1eb3d809c2471ae7c719bf51d0d104cb5e4bc5037b68d2e7d175d7d3e64c55d610cb3b7bcd22912b34dc1b4b0346c2b574348b8dd485c81ca",
            "a26c6170f3d1286b433840a66eff422497979e052c09186130722f4747c88a64",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x121212255d79177bac0532e5887199385c2dde2e",
            "BP1Mr1ydVm7x6z2AnCRxrnxxm/UdDRBMteS8UDe2jS59F119PmTFXWEMs7e80ikSs03BtLA0bCtXQ0i43Uhcgco=",
            "omxhcPPRKGtDOECmbv9CJJeXngUsCRhhMHIvR0fIimQ=",
        ),
    ),
    # vanity/0x13131
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x13131c4205899853c75fe974d5954b05517bdfce",
            "0x845a3f249b10b3227f845ed3900e5a2adeb7031fdaed4a6b505ccd5d1c14dd6dbf2d9b41fd5a310fd9a842b82458c78879e0246d39d484f4c01a588b6e0c4010",
            "6d889d00d426b029d9fcf742f2f2fb3c9924786e00096088f8d8fb7baecc1cc8",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x13131c4205899853c75fe974d5954b05517bdfce",
            "BIRaPySbELMif4Re05AOWiretwMf2u1Ka1BczV0cFN1tvy2bQf1aMQ/ZqEK4JFjHiHngJG051IT0wBpYi24MQBA=",
            "bYidANQmsCnZ/PdC8vL7PJkkeG4ACWCI+Nj7e67MHMg=",
        ),
    ),
    # vanity/0x14141
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x141412c6f98de98b9eb94593fa219a4454fff128",
            "0x5458da28d91d98af55862548d5285ebb73f2b0da936bb5099bfa631c23368c3daa8b2838857a08859c2780dfe5687da742d8be50ecbca56fa7320bf2f2a57525",
            "66368251d91aca53fd021d66bc1f41c1bcefd5d171ef1ab6378d12d8e4f991f7",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x141412c6f98de98b9eb94593fa219a4454fff128",
            "BFRY2ijZHZivVYYlSNUoXrtz8rDak2u1CZv6YxwjNow9qosoOIV6CIWcJ4Df5Wh9p0LYvlDsvKVvpzIL8vKldSU=",
            "ZjaCUdkaylP9Ah1mvB9Bwbzv1dFx7xq2N40S2OT5kfc=",
        ),
    ),
    # vanity/0x15151
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x15151fac2c9e8779f837b95cf650069a8bf62000",
            "0x871b82492264e1bd695da3b577187ee538bd849c1a18f3b765837d2eb2c756b9cb0e86105cdad5e9920f3defdf840bd886e148874f2ca418906b8c0d6de5a41d",
            "322ace55fa15b403778b7d58961b51532ab57fed62c37621b4fedd1554898ceb",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x15151fac2c9e8779f837b95cf650069a8bf62000",
            "BIcbgkkiZOG9aV2jtXcYfuU4vYScGhjzt2WDfS6yx1a5yw6GEFza1emSDz3v34QL2IbhSIdPLKQYkGuMDW3lpB0=",
            "MirOVfoVtAN3i31YlhtRUyq1f+1iw3YhtP7dFVSJjOs=",
        ),
    ),
    # vanity/0x16161
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x161616a971ab1fd0cfa6aa64031ac2e54aaf4fa7",
            "0x2fae9f8e30be82426f90ab524344c72094703c263d41e071b036eddc461741157d569639a6bf2261eb3fbb2e11a688f79a80da30339e81ca64fff043a179bd69",
            "ffce7ab98dda6410aaf64cb740d43f805ad2d1a2edbc463fc0c6e69186c70cb7",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x161616a971ab1fd0cfa6aa64031ac2e54aaf4fa7",
            "BC+un44wvoJCb5CrUkNExyCUcDwmPUHgcbA27dxGF0EVfVaWOaa/ImHrP7suEaaI95qA2jAznoHKZP/wQ6F5vWk=",
            "/856uY3aZBCq9ky3QNQ/gFrS0aLtvEY/wMbmkYbHDLc=",
        ),
    ),
    # vanity/0x17171
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x17171350adf0aa2453ee1acddf8ea7db73d050fd",
            "0x0bd488994b70e1293a61db8fe430fcf3b7194d0022ba4a4380994a8e957f03c33fcad41c946f5418091f0edd81597f25fa82acbb004eb93a924522c873b901e9",
            "64855c638256faacc8ccbdbce00c9fd90a4677c012638b23d946aa8e0873cdcd",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x17171350adf0aa2453ee1acddf8ea7db73d050fd",
            "BAvUiJlLcOEpOmHbj+Qw/PO3GU0AIrpKQ4CZSo6VfwPDP8rUHJRvVBgJHw7dgVl/JfqCrLsATrk6kkUiyHO5Aek=",
            "ZIVcY4JW+qzIzL284Ayf2QpGd8ASY4sj2Uaqjghzzc0=",
        ),
    ),
    # vanity/0x18181
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x181819df99c23e9bf71002904a7f47cb6bce290c",
            "0xa7eafad8f42217d4ffb4c3a8668e323a9274b8024b8ebc092d224b8bb9daa94a74423113bd0eb4a285b1567b0bbd0611e1354d392d3fad611fbd15c2b55c4709",
            "04c5c37acfd96b6a6e0d827280eb4da7ba9252fcc83a5dbe406f5eea8b23099d",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x181819df99c23e9bf71002904a7f47cb6bce290c",
            "BKfq+tj0IhfU/7TDqGaOMjqSdLgCS468CS0iS4u52qlKdEIxE70OtKKFsVZ7C70GEeE1TTktP61hH70VwrVcRwk=",
            "BMXDes/Za2puDYJygOtNp7qSUvzIOl2+QG9e6osjCZ0=",
        ),
    ),
    # vanity/0x19191
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x19191898322eabd8e692ca3b6246f22e396a0435",
            "0x893c2faf4643f10a78b6b74e6ecf39f97f36945b33c0f37e94227619681e01a114c2342f34d640ac9d4df74b69864fe83aa0e3260abdb12adfef599d6e87ed71",
            "bab0af9392184a697be8dfe8c6b119ca7d800c93abb0d49e86239180c3781cc1",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x19191898322eabd8e692ca3b6246f22e396a0435",
            "BIk8L69GQ/EKeLa3Tm7POfl/NpRbM8DzfpQidhloHgGhFMI0LzTWQKydTfdLaYZP6Dqg4yYKvbEq3+9ZnW6H7XE=",
            "urCvk5IYSml76N/oxrEZyn2ADJOrsNSehiORgMN4HME=",
        ),
    ),
    # vanity/0x20202
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x202025ebeab7f1c5c58f8a229968907fb9624589",
            "0x7782d69b534a6f7bc33afc14c5bde7812adb183e11bde4ade88fb5a5330fd9b010a20095935f450239228e1d68025b0a5fdedfda628a4e9004fe40be37e0ea0c",
            "c247c5afd6a0995befe1aa967c00393d173ea4449162f02f9598e0f780181497",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x202025ebeab7f1c5c58f8a229968907fb9624589",
            "BHeC1ptTSm97wzr8FMW954Eq2xg+Eb3kreiPtaUzD9mwEKIAlZNfRQI5Io4daAJbCl/e39piik6QBP5Avjfg6gw=",
            "wkfFr9agmVvv4aqWfAA5PRc+pESRYvAvlZjg94AYFJc=",
        ),
    ),
    # vanity/0x21212
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x212125da3a6219849710c9d4e7620e61e00c8e1d",
            "0x2e36dcbde662904c5259d3f05f427ca8c38febdd04965c1ebc40ebe59d701592e648ee6df1d5dbaee815dadc8baba4143bd5b16e02219eb3150902d8ecc19c7b",
            "6d5c6a92702e9c23e6c3aa027d37cb011bf1ad2e15dab973d277905fb1cb6d45",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x212125da3a6219849710c9d4e7620e61e00c8e1d",
            "BC423L3mYpBMUlnT8F9CfKjDj+vdBJZcHrxA6+WdcBWS5kjubfHV267oFdrci6ukFDvVsW4CIZ6zFQkC2OzBnHs=",
            "bVxqknAunCPmw6oCfTfLARvxrS4V2rlz0neQX7HLbUU=",
        ),
    ),
    # vanity/0x22222
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x222223c99a38e23aade0d853e85ef0f83ad2eb6c",
            "0x6f0e5979e04dc554353d709e9ca5654cf30de8957de0e238478ab3cdf41049ca8ae1e6758a23cde0e2b7392d434f4a8e1d0f1e169e520e2e99880893534a0dc4",
            "8257b929f2690a150b9ae556aa97d79f88f694b12a80b819d6eeac7a6f836f73",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x222223c99a38e23aade0d853e85ef0f83ad2eb6c",
            "BG8OWXngTcVUNT1wnpylZUzzDeiVfeDiOEeKs830EEnKiuHmdYojzeDitzktQ09Kjh0PHhaeUg4umYgIk1NKDcQ=",
            "gle5KfJpChULmuVWqpfXn4j2lLEqgLgZ1u6sem+Db3M=",
        ),
    ),
    # vanity/0x23232
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x23232fec302fe83062b9a8714c922e05041c07e0",
            "0x1ba526ade733ee76cc3c31cc3f2b1c708a17700467adb88f65d3cc91405a458c71b23693f99ae43ff2816d7bbda767f8b13d272099c145d1585c88bfeff26333",
            "29ddc832c07571cc917e5fdab1348c7a961107c4a5348f08a12ded4ea940a329",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x23232fec302fe83062b9a8714c922e05041c07e0",
            "BBulJq3nM+52zDwxzD8rHHCKF3AEZ624j2XTzJFAWkWMcbI2k/ma5D/ygW17vadn+LE9JyCZwUXRWFyIv+/yYzM=",
            "Kd3IMsB1ccyRfl/asTSMepYRB8SlNI8IoS3tTqlAoyk=",
        ),
    ),
    # vanity/0x24242
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x242425e58088aee470488cfad73e1c89c94f8ec3",
            "0x4a4ee70123e65f22184491d5d74703b7e3423b79ff9f6768976781c44b96919743b6c75d30ee6802a59998c7de6d60131f08bfb1e04906db2b33d8430cb87b49",
            "4e51c337269e980c74516372c2dc8dae48c03bb9304fb998d4db91b5b8676885",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x242425e58088aee470488cfad73e1c89c94f8ec3",
            "BEpO5wEj5l8iGESR1ddHA7fjQjt5/59naJdngcRLlpGXQ7bHXTDuaAKlmZjH3m1gEx8Iv7HgSQbbKzPYQwy4e0k=",
            "TlHDNyaemAx0UWNywtyNrkjAO7kwT7mY1NuRtbhnaIU=",
        ),
    ),
    # vanity/0x25252
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x25252e265f63f49e12bbd54a88357785ee96143e",
            "0x861bc664fad2b29505293b77615e6a4b39a4545d9a6ae188118f93a77e4f7ee3647325f5996df92015a55461e1f2dd7046e944d395021785120e80fe9e972e83",
            "a6cbb7bbdf64b63f7d6ab39b8c44ecfa5bd47eb879af14315f607cd09d5fda05",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x25252e265f63f49e12bbd54a88357785ee96143e",
            "BIYbxmT60rKVBSk7d2Feaks5pFRdmmrhiBGPk6d+T37jZHMl9Zlt+SAVpVRh4fLdcEbpRNOVAheFEg6A/p6XLoM=",
            "psu3u99ktj99arObjETs+lvUfrh5rxQxX2B80J1f2gU=",
        ),
    ),
    # vanity/0x26262
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x2626258d96bae20310832fd1cf0c9579136985d3",
            "0x4077a5b7e2b95e08ebe6666f461b5d6708a41b497eb4941d58d6929fb5f70bf56df2ac7431e2434d904197c69a9807f41216424b431582742dfad0cd0928cf22",
            "efeda205664a86302eab70a5cba48e083279dafe560c5fb381ee02640a6386b2",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x2626258d96bae20310832fd1cf0c9579136985d3",
            "BEB3pbfiuV4I6+Zmb0YbXWcIpBtJfrSUHVjWkp+19wv1bfKsdDHiQ02QQZfGmpgH9BIWQktDFYJ0LfrQzQkozyI=",
            "7+2iBWZKhjAuq3Cly6SOCDJ52v5WDF+zge4CZApjhrI=",
        ),
    ),
    # vanity/0x27272
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x2727200fad767eda0b07bd8c151fb23a22515f15",
            "0x0a142c492e1a8d01a56b24145d418c297113015eda14c923dae8f61cbf7f999ca413ed2ca6cc3e4974417bb5739bd6af439674a9885dd2f7a23f65a74d921c8d",
            "c046af3857c8a762dff0ceb2a5d4a89e6c4724817b2b82dfaf70fc9816b003ed",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x2727200fad767eda0b07bd8c151fb23a22515f15",
            "BAoULEkuGo0BpWskFF1BjClxEwFe2hTJI9ro9hy/f5mcpBPtLKbMPkl0QXu1c5vWr0OWdKmIXdL3oj9lp02SHI0=",
            "wEavOFfIp2Lf8M6ypdSonmxHJIF7K4Lfr3D8mBawA+0=",
        ),
    ),
    # vanity/0x28282
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x28282817196377f0e4fd1daef0b7695e7c92199e",
            "0xb0c6331f57abaaf213929ed9a5d1e6cc114c09d42afa7c5023048422e331a98c0d9921a5ab2ef6ba3ee76b07ed456e02f3b89c20506a553ae2a4775034218847",
            "053825d7a8a35bd2552f1ecd1ce04a5e746e4204183278ada0c2b1e621a4e06c",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x28282817196377f0e4fd1daef0b7695e7c92199e",
            "BLDGMx9Xq6ryE5Ke2aXR5swRTAnUKvp8UCMEhCLjMamMDZkhpasu9ro+52sH7UVuAvO4nCBQalU64qR3UDQhiEc=",
            "BTgl16ijW9JVLx7NHOBKXnRuQgQYMnitoMKx5iGk4Gw=",
        ),
    ),
    # vanity/0x29292
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x2929278cbddc7e1711d7fe29f4036b4e8590da28",
            "0xe6ac24bca903ac29da6185a67ea882846594dbbf7a024c6bd63ad5ebe0655dafb18dbd256086b3d99ede1c4ed66ca162fd7ad0ed5978fa6b550ca1f5612b4775",
            "72d7f0565edea769a1db4e0b7da78d83bac104ecab4599cd06db3159f52fc534",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x2929278cbddc7e1711d7fe29f4036b4e8590da28",
            "BOasJLypA6wp2mGFpn6ogoRllNu/egJMa9Y61evgZV2vsY29JWCGs9me3hxO1myhYv160O1ZePprVQyh9WErR3U=",
            "ctfwVl7ep2mh204LfaeNg7rBBOyrRZnNBtsxWfUvxTQ=",
        ),
    ),
    # vanity/0x30303
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x30303026a8fd27fb1441745c5915d8be094bb286",
            "0xe020d07914b1de8e2cdc196ffd59f7243a9e140bcd0dd5c1c4e5743bcbb50413ea64ed9cae44d935ed16c284feb8935fd6537828063e6cc9aafca43c47749ff8",
            "a279c3523ee52b9079046733f1d2863ec24f8597a306bc7a01c270e6bff46ebc",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x30303026a8fd27fb1441745c5915d8be094bb286",
            "BOAg0HkUsd6OLNwZb/1Z9yQ6nhQLzQ3VwcTldDvLtQQT6mTtnK5E2TXtFsKE/riTX9ZTeCgGPmzJqvykPEd0n/g=",
            "onnDUj7lK5B5BGcz8dKGPsJPhZejBrx6AcJw5r/0brw=",
        ),
    ),
    # vanity/0x31313
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x31313a31b215a209d0a7068df681bda993e3b985",
            "0x4eac38fe99c0c7ad85e94255e1882864856a0bcdb37b62bf085936aa040dfd25df64fa2755148816cf68d0da9212059988ed44c459a499f2d7bbb3100cd05bfb",
            "ac4b6bcdefa4978d56e9095250673b050291730b566952acfbb8ef97a6e72469",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x31313a31b215a209d0a7068df681bda993e3b985",
            "BE6sOP6ZwMethelCVeGIKGSFagvNs3tivwhZNqoEDf0l32T6J1UUiBbPaNDakhIFmYjtRMRZpJny17uzEAzQW/s=",
            "rEtrze+kl41W6QlSUGc7BQKRcwtWaVKs+7jvl6bnJGk=",
        ),
    ),
    # vanity/0x32323
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x32323a0117c026142616a22a54328008ed5d3715",
            "0xcd75927b2e573aef075f3ff7280ea26fac1a70e3eb57c9372eed29362d6a5384920531c46abd7a415fdacd1543d25f40ae5e271880f59211427ac7457a0d5c2e",
            "a41fe91754e56349e59795b57610e55c4c46e423cefa64799b379bfcfc0ed138",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x32323a0117c026142616a22a54328008ed5d3715",
            "BM11knsuVzrvB18/9ygOom+sGnDj61fJNy7tKTYtalOEkgUxxGq9ekFf2s0VQ9JfQK5eJxiA9ZIRQnrHRXoNXC4=",
            "pB/pF1TlY0nll5W1dhDlXExG5CPO+mR5mzeb/PwO0Tg=",
        ),
    ),
    # vanity/0x33333
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x33333daad9c2c8d5b14c911a12989716ea5dbfd3",
            "0x92afca1f4486ac3162e9b05705936722826bbd750d3ee8de2b21007c6284431fffb77cd7bb326ad9945b341c9ae1161cbb799c9dc626c8f43655d35122c6bd6e",
            "a4c4a353c34cd37de9d31ad09f2bb117bd55886139cda9409275b2b30c29c8cf",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x33333daad9c2c8d5b14c911a12989716ea5dbfd3",
            "BJKvyh9EhqwxYumwVwWTZyKCa711DT7o3ishAHxihEMf/7d817syatmUWzQcmuEWHLt5nJ3GJsj0NlXTUSLGvW4=",
            "pMSjU8NM033p0xrQnyuxF71ViGE5zalAknWyswwpyM8=",
        ),
    ),
    # vanity/0x34343
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x343433a125b20b646c8da30ca35cb612e2b95575",
            "0x11ba79093b501a3e7d5c9fbd373a6153115bb2596378b828fd8592501a9c1b0818289b4d90aa7293d9ecb15014a2e9f7474b39965f25968ea622ef42674def15",
            "dc31c0f4522efed2b6b5b65c66898e93e6cf2cbf5973f59ae3e57dc2e973185e",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x343433a125b20b646c8da30ca35cb612e2b95575",
            "BBG6eQk7UBo+fVyfvTc6YVMRW7JZY3i4KP2FklAanBsIGCibTZCqcpPZ7LFQFKLp90dLOZZfJZaOpiLvQmdN7xU=",
            "3DHA9FIu/tK2tbZcZomOk+bPLL9Zc/Wa4+V9wulzGF4=",
        ),
    ),
    # vanity/0x35353
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x3535301ade2032e1395d675590fba376f9bc096e",
            "0x3207eadece00257ea3586b17fc76a01426dafa2d4544d0c31f454824e762bf78ef0be1b3adeaabbc8e5d86c29eaed9a8dfaf85377954111b50ea0985bc139b43",
            "727f6cb70b365cdc200d78b349e87531bf56e7e290a6f47e2d3065f6c79ab350",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x3535301ade2032e1395d675590fba376f9bc096e",
            "BDIH6t7OACV+o1hrF/x2oBQm2votRUTQwx9FSCTnYr947wvhs63qq7yOXYbCnq7ZqN+vhTd5VBEbUOoJhbwTm0M=",
            "cn9stws2XNwgDXizSeh1Mb9W5+KQpvR+LTBl9seas1A=",
        ),
    ),
    # vanity/0x36363
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x3636316b563891b22cd27a1580242adf9899002a",
            "0x8dd9d4eb4a1ec795fddae87125250ac03d2f32303bbfed0d842688b776b4b4fc2bf8ec733e5599f9d38b4525602141614b5a00b8d52ecdedf8cd7cc0ef67a3d0",
            "80b78565b8061c345a98372392ae38466c34825ae3810ec1d67fab1db3d2d8f4",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x3636316b563891b22cd27a1580242adf9899002a",
            "BI3Z1OtKHseV/drocSUlCsA9LzIwO7/tDYQmiLd2tLT8K/jscz5VmfnTi0UlYCFBYUtaALjVLs3t+M18wO9no9A=",
            "gLeFZbgGHDRamDcjkq44Rmw0glrjgQ7B1n+rHbPS2PQ=",
        ),
    ),
    # vanity/0x37373
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x37373d0475fb52c81993c649eac2829d2fc22a38",
            "0xfeb3a53d5676ccfadecbafb3a9e2dd48e3b34d1a593baa09bd87cb69e600b4bd4236f309b33573b447b2a882a9b49d976faffc9bdf6fd2996ca9b0554636decb",
            "8208f34261449e84b48585b437bf2b71ab5ee4d60cdc9493576b841a96014d26",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x37373d0475fb52c81993c649eac2829d2fc22a38",
            "BP6zpT1Wdsz63suvs6ni3Ujjs00aWTuqCb2Hy2nmALS9QjbzCbM1c7RHsqiCqbSdl2+v/Jvfb9KZbKmwVUY23ss=",
            "ggjzQmFEnoS0hYW0N78rcate5NYM3JSTV2uEGpYBTSY=",
        ),
    ),
    # vanity/0x38383
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x383837764c4fc2c4cfbabba0bdc29cf42accf575",
            "0x8172f90c8cddac54e5a3ce8ba2e4b0c3933ef441da4a9634b9f597df9693890e2bb2e7249b78caafd413976b181bd168bb3ba988b734d51bff53f479367240f9",
            "9ebd19fbfb4e5e70f777ef5f80d5be8c3dc2bfe231132f9806713215e51d2bdb",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x383837764c4fc2c4cfbabba0bdc29cf42accf575",
            "BIFy+QyM3axU5aPOi6LksMOTPvRB2kqWNLn1l9+Wk4kOK7LnJJt4yq/UE5drGBvRaLs7qYi3NNUb/1P0eTZyQPk=",
            "nr0Z+/tOXnD3d+9fgNW+jD3Cv+IxEy+YBnEyFeUdK9s=",
        ),
    ),
    # vanity/0x39393
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x393938d08db0416c82e5b167375c0916e4ab8955",
            "0x169e7188c71fc55c3606ad4d83ad507657c65b804e1c8e3786055bcb6675f8ef28ce61afde802aac563b1162ff8a0536aac9ae760de33b18f553709cecbfdd55",
            "90f089f47727fae82ade6e2c3e5b011b1b00f4d8280543e21a4e4c86510561c9",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x393938d08db0416c82e5b167375c0916e4ab8955",
            "BBaecYjHH8VcNgatTYOtUHZXxluAThyON4YFW8tmdfjvKM5hr96AKqxWOxFi/4oFNqrJrnYN4zsY9VNwnOy/3VU=",
            "kPCJ9Hcn+ugq3m4sPlsBGxsA9NgoBUPiGk5MhlEFYck=",
        ),
    ),
    # vanity/0x40404
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x40404dbc6694d4fc5ec3d4d85e4bc7dbc44a7fa0",
            "0xf4ca4aa12d7a1885fdc16c009308fe95bbce9213db8e3b8bfd47ca4e810f572f434135be2ef9e2a3266cb91fb951b3fc08b31eed1f491dc76b09a52ee626e82c",
            "644aa1ec650aa59d24bbc2decb9d774632972a9bec14869b17b912c9d7ee3e61",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x40404dbc6694d4fc5ec3d4d85e4bc7dbc44a7fa0",
            "BPTKSqEtehiF/cFsAJMI/pW7zpIT2447i/1Hyk6BD1cvQ0E1vi754qMmbLkfuVGz/AizHu0fSR3HawmlLuYm6Cw=",
            "ZEqh7GUKpZ0ku8Ley513RjKXKpvsFIabF7kSydfuPmE=",
        ),
    ),
    # vanity/0x41414
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x41414b731ca2c6ae06062031b77ff292a3175e16",
            "0xdfff09280c7c145b56aef6e665923001caa67739cea950f2e618babb9da57b6ab45845cecaf1660cf5837068fb1418ec7d666177d4a7c797d630aa7e13ecbcbc",
            "514162625a75f10f6b06add26d3a6ff9a6738c78005ee3606cda1bf8f466d0a6",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x41414b731ca2c6ae06062031b77ff292a3175e16",
            "BN//CSgMfBRbVq725mWSMAHKpnc5zqlQ8uYYurudpXtqtFhFzsrxZgz1g3Bo+xQY7H1mYXfUp8eX1jCqfhPsvLw=",
            "UUFiYlp18Q9rBq3SbTpv+aZzjHgAXuNgbNob+PRm0KY=",
        ),
    ),
    # vanity/0x42424
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x42424a775f88a840196f0cf68e9a1d3d5d19ada3",
            "0x43d816b9d488dc4038e9a13da6923710859d9d74ef7622ae4b1930d80312df1cc91909a67ac7be111f2ed629056ea9c999c8a925007a90804cb125150174c958",
            "d9a1b1f951a8293273e070b8ff0f9ca0c91356861fc6ea890e18ab99c159affd",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x42424a775f88a840196f0cf68e9a1d3d5d19ada3",
            "BEPYFrnUiNxAOOmhPaaSNxCFnZ1073YirksZMNgDEt8cyRkJpnrHvhEfLtYpBW6pyZnIqSUAepCATLElFQF0yVg=",
            "2aGx+VGoKTJz4HC4/w+coMkTVoYfxuqJDhirmcFZr/0=",
        ),
    ),
    # vanity/0x43434
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x43434c6f3499bb9f7e16187b6d83d9a4b40c2f1d",
            "0x32da5f74549cfc9732bc761951dba4c020485b37e483c5fb60a0648547de4d91ed83ecec5ecffb12e347cb536ee8f2bd889593e6cb65f39a03b88063d63b7447",
            "8dd77adcd09b875f4d09d5f0789b1602235232db10a2e35c91b3245723d0ccb2",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x43434c6f3499bb9f7e16187b6d83d9a4b40c2f1d",
            "BDLaX3RUnPyXMrx2GVHbpMAgSFs35IPF+2CgZIVH3k2R7YPs7F7P+xLjR8tTbujyvYiVk+bLZfOaA7iAY9Y7dEc=",
            "jdd63NCbh19NCdXweJsWAiNSMtsQouNckbMkVyPQzLI=",
        ),
    ),
    # vanity/0x44444
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x4444460d263a461a714302a5e7e9888dd4758706",
            "0x7caaab2378e7eda1de6549e6845aa3c7795069dcd8c5770ae038f6aca0244855224f92ab8715f63fb251b206741c17dadaee26f93050df2ecd0c7fe4e516dc90",
            "ed45d918da3ee47e58f60e805a8df833c3fd9a07f71b32cd9c787b6a26b7c900",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x4444460d263a461a714302a5e7e9888dd4758706",
            "BHyqqyN45+2h3mVJ5oRao8d5UGnc2MV3CuA49qygJEhVIk+Sq4cV9j+yUbIGdBwX2truJvkwUN8uzQx/5OUW3JA=",
            "7UXZGNo+5H5Y9g6AWo34M8P9mgf3GzLNnHh7aia3yQA=",
        ),
    ),
    # vanity/0x45454
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x454546c8bfd65b62e6b2ca480904c57fc8f1b66b",
            "0x51aed03feb3d9b940a0a17729c8c95934d5dc3c0fc313a3a05f2d5aabb83895d0cd283c78dfed8c0e41e84980bb5d74cb8d90dc4ea91eff53862fde12fd4e31a",
            "23963c5aee920ab39a62bad3dc1da2c56b755eeae363c8ec0f6c917533aab301",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x454546c8bfd65b62e6b2ca480904c57fc8f1b66b",
            "BFGu0D/rPZuUCgoXcpyMlZNNXcPA/DE6OgXy1aq7g4ldDNKDx43+2MDkHoSYC7XXTLjZDcTqke/1OGL94S/U4xo=",
            "I5Y8Wu6SCrOaYrrT3B2ixWt1XurjY8jsD2yRdTOqswE=",
        ),
    ),
    # vanity/0x46464
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x46464b7dc66d36a9af3eca0845dfda658e836f6d",
            "0xd98baaf0ff84aeb9f89c5c5cf2b3eb56a078ccbe747d4796fedab91f7fe47b03d93189bea0661f028219272916b6322cc0653dbc21cecdf1538ca7615608ca06",
            "d96893895416e1cb9ad9962e308645121fd1594abbb58e4f47a24fd93d9ef51c",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x46464b7dc66d36a9af3eca0845dfda658e836f6d",
            "BNmLqvD/hK65+JxcXPKz61ageMy+dH1Hlv7auR9/5HsD2TGJvqBmHwKCGScpFrYyLMBlPbwhzs3xU4ynYVYIygY=",
            "2WiTiVQW4cua2ZYuMIZFEh/RWUq7tY5PR6JP2T2e9Rw=",
        ),
    ),
    # vanity/0x47474
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x4747492000c62f36aa052c76bc1791446e59cdf6",
            "0xb4b34c4e3b6838684c40c59ddf97659c1592400725bb4edb6485b32453f1472c59bc567af9e6f02c765f008686b28255ca016740bd49d9cee46a4ec8ab3126ac",
            "a4bda74676f8cfd66744b70dba8fd27214cc540f4453f26a6855e129d905e6c6",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x4747492000c62f36aa052c76bc1791446e59cdf6",
            "BLSzTE47aDhoTEDFnd+XZZwVkkAHJbtO22SFsyRT8UcsWbxWevnm8Cx2XwCGhrKCVcoBZ0C9SdnO5GpOyKsxJqw=",
            "pL2nRnb4z9ZnRLcNuo/SchTMVA9EU/JqaFXhKdkF5sY=",
        ),
    ),
    # vanity/0x48484
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x484841a3f83dce1dad6b850b14ddccf4fd956cef",
            "0x17fa96604a375f9ab3f047fbdb5efaff1e0f207e2f2ab036001b6814d3fd998987b9fecd6b822085e4a47d3db634dd859f4febe7a0e2b72e35fc2097c4aa0b60",
            "c3c802c9f54c99053e77f408f185905cb14c669ab5eee5344c278ebf60bdd4e2",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x484841a3f83dce1dad6b850b14ddccf4fd956cef",
            "BBf6lmBKN1+as/BH+9te+v8eDyB+LyqwNgAbaBTT/ZmJh7n+zWuCIIXkpH09tjTdhZ9P6+eg4rcuNfwgl8SqC2A=",
            "w8gCyfVMmQU+d/QI8YWQXLFMZpq17uU0TCeOv2C91OI=",
        ),
    ),
    # vanity/0x49494
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x494942c94d16fbbcfb9ada7cc6f4e9b4570bce82",
            "0x7d248e8064d2dbe3d48e898d25098b8d259fb3a2a03942bc3a5745c9a952986d827d0796d9ce781ccaae3899b43c8221a5c2dbec2309f8d158dd30cc3391a5f7",
            "55eae3810f32b957fc885fa69ed61b0872a2afd3ca61d438e67d5e832df2d289",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x494942c94d16fbbcfb9ada7cc6f4e9b4570bce82",
            "BH0kjoBk0tvj1I6JjSUJi40ln7OioDlCvDpXRcmpUphtgn0HltnOeBzKrjiZtDyCIaXC2+wjCfjRWN0wzDORpfc=",
            "VerjgQ8yuVf8iF+mntYbCHKir9PKYdQ45n1egy3y0ok=",
        ),
    ),
    # vanity/0x50505
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x50505f19daff4705ad00ea8e80209b64879c80ff",
            "0xc0f377e5af5d7e53512f2d10cefead3d810930174c55e7c24d69c7db5a3cd655d56776079c44b0815e513901127f4783b1d965c8d506de6f316990fb2b4fe658",
            "a52efee13d1e9b91d7609164f5f2a931958dac7ac0b7085cb4ab065a183c600b",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x50505f19daff4705ad00ea8e80209b64879c80ff",
            "BMDzd+WvXX5TUS8tEM7+rT2BCTAXTFXnwk1px9taPNZV1Wd2B5xEsIFeUTkBEn9Hg7HZZcjVBt5vMWmQ+ytP5lg=",
            "pS7+4T0em5HXYJFk9fKpMZWNrHrAtwhctKsGWhg8YAs=",
        ),
    ),
    # vanity/0x51515
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x515157bea35d2ffd8d611a200e2f6379a33b0e3a",
            "0x427cd6634802590e3e97d59842f079324121d92e2196120461c199b09315ca6b3d442e4bc9ca3f5ec2bbf3d5286d0feab8d357c63688514d66da15b2761c694e",
            "e6067c1871b650ddd0339b95800dd4582f5a2f845fb8d22652c249f899973b3f",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x515157bea35d2ffd8d611a200e2f6379a33b0e3a",
            "BEJ81mNIAlkOPpfVmELweTJBIdkuIZYSBGHBmbCTFcprPUQuS8nKP17Cu/PVKG0P6rjTV8Y2iFFNZtoVsnYcaU4=",
            "5gZ8GHG2UN3QM5uVgA3UWC9aL4RfuNImUsJJ+JmXOz8=",
        ),
    ),
    # vanity/0x52525
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x52525323cf3cf3e0e196ea1442487c053ba5af6c",
            "0x000572373475296bded6d6f4204ff009266c9ff566cd1873cc71905ccdff23d53d1675f85b9f1b97506ccd48add614ce8386a8efe739a4ee787cadeb834332af",
            "b252b3c023eb6362d904b65b7ea6d45f21fc4081c585c268c90dd0d0082a73bf",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x52525323cf3cf3e0e196ea1442487c053ba5af6c",
            "BAAFcjc0dSlr3tbW9CBP8AkmbJ/1Zs0Yc8xxkFzN/yPVPRZ1+FufG5dQbM1IrdYUzoOGqO/nOaTueHyt64NDMq8=",
            "slKzwCPrY2LZBLZbfqbUXyH8QIHFhcJoyQ3Q0Agqc78=",
        ),
    ),
    # vanity/0x53535
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x535352abc1821bb2d19301386b45cf0c73811995",
            "0x389296e64a636b010cf2e20517ab34282109c498a4d544aae0cc928a426305a4e7343a66f38768c742d24d8110abb1444ba92012241c3f5965be4d5c72f7fc5f",
            "17ccc56dcf1c551def94e0f9998ba7fb389f30c677e423fe014dc336a14abcba",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x535352abc1821bb2d19301386b45cf0c73811995",
            "BDiSluZKY2sBDPLiBRerNCghCcSYpNVEquDMkopCYwWk5zQ6ZvOHaMdC0k2BEKuxREupIBIkHD9ZZb5NXHL3/F8=",
            "F8zFbc8cVR3vlOD5mYun+zifMMZ35CP+AU3DNqFKvLo=",
        ),
    ),
    # vanity/0x54545
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x54545f5426f298d7da68cb9d72342a9416158edb",
            "0x0de44ecb966c2c6b54a95193d6d053a21061c85cec41f2ebb00d8a3bbea612c55cfca7a25996de574aa94a93f80df256ea68ec4a76194a2b953fd8b3397470eb",
            "3f81533f9ba4de80e355b2f2fec1b293c0b047e6b9018adb816ddbe2e3a2d1ca",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x54545f5426f298d7da68cb9d72342a9416158edb",
            "BA3kTsuWbCxrVKlRk9bQU6IQYchc7EHy67ANiju+phLFXPynolmW3ldKqUqT+A3yVupo7Ep2GUorlT/Yszl0cOs=",
            "P4FTP5uk3oDjVbLy/sGyk8CwR+a5AYrbgW3b4uOi0co=",
        ),
    ),
    # vanity/0x55555
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x55555f1952141755df24ddc00de0091ee32186c7",
            "0x1e825f6393d7c78763e1b3ea29655ff1f972ffa227cfe8bb4720b290d5345efd2d066c7a99d7fa5b3c8ee4642ea8d576f0b4cc4f1edb68f11a6a6fb72906ff4f",
            "74361e76eaa6bdab77988b58bbf08ebf15200011568492ef660b433c087f210d",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x55555f1952141755df24ddc00de0091ee32186c7",
            "BB6CX2OT18eHY+Gz6illX/H5cv+iJ8/ou0cgspDVNF79LQZsepnX+ls8juRkLqjVdvC0zE8e22jxGmpvtykG/08=",
            "dDYeduqmvat3mItYu/COvxUgABFWhJLvZgtDPAh/IQ0=",
        ),
    ),
    # vanity/0x56565
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x565655e31d60749c7742a7d89b4d5f514f83e885",
            "0x353c1a5b958bc844652692b5f849c9a1c076fd737d04dbb1b65673899ef01a4ccc01efe0c993316df25d5b9ebf3fd7bbf1948b29d4b0e5e1d613f8a050e4b6cc",
            "f284ac0a95ccf134538b0f2745d517526cefe7929cfb7be66b8af43a237fabc3",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x565655e31d60749c7742a7d89b4d5f514f83e885",
            "BDU8GluVi8hEZSaStfhJyaHAdv1zfQTbsbZWc4me8BpMzAHv4MmTMW3yXVuevz/Xu/GUiynUsOXh1hP4oFDktsw=",
            "8oSsCpXM8TRTiw8nRdUXUmzv55Kc+3vma4r0OiN/q8M=",
        ),
    ),
    # vanity/0x57575
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x575758f30caaee0b234ab33a0bbdb065f3c57db6",
            "0x7ed21542725081e909cad465db8b7b058405991c8c625d28044842a1ac0d4d68bb5849cfc477e3de7e051f205caa6bd7be718c108ba2d3511d0b3e935e8f07e0",
            "9f5fa3a8c107380e7bb19c87eb5e040f08700d8abb97ac3442aa6021af9bcbe9",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x575758f30caaee0b234ab33a0bbdb065f3c57db6",
            "BH7SFUJyUIHpCcrUZduLewWEBZkcjGJdKARIQqGsDU1ou1hJz8R3495+BR8gXKpr175xjBCLotNRHQs+k16PB+A=",
            "n1+jqMEHOA57sZyH614EDwhwDYq7l6w0QqpgIa+by+k=",
        ),
    ),
    # vanity/0x58585
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x58585cd7ac277c4a13fbe9cb49cf444f6128d262",
            "0x9f283586c1fdd9799d19c822798fbbe1958fc95ea665e2d88583e1f10278df5e75238185c5ba489b4a9b48a4a499d06e0bce9f47507473d2a4c7c38b7edcc5cd",
            "21b500debc0cc2901098ace1b46ab597441059409255ce3c0ed5b809c201713c",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x58585cd7ac277c4a13fbe9cb49cf444f6128d262",
            "BJ8oNYbB/dl5nRnIInmPu+GVj8lepmXi2IWD4fECeN9edSOBhcW6SJtKm0ikpJnQbgvOn0dQdHPSpMfDi37cxc0=",
            "IbUA3rwMwpAQmKzhtGq1l0QQWUCSVc48DtW4CcIBcTw=",
        ),
    ),
    # vanity/0x59595
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x5959505f477913b671abf4238c065a4e793c66f8",
            "0x51369c11a9fd96e029d0e8a3ffd4d6b7ac8ef74cfec62f94f47f0319b6e0e8606aaecd0fe781ea9ef5aa582e42a7360fb399e39cc87e4c1435a2d03dc8a50851",
            "14fe10ab7638c4573d0b8c427d51b59197c6e719b0fb38fcac06aeedad27befb",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x5959505f477913b671abf4238c065a4e793c66f8",
            "BFE2nBGp/ZbgKdDoo//U1resjvdM/sYvlPR/Axm24Ohgaq7ND+eB6p71qlguQqc2D7OZ45zIfkwUNaLQPcilCFE=",
            "FP4Qq3Y4xFc9C4xCfVG1kZfG5xmw+zj8rAau7a0nvvs=",
        ),
    ),
    # vanity/0x60606
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x606060134d696e52358ea0d069aeafd77061f1c1",
            "0x68373bca8252de3d0e75d5e7c753dbc7e4f37ff3ab927171014d4f2883f2d246b255426b092f8e1f5d135af2ecaa069d0d3e7c254854dc70777e88dbc1937eff",
            "ad2d5b7f430a3b962ad5589d3ba9afb6534673a8862dc3d490735aaaa4569abd",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x606060134d696e52358ea0d069aeafd77061f1c1",
            "BGg3O8qCUt49DnXV58dT28fk83/zq5JxcQFNTyiD8tJGslVCawkvjh9dE1ry7KoGnQ0+fCVIVNxwd36I28GTfv8=",
            "rS1bf0MKO5Yq1VidO6mvtlNGc6iGLcPUkHNaqqRWmr0=",
        ),
    ),
    # vanity/0x61616
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x616163c65b30abf3dc528999179c31bbdb806dd6",
            "0x93bedbef322515b3fbc338c5d54931d2932044a4794a765fbe74cd5704c60ea01849c20a4d2ab908f0945b4d27addd69f775c54d967c6c95f88d8dabd67630d0",
            "349f8bcc53b04022cc84cd86e1eb745c02cccd6107f09452af53af0e99dd498d",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x616163c65b30abf3dc528999179c31bbdb806dd6",
            "BJO+2+8yJRWz+8M4xdVJMdKTIESkeUp2X750zVcExg6gGEnCCk0quQjwlFtNJ63dafd1xU2WfGyV+I2Nq9Z2MNA=",
            "NJ+LzFOwQCLMhM2G4et0XALMzWEH8JRSr1OvDpndSY0=",
        ),
    ),
    # vanity/0x62626
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x6262614402704ee51b40fe727f35e9e45e56c575",
            "0x211d311c338246f43e3c5c5ab7abeddb576d48768f8f4143f8f22429452aedc6e23e4804d17c3f744af4463fd0f69ea354d437fbfa17b2dbcdf9353a5815ce2d",
            "37a75ab355b0889dabb4136324457b69bd9ecd705382ebf168a4f7577bef0912",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x6262614402704ee51b40fe727f35e9e45e56c575",
            "BCEdMRwzgkb0PjxcWrer7dtXbUh2j49BQ/jyJClFKu3G4j5IBNF8P3RK9EY/0Paeo1TUN/v6F7Lbzfk1OlgVzi0=",
            "N6das1WwiJ2rtBNjJEV7ab2ezXBTguvxaKT3V3vvCRI=",
        ),
    ),
    # vanity/0x63636
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x636369060fa16ce5b3a43833d8fc3c3f52e1241f",
            "0xfd05b1891e63a4bacaa76c3f15e1fc5e73ed4699e34ade55689e55c7b1a21368eb2861d97cb4dbffdeaa1a9b711390f81c455dd080d8792de97d59b02442fe2a",
            "66fa2cf84d9b4fe7e276e930c9f2c44df46808228f9f5dbcf31fecdc3fd28189",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x636369060fa16ce5b3a43833d8fc3c3f52e1241f",
            "BP0FsYkeY6S6yqdsPxXh/F5z7UaZ40reVWieVcexohNo6yhh2Xy02//eqhqbcROQ+BxFXdCA2Hkt6X1ZsCRC/io=",
            "Zvos+E2bT+fidukwyfLETfRoCCKPn1288x/s3D/SgYk=",
        ),
    ),
    # vanity/0x64646
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x64646c1ee19802aa229233c346afd9b0706e9047",
            "0x1b0a38c699fb77c6d83cfe8914204ee3e246826800b51647299135f87ccd151eb50378ddb30d315c0c80796bb8c63ddd74453b07f622b804e79d222c56f43c32",
            "8af53c9c450e3e33cb457ed6951f1d7b03620e32ec420e99c3339671916ee9e2",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x64646c1ee19802aa229233c346afd9b0706e9047",
            "BBsKOMaZ+3fG2Dz+iRQgTuPiRoJoALUWRymRNfh8zRUetQN43bMNMVwMgHlruMY93XRFOwf2IrgE550iLFb0PDI=",
            "ivU8nEUOPjPLRX7WlR8dewNiDjLsQg6ZwzOWcZFu6eI=",
        ),
    ),
    # vanity/0x65656
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x656567cc7d197baba98cbf1cb2b690c301e301ce",
            "0xddf82e5dd6d492f56fc7ff82f1bd0e25b3985c5f88e5d029c11e9bcf88cd5606a95d629474eeaff5874cdb8a5877c85f74a75a56cc4cfa54c72870cbbd660472",
            "3e83c2c03ba622e2f3b2e985bfd6e978915764361bd47aa0b64e265cf6aaf554",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x656567cc7d197baba98cbf1cb2b690c301e301ce",
            "BN34Ll3W1JL1b8f/gvG9DiWzmFxfiOXQKcEem8+IzVYGqV1ilHTur/WHTNuKWHfIX3SnWlbMTPpUxyhwy71mBHI=",
            "PoPCwDumIuLzsumFv9bpeJFXZDYb1Hqgtk4mXPaq9VQ=",
        ),
    ),
    # vanity/0x66666
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x6666603f46c041a490cb7af120719fa66b782ebd",
            "0x8f3977547f6c14f7ff7c42d71a93c8223c4ed65f474a010d1c66fe79b5d9064be18b2543c8383f1b132a5dc309e6e45c5ea310f3b2291918a00f80cc7f8bb520",
            "ef8b2c10355c1cf1471fa54ee1c58b279133fe1c9f4848b46d3777c1b193f5ba",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x6666603f46c041a490cb7af120719fa66b782ebd",
            "BI85d1R/bBT3/3xC1xqTyCI8TtZfR0oBDRxm/nm12QZL4YslQ8g4PxsTKl3DCebkXF6jEPOyKRkYoA+AzH+LtSA=",
            "74ssEDVcHPFHH6VO4cWLJ5Ez/hyfSEi0bTd3wbGT9bo=",
        ),
    ),
    # vanity/0x67676
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x6767655c763925371af4968782582a77570c21ab",
            "0x9013df81c07aeb05b9276fbfee6c68a3adee4797a665b8c999e759e05bb9ce52365e4a183fb38cd439f443e4b0eae86f2936db1f72d1fdb0d5dbb4ec214c7c16",
            "0778f66a67ce89700f1b359d174991b0cc0d7b93caea0a148a2e45ae0d9c6250",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x6767655c763925371af4968782582a77570c21ab",
            "BJAT34HAeusFuSdvv+5saKOt7keXpmW4yZnnWeBbuc5SNl5KGD+zjNQ59EPksOrobyk22x9y0f2w1du07CFMfBY=",
            "B3j2amfOiXAPGzWdF0mRsMwNe5PK6goUii5Frg2cYlA=",
        ),
    ),
    # vanity/0x68686
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x68686f415f2504f24ab35f3a38cc96a1dcdfa754",
            "0xe75cf5cb116a6a1fd95c7b57f5a31d94360eaaa1a0d19b1f958a2a68c7d8b3c0f30d7b1824bd5a31d4de683b901c422d56c4aef823480a6da429fb3b7bdad2c6",
            "5875e46b8a2922cd8d05be3cdcc2738bdb198501db6def9018d49a9ddb854f48",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x68686f415f2504f24ab35f3a38cc96a1dcdfa754",
            "BOdc9csRamof2Vx7V/WjHZQ2DqqhoNGbH5WKKmjH2LPA8w17GCS9WjHU3mg7kBxCLVbErvgjSAptpCn7O3va0sY=",
            "WHXka4opIs2NBb483MJzi9sZhQHbbe+QGNSanduFT0g=",
        ),
    ),
    # vanity/0x69696
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x69696ffffc365605345204f40e662953a8811a84",
            "0x891fb1c8dc4165b02fe32c02ec9ed5c98cb0607a459f47a2e03c2aa08bfc8d9765113441475361827ba1c18a3d84af1e963a81b57421c8b0a8dc5b9c9af0db0c",
            "5ee907d45d6ea807df8c393c1ce939f6e31277c6cccb389029dd63f6cacdbe74",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x69696ffffc365605345204f40e662953a8811a84",
            "BIkfscjcQWWwL+MsAuye1cmMsGB6RZ9HouA8KqCL/I2XZRE0QUdTYYJ7ocGKPYSvHpY6gbV0IciwqNxbnJrw2ww=",
            "XukH1F1uqAffjDk8HOk59uMSd8bMyziQKd1j9srNvnQ=",
        ),
    ),
    # vanity/0x70707
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x707072eb662bcef1549475ad8c5e8b2ab3bd72af",
            "0x8b916dd524bc1a5174a9193b432c217fcd7c1ef0d5509d5c6ba1fabfa69969a0094ca6bac8818c219e00145f25de3f3efb6a45815c774a37c2bb4b1d764f92fb",
            "7bf6350a44cc60d1d8475c921a046c6be8a6912327cb591e583017720100e810",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x707072eb662bcef1549475ad8c5e8b2ab3bd72af",
            "BIuRbdUkvBpRdKkZO0MsIX/NfB7w1VCdXGuh+r+mmWmgCUymusiBjCGeABRfJd4/PvtqRYFcd0o3wrtLHXZPkvs=",
            "e/Y1CkTMYNHYR1ySGgRsa+imkSMny1keWDAXcgEA6BA=",
        ),
    ),
    # vanity/0x71717
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x717176241347a232a99637321ad21982a3247c18",
            "0x4d6a2a76de26555fb7830e1de302e3a2ccd2a98fe5bbc80929f9ae40a52e33412e2eb5d7d2993920cc6aef03eeb10ada8a4e46a3f8b87aa7435ed1eeb8b4e0f6",
            "539ac60276457ef49e9a6371c3b2dda4f4f69b02691110d396c5d6d76f3126a8",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x717176241347a232a99637321ad21982a3247c18",
            "BE1qKnbeJlVft4MOHeMC46LM0qmP5bvICSn5rkClLjNBLi6119KZOSDMau8D7rEK2opORqP4uHqnQ17R7ri04PY=",
            "U5rGAnZFfvSemmNxw7LdpPT2mwJpERDTlsXW128xJqg=",
        ),
    ),
    # vanity/0x72727
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x727277ff716a52a231787679be270c40560a6a73",
            "0xae851c055321b5b3b269f5458621e2d197ee14aff41eefc7da03ff745fecd6e8deaa535a5c24854cb8e74ab329502ebb385c6dbfdfb6e422af22b5ef2f359a5a",
            "3b1493722170eb80790e33e0e034b5088ccfb8cd550f4c2c2519cb8b560c534e",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x727277ff716a52a231787679be270c40560a6a73",
            "BK6FHAVTIbWzsmn1RYYh4tGX7hSv9B7vx9oD/3Rf7Nbo3qpTWlwkhUy450qzKVAuuzhcbb/ftuQiryK17y81mlo=",
            "OxSTciFw64B5DjPg4DS1CIzPuM1VD0wsJRnLi1YMU04=",
        ),
    ),
    # vanity/0x73737
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x7373785aa02a41da21ac48e0ae458add240a9bed",
            "0xa5f7ed8781c359538f8d30822bc393453b8971510bb1f78f43b2bda6aab0b86aac8c761dced56da786385d3a8580a08f469c5b47f846104ecaa5f4c90625f34f",
            "a8230db8cbf3372a470d0defe178b4eabb30a3a03fc3a7c540d45a34e8f1047e",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x7373785aa02a41da21ac48e0ae458add240a9bed",
            "BKX37YeBw1lTj40wgivDk0U7iXFRC7H3j0OyvaaqsLhqrIx2Hc7VbaeGOF06hYCgj0acW0f4RhBOyqX0yQYl808=",
            "qCMNuMvzNypHDQ3v4Xi06rswo6A/w6fFQNRaNOjxBH4=",
        ),
    ),
    # vanity/0x74747
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x747474eb8cf1ef565ba35b3bac6535695a2cedaf",
            "0x2ace2f93af5783260746b85e19ed2c37ba4f29aa11155e0a7fcdf5e6433b8e2afac4f876601b58e93f4b25ee5c2989b95e9323f17513d8b6d0ef1c8e5a98e551",
            "a06ba58858031042d0c758971c363dbb4e7c65960130030cb953d0b660533a29",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x747474eb8cf1ef565ba35b3bac6535695a2cedaf",
            "BCrOL5OvV4MmB0a4XhntLDe6TymqERVeCn/N9eZDO44q+sT4dmAbWOk/SyXuXCmJuV6TI/F1E9i20O8cjlqY5VE=",
            "oGuliFgDEELQx1iXHDY9u058ZZYBMAMMuVPQtmBTOik=",
        ),
    ),
    # vanity/0x75757
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x757572ece34fa3868ce0acd6c5e5447d6eb16ba8",
            "0x2e89971ba2c36595eaa5b5a9e2477b0abaa132cc518bd26f40bb34af6d3db0cfe9052c8a706a7c402d3006735f4fec5da44cad5c1eefafbe7eaaaf38b934f678",
            "75163e00bfe363d050eb3909406e26387ba12f69dd9a7d3441a0084d96bb36a2",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x757572ece34fa3868ce0acd6c5e5447d6eb16ba8",
            "BC6Jlxuiw2WV6qW1qeJHewq6oTLMUYvSb0C7NK9tPbDP6QUsinBqfEAtMAZzX0/sXaRMrVwe76++fqqvOLk09ng=",
            "dRY+AL/jY9BQ6zkJQG4mOHuhL2ndmn00QaAITZa7NqI=",
        ),
    ),
    # vanity/0x76767
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x767675e21d1c79eaaf794a0aae6086a85eeefe67",
            "0x256ba0ab969c5970ef9b52a6ae66e81905c633974aa6bb88f3ac5ce3b99201139dd8b976b5a9ca3a4c7aadf54c08ed28acf6f6aab2542b8e1c11a5df6f4d42a9",
            "09cc51edd81072f7b245f4e8b1576f69b12b6f1454efa876ffaf5987010e69df",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x767675e21d1c79eaaf794a0aae6086a85eeefe67",
            "BCVroKuWnFlw75tSpq5m6BkFxjOXSqa7iPOsXOO5kgETndi5drWpyjpMeq31TAjtKKz29qqyVCuOHBGl329NQqk=",
            "CcxR7dgQcveyRfTosVdvabErbxRU76h2/69ZhwEOad8=",
        ),
    ),
    # vanity/0x77777
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x777776547ef42b4d61121d5f8b92a313e69afc9f",
            "0x1c52482c32da361be89828ae14a41e9711b4ced2accfd228fb91ef8ae2a64e5dcaa79424cca1f2b8b7be588e58c14708c84835899aa57f732e22c353b3327478",
            "0b9bc2125d0fac1050bca7b0320ffe45493b2a0e3ff08e0e8885fe0124e55662",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x777776547ef42b4d61121d5f8b92a313e69afc9f",
            "BBxSSCwy2jYb6JgorhSkHpcRtM7SrM/SKPuR74ripk5dyqeUJMyh8ri3vliOWMFHCMhINYmapX9zLiLDU7MydHg=",
            "C5vCEl0PrBBQvKewMg/+RUk7Kg4/8I4OiIX+ASTlVmI=",
        ),
    ),
    # vanity/0x78787
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x787873574d876e9a43907395f4b2c49ed8a2ab7b",
            "0xb64e537bf502697531a7a48160065de2118ad7da19e534cd5a985cee3c1c1abd53692438f47ded9e9945f2401bfaf54ec325d8d0f77e35272cdd7333fd9c9f50",
            "c14354479b8b3d612f07a104cf30e8433be4e6e6b3e858282475a558f4ed3e86",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x787873574d876e9a43907395f4b2c49ed8a2ab7b",
            "BLZOU3v1Aml1MaekgWAGXeIRitfaGeU0zVqYXO48HBq9U2kkOPR97Z6ZRfJAG/r1TsMl2ND3fjUnLN1zM/2cn1A=",
            "wUNUR5uLPWEvB6EEzzDoQzvk5uaz6FgoJHWlWPTtPoY=",
        ),
    ),
    # vanity/0x79797
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x797974acbf475726360da691583270634c4ee310",
            "0x526b93782d2bec4834f5061cd7738042c00627e47c89a90377027f393aa03cdc64d5bf0422fb6fcd1b0c4d8e16a01c6d54ea7397cf12b6026d5c03f3aed4768c",
            "613d75ccb4ad147bca9d5e9433f78494abc10994de7d37f59553b0642579898b",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x797974acbf475726360da691583270634c4ee310",
            "BFJrk3gtK+xINPUGHNdzgELABifkfImpA3cCfzk6oDzcZNW/BCL7b80bDE2OFqAcbVTqc5fPErYCbVwD867Udow=",
            "YT11zLStFHvKnV6UM/eElKvBCZTefTf1lVOwZCV5iYs=",
        ),
    ),
    # vanity/0x80808
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x80808efe87adb7f6859eee429958fe0cbdc2d87a",
            "0x3b4780913f76e215a8bdfc5b0abae856fe30d5f6a1bfb69470b34f83bb815182a977fd3982393ae45706aa3194d6d660194771abeba79ab17a649948d5d49c58",
            "9ac0a57f19e47a10c470e8d966e8a106cd875d9c723b3f748ed5cc65c1d3544d",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x80808efe87adb7f6859eee429958fe0cbdc2d87a",
            "BDtHgJE/duIVqL38Wwq66Fb+MNX2ob+2lHCzT4O7gVGCqXf9OYI5OuRXBqoxlNbWYBlHcavrp5qxemSZSNXUnFg=",
            "msClfxnkehDEcOjZZuihBs2HXZxyOz90jtXMZcHTVE0=",
        ),
    ),
    # vanity/0x81818
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x81818f4847c65eacaaed43b57862903334d8adc0",
            "0x3a8b5f538b7dba7b4cdaa530fa40d591ee405de0d7953a3993c6126d655e954c32a7cdf47106b1d4710a9e32a9892e2ee649665a13cf4423a130ee80dc5535b1",
            "779621f708f1374d6276ad95719dbeb605ae7614c9d831e2106e6daf5142f1a7",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x81818f4847c65eacaaed43b57862903334d8adc0",
            "BDqLX1OLfbp7TNqlMPpA1ZHuQF3g15U6OZPGEm1lXpVMMqfN9HEGsdRxCp4yqYkuLuZJZloTz0QjoTDugNxVNbE=",
            "d5Yh9wjxN01idq2VcZ2+tgWudhTJ2DHiEG5tr1FC8ac=",
        ),
    ),
    # vanity/0x82828
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x8282884a953eb63e551952efc3a0ee8e174b583c",
            "0x245791831c47512b3998883888ed537fcaf2e62891ade686513202faa782e803a1b24b7c788b2d1db037a8ced6fb8677031640cf77b132a05d85374c1934e1b3",
            "78910dc9c64ebb135db6c2771848a5a55aba3ee0bcce4c905d20cfba1c95da3a",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x8282884a953eb63e551952efc3a0ee8e174b583c",
            "BCRXkYMcR1ErOZiIOIjtU3/K8uYoka3mhlEyAvqngugDobJLfHiLLR2wN6jO1vuGdwMWQM93sTKgXYU3TBk04bM=",
            "eJENycZOuxNdtsJ3GEilpVq6PuC8zkyQXSDPuhyV2jo=",
        ),
    ),
    # vanity/0x83838
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x8383880622954c1d204c6aab0607808a7da0b891",
            "0xb80bf719b9379c0f3ea4a6c205379361b937e38bb5c9c46e9727c8f77c807d4dd81345a83b21ad0930ff56c289bd4522c04ca3e659a9f065a67c85bc842bb4f6",
            "c6a7eaeaf9c4c5fa22e4c1d0640df1104e4db907ade69fb5accf0d56a18cec4f",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x8383880622954c1d204c6aab0607808a7da0b891",
            "BLgL9xm5N5wPPqSmwgU3k2G5N+OLtcnEbpcnyPd8gH1N2BNFqDshrQkw/1bCib1FIsBMo+ZZqfBlpnyFvIQrtPY=",
            "xqfq6vnExfoi5MHQZA3xEE5NuQet5p+1rM8NVqGM7E8=",
        ),
    ),
    # vanity/0x84848
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x84848af1455ffbe811f625538c6189e168fc6aea",
            "0xa93e6c9ac46f85f14fba5696091527dc38a84299efcafd6491143d332c6d19cf22962c1d36aad7de7c9f37b522c645df882080e5460321251f7f76a6199605e4",
            "66e3f321c71725a52cea5767fb7c7fad557dd64d74bf5cefae877dbbe5ba5c0c",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x84848af1455ffbe811f625538c6189e168fc6aea",
            "BKk+bJrEb4XxT7pWlgkVJ9w4qEKZ78r9ZJEUPTMsbRnPIpYsHTaq1958nze1IsZF34gggOVGAyElH392phmWBeQ=",
            "ZuPzIccXJaUs6ldn+3x/rVV91k10v1zvrod9u+W6XAw=",
        ),
    ),
    # vanity/0x85858
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x8585832936bf4986fd63729a0b9279c963bcfe24",
            "0xa21159e12a763dada38a637a4368f126227d67fc499c6355f05b0c0f07d424353e93afcf6b84db99a63a02bf00d8b9107f82e6c0f99963f9405757cf89b5de47",
            "f307bca0ded5ff46a86bb88c0a5eb9263adc311b9143de7629adadc3d1dc7e33",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x8585832936bf4986fd63729a0b9279c963bcfe24",
            "BKIRWeEqdj2to4pjekNo8SYifWf8SZxjVfBbDA8H1CQ1PpOvz2uE25mmOgK/ANi5EH+C5sD5mWP5QFdXz4m13kc=",
            "8we8oN7V/0aoa7iMCl65JjrcMRuRQ952Ka2tw9HcfjM=",
        ),
    ),
    # vanity/0x86868
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x86868a30b999a40885c41b648db26632d3960191",
            "0x86935f18b409b34bca376301f95b041cb9af1a6a07314472d12a76ca674b3e8f737c47880c62d2521604b244446d11ad563d9b368519b3dee7f28d349bf27e91",
            "c31cc82380501e708e47090cc96f63dfec9a2e59cf6595494a228050ec0f18bf",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x86868a30b999a40885c41b648db26632d3960191",
            "BIaTXxi0CbNLyjdjAflbBBy5rxpqBzFEctEqdspnSz6Pc3xHiAxi0lIWBLJERG0RrVY9mzaFGbPe5/KNNJvyfpE=",
            "wxzII4BQHnCORwkMyW9j3+yaLlnPZZVJSiKAUOwPGL8=",
        ),
    ),
    # vanity/0x87878
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x87878f99141a7866e10cc06ad4022fb80011fdc7",
            "0xfea616715b85a788eb9c38929c7ef5d81a37aba6f08fc7b02f949397a75c3e2b183cbc11ce1d53825e6c2f25f02f4b478cf369af5787d14c19ce91f1eaf2a429",
            "640131f4c8811768fbd8675eb018254486750f168d2e88e8ca97bbce6e942ed2",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x87878f99141a7866e10cc06ad4022fb80011fdc7",
            "BP6mFnFbhaeI65w4kpx+9dgaN6um8I/HsC+Uk5enXD4rGDy8Ec4dU4JebC8l8C9LR4zzaa9Xh9FMGc6R8erypCk=",
            "ZAEx9MiBF2j72GdesBglRIZ1DxaNLojoype7zm6ULtI=",
        ),
    ),
    # vanity/0x88888
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x8888853ee72320eb98db7f76d2edf1a03d0f0ed1",
            "0xeca4107403a86380ba7edd6951a7c13e416979b2ad919cf07d0ffbc63a40cc8eb5804077d0246754971b5474022e8893ebc2df391342df54235ca951d0ebcb3d",
            "4fdb9411a87aaf34c07cea2a7b21f96c7d304c21a877eafe169a0ede0798709c",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x8888853ee72320eb98db7f76d2edf1a03d0f0ed1",
            "BOykEHQDqGOAun7daVGnwT5BaXmyrZGc8H0P+8Y6QMyOtYBAd9AkZ1SXG1R0Ai6Ik+vC3zkTQt9UI1ypUdDryz0=",
            "T9uUEah6rzTAfOoqeyH5bH0wTCGod+r+FpoO3geYcJw=",
        ),
    ),
    # vanity/0x89898
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x8989857d44a51cc63b9f3ff327a22fcbf497b525",
            "0xf9cd519f3bb1c14bab7be1c9cad8c82b09bfd2acc84861c8186c20480c1beade68886b0de864bd21d56d53f81ac001ef579629db59a3fa1bc47c17d01ae36fdb",
            "345f84b91f78ddec901b94cb2ba32673f0e103bef1d7ccbde4bc53364cc2189e",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x8989857d44a51cc63b9f3ff327a22fcbf497b525",
            "BPnNUZ87scFLq3vhycrYyCsJv9KsyEhhyBhsIEgMG+reaIhrDehkvSHVbVP4GsAB71eWKdtZo/obxHwX0Brjb9s=",
            "NF+EuR943eyQG5TLK6Mmc/DhA77x18y95LxTNkzCGJ4=",
        ),
    ),
    # vanity/0x90909
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x90909c67a0b9e2b14de4e82ccb90f4f04f7b8cbd",
            "0xfbf0db80ecf474ea7fb7af63041f3b4cb1886e09e6701d8dbad712009274b0f883d9cea4dc429e9df9e2a4c0d5e1655640440f812cbf747ea4a223a01071bef4",
            "4f5a82e014443a58a8eaa5a35dd05d56f36fdf26a1d254484670a4b24b682f47",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x90909c67a0b9e2b14de4e82ccb90f4f04f7b8cbd",
            "BPvw24Ds9HTqf7evYwQfO0yxiG4J5nAdjbrXEgCSdLD4g9nOpNxCnp354qTA1eFlVkBED4Esv3R+pKIjoBBxvvQ=",
            "T1qC4BREOlio6qWjXdBdVvNv3yah0lRIRnCksktoL0c=",
        ),
    ),
    # vanity/0x91919
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x91919ba6a401fe5c57ac59993951bc8fec85d4e5",
            "0x983ec3a819459fbd3ff403d0ab426a646ade7f801da5e87e7fff7b55d342a3622fbae894b793765be093931b5c2df6c4ad50efa8ae710edd4f505abc2147ba02",
            "bf00913f5c1faa6c2d43a5b2907b64503d32846b18d145d5c48c1d5d22586d75",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x91919ba6a401fe5c57ac59993951bc8fec85d4e5",
            "BJg+w6gZRZ+9P/QD0KtCamRq3n+AHaXofn//e1XTQqNiL7rolLeTdlvgk5MbXC32xK1Q76iucQ7dT1BavCFHugI=",
            "vwCRP1wfqmwtQ6WykHtkUD0yhGsY0UXVxIwdXSJYbXU=",
        ),
    ),
    # vanity/0x92929
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x92929134eaa5e09deff148a7210bea5814e7866c",
            "0x9b465645dc1ed36c0eb77d355e2d9230f3b7d5c1a71b4f91727eb9b266733cb8c21ad4dc5581a689c211af88fa72da6bdaac815e30fe60ebc7955dce2971972e",
            "c533ca6a808c80baa73c76c5b0867c2413c8b6642eeeca2c38998b4f08cba90b",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x92929134eaa5e09deff148a7210bea5814e7866c",
            "BJtGVkXcHtNsDrd9NV4tkjDzt9XBpxtPkXJ+ubJmczy4whrU3FWBponCEa+I+nLaa9qsgV4w/mDrx5Vdzilxly4=",
            "xTPKaoCMgLqnPHbFsIZ8JBPItmQu7sosOJmLTwjLqQs=",
        ),
    ),
    # vanity/0x93939
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x939397a4911e1065f4a42bfcebf719e36b8b7019",
            "0x267cb79e4c26bbe8cbeee0535089b39a1ed861958c969b06b6acb9b41454e8c626383a150701818d2ea211dbef9a4323c594dfd4f85912931dd10de2cc7510d2",
            "60c9063811e7f060adfecfa490b43b765b7a54a94b7ffb98a2ab1a2b1642c393",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x939397a4911e1065f4a42bfcebf719e36b8b7019",
            "BCZ8t55MJrvoy+7gU1CJs5oe2GGVjJabBrasubQUVOjGJjg6FQcBgY0uohHb75pDI8WU39T4WRKTHdEN4sx1ENI=",
            "YMkGOBHn8GCt/s+kkLQ7dlt6VKlLf/uYoqsaKxZCw5M=",
        ),
    ),
    # vanity/0x94949
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x94949688b71c312e3eaffbadf810e4df0ad027dd",
            "0x0a498ee476390b97be845df4322d01acc413e3646fe9ad030bf9e74b8ce643b576fecebc789d0b7a4befd4cb4b0a15d2978b661f34c99f8a5d6efb91a36e49e5",
            "8291520f15b47c58a63267002042f27b1f4ae540b0240c0d1a200d53967e615f",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x94949688b71c312e3eaffbadf810e4df0ad027dd",
            "BApJjuR2OQuXvoRd9DItAazEE+Nkb+mtAwv550uM5kO1dv7OvHidC3pL79TLSwoV0peLZh80yZ+KXW77kaNuSeU=",
            "gpFSDxW0fFimMmcAIELyex9K5UCwJAwNGiANU5Z+YV8=",
        ),
    ),
    # vanity/0x95959
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x959595f7f6390ebac93540382b4701eaf3f66d7a",
            "0x929396820daaa835f1528dbcccbb4190b50e85ee080d4c67107b64d17bfc4a1d7265cfae1effe686e662db875f4fec65243c711a07693bd5ccbade1d0f5e2a9d",
            "f5909893fce3a3788feed19bd2cd7ee9a709601d72d1938651d7aab83cbb9b6c",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x959595f7f6390ebac93540382b4701eaf3f66d7a",
            "BJKTloINqqg18VKNvMy7QZC1DoXuCA1MZxB7ZNF7/EodcmXPrh7/5obmYtuHX0/sZSQ8cRoHaTvVzLreHQ9eKp0=",
            "9ZCYk/zjo3iP7tGb0s1+6acJYB1y0ZOGUdequDy7m2w=",
        ),
    ),
    # vanity/0x96969
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x96969277590e973f65d39a84a99a049a660bfbca",
            "0xbe4a072cc4dbfda6e035217323cfffb098464ead39a7f8a5d73f6d8a18be2929df67c416e59cdb7a43448c0296d3113f4f0abbdd4a87cd268d8443d83537b5cb",
            "af0f838480db15e1f5fa5db30f81931c75148201cf42ca682cea863be8b6b54b",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x96969277590e973f65d39a84a99a049a660bfbca",
            "BL5KByzE2/2m4DUhcyPP/7CYRk6tOaf4pdc/bYoYvikp32fEFuWc23pDRIwCltMRP08Ku91Kh80mjYRD2DU3tcs=",
            "rw+DhIDbFeH1+l2zD4GTHHUUggHPQspoLOqGO+i2tUs=",
        ),
    ),
    # vanity/0x97979
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x97979df7120ec91243480905232c2678644ec1ad",
            "0xd12c55b4fa448d380c22676b07b8784d8b1d70902a62f3011c60cb0a88ed317abbb551023b823a3f8deeee7125675a4b75c061faf990c31e2fafd159d1088ff9",
            "563853f836a140b684274b578ea7caf6e14d5ad61b0df204067b864b20fa172e",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x97979df7120ec91243480905232c2678644ec1ad",
            "BNEsVbT6RI04DCJnawe4eE2LHXCQKmLzARxgywqI7TF6u7VRAjuCOj+N7u5xJWdaS3XAYfr5kMMeL6/RWdEIj/k=",
            "VjhT+DahQLaEJ0tXjqfK9uFNWtYbDfIEBnuGSyD6Fy4=",
        ),
    ),
    # vanity/0x98989
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x98989d1acee1ffb556a1170a4821a62d3e370c11",
            "0x8636be98519495d24cfda14ccd9c2cdd752da0262b9b9f3261dd9f855b0ce3c7905d499258b47a13731b940d7823cc97ce18beed76a51da47eaf873e7bdc6a72",
            "e20041fb118245232aaff70577111d9098438a08b045ce91257adc8ca6d00fbc",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x98989d1acee1ffb556a1170a4821a62d3e370c11",
            "BIY2vphRlJXSTP2hTM2cLN11LaAmK5ufMmHdn4VbDOPHkF1Jkli0ehNzG5QNeCPMl84Yvu12pR2kfq+HPnvcanI=",
            "4gBB+xGCRSMqr/cFdxEdkJhDigiwRc6RJXrcjKbQD7w=",
        ),
    ),
    # vanity/0x99999
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x999999334d613e65470b1f2262689142a0be9a2c",
            "0xf537ed62950652129558fac25323c13026da9f2bc2a72fbceb88236324777ba719821f6e8c0ed3810e1e5f4debde97586a74cb8ece4f99ae189c321f8e66aaca",
            "d1b71b469cc9a4dab8e6b86d1ede88084eb4f48e0c69d80befb2bb71f6524509",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x999999334d613e65470b1f2262689142a0be9a2c",
            "BPU37WKVBlISlVj6wlMjwTAm2p8rwqcvvOuII2Mkd3unGYIfbowO04EOHl9N696XWGp0y47OT5muGJwyH45mqso=",
            "0bcbRpzJpNq45rhtHt6ICE609I4MadgL77K7cfZSRQk=",
        ),
    ),
    # vanity/0x10010
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x1001063195ee13398dc6a26b42e2092d978960e5",
            "0x4d0834cd1e63645c152016da222aff54e9076cb70509b6e5c1cb402f69fe2ff621be2e2ffb798ff156634e340f4657c8ca9d229b5b97756caa30a26a7d35aafb",
            "9d5fd8ad73eaf772e5e00f49eba584e62c82749843a7ef0e580176f8cd1f14f1",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x1001063195ee13398dc6a26b42e2092d978960e5",
            "BE0INM0eY2RcFSAW2iIq/1TpB2y3BQm25cHLQC9p/i/2Ib4uL/t5j/FWY040D0ZXyMqdIptbl3VsqjCian01qvs=",
            "nV/YrXPq93Ll4A9J66WE5iyCdJhDp+8OWAF2+M0fFPE=",
        ),
    ),
    # vanity/0x10110
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x10110b6d91607d297f544a39b062b085cfbac921",
            "0x55b138ad10dc4c43ded70576fad79185d31c91e660eaa4a633cb3a58fdd2bd6a255499600b5c08ea15e4c8b7d023766647dae20dd4fa434fa80c9cea6f249cb7",
            "332a1f80e99307f99f05f60351864ab8e489d72f0535c3af30cb0abd6aa4a65c",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x10110b6d91607d297f544a39b062b085cfbac921",
            "BFWxOK0Q3ExD3tcFdvrXkYXTHJHmYOqkpjPLOlj90r1qJVSZYAtcCOoV5Mi30CN2Zkfa4g3U+kNPqAyc6m8knLc=",
            "MyofgOmTB/mfBfYDUYZKuOSJ1y8FNcOvMMsKvWqkplw=",
        ),
    ),
    # vanity/0x10210
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x1021000f24e099e48223e788d2fd864f0f3a85ba",
            "0x54b158ed4f9e9b540549c8a91dc35ef16f01fa128279051b5210c698b1fe6c9bea978808580b0dbdacef7683c65c7915420349801353612b9870a885ad1097a0",
            "8cbc18410e203c4530fe10ff9b7d188a8c0c6718751d1e2d74078b5ae8710423",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x1021000f24e099e48223e788d2fd864f0f3a85ba",
            "BFSxWO1PnptUBUnIqR3DXvFvAfoSgnkFG1IQxpix/myb6peICFgLDb2s73aDxlx5FUIDSYATU2ErmHCoha0Ql6A=",
            "jLwYQQ4gPEUw/hD/m30YiowMZxh1HR4tdAeLWuhxBCM=",
        ),
    ),
    # vanity/0x10310
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x10310112a4a0081e159870a402ca52f400f86dca",
            "0x7ffe2166446832c530ec84fe4fece607e732da98378651c3ebf3ca6610d502d83e2e920ab153095010369a48ebed89c7061a340c2ecb68bfc192d0b6c69596ab",
            "0051604e87f1e96e891eebdd6a01cd8640db82eeb3ce82c686729ab9453c5571",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x10310112a4a0081e159870a402ca52f400f86dca",
            "BH/+IWZEaDLFMOyE/k/s5gfnMtqYN4ZRw+vzymYQ1QLYPi6SCrFTCVAQNppI6+2JxwYaNAwuy2i/wZLQtsaVlqs=",
            "AFFgTofx6W6JHuvdagHNhkDbgu6zzoLGhnKauUU8VXE=",
        ),
    ),
    # vanity/0x10410
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x10410dbefc2c5f438ef937ccee2f53bcb0578670",
            "0x05521e159328acf359d4124709535f65494f008928c507fc9445f5e715342a71c87f52c451e29d49bff8c83ab16a82bc18f109c68d8130d1c1f2be504b2361a8",
            "20d62707d28d7dbc16c4667c46e117c9a5916093cdd426e4e7df2968b622d77e",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x10410dbefc2c5f438ef937ccee2f53bcb0578670",
            "BAVSHhWTKKzzWdQSRwlTX2VJTwCJKMUH/JRF9ecVNCpxyH9SxFHinUm/+Mg6sWqCvBjxCcaNgTDRwfK+UEsjYag=",
            "INYnB9KNfbwWxGZ8RuEXyaWRYJPN1Cbk598paLYi134=",
        ),
    ),
    # vanity/0x10510
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x10510b93e21b1c6f0145615bf0af6d48f357573b",
            "0x98066b2f8cfe758594ad7854e58cd336f1daedc62674d73e70ba5505f944393f286acf9f09dd3a319316c78ae9cb6cbe471150ed15eb26d8c2c845d22dddffba",
            "a99783cdbc018f6a3176d1ed184dfa96d4315966dff4e5ae0d170a6cee9da37b",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x10510b93e21b1c6f0145615bf0af6d48f357573b",
            "BJgGay+M/nWFlK14VOWM0zbx2u3GJnTXPnC6VQX5RDk/KGrPnwndOjGTFseK6ctsvkcRUO0V6ybYwshF0i3d/7o=",
            "qZeDzbwBj2oxdtHtGE36ltQxWWbf9OWuDRcKbO6do3s=",
        ),
    ),
    # vanity/0x10610
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x106107653c3c5d7706971953de8926b5209e6a50",
            "0x4024ea916c07720aaaf5349804d620659539025d71a5ddc35511dfcd7042e19e4c16c6fc922862aae51239cf68674375a78762d9f228ef17a48e58137eba5c6c",
            "ebe5a0ff3a9e611417a541c604b958d1f8f52555fd131584e2332338967416d5",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x106107653c3c5d7706971953de8926b5209e6a50",
            "BEAk6pFsB3IKqvU0mATWIGWVOQJdcaXdw1UR381wQuGeTBbG/JIoYqrlEjnPaGdDdaeHYtnyKO8XpI5YE366XGw=",
            "6+Wg/zqeYRQXpUHGBLlY0fj1JVX9ExWE4jMjOJZ0FtU=",
        ),
    ),
    # vanity/0x10710
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x10710e5cc41aed099e9a47552a91a725032b0322",
            "0xee4324a45af57502cf500e6f839779abb075837b607f24276a51bb4ad614999f8efd5f506256e8bc2a77e7b5556719867fb826d82d5633c3eda3739c2ed88e44",
            "87e2e1f19ed725681374597fb479a6dda59047ad5bd8d1917e9941185081b90f",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x10710e5cc41aed099e9a47552a91a725032b0322",
            "BO5DJKRa9XUCz1AOb4OXeauwdYN7YH8kJ2pRu0rWFJmfjv1fUGJW6Lwqd+e1VWcZhn+4JtgtVjPD7aNznC7YjkQ=",
            "h+Lh8Z7XJWgTdFl/tHmm3aWQR61b2NGRfplBGFCBuQ8=",
        ),
    ),
    # vanity/0x10810
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x10810ce443a1a910bdd88fcd90002cfadc0cbb8d",
            "0x31add7ae14c502bca8b5a10e0bd3c3cc1617938b82dcffbbc158dad85ed28c94bbf6657dc8adf1d1a233fd184f2a926d6c34dbb6cce250c45be581700312b79d",
            "c4f2fa9bfa5febe5d7c514d1631851b96656c7cb1901b6954220b1323d1a8f2c",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x10810ce443a1a910bdd88fcd90002cfadc0cbb8d",
            "BDGt164UxQK8qLWhDgvTw8wWF5OLgtz/u8FY2the0oyUu/Zlfcit8dGiM/0YTyqSbWw027bM4lDEW+WBcAMSt50=",
            "xPL6m/pf6+XXxRTRYxhRuWZWx8sZAbaVQiCxMj0ajyw=",
        ),
    ),
    # vanity/0x10910
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x109104cabf8c0a3acb8d39f4fb840824f7dc3063",
            "0x37b66e890c9e3b8fe7a720a45a5482a391ed1fc6a4151c94a6872d0b703f45859b92d454aebfe3b9ebe030a4b8a316c0e5886fc29f42cf51ec138d660bc35d82",
            "c36ac9b13eba257d9452332a6ad967b09e8d9fbb30100d074511bbba804096da",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x109104cabf8c0a3acb8d39f4fb840824f7dc3063",
            "BDe2bokMnjuP56cgpFpUgqOR7R/GpBUclKaHLQtwP0WFm5LUVK6/47nr4DCkuKMWwOWIb8KfQs9R7BONZgvDXYI=",
            "w2rJsT66JX2UUjMqatlnsJ6Nn7swEA0HRRG7uoBAlto=",
        ),
    ),
    # vanity/0x11011
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x110111b1a493f128a96e8199f8db026b8b4a3a11",
            "0x56b0fe2df6ffc9373dc41f53edd696a672f652319fcf98bface175bd57f7ecaf0c0b9551f531ceb08ffceb4d7945fe057d9649373f7795f410334aacc19b80c6",
            "656dba707958bb7f9e7d027651c7c8848415748fb0d1b6acf21e3c68775387dc",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x110111b1a493f128a96e8199f8db026b8b4a3a11",
            "BFaw/i32/8k3PcQfU+3WlqZy9lIxn8+Yv6zhdb1X9+yvDAuVUfUxzrCP/OtNeUX+BX2WSTc/d5X0EDNKrMGbgMY=",
            "ZW26cHlYu3+efQJ2UcfIhIQVdI+w0bas8h48aHdTh9w=",
        ),
    ),
    # vanity/0x11111
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x111119db4025d23f4d1e296f519c4463dfff8fa4",
            "0x6c84600332a219c49faec4d38595a2ee794ecc9e56e49c23e4eb10c333a23c92d181b43ca3bdb8678efe5b94451eb73971f1cb19e85f1fa31c4bc9e1383df8fd",
            "944f341e79b2c3ccc2a5d642c4d4c557d1fd4cce6ebb655c850a06987b1e734e",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x111119db4025d23f4d1e296f519c4463dfff8fa4",
            "BGyEYAMyohnEn67E04WVou55TsyeVuScI+TrEMMzojyS0YG0PKO9uGeO/luURR63OXHxyxnoXx+jHEvJ4Tg9+P0=",
            "lE80Hnmyw8zCpdZCxNTFV9H9TM5uu2VchQoGmHsec04=",
        ),
    ),
    # vanity/0x11211
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x112113ba2a058647a90747625b668bcc5b7f7ba1",
            "0xe5a0ec225a669546573dbdde4b9e9afbb0167628121db887efe6280c7caafa5b43481efe1d52b583db836e182dd67ba11de38bca5560d04e24e9e43016aa734c",
            "0a068967e49609fcdc9c44ccb7357dfc6d99678932ad9b5f31d2e0a15b3e5497",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x112113ba2a058647a90747625b668bcc5b7f7ba1",
            "BOWg7CJaZpVGVz293kuemvuwFnYoEh24h+/mKAx8qvpbQ0ge/h1StYPbg24YLdZ7oR3ji8pVYNBOJOnkMBaqc0w=",
            "CgaJZ+SWCfzcnETMtzV9/G2ZZ4kyrZtfMdLgoVs+VJc=",
        ),
    ),
    # vanity/0x11311
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x11311cd039c95152057deda1a9a6e983690e1002",
            "0x5cacf8ef4556fc7c97453e27fc9734708d7b9dfcf3bc50b8b5ae17f2c7a5d10158f3469963ddc0ba8a255b7063921f07047d4d5c20159df7a8e953314e74dab0",
            "e9ed805551676c3b3fddd842bd7b264579e0591726fc030701580240b59084d4",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x11311cd039c95152057deda1a9a6e983690e1002",
            "BFys+O9FVvx8l0U+J/yXNHCNe53887xQuLWuF/LHpdEBWPNGmWPdwLqKJVtwY5IfBwR9TVwgFZ33qOlTMU502rA=",
            "6e2AVVFnbDs/3dhCvXsmRXngWRcm/AMHAVgCQLWQhNQ=",
        ),
    ),
    # vanity/0x11411
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x114116d1aa052fd4193227968871ee4890eaf2a0",
            "0x59bfc3491928e579de0c0a8694b94b56222b5320427e3340a7c074187930022e99e55864e6f8e32ed4abf95bc6c15e25fdb44c59ef6aed406a6cae5b5b4a7483",
            "e37987fa26a5e5b2b980b18b4818540855b05555838accf8c5753a00c510724f",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x114116d1aa052fd4193227968871ee4890eaf2a0",
            "BFm/w0kZKOV53gwKhpS5S1YiK1MgQn4zQKfAdBh5MAIumeVYZOb44y7Uq/lbxsFeJf20TFnvau1AamyuW1tKdIM=",
            "43mH+ial5bK5gLGLSBhUCFWwVVWDisz4xXU6AMUQck8=",
        ),
    ),
    # vanity/0x11511
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x115115e96a7444a0529de4029f251ac1905ee33c",
            "0x9ec6b54ee3c48a820c6401166bc2d7324d8fec348530357eb5bb04f9a64860909c30f4873081040f3e866a85f2b281eecd7ef30756b6dae9ce11b35c26c959af",
            "b3e9b9c0e474ef380e7cd8bdc55f5882535d9a468a2bf3fde5da644b76665b24",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x115115e96a7444a0529de4029f251ac1905ee33c",
            "BJ7GtU7jxIqCDGQBFmvC1zJNj+w0hTA1frW7BPmmSGCQnDD0hzCBBA8+hmqF8rKB7s1+8wdWttrpzhGzXCbJWa8=",
            "s+m5wOR07zgOfNi9xV9YglNdmkaKK/P95dpkS3ZmWyQ=",
        ),
    ),
    # vanity/0x11611
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x116114d266a7bbeb380368ccb199aed787a68bff",
            "0x25c2b5fbfc43c333742fdbaacdc8d4c67d1f46637744eb116a67c863d35fdb3a802b64adb8c7083a4ccd93da0c5e8cb2c5f3f4f4146b949f15c14219d8ae1ba6",
            "41d504e93c1f093ab961b89ca93990f119d9fe328e63172837368c10ad8aeade",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x116114d266a7bbeb380368ccb199aed787a68bff",
            "BCXCtfv8Q8MzdC/bqs3I1MZ9H0Zjd0TrEWpnyGPTX9s6gCtkrbjHCDpMzZPaDF6MssXz9PQUa5SfFcFCGdiuG6Y=",
            "QdUE6TwfCTq5YbicqTmQ8RnZ/jKOYxcoNzaMEK2K6t4=",
        ),
    ),
    # vanity/0x11711
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x117114485a70307a6d48e24969275786cb1e2474",
            "0x7f8c207172bc61d70dce3ed7e974b777db85da990482d84d15e1ab629203ed315e5f8d90489da58839a892781ec13e411685208450b5f0298966583dac8d2740",
            "f89f6a696cd959db3e2e4a8794bbd3336c12ce7f2d9d5302cbdf5b582b7bdf15",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x117114485a70307a6d48e24969275786cb1e2474",
            "BH+MIHFyvGHXDc4+1+l0t3fbhdqZBILYTRXhq2KSA+0xXl+NkEidpYg5qJJ4HsE+QRaFIIRQtfApiWZYPayNJ0A=",
            "+J9qaWzZWds+LkqHlLvTM2wSzn8tnVMCy99bWCt73xU=",
        ),
    ),
    # vanity/0x11811
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x11811e5b532a8d6ca7d4d0b0e5f30bc5005737e3",
            "0x350187f7d38199970398ffb57ad181bdd8fc8061a1ab19e16c1ef42a9436874440721df1731370e066a2e42f9625a0fbedf299a49d589cd20e3b9c4776cd77f8",
            "7b0689d9f2788d431264caf3f41ffff98028492cf31bbe76e5c9d89882848ce0",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x11811e5b532a8d6ca7d4d0b0e5f30bc5005737e3",
            "BDUBh/fTgZmXA5j/tXrRgb3Y/IBhoasZ4Wwe9CqUNodEQHId8XMTcOBmouQvliWg++3ymaSdWJzSDjucR3bNd/g=",
            "ewaJ2fJ4jUMSZMrz9B//+YAoSSzzG7525cnYmIKEjOA=",
        ),
    ),
    # vanity/0x11911
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x11911468b7e88dffabe371bf0def9214e92c0743",
            "0x052870292ceefe3f8d7ad98a482625511f78fc171ae0ff9e0f0ff939fac26a48a65d11ff1b016e6af85abc0b01b92504035e2ad42875b71b26f6935518d0ab30",
            "742051f99b72aae120428667db9a2b14df1410c9d376da98a62fe80a04d1e694",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x11911468b7e88dffabe371bf0def9214e92c0743",
            "BAUocCks7v4/jXrZikgmJVEfePwXGuD/ng8P+Tn6wmpIpl0R/xsBbmr4WrwLAbklBANeKtQodbcbJvaTVRjQqzA=",
            "dCBR+ZtyquEgQoZn25orFN8UEMnTdtqYpi/oCgTR5pQ=",
        ),
    ),
    # vanity/0x12012
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x120120af0a6b5618f48cc7f179788d7775682cd1",
            "0x2acc61556d534c2d18615f5fea5c1b84d24515498c441a116fdb121d8f83c248fd63772548181e6c1134625c8f3a592a0aabb89184d2b55e56f006013354ab20",
            "048fc928a787a00ddc37bf6fef35f3881ce528ad4cd5d73f19a51e13783723a6",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x120120af0a6b5618f48cc7f179788d7775682cd1",
            "BCrMYVVtU0wtGGFfX+pcG4TSRRVJjEQaEW/bEh2Pg8JI/WN3JUgYHmwRNGJcjzpZKgqruJGE0rVeVvAGATNUqyA=",
            "BI/JKKeHoA3cN79v7zXziBzlKK1M1dc/GaUeE3g3I6Y=",
        ),
    ),
    # vanity/0x12112
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x12112094886e63052ff457992a960f3a2ea1cb02",
            "0x3221e483c4e93a83ac6925cca308dd54b79abd84e0c590452be50e252d87f580d2795443ef2c73160f5cc8168666dd22ec8b16c2f5ef3096b5e76577b498de03",
            "5fc220738020d104df85cb8ce240355ba12d556d9c05058b48c1efddbad5822e",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x12112094886e63052ff457992a960f3a2ea1cb02",
            "BDIh5IPE6TqDrGklzKMI3VS3mr2E4MWQRSvlDiUth/WA0nlUQ+8scxYPXMgWhmbdIuyLFsL17zCWtedld7SY3gM=",
            "X8Igc4Ag0QTfhcuM4kA1W6EtVW2cBQWLSMHv3brVgi4=",
        ),
    ),
    # vanity/0x12212
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x12212719c048e4773babcf20671dd643aff39f24",
            "0x3b191a8a37e3bd4e0e8bf85de44fe7749b815374ab46c2745514b03d994f9935907c4821756ad5a1c60321401eb933e4afecdeeaa22406acef965fb35f0e4677",
            "6f41e64d5361e7559eb0c373e33123ba12db4e14e49800cf4c356dac3250ade6",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x12212719c048e4773babcf20671dd643aff39f24",
            "BDsZGoo3471ODov4XeRP53SbgVN0q0bCdFUUsD2ZT5k1kHxIIXVq1aHGAyFAHrkz5K/s3uqiJAas75Zfs18ORnc=",
            "b0HmTVNh51WesMNz4zEjuhLbThTkmADPTDVtrDJQreY=",
        ),
    ),
    # vanity/0x12312
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x12312a7b74c4e02f8e98056bf832ba943c5e0fb7",
            "0x958c8f3efce3bfcea222c9e6c63e23563c9c5824ac4a7e0cccbb3991ef43d567744c955f2d95d5cbb248a8da88d4939dddb3bee15c2bc5e8606301de318c52df",
            "820db1047aac40ac9dc7b140bd8980ab212c791b0d246eb27bd96be245f78866",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x12312a7b74c4e02f8e98056bf832ba943c5e0fb7",
            "BJWMjz7847/OoiLJ5sY+I1Y8nFgkrEp+DMy7OZHvQ9VndEyVXy2V1cuySKjaiNSTnd2zvuFcK8XoYGMB3jGMUt8=",
            "gg2xBHqsQKydx7FAvYmAqyEseRsNJG6ye9lr4kX3iGY=",
        ),
    ),
    # vanity/0x12412
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x12412f4ccbc017125ea1fc39c3a6206279e6144c",
            "0x971f34169e36fa086b12b5445e13cb941983d3651067ca5a6865638abd803ad5c57057617d7eaa84c8fd5663f75cc740163bdf97b94d79e9b7f4e69dbd5fd38a",
            "c4a14caffddb0ef17db87c4c7276a20531f98be2328f358b580f7a7a2671316d",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x12412f4ccbc017125ea1fc39c3a6206279e6144c",
            "BJcfNBaeNvoIaxK1RF4Ty5QZg9NlEGfKWmhlY4q9gDrVxXBXYX1+qoTI/VZj91zHQBY735e5TXnpt/Tmnb1f04o=",
            "xKFMr/3bDvF9uHxMcnaiBTH5i+IyjzWLWA96eiZxMW0=",
        ),
    ),
    # vanity/0x12512
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x1251219a4b0edff56d5ba82c9cee4f950532b8fb",
            "0xa908923cf5a0148e1b55af8617d8708225feb21ef23f252d42807b26b1067bb6cf05cba2915a0eeada6eef9e04a246e25c6ec8f2d0d5747143491613e8493684",
            "9864f5d301b62dd85136825cbcba5d78643b1ff9c859f6a91d5dcac3e7a46119",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x1251219a4b0edff56d5ba82c9cee4f950532b8fb",
            "BKkIkjz1oBSOG1WvhhfYcIIl/rIe8j8lLUKAeyaxBnu2zwXLopFaDurabu+eBKJG4lxuyPLQ1XRxQ0kWE+hJNoQ=",
            "mGT10wG2LdhRNoJcvLpdeGQ7H/nIWfapHV3Kw+ekYRk=",
        ),
    ),
    # vanity/0x12612
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x126125f1dfd33f331fa6ea8be35e43293bf53864",
            "0x40de25d6abe9f17d4f54ccae3a4eff17d359866b44017744f5458c77985f38a767eb0525b543aa7b3fbb3ffbf881d8500024f58c88857027b6f3a893f4221268",
            "e80174dd4578f584773c23d572924636b65b80c697b69af1e61d8f9aa9272119",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x126125f1dfd33f331fa6ea8be35e43293bf53864",
            "BEDeJdar6fF9T1TMrjpO/xfTWYZrRAF3RPVFjHeYXzinZ+sFJbVDqns/uz/7+IHYUAAk9YyIhXAntvOok/QiEmg=",
            "6AF03UV49YR3PCPVcpJGNrZbgMaXtprx5h2PmqknIRk=",
        ),
    ),
    # vanity/0x12712
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x127126a056daaeaafd7a92d6b9615f58ec2c8a75",
            "0x4c41828ec49900e210b5a006e9c6aad463098e08bac3e9eb72c3cf4c52bc35b37b08ff11bf0b1b091c639fcef9e3a7ccf1d4d0727f9893dfdecd01b55aaefa45",
            "39bb901bad344ea11023cda93436952a532063458c167404a5762957565611bb",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x127126a056daaeaafd7a92d6b9615f58ec2c8a75",
            "BExBgo7EmQDiELWgBunGqtRjCY4IusPp63LDz0xSvDWzewj/Eb8LGwkcY5/O+eOnzPHU0HJ/mJPf3s0BtVqu+kU=",
            "ObuQG600TqEQI82pNDaVKlMgY0WMFnQEpXYpV1ZWEbs=",
        ),
    ),
    # vanity/0x12812
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x128125419da3a59ec39f2925f87b37cb07874399",
            "0x76f92e55669a63b3c2539911aa0f83100886e52dc26fcacb2e039ef86b12234c69b5dfe2d8bb8d30cb7b80a0d4b634a16edf4f5aa5e4e13c5ee8a4670f763449",
            "f00257805f52e04eec9234d61cb33b3423543a0119b091e7163be18fd0dfa554",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x128125419da3a59ec39f2925f87b37cb07874399",
            "BHb5LlVmmmOzwlOZEaoPgxAIhuUtwm/Kyy4DnvhrEiNMabXf4ti7jTDLe4Cg1LY0oW7fT1ql5OE8XuikZw92NEk=",
            "8AJXgF9S4E7skjTWHLM7NCNUOgEZsJHnFjvhj9DfpVQ=",
        ),
    ),
    # vanity/0x12912
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x129129ef3431b14a194e17a02eca1954888450a6",
            "0x4fa93fcc6a9ecf8eb589fa2f99fce18991fbbac0da87a99b66d427b6318611e8f5426b499879b9d6f77eea584c7b4f1f147c2a0aa97832eed4e034cf98d12e56",
            "f50524537cf3030cc553b67c3955523f947504bff9bb258513bbcf63e5b1b1e7",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x129129ef3431b14a194e17a02eca1954888450a6",
            "BE+pP8xqns+OtYn6L5n84YmR+7rA2oepm2bUJ7YxhhHo9UJrSZh5udb3fupYTHtPHxR8KgqpeDLu1OA0z5jRLlY=",
            "9QUkU3zzAwzFU7Z8OVVSP5R1BL/5uyWFE7vPY+Wxsec=",
        ),
    ),
    # vanity/0x13013
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x13013ab4e9fb72b8b2b1f6307a3b406d8ae86607",
            "0xcf11a9819b7696dcff3176ac3416aebedcc4ed3c4dec996195b084f11e6c60fcfde307b2d99eab90dd2e00d95c9dc4a02ec5142a945705d0f82a4408fb415fd8",
            "418a02b1c0e27a5ce17db8ab53f757a4ba1326df4c8555df1faf512235df87c0",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x13013ab4e9fb72b8b2b1f6307a3b406d8ae86607",
            "BM8RqYGbdpbc/zF2rDQWrr7cxO08TeyZYZWwhPEebGD8/eMHstmeq5DdLgDZXJ3EoC7FFCqUVwXQ+CpECPtBX9g=",
            "QYoCscDielzhfbirU/dXpLoTJt9MhVXfH69RIjXfh8A=",
        ),
    ),
    # vanity/0x13113
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x13113f3876a033e8ba11d988510fe62677ba9f0b",
            "0x239fe88080d3ef917dbbc4f4c55686f82747559c323f0902cf3a693b93337e55d09e63b59e0bfb412e7c763615453046b1b5d6b2b3c63436477b5c2736a5fcf2",
            "b415de4cca3dd9b6490848e20ab94056ec0301df83b9f0410250407340a85c27",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x13113f3876a033e8ba11d988510fe62677ba9f0b",
            "BCOf6ICA0++RfbvE9MVWhvgnR1WcMj8JAs86aTuTM35V0J5jtZ4L+0EufHY2FUUwRrG11rKzxjQ2R3tcJzal/PI=",
            "tBXeTMo92bZJCEjiCrlAVuwDAd+DufBBAlBAc0CoXCc=",
        ),
    ),
    # vanity/0x13213
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x13213ec7da829a7f701679d9f09c7f01de9c708c",
            "0xf10fd65567922be85fc48ca18006094f91ba6634a1226340b32929efffe03c1700d51d1bf6b695db812171921c544023847cdcf2d9887ba82133ab358d675e8b",
            "63255a8b9fe85e340562ce660bbe673e22ed8c0446df4ed1cb784eedc143f0dc",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x13213ec7da829a7f701679d9f09c7f01de9c708c",
            "BPEP1lVnkivoX8SMoYAGCU+RumY0oSJjQLMpKe//4DwXANUdG/a2lduBIXGSHFRAI4R83PLZiHuoITOrNY1nXos=",
            "YyVai5/oXjQFYs5mC75nPiLtjARG307Ry3hO7cFD8Nw=",
        ),
    ),
    # vanity/0x13313
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x133137acc65457b678ccebacbae9f756b4fe5724",
            "0x0a29491f00b66952c58a0aec9aa32eb1af64e2ad3ed9f960e9e8303e21cc49445780a1c10e0912786ba2656d7adc1a31f5302dabd240059ef8b829f1e5ff9c5a",
            "f39c8e9d6d6337930bcd7301767088b88dba3fa60d06ba25104b274c6e938956",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x133137acc65457b678ccebacbae9f756b4fe5724",
            "BAopSR8AtmlSxYoK7JqjLrGvZOKtPtn5YOnoMD4hzElEV4ChwQ4JEnhromVtetwaMfUwLavSQAWe+Lgp8eX/nFo=",
            "85yOnW1jN5MLzXMBdnCIuI26P6YNBrolEEsnTG6TiVY=",
        ),
    ),
    # vanity/0x13413
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x13413c9757ffb5aa76be07a89b812657aa46be73",
            "0x22a8c4e01fc8067021cf7c974c341fa7a3104143d9e570643ce782a7a6a5b33c82b83ee1a2b689477446c324a26ae5d83c1df8513568bc3c2d92a3c582995808",
            "c4b59806988faeaf21bc615a353dde17a383e64c5470df49a55191c61beee1dd",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x13413c9757ffb5aa76be07a89b812657aa46be73",
            "BCKoxOAfyAZwIc98l0w0H6ejEEFD2eVwZDzngqempbM8grg+4aK2iUd0RsMkomrl2Dwd+FE1aLw8LZKjxYKZWAg=",
            "xLWYBpiPrq8hvGFaNT3eF6OD5kxUcN9JpVGRxhvu4d0=",
        ),
    ),
    # vanity/0x13513
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x13513aa9de44fc32757b412b0381c59deafafe12",
            "0xad3e2aeed8aed5cd2ac9e0adcd8ec7bb991c1b1b4fecd5c3ef9ed6c7613c5646968fb669cd110a21970810690d8691bfd16e73b6ac629bec984de91163ba3c02",
            "654c57d8f65fcfa68e7da1ac79942259fadffed3e7317213abe44a871f10dc3a",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x13513aa9de44fc32757b412b0381c59deafafe12",
            "BK0+Ku7YrtXNKsngrc2Ox7uZHBsbT+zVw++e1sdhPFZGlo+2ac0RCiGXCBBpDYaRv9Fuc7asYpvsmE3pEWO6PAI=",
            "ZUxX2PZfz6aOfaGseZQiWfrf/tPnMXITq+RKhx8Q3Do=",
        ),
    ),
    # vanity/0x13613
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x13613389c19efb107f39ad29cde20e884707262d",
            "0xa72f6d42b4ca21cb9fea260c3476fd1be5551eb4e252f7115468a8f69f5988ee849a95daa32455fc7f81f91415aeebc72379682a9dbdd15cfb9a35f5f46009de",
            "7160c9a43b34bbd349258a71ed1ff44ba3e7da5db8d5c0e2c8bef34da177f60e",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x13613389c19efb107f39ad29cde20e884707262d",
            "BKcvbUK0yiHLn+omDDR2/RvlVR604lL3EVRoqPafWYjuhJqV2qMkVfx/gfkUFa7rxyN5aCqdvdFc+5o19fRgCd4=",
            "cWDJpDs0u9NJJYpx7R/0S6Pn2l241cDiyL7zTaF39g4=",
        ),
    ),
    # vanity/0x13713
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x13713828848a86dbfcc9f98f98e458b8032608b4",
            "0xee540fbde523274f05ae6d74f9597816657fa4b2d048cf0cef15e7ad85ec260dc2ef26ccb5cc72c823ab61172468b9f16ab80a03641cc5828810d1332d9d99bc",
            "9aeb8904d29d8b1e7f35ac154cfd7dc50ce026178027a19fc510e19148d1345c",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x13713828848a86dbfcc9f98f98e458b8032608b4",
            "BO5UD73lIydPBa5tdPlZeBZlf6Sy0EjPDO8V562F7CYNwu8mzLXMcsgjq2EXJGi58Wq4CgNkHMWCiBDRMy2dmbw=",
            "muuJBNKdix5/NawVTP19xQzgJheAJ6GfxRDhkUjRNFw=",
        ),
    ),
    # vanity/0x13813
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x1381315ccb83d4a6402b3946ce3c62a74fdf9ea2",
            "0xcfef81c8ec55c5f43e2e9599d92e6becfcd284cc322bc1be993b380ef01d6aec22616d89ccb5d1dc3a822fcfdf62b295fef14cbb04cd7053351a6209a1843dde",
            "f615e7b0072e1f4fa13b6e55b195d607a657d3bc9d1ddc9c7f2cd28c73e9614b",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x1381315ccb83d4a6402b3946ce3c62a74fdf9ea2",
            "BM/vgcjsVcX0Pi6Vmdkua+z80oTMMivBvpk7OA7wHWrsImFticy10dw6gi/P32Kylf7xTLsEzXBTNRpiCaGEPd4=",
            "9hXnsAcuH0+hO25VsZXWB6ZX07ydHdycfyzSjHPpYUs=",
        ),
    ),
    # vanity/0x13913
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x13913b02da573e734ea4219f5bf4ff4d261a48f8",
            "0x8b1c117c7b9d13993fcaa63cd016b8f464491e9fc0712ab11a3683149865fbe3a926bef67e63fec09ed610c1865719cf4fc42a9accd01bef08292eea8e59e58e",
            "b6212619f762a944e2a30aa4163abad3cd83afc3937b41d8e22a6bdc216691e4",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x13913b02da573e734ea4219f5bf4ff4d261a48f8",
            "BIscEXx7nROZP8qmPNAWuPRkSR6fwHEqsRo2gxSYZfvjqSa+9n5j/sCe1hDBhlcZz0/EKprM0BvvCCku6o5Z5Y4=",
            "tiEmGfdiqUTiowqkFjq6082Dr8OTe0HY4ipr3CFmkeQ=",
        ),
    ),
    # vanity/0x14014
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x140142d553c0330da0ac69eca9a9ba906fed0468",
            "0xed8f85ba8a10288e811b4f9300075af207c7ebe171c9b87998b866db3bc8e5088813498763424732954fec7549e20c4a6e2e5404ab575592605c1c84f7a7ef69",
            "12b1eeb7be8326b7d4c9ac671018a31290e7fec8e5bfb9d58cdd878525c6f9f6",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x140142d553c0330da0ac69eca9a9ba906fed0468",
            "BO2PhbqKECiOgRtPkwAHWvIHx+vhccm4eZi4Zts7yOUIiBNJh2NCRzKVT+x1SeIMSm4uVASrV1WSYFwchPen72k=",
            "ErHut76DJrfUyaxnEBijEpDn/sjlv7nVjN2HhSXG+fY=",
        ),
    ),
    # vanity/0x14114
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x14114c36681c14ee502232302978166f576825cb",
            "0xb4ae5434fbfc297b7578d7e3af9713f5567f5f6aeeb6ee5de151288020caae529217ee0c9d377971027328672b149ca6b0768de220db4707bddd463f4b4bd934",
            "bd8fa5b1a49ab34d5d3ee8bfef9dc24d4fecab0ccbdc944ed07c861956eb6193",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x14114c36681c14ee502232302978166f576825cb",
            "BLSuVDT7/Cl7dXjX46+XE/VWf19q7rbuXeFRKIAgyq5SkhfuDJ03eXECcyhnKxScprB2jeIg20cHvd1GP0tL2TQ=",
            "vY+lsaSas01dPui/753CTU/sqwzL3JRO0HyGGVbrYZM=",
        ),
    ),
    # vanity/0x14214
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x14214aed967b46752b04c366a860946debfa5039",
            "0x4a357ce62a0a40fc07c012ee4cb8cc01da422fd16ad9752df37a88f54a4e389f49d597c41f923e4bbfffffed0831ed4c56b1d0a096411e35be4109677207b214",
            "eda888641673c1b218bd101df1995dc457c0c6827261c1e273ce11274053f772",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x14214aed967b46752b04c366a860946debfa5039",
            "BEo1fOYqCkD8B8AS7ky4zAHaQi/Ratl1LfN6iPVKTjifSdWXxB+SPku////tCDHtTFax0KCWQR41vkEJZ3IHshQ=",
            "7aiIZBZzwbIYvRAd8ZldxFfAxoJyYcHic84RJ0BT93I=",
        ),
    ),
    # vanity/0x14314
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x14314e22e3330dc67c8352910430b15ffa8ec52f",
            "0x79b8183d0ade25451449014da527142588ff408ae8675029b5f6f6dda62b64e0c65a548c60c10be775c9368ff79b5a9eb50c6e6435632943028456f5a7ece6aa",
            "e798b18dc3424d0ac142e31247c3b467bfc5fbef78a7bff85b02e06c454727a2",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x14314e22e3330dc67c8352910430b15ffa8ec52f",
            "BHm4GD0K3iVFFEkBTaUnFCWI/0CK6GdQKbX29t2mK2TgxlpUjGDBC+d1yTaP95tanrUMbmQ1YylDAoRW9afs5qo=",
            "55ixjcNCTQrBQuMSR8O0Z7/F++94p7/4WwLgbEVHJ6I=",
        ),
    ),
    # vanity/0x14414
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x144148ce0229c17c4e3e872231203c1886aa7324",
            "0x8d2e9570868b1db16d94c7f54a38485ec196d242335e26b9e82afee291dce7903c2aa1cc5059be9dcc57ecb0595dd01fa84ac5061f0ab8b80476bedb5a7663c3",
            "f879e7f06eda9fcec5b834d41ec7e8c224a0fd78945362e32a7c3c254e494ec5",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x144148ce0229c17c4e3e872231203c1886aa7324",
            "BI0ulXCGix2xbZTH9Uo4SF7BltJCM14muegq/uKR3OeQPCqhzFBZvp3MV+ywWV3QH6hKxQYfCri4BHa+21p2Y8M=",
            "+Hnn8G7an87FuDTUHsfowiSg/XiUU2LjKnw8JU5JTsU=",
        ),
    ),
    # vanity/0x14514
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x1451491b9c1bfac5676d2317a7c147952e4d0778",
            "0xc4b3d08d5fb91d79838ec6a6db0b38e5efa0a607174fe0f51e049a44d143b292d5eff35484e48e829715dbbe3e1a3a60164bfb09eb5ce2cdf5a847d8ea7c09f0",
            "c4f5fcfefb15c16eddd4b7c2f2ebe90a55c003865adf85ef43bd4008ee7ddb5c",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x1451491b9c1bfac5676d2317a7c147952e4d0778",
            "BMSz0I1fuR15g47GptsLOOXvoKYHF0/g9R4EmkTRQ7KS1e/zVITkjoKXFdu+Pho6YBZL+wnrXOLN9ahH2Op8CfA=",
            "xPX8/vsVwW7d1LfC8uvpClXAA4Za34XvQ71ACO5921w=",
        ),
    ),
    # vanity/0x14614
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x146142d7ffd0a64412a166051ce22850a1763d00",
            "0xd260caf864a27c164711f6522a453b269543e766dad00aed7012dbe49404f2027e8a38669e63f2d2a102037cfe8a5d328193e6f5a45e910eb49fdaefbd6b44f1",
            "0c8c5d58290192d261648ebf781b97be6af4eac850f208ae81e282edccbadf38",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x146142d7ffd0a64412a166051ce22850a1763d00",
            "BNJgyvhkonwWRxH2UipFOyaVQ+dm2tAK7XAS2+SUBPICfoo4Zp5j8tKhAgN8/opdMoGT5vWkXpEOtJ/a771rRPE=",
            "DIxdWCkBktJhZI6/eBuXvmr06shQ8giugeKC7cy63zg=",
        ),
    ),
    # vanity/0x14714
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x14714e23d5a943f9e7d4391324b513eefb6eeef9",
            "0x5ca2f2d3661cb545e33fe0139255e02b5d316a961aaf2dc470cc086981c07053ec584e87e1bb37b03c9240f221c35c9c3a306ce6c7f2049798c280924f990517",
            "c9cfd0998f5ef141b79d33021fb90ce280ec7aaa21f191adcfc873f281e6a620",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x14714e23d5a943f9e7d4391324b513eefb6eeef9",
            "BFyi8tNmHLVF4z/gE5JV4CtdMWqWGq8txHDMCGmBwHBT7FhOh+G7N7A8kkDyIcNcnDowbObH8gSXmMKAkk+ZBRc=",
            "yc/QmY9e8UG3nTMCH7kM4oDseqoh8ZGtz8hz8oHmpiA=",
        ),
    ),
    # vanity/0x14814
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x148149868ef419f66f783e40ebf67b4a0e456cd5",
            "0xede17f813090f2ad8b0aa0c4daab3765b08a7d9993d7319ff91160fa6001089525858faf81ffdfc64b18565381c289de1bf9d1c9bc81790e3c3e6eff10a64b28",
            "d531442c763f903afbe2f9761749b81bb9529160b1eebda00d2a717c1561bffc",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x148149868ef419f66f783e40ebf67b4a0e456cd5",
            "BO3hf4EwkPKtiwqgxNqrN2Wwin2Zk9cxn/kRYPpgAQiVJYWPr4H/38ZLGFZTgcKJ3hv50cm8gXkOPD5u/xCmSyg=",
            "1TFELHY/kDr74vl2F0m4G7lSkWCx7r2gDSpxfBVhv/w=",
        ),
    ),
    # vanity/0x14914
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x14914cbbe5bd291a968fc719371ae43eec912721",
            "0xf5f390221b644a4883bc8acb060e98c1bb78f4638773ed65ef26f9ac331565e74c5f4b2cd930f251fd90d42242cec4febe88f5ece4af0b1eb11d1ebc60260c85",
            "4e51e6f50aacfd5cfaaaf733760606a56913ec7b057c63bd2cddac7cc2755d62",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x14914cbbe5bd291a968fc719371ae43eec912721",
            "BPXzkCIbZEpIg7yKywYOmMG7ePRjh3PtZe8m+awzFWXnTF9LLNkw8lH9kNQiQs7E/r6I9ezkrwsesR0evGAmDIU=",
            "TlHm9Qqs/Vz6qvczdgYGpWkT7HsFfGO9LN2sfMJ1XWI=",
        ),
    ),
    # vanity/0x15015
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x15015a56af5066622e54aa353bca251107c26f7c",
            "0xd8b1c8422220fc2542f5f3e69e7e6bd92973fe42f76fd92b341353bc1c2dd02a14d416ae57cb7a02497d04d63148c837fe7e48ae8cd4abb24ccb95607c40c5a6",
            "434f81c4115ae9e5a4758a7074fffa56fd6d76ad2bd8b139837a3a6aa6d9b4ff",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x15015a56af5066622e54aa353bca251107c26f7c",
            "BNixyEIiIPwlQvXz5p5+a9kpc/5C92/ZKzQTU7wcLdAqFNQWrlfLegJJfQTWMUjIN/5+SK6M1KuyTMuVYHxAxaY=",
            "Q0+BxBFa6eWkdYpwdP/6Vv1tdq0r2LE5g3o6aqbZtP8=",
        ),
    ),
    # vanity/0x15115
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x15115a09c398d9c89439e691ba8512eaab91e338",
            "0xd1987c99de2f1ea3bf6673569e282b7a353b3e220631205c58aa9854d28f48d0860aa2eb8894e916ef9650e0cb6af49d255016d45ca03fb905d3c798d65d08ee",
            "6bea280b25a353b6d6b0b5e8c3877c782600acaab201f9b179cb2acdc2235635",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x15115a09c398d9c89439e691ba8512eaab91e338",
            "BNGYfJneLx6jv2ZzVp4oK3o1Oz4iBjEgXFiqmFTSj0jQhgqi64iU6RbvllDgy2r0nSVQFtRcoD+5BdPHmNZdCO4=",
            "a+ooCyWjU7bWsLXow4d8eCYArKqyAfmxecsqzcIjVjU=",
        ),
    ),
    # vanity/0x15215
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x1521507b98a5221132a6f002acf16aac49f945fe",
            "0x529627380780be26741a6d5f38061a55d59eb672e3ab771549f0a71e931244a406ee95840c9255f8f08576aa216ac2bc72c4f65fb995efdea0fb21a351ca32ec",
            "0fbdbf25fc4d2926b248bc54b0a75f0666f627c96bb97dfd3d80d05f7b7d2ad4",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x1521507b98a5221132a6f002acf16aac49f945fe",
            "BFKWJzgHgL4mdBptXzgGGlXVnrZy46t3FUnwpx6TEkSkBu6VhAySVfjwhXaqIWrCvHLE9l+5le/eoPsho1HKMuw=",
            "D72/JfxNKSaySLxUsKdfBmb2J8lruX39PYDQX3t9KtQ=",
        ),
    ),
    # vanity/0x15315
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x15315a989de5e986918750f0d77dcafca7ae0052",
            "0x30dfe8f7799c3d27cecd21a9294082479dd110d9c853da473be7fbf5dc8d41ae6cdc12fdaf715507c726d482e28accf168d5fdb297df167485e0fb3fae8d2e42",
            "514414c095a19f315af76529f28d4ad1816dcf49d078e559c2e57723dd5139f3",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x15315a989de5e986918750f0d77dcafca7ae0052",
            "BDDf6Pd5nD0nzs0hqSlAgked0RDZyFPaRzvn+/XcjUGubNwS/a9xVQfHJtSC4orM8WjV/bKX3xZ0heD7P66NLkI=",
            "UUQUwJWhnzFa92Up8o1K0YFtz0nQeOVZwuV3I91ROfM=",
        ),
    ),
    # vanity/0x15415
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x15415f642cf31ee6894bc460ee890758098407f0",
            "0x8f597e4394268cd2ef6720db43568679795252f5981ea43daa2b2a9651cc78359c49baab94ac9d199ee2bfde78fbcb3f397abf6b463d01b0b6ba89fde7b6370f",
            "f55d55f9fead52fe088cb56ea23b67005554688af8d2ba9e0c6c4fcfd6e94731",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x15415f642cf31ee6894bc460ee890758098407f0",
            "BI9ZfkOUJozS72cg20NWhnl5UlL1mB6kPaorKpZRzHg1nEm6q5SsnRme4r/eePvLPzl6v2tGPQGwtrqJ/ee2Nw8=",
            "9V1V+f6tUv4IjLVuojtnAFVUaIr40rqeDGxPz9bpRzE=",
        ),
    ),
    # vanity/0x15515
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x155159392372bb8d6767d07af467773d52b3a548",
            "0x479d3778d2fa45e8a8385e36ffd3f87f372cee74756858cac992b6fb385ed0e01e0328a1dbb390b1ab78cbbe5b6d8d39e7876e98af5b12dadffe9f6b884bf31f",
            "bebcae236a365e942a08dcddfef987699ac08bdbb0f6680693404da729290767",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x155159392372bb8d6767d07af467773d52b3a548",
            "BEedN3jS+kXoqDheNv/T+H83LO50dWhYysmStvs4XtDgHgMooduzkLGreMu+W22NOeeHbpivWxLa3/6fa4hL8x8=",
            "vryuI2o2XpQqCNzd/vmHaZrAi9uw9mgGk0BNpykpB2c=",
        ),
    ),
    # vanity/0x15615
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x15615f633d9b129f768efa3a2e4bc20ef646c633",
            "0x25d52ef01ff8befb33bbfb52c7296146e36561f7c0ee926049972e46c9446ccd94cbe504918537ae77c4ae4eddd6fe264610a34e31a09bd1ff0fe5a44c2e6268",
            "3b2a2a8567915b392c6002c24e3a2c992a64fd039af8efeb70e66d85499702d2",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x15615f633d9b129f768efa3a2e4bc20ef646c633",
            "BCXVLvAf+L77M7v7UscpYUbjZWH3wO6SYEmXLkbJRGzNlMvlBJGFN653xK5O3db+JkYQo04xoJvR/w/lpEwuYmg=",
            "OyoqhWeRWzksYALCTjosmSpk/QOa+O/rcOZthUmXAtI=",
        ),
    ),
    # vanity/0x15715
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x15715d0f9e80eccfb0bca0351640ae99083b39bf",
            "0xde3ca8361c6bc530ebc20096134fafd223b5cfdd9ad546894f9df66b56c5acc06d2f0ddd4cfac442a20cff64a0529d1295dc21c38bd10e5e667a87d494d195e3",
            "9f0f4994fb92e04b08b7f3a1df5ba4e55a819c9a53ce034bc7f32e095d9431d4",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x15715d0f9e80eccfb0bca0351640ae99083b39bf",
            "BN48qDYca8Uw68IAlhNPr9Ijtc/dmtVGiU+d9mtWxazAbS8N3Uz6xEKiDP9koFKdEpXcIcOL0Q5eZnqH1JTRleM=",
            "nw9JlPuS4EsIt/Oh31uk5VqBnJpTzgNLx/MuCV2UMdQ=",
        ),
    ),
    # vanity/0x15815
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x158154afc0ddcb29ff26d9d5af91a1d69e01db38",
            "0xae13ed617cf2af62d7e04d0b2d7996937c5f073bfbac38c887e0f7aae9079c2fb6debb5a21c81d4cd4d51afbfc02eb8a20255f0e3dd31bc9fd4e92199a952baf",
            "7e1f616a6ee5b1a08a19c60abf5f177bccd0c9af13251360554b5f098b31082a",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x158154afc0ddcb29ff26d9d5af91a1d69e01db38",
            "BK4T7WF88q9i1+BNCy15lpN8Xwc7+6w4yIfg96rpB5wvtt67WiHIHUzU1Rr7/ALriiAlXw490xvJ/U6SGZqVK68=",
            "fh9ham7lsaCKGcYKv18Xe8zQya8TJRNgVUtfCYsxCCo=",
        ),
    ),
    # vanity/0x15915
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x15915bad23bf7cfcc37c06f78279771db329edd6",
            "0x407ae6f2eae1f6d14fb96a754fa39eba53b09ccb4cc940ae7d32653b7aa90f8a4890887153880e276e046904c1c6a4f179da141b3c838932983b0e129165f7a7",
            "2ab9cae17a511bddc4664af30434850766e8d73088718f2395f250b291b916a5",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x15915bad23bf7cfcc37c06f78279771db329edd6",
            "BEB65vLq4fbRT7lqdU+jnrpTsJzLTMlArn0yZTt6qQ+KSJCIcVOIDiduBGkEwcak8XnaFBs8g4kymDsOEpFl96c=",
            "KrnK4XpRG93EZkrzBDSFB2bo1zCIcY8jlfJQspG5FqU=",
        ),
    ),
    # vanity/0x16016
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x16016f2865cfb95869b60c621110d339532163f8",
            "0x657abdeb6291248779804e4cb29102bc498bf3d70f9414acaaae524dc9b3b9d60169ccd52fbdc93fca61ab64a376d3360234203140a3213c8a149a583ffb9eb7",
            "32e6a7fd09c18dc773dfb999e56e7b25cdba0f9375ffb0ff56c65bc7f8e5a3b3",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x16016f2865cfb95869b60c621110d339532163f8",
            "BGV6vetikSSHeYBOTLKRArxJi/PXD5QUrKquUk3Js7nWAWnM1S+9yT/KYatko3bTNgI0IDFAoyE8ihSaWD/7nrc=",
            "Muan/QnBjcdz37mZ5W57Jc26D5N1/7D/VsZbx/jlo7M=",
        ),
    ),
    # vanity/0x16116
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x16116d7d13beb478e745a182ac043490538fd330",
            "0x2b698b53a64d3a147d7dfac7d7edf4e6364d0908724c1db0e0acdaeb840035eaf6e46d035085949314500b5d594730f8efa410b080df66bfc1188e9b5e8fcd44",
            "5a05286b4acf6e3d67326b5b79ea9d60840a3974de7e463322ca7c36a4def6e5",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x16116d7d13beb478e745a182ac043490538fd330",
            "BCtpi1OmTToUfX36x9ft9OY2TQkIckwdsOCs2uuEADXq9uRtA1CFlJMUUAtdWUcw+O+kELCA32a/wRiOm16PzUQ=",
            "WgUoa0rPbj1nMmtbeeqdYIQKOXTefkYzIsp8NqTe9uU=",
        ),
    ),
    # vanity/0x16216
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x16216957043af38c38fe3e34f4b58e4c7c5a47de",
            "0x5b269f4bf2c98856e89f76e4a692e0356e272e221c8ffff7dcc6ea616e21ce8b948e6a2b6c83d3aa6a1bb10373a2624c4ab6bec6e83bcc9d4718210c1152101e",
            "334c174bb2238a7e29d0371790fd3d50576cad697f7b532e034364142870799f",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x16216957043af38c38fe3e34f4b58e4c7c5a47de",
            "BFsmn0vyyYhW6J925KaS4DVuJy4iHI//99zG6mFuIc6LlI5qK2yD06pqG7EDc6JiTEq2vsboO8ydRxghDBFSEB4=",
            "M0wXS7Ijin4p0DcXkP09UFdsrWl/e1MuA0NkFChweZ8=",
        ),
    ),
    # vanity/0x16316
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x16316c80690497f243a3986c5b72db10914e4d9b",
            "0x323004e904549eaa558ed6a40052cc1224cebcef56b9bfe8fd38a6f74ea863e2fb0f984fd6105da5e7c254b1a23672679f315d2dc8fa966392039eeec5ee6de1",
            "4fbb5d13653e86d3c1955d97b360698c443fb7d73ac249f4d10732ce49060b39",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x16316c80690497f243a3986c5b72db10914e4d9b",
            "BDIwBOkEVJ6qVY7WpABSzBIkzrzvVrm/6P04pvdOqGPi+w+YT9YQXaXnwlSxojZyZ58xXS3I+pZjkgOe7sXubeE=",
            "T7tdE2U+htPBlV2Xs2BpjEQ/t9c6wkn00QcyzkkGCzk=",
        ),
    ),
    # vanity/0x16416
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x164161ae6902bfd42f11de4f371ab5bfa2fa38d7",
            "0x9b76fbce2f6719e11432561cac6c3d860368f33fa7835370264029cdafa48cf0d7f41e7241e96715a9913305060a8c6f5004c2bb14ced6ba61078f7defb8be3e",
            "9d568976484e87f45d81f1cc5fe6c592ae75e14dcaca55ec252b62e30b56d529",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x164161ae6902bfd42f11de4f371ab5bfa2fa38d7",
            "BJt2+84vZxnhFDJWHKxsPYYDaPM/p4NTcCZAKc2vpIzw1/QeckHpZxWpkTMFBgqMb1AEwrsUzta6YQePfe+4vj4=",
            "nVaJdkhOh/RdgfHMX+bFkq514U3KylXsJSti4wtW1Sk=",
        ),
    ),
    # vanity/0x16516
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x165163732807f590184cc85832c3f990fa4cfcab",
            "0xf01a3078fd773b96e51ab7da76e1dc9380db2141e5dd8e4567dafad231ebfbd53278914dbcc47b2b8b84d722aacfc5ec553b2d28b3be360b182546ca0cac00d9",
            "2c1a52721282dbbab113743fa6b2885df9ab6c639d4977de04aec30400615fb1",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x165163732807f590184cc85832c3f990fa4cfcab",
            "BPAaMHj9dzuW5Rq32nbh3JOA2yFB5d2ORWfa+tIx6/vVMniRTbzEeyuLhNciqs/F7FU7LSizvjYLGCVGygysANk=",
            "LBpSchKC27qxE3Q/prKIXfmrbGOdSXfeBK7DBABhX7E=",
        ),
    ),
    # vanity/0x16616
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x1661624b9aef8b9c720f8e56fc172befa6b60d4c",
            "0xf97fb800f1a8a4c6aa657408cf95c36468e65f169bca6e2d3b856ca30d691979328ca450b4080320340b4192e8ecd326a4083d9f3598d00992e14d136291bb7e",
            "1d8e7b57adc4b23cd2215c0aedb2d122d5e86e4c8f4931ca261ab111ba3e0e6a",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x1661624b9aef8b9c720f8e56fc172befa6b60d4c",
            "BPl/uADxqKTGqmV0CM+Vw2Ro5l8Wm8puLTuFbKMNaRl5MoykULQIAyA0C0GS6OzTJqQIPZ81mNAJkuFNE2KRu34=",
            "HY57V63EsjzSIVwK7bLRItXobkyPSTHKJhqxEbo+Dmo=",
        ),
    ),
    # vanity/0x16716
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x16716134302e61edaf552d63b03c43f43a057e46",
            "0x7abc6fb75e9631de59d5026a9283080988fa18f3033b79007b7ce7c2100165f27c8c5e2961c196f48d956b422b740d0d67ce262de7aa6240da7a2f68f483f59a",
            "5a1a95ce5b81b7554e11bd9ddcfc392eee403c497b6f630c2bc54236c54bf01b",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x16716134302e61edaf552d63b03c43f43a057e46",
            "BHq8b7deljHeWdUCapKDCAmI+hjzAzt5AHt858IQAWXyfIxeKWHBlvSNlWtCK3QNDWfOJi3nqmJA2novaPSD9Zo=",
            "WhqVzluBt1VOEb2d3Pw5Lu5APEl7b2MMK8VCNsVL8Bs=",
        ),
    ),
    # vanity/0x16816
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x16816fce9dcf8a9f0c964e3990c19c5b6b30961f",
            "0xe190f04219428bc4e4b4762b106783ec65443eaad02be009b20ed5cf463ace7b3e08b71b8dd2d50c8844cb6c79c7140ae951753fb76946c474cb0fb1a12f441f",
            "e33c91dad05def50bef70c0ae94cfebfdb889a30080b6d48a3812acc1122bc1b",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x16816fce9dcf8a9f0c964e3990c19c5b6b30961f",
            "BOGQ8EIZQovE5LR2KxBng+xlRD6q0CvgCbIO1c9GOs57Pgi3G43S1QyIRMtseccUCulRdT+3aUbEdMsPsaEvRB8=",
            "4zyR2tBd71C+9wwK6Uz+v9uImjAIC21Io4EqzBEivBs=",
        ),
    ),
    # vanity/0x16916
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x16916197693d9642954ece1d3d81a238366f6013",
            "0xb8a84d760a6aad6eafd0fc3d1cf5ff9cf4296fcee71055275f48267c27b3f0b3ae5d5690fdce71236374c930f2927431bd9792d374de37702490e65cafe3dd89",
            "9f83cf1ba8962accf718375187e1aa8dbc958e8b3d2f4b460aa51dbcf08a4de8",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x16916197693d9642954ece1d3d81a238366f6013",
            "BLioTXYKaq1ur9D8PRz1/5z0KW/O5xBVJ19IJnwns/Czrl1WkP3OcSNjdMkw8pJ0Mb2XktN03jdwJJDmXK/j3Yk=",
            "n4PPG6iWKsz3GDdRh+GqjbyVjos9L0tGCqUdvPCKTeg=",
        ),
    ),
    # vanity/0x17017
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x17017f103f7a7d40ef6f61cec92a20c6181ddf0c",
            "0x32aff97b843ab4d917c27068bb565bc8da8d54258e497c8cbaeefec8dbd2c0c3f465accefd53072cb69a972c951f9e5dd932f6f07d240ef782d22d4ac7b98ece",
            "fa5b2cd233e3b2f116a6340b9e13e8ebee5678aee6a29072ef356f6cfe125a60",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x17017f103f7a7d40ef6f61cec92a20c6181ddf0c",
            "BDKv+XuEOrTZF8JwaLtWW8jajVQljkl8jLru/sjb0sDD9GWszv1TByy2mpcslR+eXdky9vB9JA73gtItSse5js4=",
            "+lss0jPjsvEWpjQLnhPo6+5WeK7mopBy7zVvbP4SWmA=",
        ),
    ),
    # vanity/0x17117
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x171178d558b0471ac4742b1100e95c0f6a086e4c",
            "0xffb979568a98732267847a8511f8eaeea32d0348029f1540349cd53991b52532370118583821b94689bac07001481d94b5b51f9501a363e3f3f28ed42d3294e8",
            "e851df8f8174004ebec630d491bf02795f81c6f32f7755d2003715593b0da02b",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x171178d558b0471ac4742b1100e95c0f6a086e4c",
            "BP+5eVaKmHMiZ4R6hRH46u6jLQNIAp8VQDSc1TmRtSUyNwEYWDghuUaJusBwAUgdlLW1H5UBo2Pj8/KO1C0ylOg=",
            "6FHfj4F0AE6+xjDUkb8CeV+BxvMvd1XSADcVWTsNoCs=",
        ),
    ),
    # vanity/0x17217
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x172173435bc55e11af3c4d47020c4e144ae8b331",
            "0xe2097791772e198e60f547bb7d612eb4fb0893a79310c59c8a04b3a69f6a91033cfc475ee869e2e300f29db76b029c46ba12f601145e302e4e7caa5fbdb173ff",
            "c35616acc6cad5b942e2788c85a806e5dcbbe43b12db8241c949105bb79c6436",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x172173435bc55e11af3c4d47020c4e144ae8b331",
            "BOIJd5F3LhmOYPVHu31hLrT7CJOnkxDFnIoEs6afapEDPPxHXuhp4uMA8p23awKcRroS9gEUXjAuTnyqX72xc/8=",
            "w1YWrMbK1blC4niMhagG5dy75DsS24JByUkQW7ecZDY=",
        ),
    ),
    # vanity/0x17317
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x17317e66830b03a43ae1df6a527a9b9e39395c36",
            "0x435cb4ef589ee7f87515d0b08102ff5a4e85c536da994a4f58ada4ee6242ca2fafe122a011e2d15092b6cd93b9216b4a096891c21094872cddce471b6c0a4153",
            "bdef0dbbc87cecb463599de7e65b89710f382081cbf95f2852cd88df4afd41f5",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x17317e66830b03a43ae1df6a527a9b9e39395c36",
            "BENctO9Ynuf4dRXQsIEC/1pOhcU22plKT1itpO5iQsovr+EioBHi0VCSts2TuSFrSglokcIQlIcs3c5HG2wKQVM=",
            "ve8Nu8h87LRjWZ3n5luJcQ84IIHL+V8oUs2I30r9QfU=",
        ),
    ),
    # vanity/0x17417
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x17417d3dd8e7bee0c4a72bc7112b2f06e3040758",
            "0x1138b7b9f667f68956da2456834ca67c93dfaf3d661c55b174f82a5b1e98d4baea81c799fb6f208871f10f625ea542d4111026818bee4e43599fdb636f621596",
            "5d74c67d605b8c81099e15f1d4fae92aed69e95aeb3a85620c9e2de9f511699e",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x17417d3dd8e7bee0c4a72bc7112b2f06e3040758",
            "BBE4t7n2Z/aJVtokVoNMpnyT3689ZhxVsXT4KlsemNS66oHHmftvIIhx8Q9iXqVC1BEQJoGL7k5DWZ/bY29iFZY=",
            "XXTGfWBbjIEJnhXx1PrpKu1p6VrrOoViDJ4t6fURaZ4=",
        ),
    ),
    # vanity/0x17517
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x175174a59fb0bbba8e8bde558c672acd3cb89ee5",
            "0xb76a6b301e01325db26615c0524e8758084624a84b54bcac62165f2e2c3a9554d12c5b01c65abda094acee3dc8ceafe8116f64c5847f72845225a08265a398a6",
            "5fa09963addfd158a6392ab3edf36b07fd5486ad0533dfe1478297da91cb656e",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x175174a59fb0bbba8e8bde558c672acd3cb89ee5",
            "BLdqazAeATJdsmYVwFJOh1gIRiSoS1S8rGIWXy4sOpVU0SxbAcZavaCUrO49yM6v6BFvZMWEf3KEUiWggmWjmKY=",
            "X6CZY63f0VimOSqz7fNrB/1Uhq0FM9/hR4KX2pHLZW4=",
        ),
    ),
    # vanity/0x17617
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x17617ad17acb903ffcb385e36485cc09b3979b21",
            "0xecda4cd95540b355df2f47c48bc757694538d978d4144bf8379ef47a86f5f95feef69df2dbb83d0342acf81bcb62a484a7cf74dcca14608be70b3b0bc6ac6979",
            "1d4a4cea79deab020372255d326d196385219401a8c40374954af6533397a9f5",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x17617ad17acb903ffcb385e36485cc09b3979b21",
            "BOzaTNlVQLNV3y9HxIvHV2lFONl41BRL+Dee9HqG9flf7vad8tu4PQNCrPgby2KkhKfPdNzKFGCL5ws7C8asaXk=",
            "HUpM6nneqwIDciVdMm0ZY4UhlAGoxAN0lUr2UzOXqfU=",
        ),
    ),
    # vanity/0x17717
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x17717ba292587e762e750845b0af458a025e3bee",
            "0x50636237ca2c777e13ea4f2d50108fca8345334c197db653c17625be3872bf80409a995775c201b9bdc1a6d02c4818996b70e6f0805a03325c910406ffe4b974",
            "fbdfd427656b91187439069cd815d23e9ca721815c1c9ce3a7b4e6d77f2cbaf5",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x17717ba292587e762e750845b0af458a025e3bee",
            "BFBjYjfKLHd+E+pPLVAQj8qDRTNMGX22U8F2Jb44cr+AQJqZV3XCAbm9wabQLEgYmWtw5vCAWgMyXJEEBv/kuXQ=",
            "+9/UJ2VrkRh0OQac2BXSPpynIYFcHJzjp7Tm138suvU=",
        ),
    ),
    # vanity/0x17817
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x178177db9ffb77b4c2f0be31a224fbd468435b6e",
            "0x032058542f70fe29d3ccb83144d136350683a16eec11dca61e8bd0e5e537ac28f05316f2af5f79cc0c6a4c03177bfd383f538f11deb5c0d4e7b3cc05df56f659",
            "fe83576953567b1bcec172eab452dcee009e6cc4bfb25220e6f369f6e3094e73",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x178177db9ffb77b4c2f0be31a224fbd468435b6e",
            "BAMgWFQvcP4p08y4MUTRNjUGg6Fu7BHcph6L0OXlN6wo8FMW8q9fecwMakwDF3v9OD9TjxHetcDU57PMBd9W9lk=",
            "/oNXaVNWexvOwXLqtFLc7gCebMS/slIg5vNp9uMJTnM=",
        ),
    ),
    # vanity/0x17917
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x17917ae2aa215e79794847a291a24ed469546f1e",
            "0xb26555105b3d0a98700815658350821ceccf8080feca5d743ae418a647c90cf45f648630e5dbf72e445a42561080d1956fdeb96cc4b9ea4101c7b8d0144a4134",
            "f866a4cc7bef3975d37a03afb5dcb7cb7cf51569908bf3197d179e4d91a13af6",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x17917ae2aa215e79794847a291a24ed469546f1e",
            "BLJlVRBbPQqYcAgVZYNQghzsz4CA/spddDrkGKZHyQz0X2SGMOXb9y5EWkJWEIDRlW/euWzEuepBAce40BRKQTQ=",
            "+GakzHvvOXXTegOvtdy3y3z1FWmQi/MZfReeTZGhOvY=",
        ),
    ),
    # vanity/0x18018
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x1801823c085f21f35ecb42870a3ccc72918058ad",
            "0x7d96826a8907fdc0ee5d9256744210346b7818f21344be98077e4ef100cac489961d42406fae452e014db4374b1581feecefee8acc695fbc68372a24b6e7e1cb",
            "a45ba10f8821168dff7b14aa167bfbf7fc4ecb207e76e8e448b8640f9c0380bd",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x1801823c085f21f35ecb42870a3ccc72918058ad",
            "BH2WgmqJB/3A7l2SVnRCEDRreBjyE0S+mAd+TvEAysSJlh1CQG+uRS4BTbQ3SxWB/uzv7orMaV+8aDcqJLbn4cs=",
            "pFuhD4ghFo3/exSqFnv79/xOyyB+dujkSLhkD5wDgL0=",
        ),
    ),
    # vanity/0x18118
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x181180c3f9314ed47a43479369c2c0dea0653486",
            "0x6b7dabb2d40ba9bcbcc56f324329dcf7867a9e6f241dc66642d76617da00d3265eadd2802920c03be9b32c5dd2fef4a74c047845d2c85b16a0c8ada5f2b62085",
            "1e009a6d00037990a84ae6f6b1e470e3c23b3fe953545b594bd2b7458ecca706",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x181180c3f9314ed47a43479369c2c0dea0653486",
            "BGt9q7LUC6m8vMVvMkMp3PeGep5vJB3GZkLXZhfaANMmXq3SgCkgwDvpsyxd0v70p0wEeEXSyFsWoMitpfK2IIU=",
            "HgCabQADeZCoSub2seRw48I7P+lTVFtZS9K3RY7MpwY=",
        ),
    ),
    # vanity/0x18218
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x182182893d4fd7326319b3f5ed81b5e51f2f8b8a",
            "0x48e697e399821aa740e9c1067c88672d12edf280c5e8e8b432be8ca5b2f61bc4effe44cfb173c7d8096b1f9c8183a232b803288b09bbff9f636099307f866a11",
            "14a2b02888baf2414caba8f52b946717f1f0bdc03e8ac45a178e00c8132a9f0f",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x182182893d4fd7326319b3f5ed81b5e51f2f8b8a",
            "BEjml+OZghqnQOnBBnyIZy0S7fKAxejotDK+jKWy9hvE7/5Ez7Fzx9gJax+cgYOiMrgDKIsJu/+fY2CZMH+GahE=",
            "FKKwKIi68kFMq6j1K5RnF/HwvcA+isRaF44AyBMqnw8=",
        ),
    ),
    # vanity/0x18318
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x183189d0c067c348a897482800ad16721e6e65d4",
            "0xef3771aef3b5227966312217fe5b8a4290508a409e7b042d5cdbd293bad06ceb50faeda8d611aa206abea024191b176fc223bc37be2b08bc76e6665c4cb048f5",
            "2b7be019e225b19e173c0871ead3198f97c2846e06b4f1772d1b158be27529c3",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x183189d0c067c348a897482800ad16721e6e65d4",
            "BO83ca7ztSJ5ZjEiF/5bikKQUIpAnnsELVzb0pO60GzrUPrtqNYRqiBqvqAkGRsXb8IjvDe+Kwi8duZmXEywSPU=",
            "K3vgGeIlsZ4XPAhx6tMZj5fChG4GtPF3LRsVi+J1KcM=",
        ),
    ),
    # vanity/0x18418
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x1841871d1c2906b97aaeaf5397201e18d6fe9c1b",
            "0xcee65ea697a90b6cb5bfbee32ec9913ae826340feaba7d1c91f8f923cef0c835cddfdfe6ad346ff850898812163bcbfae22fc6a36f96bf39d815344120448d5c",
            "0a75287bc8f132ae4128c37024421467da02fcd4dc3f98fb158799a88f6dabb3",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x1841871d1c2906b97aaeaf5397201e18d6fe9c1b",
            "BM7mXqaXqQtstb++4y7JkTroJjQP6rp9HJH4+SPO8Mg1zd/f5q00b/hQiYgSFjvL+uIvxqNvlr852BU0QSBEjVw=",
            "CnUoe8jxMq5BKMNwJEIUZ9oC/NTcP5j7FYeZqI9tq7M=",
        ),
    ),
    # vanity/0x18518
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x1851865ca0390044eb876d1ff981e15c854f9795",
            "0x2b031c0ad39144a18d343945c4eac273c3f81d808da321b562f03ebe95ea26bd77eeff559a0185aef864e62a0d6b4e9f7cfd005cb61937f4deb856d114622323",
            "83f72c481ab84757f52a2a70ef8ea608f9fd29252f298a97bcfc50403de4647e",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x1851865ca0390044eb876d1ff981e15c854f9795",
            "BCsDHArTkUShjTQ5RcTqwnPD+B2AjaMhtWLwPr6V6ia9d+7/VZoBha74ZOYqDWtOn3z9AFy2GTf03rhW0RRiIyM=",
            "g/csSBq4R1f1Kipw746mCPn9KSUvKYqXvPxQQD3kZH4=",
        ),
    ),
    # vanity/0x18618
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x186183e157bc1b4edec3828edd07710af25f5870",
            "0xde50c300b10e5188f56bcc8355341ce253747c0d749ccd288693dfa6888e76e3c0c4d8a87328f6d3a224150900e561335c4fad24a31e84d4a53e9278c5a27e41",
            "9c1e363e50f22027491246b2f3907f0a74c9904fb93a6cb4aba04de216f4bb61",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x186183e157bc1b4edec3828edd07710af25f5870",
            "BN5QwwCxDlGI9WvMg1U0HOJTdHwNdJzNKIaT36aIjnbjwMTYqHMo9tOiJBUJAOVhM1xPrSSjHoTUpT6SeMWifkE=",
            "nB42PlDyICdJEkay85B/CnTJkE+5Omy0q6BN4hb0u2E=",
        ),
    ),
    # vanity/0x18718
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x18718b390958583db7b63cc058b94ce8612b5b12",
            "0xcd1cb867f7d658886c316c7b207a9d64d9d2880e14d4341e4bcf229ff8721334ca6e720f1efaa48d1852c02cc4fc15cbe49d2c7d8c62c5ff2f846c5f9d530b2f",
            "2a40f34f6a4f29d7161a87a716e1d4a3c329e7710076f4e6de56ba2997068ecd",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x18718b390958583db7b63cc058b94ce8612b5b12",
            "BM0cuGf31liIbDFseyB6nWTZ0ogOFNQ0HkvPIp/4chM0ym5yDx76pI0YUsAsxPwVy+SdLH2MYsX/L4RsX51TCy8=",
            "KkDzT2pPKdcWGoenFuHUo8Mp53EAdvTm3la6KZcGjs0=",
        ),
    ),
    # vanity/0x18818
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x188187e961c094af49a9736811b97bbf91c673b2",
            "0xa774db2f81829acd54402394193fc40943316b1a96b59b044fda3aa2fc8bbb5ea8630b0fd3859fcf275c28ac70d75f2a065e8aa90ab2b24ddd9e66645b4a7f99",
            "284ba5d0cc5ee0c756ed3d126e21ee48e7bedb340562d9f9e5b050f74150c454",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x188187e961c094af49a9736811b97bbf91c673b2",
            "BKd02y+BgprNVEAjlBk/xAlDMWsalrWbBE/aOqL8i7teqGMLD9OFn88nXCiscNdfKgZeiqkKsrJN3Z5mZFtKf5k=",
            "KEul0Mxe4MdW7T0SbiHuSOe+2zQFYtn55bBQ90FQxFQ=",
        ),
    ),
    # vanity/0x18918
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x18918b6584f3a065a543ab64a2b7e4dc8fa31c44",
            "0xb35dd4bb22ccab626b5b5cbe9603ebe8fd41a5d01b43eb2e4b8ffda9664c46c69d996a0988826a57395efed5ac0ae72745245287c4dba0c62e8639cf9a1764f1",
            "e349d4a6c9d4769b58b20b33a34db1b84f6c13ba5846a8bc360f2a6c704db67b",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x18918b6584f3a065a543ab64a2b7e4dc8fa31c44",
            "BLNd1LsizKtia1tcvpYD6+j9QaXQG0PrLkuP/almTEbGnZlqCYiCalc5Xv7VrArnJ0UkUofE26DGLoY5z5oXZPE=",
            "40nUpsnUdptYsgszo02xuE9sE7pYRqi8Ng8qbHBNtns=",
        ),
    ),
    # vanity/0x19019
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x19019bb18fb5d2ac8b2b7fb0f67357efb8f7ba3f",
            "0x63053f1441b8d58bf4675684efacd7748e07b022c7c51d0815d6a3246271e0fd8f2b10d3cae46cc6df880d5375ca32c62614bf89a7147d2f8a086c37fa884881",
            "3ba37d4abce1e07be22fb226274d71ff80ee00e28e0e70dbb99a03cdd91f2ecc",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x19019bb18fb5d2ac8b2b7fb0f67357efb8f7ba3f",
            "BGMFPxRBuNWL9GdWhO+s13SOB7Aix8UdCBXWoyRiceD9jysQ08rkbMbfiA1TdcoyxiYUv4mnFH0vighsN/qISIE=",
            "O6N9Srzh4HviL7ImJ01x/4DuAOKODnDbuZoDzdkfLsw=",
        ),
    ),
    # vanity/0x19119
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x191198ad9e8a79fbc5885ec9595404299f5a2fbf",
            "0x5b82327a6d11a74947015d1820ccef78badca78b419e82ca41d6254bb79d88bf306f4e917edc59a3164f2573d3a345e79c09bdb0529255dc9dc3551459da860e",
            "deef8178b3ad8fb6c194fcce9004ab2b781db427c9c3aa450b996daf43242d84",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x191198ad9e8a79fbc5885ec9595404299f5a2fbf",
            "BFuCMnptEadJRwFdGCDM73i63KeLQZ6CykHWJUu3nYi/MG9OkX7cWaMWTyVz06NF55wJvbBSklXcncNVFFnahg4=",
            "3u+BeLOtj7bBlPzOkASrK3gdtCfJw6pFC5ltr0MkLYQ=",
        ),
    ),
    # vanity/0x19219
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x19219aad3f2a5ffa0b9ecd0e6370b2c968650552",
            "0x02f7439ccb997e48bbdb446100798fd5bdb633fe8238f58994cf826088cbf27a084979456223796be86e760d1adfa1606fc7f95077c56d0aff16215217644718",
            "bbe6a678fa5946f571e77bb7da4e7d994871e1c184c24f00e5a8108631710da2",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x19219aad3f2a5ffa0b9ecd0e6370b2c968650552",
            "BAL3Q5zLmX5Iu9tEYQB5j9W9tjP+gjj1iZTPgmCIy/J6CEl5RWIjeWvobnYNGt+hYG/H+VB3xW0K/xYhUhdkRxg=",
            "u+amePpZRvVx53u32k59mUhx4cGEwk8A5agQhjFxDaI=",
        ),
    ),
    # vanity/0x19319
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x1931945acca2e884d8da037ee3932ffb4ec511e1",
            "0x5b3a67823bd198e52766f99aef39ee78b210f5a033345c2c063612979b331d409f19120083b093d6f44bacc7a934ac01c99c761cd18b9d7770843dcfd80c4ce9",
            "f66204fb417d546c9f4cf2ad50e55613eabc3a12d37382b4cf34e1ff9e961f8c",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x1931945acca2e884d8da037ee3932ffb4ec511e1",
            "BFs6Z4I70ZjlJ2b5mu857niyEPWgMzRcLAY2EpebMx1AnxkSAIOwk9b0S6zHqTSsAcmcdhzRi513cIQ9z9gMTOk=",
            "9mIE+0F9VGyfTPKtUOVWE+q8OhLTc4K0zzTh/56WH4w=",
        ),
    ),
    # vanity/0x19419
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x1941938335b981c801da31b7844f553febc7b982",
            "0xb23c2ba80c39cf7b42cbdb798cb64fc9dfa2f4de29626758e26b474ecd6b4e59d2102392659a427c3d0271ce744a98a5335561e0786c30035b822adb83533a83",
            "c6b3df87120c62db56601ca7726c26091c24afb8b4a91a4ecb3768ba18fe7495",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x1941938335b981c801da31b7844f553febc7b982",
            "BLI8K6gMOc97QsvbeYy2T8nfovTeKWJnWOJrR07Na05Z0hAjkmWaQnw9AnHOdEqYpTNVYeB4bDADW4Iq24NTOoM=",
            "xrPfhxIMYttWYByncmwmCRwkr7i0qRpOyzdouhj+dJU=",
        ),
    ),
    # vanity/0x19519
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x19519f038893fd0228fc30d18dafe98f986fe047",
            "0x76b8ace8d26b8740e152d77f895d6f233175205cae0c8dd9713f62b24c2ae8e93c18b69ed3e1b6aa5064879772ae8df5fbfd8c601d0ed4b5e7fd0d191bc38400",
            "9555237769f8e756f481f36f3eb6ea5dfa658191a31672601f8eb53eba0b1ce2",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x19519f038893fd0228fc30d18dafe98f986fe047",
            "BHa4rOjSa4dA4VLXf4ldbyMxdSBcrgyN2XE/YrJMKujpPBi2ntPhtqpQZIeXcq6N9fv9jGAdDtS15/0NGRvDhAA=",
            "lVUjd2n451b0gfNvPrbqXfplgZGjFnJgH461ProLHOI=",
        ),
    ),
    # vanity/0x19619
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x19619e3584e6eae33e9b8abbe436676d143b9356",
            "0x5edaaf58fde4159d870e2bf37c705d4eece00621e6ddf4a32555fc215c0296b01d1a1bcc789e67279f169da5f902d07e258e9ccf0bfa7b951a5af06ac20c7012",
            "66b0b938cc929cc8ca34327d87e027c5314de70e1bb17481c55834e4fe8279cd",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x19619e3584e6eae33e9b8abbe436676d143b9356",
            "BF7ar1j95BWdhw4r83xwXU7s4AYh5t30oyVV/CFcApawHRobzHieZyefFp2l+QLQfiWOnM8L+nuVGlrwasIMcBI=",
            "ZrC5OMySnMjKNDJ9h+AnxTFN5w4bsXSBxVg05P6Cec0=",
        ),
    ),
    # vanity/0x19719
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x19719efa88d4370c1b2d9658011aca43be0800aa",
            "0x0d49b541bd7382ded7a724638aba03c054929b7c468cde90beec54e9c244a121616346919c23f9a6c6ae7c109e734458461c985177645ce78c4297b5b331cb88",
            "a5585897db8a0ccf799b2044e7da857e639a7c693affcc25749a33c53bd9d9a6",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x19719efa88d4370c1b2d9658011aca43be0800aa",
            "BA1JtUG9c4Le16ckY4q6A8BUkpt8RozekL7sVOnCRKEhYWNGkZwj+abGrnwQnnNEWEYcmFF3ZFznjEKXtbMxy4g=",
            "pVhYl9uKDM95myBE59qFfmOafGk6/8wldJozxTvZ2aY=",
        ),
    ),
    # vanity/0x19819
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x19819ab20e5b594a64985795b8267096c07cacd2",
            "0xefdae8c0b3cb243fcc044e21adb39fac689117f1d38dc00a9e3a197e7fa6d83e70f91dad22390c9a6c2031fc93c4ef819b97462306a227ff5a23bb1a7e2ee390",
            "a7502d08db620202a7ab87626533e255cf224c37b59291fb0236e23cff51865f",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x19819ab20e5b594a64985795b8267096c07cacd2",
            "BO/a6MCzyyQ/zAROIa2zn6xokRfx043ACp46GX5/ptg+cPkdrSI5DJpsIDH8k8TvgZuXRiMGoif/WiO7Gn4u45A=",
            "p1AtCNtiAgKnq4diZTPiVc8iTDe1kpH7AjbiPP9Rhl8=",
        ),
    ),
    # vanity/0x19919
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x19919d69bf4d6278f4a8b52e4722d2467022626f",
            "0xc38c5fe197f401bd8bc05113acc9f610dcc25cbb30d35f39bb4e952c3c530cb4e0237719aa386f6aa76672cda076e5f630bfcab7c9367eac7387516389a74017",
            "70a109f9bd399750aa2590d8e3341ace99bbcd64c44a131f8f1e2d9b2bf17fbc",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x19919d69bf4d6278f4a8b52e4722d2467022626f",
            "BMOMX+GX9AG9i8BRE6zJ9hDcwly7MNNfObtOlSw8Uwy04CN3Gao4b2qnZnLNoHbl9jC/yrfJNn6sc4dRY4mnQBc=",
            "cKEJ+b05l1CqJZDY4zQazpm7zWTEShMfjx4tmyvxf7w=",
        ),
    ),
    # vanity/0x20020
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x200204d46aef723651f91ddec65a873ad1e26199",
            "0xfdac38c443b4f3ae097cc1b11fe7cd4739fbb3b903eeb6c00a533034ed22b7323a8af3693dcd65de6f261f9395a964ac40637cade8503d251bea9cf74700a8d9",
            "313916ef17a137b7b0c542b0a59f4582fc2a992ad85c39ec09fcc4ea3cf3ee4a",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x200204d46aef723651f91ddec65a873ad1e26199",
            "BP2sOMRDtPOuCXzBsR/nzUc5+7O5A+62wApTMDTtIrcyOorzaT3NZd5vJh+TlalkrEBjfK3oUD0lG+qc90cAqNk=",
            "MTkW7xehN7ewxUKwpZ9FgvwqmSrYXDnsCfzE6jzz7ko=",
        ),
    ),
    # vanity/0x20120
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x20120d32631a541736d99b7275243e272d947cee",
            "0xbeed60ea925cd5c43086a3e48c7f454fc47d9f9381bf4c0c116bd803ca9194c99a15bcb35a258aa03e6f37ab5870259dc95ba03d781a7e8a66a94675808ff058",
            "ef0617edff02089c4350b483f9856d8ed2c15ff38b4de33e76c77f5570230a5b",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x20120d32631a541736d99b7275243e272d947cee",
            "BL7tYOqSXNXEMIaj5Ix/RU/EfZ+Tgb9MDBFr2APKkZTJmhW8s1oliqA+bzerWHAlnclboD14Gn6KZqlGdYCP8Fg=",
            "7wYX7f8CCJxDULSD+YVtjtLBX/OLTeM+dsd/VXAjCls=",
        ),
    ),
    # vanity/0x20220
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x20220f32112e1a95b3ae22552284b15225409fe5",
            "0x7d4eb8a89b72747742f2d2e4aea6c4dc59bbc57f58f19595f2240426325dbce3f03958583c22ff3c941bdf53e6554fb88a82ca67d7508e655dead38c7709a867",
            "c4bcdc8964b0706652c7630669833bb50ac0e946487128d4a0475c35576c9d11",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x20220f32112e1a95b3ae22552284b15225409fe5",
            "BH1OuKibcnR3QvLS5K6mxNxZu8V/WPGVlfIkBCYyXbzj8DlYWDwi/zyUG99T5lVPuIqCymfXUI5lXerTjHcJqGc=",
            "xLzciWSwcGZSx2MGaYM7tQrA6UZIcSjUoEdcNVdsnRE=",
        ),
    ),
    # vanity/0x20320
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x20320a10f2932e63f362a3b75a81b4ea434e31e2",
            "0xce792db16ff92fe32f38f5f75a73c7363874e714e6e08464cdc6abab9a2266a024c06e56b50bf75e025ee6a8d8a864b30a8078b4cbd30a4f0ab0a7066ec7d33a",
            "7c735cac49323c8fc60b9d24beb5fff497b3b81ab916fa444b77ea963029435a",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x20320a10f2932e63f362a3b75a81b4ea434e31e2",
            "BM55LbFv+S/jLzj191pzxzY4dOcU5uCEZM3Gq6uaImagJMBuVrUL914CXuao2KhkswqAeLTL0wpPCrCnBm7H0zo=",
            "fHNcrEkyPI/GC50kvrX/9JezuBq5FvpES3fqljApQ1o=",
        ),
    ),
    # vanity/0x20420
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x204201161978f99e990b09869c99ea0f2ecc5ea7",
            "0xe48195b6cda1c77fd7eaf760fe09f321bf7eab087f7f736ecb09f34bfa75b1db5a417b93c2751ecb9122e5e3b82e9c5ff93f181ecfa1bd6a6a541966ea86cdd9",
            "6af4a21cd9d8da60c1b75c79db01fc6ab42b609f8e8f1b20c991885b0ea9eeda",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x204201161978f99e990b09869c99ea0f2ecc5ea7",
            "BOSBlbbNocd/1+r3YP4J8yG/fqsIf39zbssJ80v6dbHbWkF7k8J1HsuRIuXjuC6cX/k/GB7Pob1qalQZZuqGzdk=",
            "avSiHNnY2mDBt1x52wH8arQrYJ+OjxsgyZGIWw6p7to=",
        ),
    ),
    # vanity/0x20520
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x205205a9a9f4fbdd84ba46300ce8c88e90344588",
            "0x963d6454de89aa4a1d0d68bf4f26c77ccdd54992effc11ac030c05dce6e64c751d43040c9c499fba0e4a6579138944b26888941997b39c8bf98b5babab26bdd0",
            "91b45c7cbc69ddc09d3735c9573a67cf94bbd537468f730ad85274f798efa284",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x205205a9a9f4fbdd84ba46300ce8c88e90344588",
            "BJY9ZFTeiapKHQ1ov08mx3zN1UmS7/wRrAMMBdzm5kx1HUMEDJxJn7oOSmV5E4lEsmiIlBmXs5yL+Ytbq6smvdA=",
            "kbRcfLxp3cCdNzXJVzpnz5S71TdGj3MK2FJ095jvooQ=",
        ),
    ),
    # vanity/0x20620
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x2062022d08435b20612425a8d35e407d2e2d5d02",
            "0x76acf5a3ab4d3b8c50f7783adf01bda082d88461ebe95fe7799c865eeb33222192677b5123fed9f3fa5d8bcddddfeeac9c0fedc480f2e8ed103d19db37b0ab17",
            "b80313bb6cabde96954d646e7f3039f55b06c2e3a9a68eb0d334ece635cbda14",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x2062022d08435b20612425a8d35e407d2e2d5d02",
            "BHas9aOrTTuMUPd4Ot8BvaCC2IRh6+lf53mchl7rMyIhkmd7USP+2fP6XYvN3d/urJwP7cSA8ujtED0Z2zewqxc=",
            "uAMTu2yr3paVTWRufzA59VsGwuOppo6w0zTs5jXL2hQ=",
        ),
    ),
    # vanity/0x20720
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x20720c0b66bcd54b1ff30c873ee1595e79fe2e05",
            "0x9f7fbfc017b0a059f18d2b977f4b30420badfe63b5ad917b2498cef10ac0b6f0d09e07e534e6ba4fdf705602e7b58e10c28773706f69a451581c787235e3d717",
            "853a23720827b9c6c9e28e2f9e15b36a773d5ef8c55cfbe29ddabaa63d7b8030",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x20720c0b66bcd54b1ff30c873ee1595e79fe2e05",
            "BJ9/v8AXsKBZ8Y0rl39LMEILrf5jta2ReySYzvEKwLbw0J4H5TTmuk/fcFYC57WOEMKHc3BvaaRRWBx4cjXj1xc=",
            "hTojcggnucbJ4o4vnhWzanc9XvjFXPvindq6pj17gDA=",
        ),
    ),
    # vanity/0x20820
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x2082079388ed2d731aac88ad17c9c375860ec276",
            "0xb9e64d7f3ffc5bc3e8c2e8bee63f2f28e83d471a540edd06c9bd0d52adcb3931221816180435c1df1ac261d1a168c29f846036dea4f09fae8491b606cdc1123a",
            "b129787713b760d41bdf253fbffd6a56f499661be230a2eadd31b5b240c4c6b2",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x2082079388ed2d731aac88ad17c9c375860ec276",
            "BLnmTX8//FvD6MLovuY/LyjoPUcaVA7dBsm9DVKtyzkxIhgWGAQ1wd8awmHRoWjCn4RgNt6k8J+uhJG2Bs3BEjo=",
            "sSl4dxO3YNQb3yU/v/1qVvSZZhviMKLq3TG1skDExrI=",
        ),
    ),
    # vanity/0x20920
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x20920ec84d6315a3127042b9065bace05d8f360c",
            "0x3dfc131a599e77ec2223ad8b1b8bd1968b9800cd9f7e11791fb7b381bef3f61655fc7049d2c2da8ab776c6c2e761bc71e73b2799bca09c14aa24ea6b2107cf40",
            "3bb11a38f274d6d885fe99deb58a5fea9ada74976b35f6ca6c7a80ac12d994fc",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x20920ec84d6315a3127042b9065bace05d8f360c",
            "BD38ExpZnnfsIiOtixuL0ZaLmADNn34ReR+3s4G+8/YWVfxwSdLC2oq3dsbC52G8cec7J5m8oJwUqiTqayEHz0A=",
            "O7EaOPJ01tiF/pnetYpf6pradJdrNfbKbHqArBLZlPw=",
        ),
    ),
    # vanity/0x21021
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x21021fec3b0cf43d70941583a055a118861e69f2",
            "0x2159aa6830a7ff15b7f7ebaba7f2950f9150947a27f39206ace4808bc5b045814cedb91a928d36106cc36517bdfc840d86677e5580ce7826a6eb4fba58f21387",
            "c305b54f9273a7724cc841b06eea0c5644c4b7d3c7eea51a3ef580c2bcae18b8",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x21021fec3b0cf43d70941583a055a118861e69f2",
            "BCFZqmgwp/8Vt/frq6fylQ+RUJR6J/OSBqzkgIvFsEWBTO25GpKNNhBsw2UXvfyEDYZnflWAzngmputPuljyE4c=",
            "wwW1T5Jzp3JMyEGwbuoMVkTEt9PH7qUaPvWAwryuGLg=",
        ),
    ),
    # vanity/0x21121
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x21121de5deecdb579f2acc741081f536c47bd633",
            "0x9a8e1bc38029ead1f978ee87d4251fcd113a110b1d3765a5bb56c5e31762b61985c6369a4eef691473e58803d12c003ad73ef17f54e9ebace95a8fd3fd3e8b16",
            "b7a5c48baa868a55807a2c277f45bb895ac55aad7ef24372c84a8bb4a3cfd451",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x21121de5deecdb579f2acc741081f536c47bd633",
            "BJqOG8OAKerR+Xjuh9QlH80ROhELHTdlpbtWxeMXYrYZhcY2mk7vaRRz5YgD0SwAOtc+8X9U6eus6VqP0/0+ixY=",
            "t6XEi6qGilWAeiwnf0W7iVrFWq1+8kNyyEqLtKPP1FE=",
        ),
    ),
    # vanity/0x21221
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x212214ee561e296d8a9edf5388819fa19b9b9e19",
            "0xa1cf92ca52f3fff7a4f635cc2f489f7f3f4b6d8b8736929f60432cd9521891a001d9e20c6a50738aa8b3198c2431ad29a335341e857d33c2ce38075cb578cf79",
            "82dbb0d367d429446416596aa974caef123e4f1a1362abc458543bd3e36da60e",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x212214ee561e296d8a9edf5388819fa19b9b9e19",
            "BKHPkspS8//3pPY1zC9In38/S22LhzaSn2BDLNlSGJGgAdniDGpQc4qosxmMJDGtKaM1NB6FfTPCzjgHXLV4z3k=",
            "gtuw02fUKURkFllqqXTK7xI+TxoTYqvEWFQ70+Ntpg4=",
        ),
    ),
    # vanity/0x21321
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x213214361852e96b7ec2afc81d667ccfccda7bb1",
            "0x06a234b01e646278e5e6404dec3439715e2292e4816402e404cb6f505c2cf2c1b33d42ae33fc5922f835039903f436a469ebf462c0aeecee4efafe57c3038e24",
            "14d86b0764d0ec4a9ac6f77a21355109b81d7b89fc19f0409ba5937eca7246da",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x213214361852e96b7ec2afc81d667ccfccda7bb1",
            "BAaiNLAeZGJ45eZATew0OXFeIpLkgWQC5ATLb1BcLPLBsz1CrjP8WSL4NQOZA/Q2pGnr9GLAruzuTvr+V8MDjiQ=",
            "FNhrB2TQ7Eqaxvd6ITVRCbgde4n8GfBAm6WTfspyRto=",
        ),
    ),
    # vanity/0x21421
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x2142186854c33221beef623d353bdb32951e2169",
            "0xe12347b713b56a8f3591ceab8aa1b33586f0b34caaf1a971f48037c34497319fa64d774c20fcb6c8805f8e9b85d59d83854015b442d342b3d1aaf87bf481d264",
            "62b607ef02c96c934eb230292a287d0d2f0332c532ad6496a0c2854434a5d54b",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x2142186854c33221beef623d353bdb32951e2169",
            "BOEjR7cTtWqPNZHOq4qhszWG8LNMqvGpcfSAN8NElzGfpk13TCD8tsiAX46bhdWdg4VAFbRC00Kz0ar4e/SB0mQ=",
            "YrYH7wLJbJNOsjApKih9DS8DMsUyrWSWoMKFRDSl1Us=",
        ),
    ),
    # vanity/0x21521
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x2152188f9e5b0afa0c7db1b4c5c501c93638f6bf",
            "0x351a14e125daa67e53bae70faec92c5fd8e914015d46945c62524f39b67704b4663c2d40c70e574e5494a21a5f08ff7febd3fff2b344be756c1168d62c16267e",
            "30c0db88913f5c76da73d57ef607e45b936854ceb4adebae4522b84c11d8adbd",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x2152188f9e5b0afa0c7db1b4c5c501c93638f6bf",
            "BDUaFOEl2qZ+U7rnD67JLF/Y6RQBXUaUXGJSTzm2dwS0ZjwtQMcOV05UlKIaXwj/f+vT//KzRL51bBFo1iwWJn4=",
            "MMDbiJE/XHbac9V+9gfkW5NoVM60reuuRSK4TBHYrb0=",
        ),
    ),
    # vanity/0x21621
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x216216e157a49a3b943ddc4e86d455936fa4544b",
            "0xc008cefc6df71469fbbeefbe0f899e5e7b5f90f3e60ceda1863b0f877d169f9117e30ee2a1c6274804f77a36033bc97623e432295a561913336505097011ece0",
            "537c22f3952df8ece9d658f3a149e2aa70233b80989faf79a7022dfde7f0e2d6",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x216216e157a49a3b943ddc4e86d455936fa4544b",
            "BMAIzvxt9xRp+77vvg+Jnl57X5Dz5gztoYY7D4d9Fp+RF+MO4qHGJ0gE93o2AzvJdiPkMilaVhkTM2UFCXAR7OA=",
            "U3wi85Ut+Ozp1ljzoUniqnAjO4CYn695pwIt/efw4tY=",
        ),
    ),
    # vanity/0x21721
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x217219cd3f83a344027c9cb3515240ce950fdb58",
            "0xd461cbd42d36fd2b259eb362054d65f4eb00bc8ac3427970c01d71d0988cf65c52159e251f8dd6c252ac9469023cbea0d170cd3ce797309ca0f710d9255dfd68",
            "783ac9d8469d96b5c64aa6b5f28da80fececa7d514c5510b8bf3950a33cbd474",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x217219cd3f83a344027c9cb3515240ce950fdb58",
            "BNRhy9QtNv0rJZ6zYgVNZfTrALyKw0J5cMAdcdCYjPZcUhWeJR+N1sJSrJRpAjy+oNFwzTznlzCcoPcQ2SVd/Wg=",
            "eDrJ2EadlrXGSqa18o2oD+zsp9UUxVELi/OVCjPL1HQ=",
        ),
    ),
    # vanity/0x21821
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x218218ef386e97d8bf1a873cea2bf212232551be",
            "0x02b88d59dfb7078e852319803d1fbdacd4154f841c5c9b5ee615ba09227fbd2cde75b1378924c4bcdba9f5d843d11b87a883eb45c6b535a963fdd1cb8170e9d0",
            "e5d852ea45cf921ce80419347b10d349a9607e0ee65fe0ee35236572986772ec",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x218218ef386e97d8bf1a873cea2bf212232551be",
            "BAK4jVnftweOhSMZgD0fvazUFU+EHFybXuYVugkif70s3nWxN4kkxLzbqfXYQ9Ebh6iD60XGtTWpY/3Ry4Fw6dA=",
            "5dhS6kXPkhzoBBk0exDTSalgfg7mX+DuNSNlcphncuw=",
        ),
    ),
    # vanity/0x21921
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x219218e7e0b731de871e5f2758bb3023bfe28771",
            "0xdd068537e94a13bd7a436fa841def1c9a6c4d26beab43f07b4443d0316dff65fb7fbb21ef1bef83618944fda81d98663960ee55bc2356f177d2c06181e33c71b",
            "52a994ed53698cf571b49bd330182f4211d99dab2133462a3a5c7f6f3a79850e",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x219218e7e0b731de871e5f2758bb3023bfe28771",
            "BN0GhTfpShO9ekNvqEHe8cmmxNJr6rQ/B7REPQMW3/Zft/uyHvG++DYYlE/agdmGY5YO5VvCNW8XfSwGGB4zxxs=",
            "UqmU7VNpjPVxtJvTMBgvQhHZnashM0YqOlx/bzp5hQ4=",
        ),
    ),
    # vanity/0x22022
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x220222abe8648aac5f1855a0e70f643e97eaf81d",
            "0x787aae94d7cbb8370c292a08876f74aaca0331ba2b2c7f471ad75a7c007beab8e818ebeaf16a6a0bd4224b7ddd11d7d09d0f08ce3b82a8b0f7fb0f667f95c3a8",
            "cffab18d33a449e2f02d97f27c8dfd483e0687a8e36790cd20400759f602f339",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x220222abe8648aac5f1855a0e70f643e97eaf81d",
            "BHh6rpTXy7g3DCkqCIdvdKrKAzG6Kyx/RxrXWnwAe+q46Bjr6vFqagvUIkt93RHX0J0PCM47gqiw9/sPZn+Vw6g=",
            "z/qxjTOkSeLwLZfyfI39SD4Gh6jjZ5DNIEAHWfYC8zk=",
        ),
    ),
    # vanity/0x22122
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x2212289318440024e8d47e7d28b6f961b9f1cfa2",
            "0xca4d5984cf711d5ea44778566f4aa13d4e5e4dbcb7f666996917cf0fb577fd14839c76dde95e87094ea0f1ef83c339d4996b0b9f4641cbbcd85eac30c2dceda4",
            "a1935f793e70d43e63ce03c92c47436269e3a6a63086c3b04ba7090363181614",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x2212289318440024e8d47e7d28b6f961b9f1cfa2",
            "BMpNWYTPcR1epEd4Vm9KoT1OXk28t/ZmmWkXzw+1d/0Ug5x23elehwlOoPHvg8M51JlrC59GQcu82F6sMMLc7aQ=",
            "oZNfeT5w1D5jzgPJLEdDYmnjpqYwhsOwS6cJA2MYFhQ=",
        ),
    ),
    # vanity/0x22222
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x222229bad282141f99471357c0161fd7a36526c6",
            "0xb8dc0a964294b936e9171eb7815bc144daa81fb013da58bb1e2d768fe574468fe0039435f8de591fe76108eb9d765bbb5f1046c3c37f6f9cef51ba892bcdc1a2",
            "a3a27feca650b1f1e2403475b33211423e0118a75201cca0771d28572094fcbe",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x222229bad282141f99471357c0161fd7a36526c6",
            "BLjcCpZClLk26Rcet4FbwUTaqB+wE9pYux4tdo/ldEaP4AOUNfjeWR/nYQjrnXZbu18QRsPDf2+c71G6iSvNwaI=",
            "o6J/7KZQsfHiQDR1szIRQj4BGKdSAcygdx0oVyCU/L4=",
        ),
    ),
    # vanity/0x22322
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x2232265d5b5342f30760bf788012c794b76ec123",
            "0x3001f58d10ae3c588e49082a4c021dbb335eef89c6168f77b5d8430973a4a0f2db927e04570f53069a80cd8dabe1e20f311d6e1d948fe30239ccc0aa1f694e9b",
            "e44b24860ce94c7cf363f89c53679ac31c0c1ad3ccab4c503b03a599079ddc02",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x2232265d5b5342f30760bf788012c794b76ec123",
            "BDAB9Y0QrjxYjkkIKkwCHbszXu+JxhaPd7XYQwlzpKDy25J+BFcPUwaagM2Nq+HiDzEdbh2Uj+MCOczAqh9pTps=",
            "5EskhgzpTHzzY/icU2eawxwMGtPMq0xQOwOlmQed3AI=",
        ),
    ),
    # vanity/0x22422
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x22422fd455c409788ba7edd0c98c5fe73896a077",
            "0x32f6554be84b9007abec634b9cd06d47d511fb885735116e18387a47b06db5c6c24f42dea2aa7daae8b963af27154b4c80eefbb0f93cf001086c2ff81719603d",
            "49bdad17054857971f3ede121329699091ac9ac01cc9254f0e188731de68ad4e",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x22422fd455c409788ba7edd0c98c5fe73896a077",
            "BDL2VUvoS5AHq+xjS5zQbUfVEfuIVzURbhg4ekewbbXGwk9C3qKqfarouWOvJxVLTIDu+7D5PPABCGwv+BcZYD0=",
            "Sb2tFwVIV5cfPt4SEylpkJGsmsAcySVPDhiHMd5orU4=",
        ),
    ),
    # vanity/0x22522
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x2252244f4194d059ad7aa30035f269ac866613ac",
            "0x366ddd3ce5f6a26ff25c3c07dd3f116db44c794402d39fadfa222829ebc541ec2039c42b773ddaa8ea62a86aeec1683b8a503140614ac932eda1f83b058d22c9",
            "8b288c3bf2175c923562c69eff38868bc3d69596dc9ee3ec193ba9423561ad35",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x2252244f4194d059ad7aa30035f269ac866613ac",
            "BDZt3Tzl9qJv8lw8B90/EW20THlEAtOfrfoiKCnrxUHsIDnEK3c92qjqYqhq7sFoO4pQMUBhSsky7aH4OwWNIsk=",
            "iyiMO/IXXJI1Ysae/ziGi8PWlZbcnuPsGTupQjVhrTU=",
        ),
    ),
    # vanity/0x22622
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x226221fe807f59b1dc518e1789711b45d8297fd2",
            "0x4113744269058600e25f19256039f45dbc9b4f3fd9c7222223817a2871cbeaf80bb7f7e417cf8ad0166248fdea12a8a492b6355ff6eb67a41ed47cc216560a48",
            "c755e2b0957ff817fecbadf580b5252fe844384e9531c91aea234a4456f603b4",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x226221fe807f59b1dc518e1789711b45d8297fd2",
            "BEETdEJpBYYA4l8ZJWA59F28m08/2cciIiOBeihxy+r4C7f35BfPitAWYkj96hKopJK2NV/262ekHtR8whZWCkg=",
            "x1XisJV/+Bf+y631gLUlL+hEOE6VMcka6iNKRFb2A7Q=",
        ),
    ),
    # vanity/0x22722
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x227228b43c974e63e365116266706934c4024efe",
            "0x246bab5104a674c040f2841eb4eec8b4c8f0128f8e7bab2cfa38f0758f36473828ad48d4d7b1cd309883140cf257ddf5bc7660e516ca06a6a376c210d74837bf",
            "652890ec287e482e8dcb4ca74037e3d6acc1aef65d8c771e4cb7beed0c5f1f1e",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x227228b43c974e63e365116266706934c4024efe",
            "BCRrq1EEpnTAQPKEHrTuyLTI8BKPjnurLPo48HWPNkc4KK1I1NexzTCYgxQM8lfd9bx2YOUWygamo3bCENdIN78=",
            "ZSiQ7Ch+SC6Ny0ynQDfj1qzBrvZdjHceTLe+7QxfHx4=",
        ),
    ),
    # vanity/0x22822
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x228224344d0ab6039f76761df2c358be0624c077",
            "0x004b7921b69bbc14aabfd9389b0a1e52f13cb945bb1f2708a853f9380857deb0769c6968765f1771de602169fa18e941428a6ab04b7cb2cde89219851951e5fb",
            "016d74816a53e5b30a576446b25f3559a1d21944d6f888a4d282d9037b327051",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x228224344d0ab6039f76761df2c358be0624c077",
            "BABLeSG2m7wUqr/ZOJsKHlLxPLlFux8nCKhT+TgIV96wdpxpaHZfF3HeYCFp+hjpQUKKarBLfLLN6JIZhRlR5fs=",
            "AW10gWpT5bMKV2RGsl81WaHSGUTW+Iik0oLZA3sycFE=",
        ),
    ),
    # vanity/0x22922
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x2292272c6e0f2197f07f266b29ee39654f16c91f",
            "0x19ea539d8b9acd0f011de0c1362abc08c78cf7808f5b33b4aada9bc67a2632f9cbb4bf59b31dfbce3047edd3e78b921746cfa63110d5bd1e099ecc47a1bbee9f",
            "5760c39b869941aa6ce67e37b15209acfff1f9a057a2ee313e63f939178a9685",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x2292272c6e0f2197f07f266b29ee39654f16c91f",
            "BBnqU52Lms0PAR3gwTYqvAjHjPeAj1sztKram8Z6JjL5y7S/WbMd+84wR+3T54uSF0bPpjEQ1b0eCZ7MR6G77p8=",
            "V2DDm4aZQaps5n43sVIJrP/x+aBXou4xPmP5OReKloU=",
        ),
    ),
    # vanity/0x23023
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x2302399cda4ef60b095ed1fa95f7078cc7c6caa2",
            "0x61711aadee9cdf8efa1ae150aba3e0d53079d9d6c62b2573bb94a6c4422c6461f864109f17ccec77545d0609b29571946751c11a5b3202e01d8941b38b25fb75",
            "e67438399367f460ae62edc3790803f4c41be987d0dac6ccef4b147a68b97b11",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x2302399cda4ef60b095ed1fa95f7078cc7c6caa2",
            "BGFxGq3unN+O+hrhUKuj4NUwednWxislc7uUpsRCLGRh+GQQnxfM7HdUXQYJspVxlGdRwRpbMgLgHYlBs4sl+3U=",
            "5nQ4OZNn9GCuYu3DeQgD9MQb6YfQ2sbM70sUemi5exE=",
        ),
    ),
    # vanity/0x23123
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x23123d7e7860f9075c9f62c9ae56b0ed6f47b46d",
            "0x95b571dc857975daa749c6146d0adc3e41637d580f68d1e06eb2755182061c4cad17235d8e1f64f54e011776daad07b95a020e5d476a66eefd786afeb1e46762",
            "b9da64799ba5dd46da45b5ac29c820f121a283ffbb400c7802b2d2e57966f4b5",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x23123d7e7860f9075c9f62c9ae56b0ed6f47b46d",
            "BJW1cdyFeXXap0nGFG0K3D5BY31YD2jR4G6ydVGCBhxMrRcjXY4fZPVOARd22q0HuVoCDl1Hambu/Xhq/rHkZ2I=",
            "udpkeZul3UbaRbWsKcgg8SGig/+7QAx4ArLS5Xlm9LU=",
        ),
    ),
    # vanity/0x23223
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x23223d061f5ca829ebb51d853f28c9034dd23afa",
            "0xa2cfbd64550adb395a0631cd5d007f2bb80d242734357403af9874c70f6d276ec93d90519b3b57ccd00f94cd990d3a3163dd180929dd22b7d0d31e270094487e",
            "f382fbb2c07803cbbfee9dc9180d0488a42a8ef2b0e6f4abdb8bc40ddc34a0ac",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x23223d061f5ca829ebb51d853f28c9034dd23afa",
            "BKLPvWRVCts5WgYxzV0Afyu4DSQnNDV0A6+YdMcPbSduyT2QUZs7V8zQD5TNmQ06MWPdGAkp3SK30NMeJwCUSH4=",
            "84L7ssB4A8u/7p3JGA0EiKQqjvKw5vSr24vEDdw0oKw=",
        ),
    ),
    # vanity/0x23323
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x2332351e8499b49b339a7decdacc6dbe24169f62",
            "0x5fc86f27589478d09454ff70e41a2aa102349098b868ba18290c1bf84c81fd883ca60908d318f3ae34fefb795a4962cb273bb6c81ed2f48e04701982dde36bc7",
            "b088da1214592919a25d8db200085f995edf8e161066f47981ab7b2bc5e4e2cf",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x2332351e8499b49b339a7decdacc6dbe24169f62",
            "BF/IbydYlHjQlFT/cOQaKqECNJCYuGi6GCkMG/hMgf2IPKYJCNMY8640/vt5Wkliyyc7tsge0vSOBHAZgt3ja8c=",
            "sIjaEhRZKRmiXY2yAAhfmV7fjhYQZvR5gat7K8Xk4s8=",
        ),
    ),
    # vanity/0x23423
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x234232953eb0e5b63a8071e312b92d10d1c7893d",
            "0xa4b3268c05e8a7938657e848c160663c1384af35781e6da25ef88cb71ba079afd5f15dd5663187a402c9ca37c62171d55f0d5ae66c0814e4edd5da315e907742",
            "697a336245673d1f571a47492be04eb3df9a92076caa8033eef4d0f56b249b97",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x234232953eb0e5b63a8071e312b92d10d1c7893d",
            "BKSzJowF6KeThlfoSMFgZjwThK81eB5tol74jLcboHmv1fFd1WYxh6QCyco3xiFx1V8NWuZsCBTk7dXaMV6Qd0I=",
            "aXozYkVnPR9XGkdJK+BOs9+akgdsqoAz7vTQ9Wskm5c=",
        ),
    ),
    # vanity/0x23523
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x23523099d76da2c1493b910a5c9cde8a99a38abd",
            "0x554be6a97f998ef73c373c0a2e846b62459f08252d5663e53404bc6c985865d69da13623122f70c22c5e63e11aaeadb9d49430ab0f88c68a41b1cc08ce9e9ad7",
            "42d0251374575bfc27d45c3b1d2078719542c1f40663e36e8bbb3134b8fa913a",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x23523099d76da2c1493b910a5c9cde8a99a38abd",
            "BFVL5ql/mY73PDc8Ci6Ea2JFnwglLVZj5TQEvGyYWGXWnaE2IxIvcMIsXmPhGq6tudSUMKsPiMaKQbHMCM6emtc=",
            "QtAlE3RXW/wn1Fw7HSB4cZVCwfQGY+Nui7sxNLj6kTo=",
        ),
    ),
    # vanity/0x23623
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x23623f7b43bcbcd4bc02accfa812d8d9a2dd0c38",
            "0x24fcf42932db51d6d1720f6d6496299ae9279c85e55bcde743f1254c1737c18fb48aadd294660e6e604dd5445f49d90067f16b546a0e4a9d57a062278e9e6c49",
            "b23228d16993248ec67c339433e30bb757ff119a14f375d5282892dadf565f34",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x23623f7b43bcbcd4bc02accfa812d8d9a2dd0c38",
            "BCT89Cky21HW0XIPbWSWKZrpJ5yF5VvN50PxJUwXN8GPtIqt0pRmDm5gTdVEX0nZAGfxa1RqDkqdV6BiJ46ebEk=",
            "sjIo0WmTJI7GfDOUM+MLt1f/EZoU83XVKCiS2t9WXzQ=",
        ),
    ),
    # vanity/0x23723
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x23723e8757856e173425ea64ca19a20dcf79743a",
            "0xb98ee03251bdbdd235cebd817d8f1d7565a741d34de580caa4519175293923ffe0368e5156e435b099b4f3726508b0f1b204499b18d45ed9e0b8ef28ef80d353",
            "cad3653882ae144a59725902c943acd2fd5ad931e803b1ec884f548e0a51a4b8",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x23723e8757856e173425ea64ca19a20dcf79743a",
            "BLmO4DJRvb3SNc69gX2PHXVlp0HTTeWAyqRRkXUpOSP/4DaOUVbkNbCZtPNyZQiw8bIESZsY1F7Z4LjvKO+A01M=",
            "ytNlOIKuFEpZclkCyUOs0v1a2THoA7HsiE9UjgpRpLg=",
        ),
    ),
    # vanity/0x23823
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x238233e22c6cc340c5bf5381df18ed03e31fc967",
            "0xe7f57c67172cfc8a6c2103c455bbf2b76f73302c6ce99ae39fdd39b4d5877fec6037011385ac8cd251b70e77dafb00e160268205addf57de29a9fda1d4692d80",
            "fa3bbbf84a38be0e872f03e0bd2ef959a3cce0d2a394479b9afaca587a98941c",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x238233e22c6cc340c5bf5381df18ed03e31fc967",
            "BOf1fGcXLPyKbCEDxFW78rdvczAsbOma45/dObTVh3/sYDcBE4WsjNJRtw532vsA4WAmggWt31feKan9odRpLYA=",
            "+ju7+Eo4vg6HLwPgvS75WaPM4NKjlEebmvrKWHqYlBw=",
        ),
    ),
    # vanity/0x23923
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x239231883f59b709b695f684c251a1c7db112e2d",
            "0xa51906ff76cec0926dbda1655de8e53268f52f88dca8d2346b6a7eab59fd26e3f027741dbbdf858e68815f175417193f02cebf265a16b4e8e9d63668ac1b83aa",
            "4938a47c98bc975aead1d266c8ba77d7028a2ac59ced7f94ea6bd9771ddf7011",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x239231883f59b709b695f684c251a1c7db112e2d",
            "BKUZBv92zsCSbb2hZV3o5TJo9S+I3KjSNGtqfqtZ/Sbj8Cd0HbvfhY5ogV8XVBcZPwLOvyZaFrTo6dY2aKwbg6o=",
            "STikfJi8l1rq0dJmyLp31wKKKsWc7X+U6mvZdx3fcBE=",
        ),
    ),
    # vanity/0x24024
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x24024aa81ddb7c54eb765213c369908ff8f51339",
            "0xe72d43d854b359abe90674a3cadad474957e218e8b7b6ce5f8d540b3076fdaf24f1ebec32405dc20d3f007ad23645bf6d343b7834135b79cf82ffcc66144de2f",
            "ac928953f66e40c290f0f31c8335d99ca00ec75d8e6dd7d6ab2683795d39f212",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x24024aa81ddb7c54eb765213c369908ff8f51339",
            "BOctQ9hUs1mr6QZ0o8ra1HSVfiGOi3ts5fjVQLMHb9ryTx6+wyQF3CDT8AetI2Rb9tNDt4NBNbec+C/8xmFE3i8=",
            "rJKJU/ZuQMKQ8PMcgzXZnKAOx12ObdfWqyaDeV058hI=",
        ),
    ),
    # vanity/0x24124
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x24124e194524971fc8b2186f45474e191cec8b0c",
            "0x819a37b961edbeac2b4f1bff70d3f89c88330c92c18e178d53395f7495a21803fdd1ed312cf6de11178549c4201c29d8100306d8662f9d2f7e971d7c7f5ff3d6",
            "73cf22463534ac83d2897b964adbf23d03ac9c0af57e9d18e4199ec485c647b2",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x24124e194524971fc8b2186f45474e191cec8b0c",
            "BIGaN7lh7b6sK08b/3DT+JyIMwySwY4XjVM5X3SVohgD/dHtMSz23hEXhUnEIBwp2BADBthmL50vfpcdfH9f89Y=",
            "c88iRjU0rIPSiXuWStvyPQOsnAr1fp0Y5BmexIXGR7I=",
        ),
    ),
    # vanity/0x24224
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x24224648b22d3cfb70daddadf5dc3306253b0ec9",
            "0x7ba556d5a11506617f2d36bcf3284a3cbe4f49943cdb1236a3f6ad7f17348562b97587470c6d159ad2b6af2162ea4ba93cd24adcb2af33b7fb4c49f4f5d15df0",
            "f8ce83960b71e94e548735bad157ba744012d0cf6fff48f0b437882ddcf78f88",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x24224648b22d3cfb70daddadf5dc3306253b0ec9",
            "BHulVtWhFQZhfy02vPMoSjy+T0mUPNsSNqP2rX8XNIViuXWHRwxtFZrStq8hYupLqTzSStyyrzO3+0xJ9PXRXfA=",
            "+M6Dlgtx6U5UhzW60Ve6dEAS0M9v/0jwtDeILdz3j4g=",
        ),
    ),
    # vanity/0x24324
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x24324c1ff813975a85a9e9275c3cf3776ce0ee3c",
            "0x824b8dae8f160f76f72f418a6e0f494c825c1a5a2454d6e235efaf5c6001fe05b36beb864a64d6bff76f053a1c703483ea0b9b970ea5532655ef685854ec9ccb",
            "c450eebc2b4c33e1707779a907b8c08f1810ee346be576532d9f9df492b4f234",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x24324c1ff813975a85a9e9275c3cf3776ce0ee3c",
            "BIJLja6PFg929y9Bim4PSUyCXBpaJFTW4jXvr1xgAf4Fs2vrhkpk1r/3bwU6HHA0g+oLm5cOpVMmVe9oWFTsnMs=",
            "xFDuvCtMM+Fwd3mpB7jAjxgQ7jRr5XZTLZ+d9JK08jQ=",
        ),
    ),
    # vanity/0x24424
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x2442482cceb05e9d7136b9a6614b6f8154e99f06",
            "0x603a0da7654edb66da47ff3032d23b707b96cbfe7abaa552e2d9bc75cd5bfc5c877c55f318a42a4ff3df04beca23aff5e32c09dc48be7da78743efe1a8d4eb6f",
            "3075af5f799e7b45a4ff10e3c6bdf8bcc8e720725fdc399410f6e34d47e13814",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x2442482cceb05e9d7136b9a6614b6f8154e99f06",
            "BGA6DadlTttm2kf/MDLSO3B7lsv+erqlUuLZvHXNW/xch3xV8xikKk/z3wS+yiOv9eMsCdxIvn2nh0Pv4ajU628=",
            "MHWvX3mee0Wk/xDjxr34vMjnIHJf3DmUEPbjTUfhOBQ=",
        ),
    ),
    # vanity/0x24524
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x24524b5ad2975840fe86af394f45c7e82e99b048",
            "0xd7f12fcec7f41af4f5f5ca632d918ad5f1ed96db299db4c037816b80d2bafcfdbc574719128d5752a3b8d2da1acdb7a4693e47a2043f6d6a2d2cd0440ca3d42f",
            "a723ecdea8e52d942eb4b91a0eca80d5afef5f4469c96dfdb1bd367f9db9ab70",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x24524b5ad2975840fe86af394f45c7e82e99b048",
            "BNfxL87H9Br09fXKYy2RitXx7ZbbKZ20wDeBa4DSuvz9vFdHGRKNV1KjuNLaGs23pGk+R6IEP21qLSzQRAyj1C8=",
            "pyPs3qjlLZQutLkaDsqA1a/vX0RpyW39sb02f525q3A=",
        ),
    ),
    # vanity/0x24624
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x246249796546659cba9c5f0e1481396e607831df",
            "0xa08e281bdc9f017bff6aa28034503131d0bf12e175b97c7e09d6e48982e75cd32a95293048e489387c5f639e15fb870438040877e5b1554cbab7732b35308e9c",
            "3c321fa2c6bdbb6cd1b6699e02827b08634feee4cafe9612f957c5900d6da0f5",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x246249796546659cba9c5f0e1481396e607831df",
            "BKCOKBvcnwF7/2qigDRQMTHQvxLhdbl8fgnW5ImC51zTKpUpMEjkiTh8X2OeFfuHBDgECHflsVVMurdzKzUwjpw=",
            "PDIfosa9u2zRtmmeAoJ7CGNP7uTK/pYS+VfFkA1toPU=",
        ),
    ),
    # vanity/0x24724
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x247249f7f2a01e4d71cefe44b79ad5b541b5be78",
            "0x007f0f5d225aa14c9243a6fe2086f0426e9995e5741039068bc120e810a46e0f00dbc0896c885dd47f70864ef3d50a0a59a2c93f0461ff36bedbc00d3b4c4642",
            "2930189585a357d48cf2fc1b33b4b6cf5016df925460dbe2ae989ecf3dd2b909",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x247249f7f2a01e4d71cefe44b79ad5b541b5be78",
            "BAB/D10iWqFMkkOm/iCG8EJumZXldBA5BovBIOgQpG4PANvAiWyIXdR/cIZO89UKClmiyT8EYf82vtvADTtMRkI=",
            "KTAYlYWjV9SM8vwbM7S2z1AW35JUYNvirpiezz3SuQk=",
        ),
    ),
    # vanity/0x24824
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x24824776b5069857e2815282a2a168e293c67ae0",
            "0x13e19f52206675dc1d1f286d55de65ee6b2f10c484b445b86e36295fe3730132f71ccef6614632181b4c64866a8cafb83ddadb4a7528224df05fcf802abb13fd",
            "a5b11349b62d5adda5f5538dc243fecdcc68328eefc0b8698477a26967efe50c",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x24824776b5069857e2815282a2a168e293c67ae0",
            "BBPhn1IgZnXcHR8obVXeZe5rLxDEhLRFuG42KV/jcwEy9xzO9mFGMhgbTGSGaoyvuD3a20p1KCJN8F/PgCq7E/0=",
            "pbETSbYtWt2l9VONwkP+zcxoMo7vwLhphHeiaWfv5Qw=",
        ),
    ),
    # vanity/0x24924
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x2492453d702dfc8635a21d5c7beb142d8182a9a7",
            "0x469e4ecaa914486e1ecb3ff4985cc31744b53efa2fd1ba0342a1e5f759daeb5364126e58db4f717cc843fbd156e299cac6dd801879757da3520f3e7ddd52f440",
            "8433f0d1b86c50a5e6e6eb255c06038c7fec2900f84b7590bc7e89ac2d65b018",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x2492453d702dfc8635a21d5c7beb142d8182a9a7",
            "BEaeTsqpFEhuHss/9JhcwxdEtT76L9G6A0Kh5fdZ2utTZBJuWNtPcXzIQ/vRVuKZysbdgBh5dX2jUg8+fd1S9EA=",
            "hDPw0bhsUKXm5uslXAYDjH/sKQD4S3WQvH6JrC1lsBg=",
        ),
    ),
    # vanity/0x25025
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x25025528bcd6f8ec5e7a8ec3c07b38ff8ec25243",
            "0xbb99d6e8a55a2ce830baeed43fa4a3be6096c91fe6e84115b28b36e881d39415a3944c06510077b76bad2c77ea8cbfd056ac45f80c509b5ded0a28322b8cafd9",
            "67bd13bb420d7a4040f5719286f78e62852eb677a7cb6c28dc9aed27ca049fe0",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x25025528bcd6f8ec5e7a8ec3c07b38ff8ec25243",
            "BLuZ1uilWizoMLru1D+ko75glskf5uhBFbKLNuiB05QVo5RMBlEAd7drrSx36oy/0FasRfgMUJtd7QooMiuMr9k=",
            "Z70Tu0INekBA9XGShveOYoUutneny2wo3JrtJ8oEn+A=",
        ),
    ),
    # vanity/0x25125
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x25125af70145cc199666187d7429232ee05b5183",
            "0x763122eea81db052aaea99d73bd2118fd343fc822fb442ab72b46cd1c0cbe9d57598d3e149a85148f0a9d9814c6bdbd5454513d079c22b70df643623ab0d0aa9",
            "5fdaf74cc5c47b2d774fe15bf7fe08d0cf61d587d651be79f0ae6e3798b35772",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x25125af70145cc199666187d7429232ee05b5183",
            "BHYxIu6oHbBSquqZ1zvSEY/TQ/yCL7RCq3K0bNHAy+nVdZjT4UmoUUjwqdmBTGvb1UVFE9B5witw32Q2I6sNCqk=",
            "X9r3TMXEey13T+Fb9/4I0M9h1YfWUb558K5uN5izV3I=",
        ),
    ),
    # vanity/0x25225
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x2522510256c2a4489b3e4e79e5c87f8cc8b75969",
            "0x4bcbf5f4b8c417962c377937582c83b61241a2e839291a8e276a98f24ee24c3477c56c5f867acc0278daab4ae28e8f91d63ef54d2b5167c901d7aa37c6a31693",
            "119a49f76814178d405fd013abc407337691c650957df9dc2b5e2bdff5e5ea5e",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x2522510256c2a4489b3e4e79e5c87f8cc8b75969",
            "BEvL9fS4xBeWLDd5N1gsg7YSQaLoOSkajidqmPJO4kw0d8VsX4Z6zAJ42qtK4o6PkdY+9U0rUWfJAdeqN8ajFpM=",
            "EZpJ92gUF41AX9ATq8QHM3aRxlCVffncK14r3/Xl6l4=",
        ),
    ),
    # vanity/0x25325
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x2532519cea3ced4cf8ec8518204e43919a805f56",
            "0x91690d1fad640b4e33c79bd95da9e5d2bfcf011595a1f40a2161ee09f7eaab6e7be2debb16ff4cb98be87d9bad03b105126325828d815895cd56d7acb9109342",
            "f4c2450073820991f81814e834fcba7f398cfc01641f4286f0f5786f4cd37ccf",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x2532519cea3ced4cf8ec8518204e43919a805f56",
            "BJFpDR+tZAtOM8eb2V2p5dK/zwEVlaH0CiFh7gn36qtue+Leuxb/TLmL6H2brQOxBRJjJYKNgViVzVbXrLkQk0I=",
            "9MJFAHOCCZH4GBToNPy6fzmM/AFkH0KG8PV4b0zTfM8=",
        ),
    ),
    # vanity/0x25425
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x254256ad58423e4aac635f8b412cb7cb453282c4",
            "0xb23cf3088446c8b9427abe1127b4cf3b6cc89d5c9d1092fc468ed76843893453ac8ea86c867025533d73e3a905cfba80113c6d05cf994816d5b6b310623c9667",
            "cbbaa0ac0879daa5241e90f5101f70b5e5aa5aeba3fce691880901246f0b2909",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x254256ad58423e4aac635f8b412cb7cb453282c4",
            "BLI88wiERsi5Qnq+ESe0zztsyJ1cnRCS/EaO12hDiTRTrI6obIZwJVM9c+OpBc+6gBE8bQXPmUgW1bazEGI8lmc=",
            "y7qgrAh52qUkHpD1EB9wteWqWuuj/OaRiAkBJG8LKQk=",
        ),
    ),
    # vanity/0x25525
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x2552558c3d873134f355d41e637ebdbfed3bf3f2",
            "0x6951d13e80b5749e690024c6341022053e41a054209d4cb5d6ac49d10ef7d995f14511c77107fcc072778ae1eb1d744ec788b256b7fe0945e7ae412274752f82",
            "daa0ff2f44655346436609557510b083cdbffa4434fe5ef3817e38e60c55059a",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x2552558c3d873134f355d41e637ebdbfed3bf3f2",
            "BGlR0T6AtXSeaQAkxjQQIgU+QaBUIJ1MtdasSdEO99mV8UURx3EH/MByd4rh6x10TseIsla3/glF565BInR1L4I=",
            "2qD/L0RlU0ZDZglVdRCwg82/+kQ0/l7zgX445gxVBZo=",
        ),
    ),
    # vanity/0x25625
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x25625b712cfba042165438bfd4f7877d39113b07",
            "0xe02b308af0e684009f0970c34d8d37645c607595020e0780d6f7d2731b6858f506284f3fc02feb854ac7913ee073ab10ca0de34b46cc9ab0661641424d912395",
            "cd384c10fa3582408218498675f2f82990e808a794eeaae6290455db91016b67",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x25625b712cfba042165438bfd4f7877d39113b07",
            "BOArMIrw5oQAnwlww02NN2RcYHWVAg4HgNb30nMbaFj1BihPP8Av64VKx5E+4HOrEMoN40tGzJqwZhZBQk2RI5U=",
            "zThMEPo1gkCCGEmGdfL4KZDoCKeU7qrmKQRV25EBa2c=",
        ),
    ),
    # vanity/0x25725
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x2572546783cacab246a4482eee958c91849ec372",
            "0xd0c847cc9984cdf2848e88bd2de8703afa796b924c6cc5769551d9490b808912d2cac0b4da2e01948b602aa184a91434fd1898894740c85a89eb84e238b507e8",
            "0e92213eb514257006d26f7a75b1cda963f5f878228078caf544eb5c4e30f50f",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x2572546783cacab246a4482eee958c91849ec372",
            "BNDIR8yZhM3yhI6IvS3ocDr6eWuSTGzFdpVR2UkLgIkS0srAtNouAZSLYCqhhKkUNP0YmIlHQMhaieuE4ji1B+g=",
            "DpIhPrUUJXAG0m96dbHNqWP1+HgigHjK9UTrXE4w9Q8=",
        ),
    ),
    # vanity/0x25825
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x25825a5287098e3779d47f4d2692586e8184fbd4",
            "0x4b62912edd51c1bd77b6166dba36ce4a9d3035bbaa14551bd6faaad4247fb3a8410b5367c74fad8f61f61bd8c80d2590f39f1f07b7922e57dede1b4aa7804fc0",
            "604b637d6ac14254fb616ac5a1daa504f61025bf2c28bbee74ba46c3c749545a",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x25825a5287098e3779d47f4d2692586e8184fbd4",
            "BEtikS7dUcG9d7YWbbo2zkqdMDW7qhRVG9b6qtQkf7OoQQtTZ8dPrY9h9hvYyA0lkPOfHwe3ki5X3t4bSqeAT8A=",
            "YEtjfWrBQlT7YWrFodqlBPYQJb8sKLvudLpGw8dJVFo=",
        ),
    ),
    # vanity/0x25925
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x259258341dbcd5eab6338965352f7c415a01b3ec",
            "0x990c9a0e32d0ae21c70e40e41cbb9fb8978c3c7acadb5cb19003e3f293e8042fb3ed100a87b5f83e80276f7a7f480207cae4a42c8a23709a92d049bc4921fbec",
            "c334cd32bd8e85b0849cce768765e47021602f3ed1cedaf602aaba79516f6d79",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x259258341dbcd5eab6338965352f7c415a01b3ec",
            "BJkMmg4y0K4hxw5A5By7n7iXjDx6yttcsZAD4/KT6AQvs+0QCoe1+D6AJ296f0gCB8rkpCyKI3CaktBJvEkh++w=",
            "wzTNMr2OhbCEnM52h2XkcCFgLz7Rztr2Aqq6eVFvbXk=",
        ),
    ),
    # vanity/0x26026
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x26026f746c3a55c81e6d84b0c62ad364b7fddbc4",
            "0xda5413ad9749e11fdd55762f6c1e26211bd23bf8824bc933e890b2ceeb2b5c866ad58878e1113a1dd76a3ebf1cc3aa3d92196e993f9cb6aa71a2e4dae584d33f",
            "111a340141d1ebdf3c942dc4630999546a61473d354922f0b954526946bab973",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x26026f746c3a55c81e6d84b0c62ad364b7fddbc4",
            "BNpUE62XSeEf3VV2L2weJiEb0jv4gkvJM+iQss7rK1yGatWIeOEROh3Xaj6/HMOqPZIZbpk/nLaqcaLk2uWE0z8=",
            "ERo0AUHR6988lC3EYwmZVGphRz01SSLwuVRSaUa6uXM=",
        ),
    ),
    # vanity/0x26126
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x26126538fbb9ab82470ae79dc5b12a01c4b1deae",
            "0x96d7b1163b12f8f43e14eecfbe2bda874c5246e28ecb9be5ebfab1aa91e000f8ac5aa30d46405dc88bbd00f697d4d11962fb9784ab856a31332517df386faa96",
            "26f2326c81fafddda243ac91c59e4f61a7640e1dbc8f660434b3bbfc16458a28",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x26126538fbb9ab82470ae79dc5b12a01c4b1deae",
            "BJbXsRY7Evj0PhTuz74r2odMUkbijsub5ev6saqR4AD4rFqjDUZAXciLvQD2l9TRGWL7l4SrhWoxMyUX3zhvqpY=",
            "JvIybIH6/d2iQ6yRxZ5PYadkDh28j2YENLO7/BZFiig=",
        ),
    ),
    # vanity/0x26226
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x26226c6ea294db596d5fa50243251f41c828108a",
            "0x1943e2946640d9fd6255f8ca52640f7caf3416463c31a73b1c6ef7859c63f5138c1be8e9c9fee9a08e4020f09057b3b94b5bde05895573b0d85c601f1d9b50f3",
            "43f3d09c69049992bb7f3a337b56e7ca10f03bf9fc9d942e842ff8a20d5af07c",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x26226c6ea294db596d5fa50243251f41c828108a",
            "BBlD4pRmQNn9YlX4ylJkD3yvNBZGPDGnOxxu94WcY/UTjBvo6cn+6aCOQCDwkFezuUtb3gWJVXOw2FxgHx2bUPM=",
            "Q/PQnGkEmZK7fzoze1bnyhDwO/n8nZQuhC/4og1a8Hw=",
        ),
    ),
    # vanity/0x26326
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x26326e454c9f7e8c5536872154657f35bcfd078c",
            "0x279471c72ded8d5fe854645a873608ec1de7613c2ee413a0935bbb6489d4afcac6723019b08ae68b6c8b7dc85cb0990e17c75ec5a6ca1f205489e092a2b68033",
            "9ff949bedbfafcc542a6dcf9e339249ddaf20905fa9ea90ef9cab3eda8ce181d",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x26326e454c9f7e8c5536872154657f35bcfd078c",
            "BCeUccct7Y1f6FRkWoc2COwd52E8LuQToJNbu2SJ1K/KxnIwGbCK5otsi33IXLCZDhfHXsWmyh8gVIngkqK2gDM=",
            "n/lJvtv6/MVCptz54zkkndryCQX6nqkO+cqz7ajOGB0=",
        ),
    ),
    # vanity/0x26426
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x264263b9424369c4c973635f127c797c936219f4",
            "0x75b66b36580639a113d3b83d427f3bca09832a2e3be4f2842184c4719e9bdf309ab82b3da6e85df09908fceca53f37a520ce9a2a99ddc5806b9f197e0db93bc7",
            "74bae35c381af591b7c0364c81d40b7408b2a42422dd663633ad0631fc12e2e0",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x264263b9424369c4c973635f127c797c936219f4",
            "BHW2azZYBjmhE9O4PUJ/O8oJgyouO+TyhCGExHGem98wmrgrPaboXfCZCPzspT83pSDOmiqZ3cWAa58Zfg25O8c=",
            "dLrjXDga9ZG3wDZMgdQLdAiypCQi3WY2M60GMfwS4uA=",
        ),
    ),
    # vanity/0x26526
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x265269b9386be61b3bf33d740aef22a47e07cb79",
            "0x20c3a9220c0974be4c106bff4912f7ad526ec9ec946b14e5fad418f7329c3763785cbf16d478fb0f69d53390150eff1ca077387154c417696efc760b2c6dcac4",
            "132580af68a72aef69531486a826e56aea42d613b531c6ae96a0f21dbf56cff0",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x265269b9386be61b3bf33d740aef22a47e07cb79",
            "BCDDqSIMCXS+TBBr/0kS961SbsnslGsU5frUGPcynDdjeFy/FtR4+w9p1TOQFQ7/HKB3OHFUxBdpbvx2CyxtysQ=",
            "EyWAr2inKu9pUxSGqCblaupC1hO1McaulqDyHb9Wz/A=",
        ),
    ),
    # vanity/0x26626
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x26626e2f85c797e856ad2cc56d949fbab9c2c111",
            "0xccc4581e138b30f8f5457c5fae45f67a49a98879772e1bea4b76218bb12ecea9249f79e70c8b83811481d68fda6fd6c08e20169cff8df8bfb377c6202e2672fe",
            "a429161b91e8c60635bcf9058ef530211f426fb653c9ded5d7da43da9e4fdb9a",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x26626e2f85c797e856ad2cc56d949fbab9c2c111",
            "BMzEWB4TizD49UV8X65F9npJqYh5dy4b6kt2IYuxLs6pJJ955wyLg4EUgdaP2m/WwI4gFpz/jfi/s3fGIC4mcv4=",
            "pCkWG5HoxgY1vPkFjvUwIR9Cb7ZTyd7V19pD2p5P25o=",
        ),
    ),
    # vanity/0x26726
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x267263be5cae45687738d8f222812611fff5943d",
            "0x5861c5ba59ed44c498f652deb885db91b2ecb8c4000df3ed48507a4df35ff53078239cf9f093943e09a1735c41ce1bddd22847ae5aaef1b0003d6fcaf8805019",
            "070afa2229e749f5c3c3932b1908dc874ca6b15a6236dbf728fbfda74b6da0ee",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x267263be5cae45687738d8f222812611fff5943d",
            "BFhhxbpZ7UTEmPZS3riF25Gy7LjEAA3z7UhQek3zX/UweCOc+fCTlD4JoXNcQc4b3dIoR65arvGwAD1vyviAUBk=",
            "Bwr6IinnSfXDw5MrGQjch0ymsVpiNtv3KPv9p0ttoO4=",
        ),
    ),
    # vanity/0x26826
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x26826584ff3dca8e56784600717c6b7ada22ae2e",
            "0x5dca2011ea490fd7e4aa6fc538efe51b848c5ed6d6e48846506dede9afb947d2b91f13947a39475d05b178b3449ce84a8ea5cc3ad8f5b6604f86fd837ca7f267",
            "fea117b3d99f5d6528fc34e15d6a79711632062727739219bb5d29f049a118b8",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x26826584ff3dca8e56784600717c6b7ada22ae2e",
            "BF3KIBHqSQ/X5KpvxTjv5RuEjF7W1uSIRlBt7emvuUfSuR8TlHo5R10FsXizRJzoSo6lzDrY9bZgT4b9g3yn8mc=",
            "/qEXs9mfXWUo/DThXWp5cRYyBicnc5IZu10p8EmhGLg=",
        ),
    ),
    # vanity/0x26926
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x26926c2a133635a76416899dd11039ee3e559057",
            "0xa1d73faf0e793d7e69bfde55bb214eaa934aff00656a42b2ff830770b08578bec883c7988d4d4c315ca8af5239c6e3da71b103d4c0c3cb950cfcb8d22733038a",
            "36b190635f022c69271c2c8836623be490110452b75eab2abafd370aad94dbb5",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x26926c2a133635a76416899dd11039ee3e559057",
            "BKHXP68OeT1+ab/eVbshTqqTSv8AZWpCsv+DB3CwhXi+yIPHmI1NTDFcqK9SOcbj2nGxA9TAw8uVDPy40iczA4o=",
            "NrGQY18CLGknHCyINmI75JARBFK3Xqsquv03Cq2U27U=",
        ),
    ),
    # vanity/0x27027
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x2702722eb83262a1e19610928603c5507914b4a6",
            "0x4afad26696d27f01e2974a32f414d3e49ae2b2f2ff691f56b85eb2af89502422e963e22c7d61fbf6f277ba12b94148b7d1b7417c0cb86157713dc9ec0717fd29",
            "6a7c7f2a6bbff7f29354f1d3c7f6c944fcad74257274ce9d8bc2da07b6601ad3",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x2702722eb83262a1e19610928603c5507914b4a6",
            "BEr60maW0n8B4pdKMvQU0+Sa4rLy/2kfVrhesq+JUCQi6WPiLH1h+/byd7oSuUFIt9G3QXwMuGFXcT3J7AcX/Sk=",
            "anx/Kmu/9/KTVPHTx/bJRPytdCVydM6di8LaB7ZgGtM=",
        ),
    ),
    # vanity/0x27127
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x27127115cfaea559351bf5ff47a879277963b1db",
            "0x042cdd7a7cfef5868485ed00c44de43a7594b6c5996c27f3c1aa9d740a222e1cc31b21d4ff65e06650ec4536eef5f519cec082e317e7e4ca38d90ae678feaa36",
            "7767ca29a0fcd625f6275f61812fadf39a69b1822c2208bddc86795266993cd7",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x27127115cfaea559351bf5ff47a879277963b1db",
            "BAQs3Xp8/vWGhIXtAMRN5Dp1lLbFmWwn88GqnXQKIi4cwxsh1P9l4GZQ7EU27vX1Gc7AguMX5+TKONkK5nj+qjY=",
            "d2fKKaD81iX2J19hgS+t85ppsYIsIgi93IZ5UmaZPNc=",
        ),
    ),
    # vanity/0x27227
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x27227497fb34f22ff338ba2d8ccf3fd6be75a9c0",
            "0x93666fcfe918d0494661f8226e29174bf174282fff2905808698344244706ee0b97e2aee81518ab6b8735792113729404fdf65ac71df43418c24e44a20b30427",
            "7d6959a72fe41d93b20c00501599c2f48c12c997a291180dca0bbf3bdad15568",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x27227497fb34f22ff338ba2d8ccf3fd6be75a9c0",
            "BJNmb8/pGNBJRmH4Im4pF0vxdCgv/ykFgIaYNEJEcG7guX4q7oFRira4c1eSETcpQE/fZaxx30NBjCTkSiCzBCc=",
            "fWlZpy/kHZOyDABQFZnC9IwSyZeikRgNygu/O9rRVWg=",
        ),
    ),
    # vanity/0x27327
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x27327199fa695c188377f3bc1f1b47a3d0e3af9e",
            "0x18347b7da0d49430922128dad6d16209c5faba1e34341aebfc75bafdcb7902736c53ad0cd06a8a8927a7d44d935613f431b900429f043fdd5924d3b27c20c11d",
            "185ab14e1542899484093a852b66ece6afa91ad6c0679c392daeeecee05c2457",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x27327199fa695c188377f3bc1f1b47a3d0e3af9e",
            "BBg0e32g1JQwkiEo2tbRYgnF+roeNDQa6/x1uv3LeQJzbFOtDNBqioknp9RNk1YT9DG5AEKfBD/dWSTTsnwgwR0=",
            "GFqxThVCiZSECTqFK2bs5q+pGtbAZ5w5La7uzuBcJFc=",
        ),
    ),
    # vanity/0x27427
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x2742780a92760c3d0a3c79ce27b03ce43881957d",
            "0xdd1e1d920c950b37217d12f71ca1da5ec701bccd48e4ef9f15f6520d5e96bf58f9ebf64c4e60732b37f39ed49d4b6bb153eb6ede2b54d6d1d2fe6d33250bd72f",
            "1fb5621e58f117003cd339ffbeca01debb7678c754a4606b48084bafc53c3df0",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x2742780a92760c3d0a3c79ce27b03ce43881957d",
            "BN0eHZIMlQs3IX0S9xyh2l7HAbzNSOTvnxX2Ug1elr9Y+ev2TE5gcys3857UnUtrsVPrbt4rVNbR0v5tMyUL1y8=",
            "H7ViHljxFwA80zn/vsoB3rt2eMdUpGBrSAhLr8U8PfA=",
        ),
    ),
    # vanity/0x27527
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x27527f3237be6d757e8936e92f2d9170be3ed5c9",
            "0x40efbda6cbee786b899bef99ca8f227e5a6dc813ed922d4c935a26a3fa6887bd56548ee81ec397917e9c7644f33a62c8468cdf4b13f49c7f8863273fc369b6da",
            "0d2a0ee4165344046b657794dd7c26cf2481cf4e642d70af7537a8bdece89b0e",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x27527f3237be6d757e8936e92f2d9170be3ed5c9",
            "BEDvvabL7nhriZvvmcqPIn5abcgT7ZItTJNaJqP6aIe9VlSO6B7Dl5F+nHZE8zpiyEaM30sT9Jx/iGMnP8Nptto=",
            "DSoO5BZTRARrZXeU3XwmzySBz05kLXCvdTeovezomw4=",
        ),
    ),
    # vanity/0x27627
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x276277359c64f1e542883b7916e0af7d4782c887",
            "0x66e70e4f5a7dc9d3e3c4d66e3bda74412d7d0a2c8ce291491d4ef683101a537044664eb876d04753e1f15e3c9159d67840604ef4f3178314a539251499c87909",
            "5c53ee552bad671921fe0cd437c4902dcff7a9d5a7700add8998a5bc6b10827f",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x276277359c64f1e542883b7916e0af7d4782c887",
            "BGbnDk9afcnT48TWbjvadEEtfQosjOKRSR1O9oMQGlNwRGZOuHbQR1Ph8V48kVnWeEBgTvTzF4MUpTklFJnIeQk=",
            "XFPuVSutZxkh/gzUN8SQLc/3qdWncArdiZilvGsQgn8=",
        ),
    ),
    # vanity/0x27727
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x2772791cfb91dec3a0042caf97e9de1000dfda18",
            "0x9799a78e1a24dbbdaa2cfd0be870ffee95146f02ac39da0be2d922e6ed7dc00599d9226597d3606e97fc90cf8308abfd3794f136e7ee22d68ad19b0bbfdc59e8",
            "99739816795e70d914cf2705ae7da52411635ca0f267b9530cf8b36188cca5ee",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x2772791cfb91dec3a0042caf97e9de1000dfda18",
            "BJeZp44aJNu9qiz9C+hw/+6VFG8CrDnaC+LZIubtfcAFmdkiZZfTYG6X/JDPgwir/TeU8Tbn7iLWitGbC7/cWeg=",
            "mXOYFnlecNkUzycFrn2lJBFjXKDyZ7lTDPizYYjMpe4=",
        ),
    ),
    # vanity/0x27827
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x278272ba0aa2421d9858aeb1219574a41d63c650",
            "0x92a5d56772c57903fc0fadf4959c8f9281b7cd2701e2037d681c0e68044120b6ca7b7dbf5eb74a717f586233260f803b4f1c502e7ffc73cb8dd244991cc452cf",
            "30763f115971c2d9a4fae76b6fac8764f2ee148416273b22e315aa4e04ab1d52",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x278272ba0aa2421d9858aeb1219574a41d63c650",
            "BJKl1WdyxXkD/A+t9JWcj5KBt80nAeIDfWgcDmgEQSC2ynt9v163SnF/WGIzJg+AO08cUC5//HPLjdJEmRzEUs8=",
            "MHY/EVlxwtmk+udrb6yHZPLuFIQWJzsi4xWqTgSrHVI=",
        ),
    ),
    # vanity/0x27927
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x27927a3ac7ee84764b412b7292e89ad8f0244e43",
            "0xfc5013e8cab0b94285a002b3215cdf1a0a552cf0033e982c4d8bb7b50c14833055cfbadf01d9503d775b53672dd5bff6f73592083b7a51585342f69fc9cdc10f",
            "250c7253e3a5d6a517039f8d36a319222850278999fa97e72432bf7e543853d0",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x27927a3ac7ee84764b412b7292e89ad8f0244e43",
            "BPxQE+jKsLlChaACsyFc3xoKVSzwAz6YLE2Lt7UMFIMwVc+63wHZUD13W1NnLdW/9vc1kgg7elFYU0L2n8nNwQ8=",
            "JQxyU+Ol1qUXA5+NNqMZIihQJ4mZ+pfnJDK/flQ4U9A=",
        ),
    ),
    # vanity/0x28028
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x280289ebcdb67705bb41072c2c984a4d01a742fc",
            "0xd986c8a43a762e195851832603813459a212339ef4f0cb9c444215f070c1f9e65c4294db7b06aac76b46e73bc9c0525083ddb4fb9f1268ec6e285dd814e07168",
            "752f4514e2e560d4979e9b2ed22b8d2ca4be30991e6e3a14bb2fcfee9553a872",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x280289ebcdb67705bb41072c2c984a4d01a742fc",
            "BNmGyKQ6di4ZWFGDJgOBNFmiEjOe9PDLnERCFfBwwfnmXEKU23sGqsdrRuc7ycBSUIPdtPufEmjsbihd2BTgcWg=",
            "dS9FFOLlYNSXnpsu0iuNLKS+MJkebjoUuy/P7pVTqHI=",
        ),
    ),
    # vanity/0x28128
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x281280b951a6ae7d068b170ef7246288b2c4dba4",
            "0x585dff67a322fbd1ec359359cc7960bab20d118b4536bea3b0cd95accdaac73c9ff2fb023814087c09ccc6441824910ffc30affb2bb02eef0e1775fa6ddc3062",
            "eb48e657a0b535d0c80ab0ee2ab01261ff246272c0a868886f4f349f91d2ffc2",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x281280b951a6ae7d068b170ef7246288b2c4dba4",
            "BFhd/2ejIvvR7DWTWcx5YLqyDRGLRTa+o7DNlazNqsc8n/L7AjgUCHwJzMZEGCSRD/wwr/srsC7vDhd1+m3cMGI=",
            "60jmV6C1NdDICrDuKrASYf8kYnLAqGiIb080n5HS/8I=",
        ),
    ),
    # vanity/0x28228
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x28228f759185c2c7770c2fb974577060419123ae",
            "0x04037d30b34c382c7f993dd16fbdacc619223f5b20c70d56be8dbff17da15d48fea5e0d1e28d1590b302c3060f27fb3003accbf0d1cd186a0338d72495493f06",
            "e312a74d4bcdbcae3412f9b0e7ea09fe4487c375bd97b65e50df65029e57e99d",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x28228f759185c2c7770c2fb974577060419123ae",
            "BAQDfTCzTDgsf5k90W+9rMYZIj9bIMcNVr6Nv/F9oV1I/qXg0eKNFZCzAsMGDyf7MAOsy/DRzRhqAzjXJJVJPwY=",
            "4xKnTUvNvK40Evmw5+oJ/kSHw3W9l7ZeUN9lAp5X6Z0=",
        ),
    ),
    # vanity/0x28328
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x28328216d79a877b3ffdf068f894e3c7b37461ba",
            "0x5662b7437703e9717a484718afb754354f5f29baddf44fc3d04e2add37fce9671bb0f62125a9ac806ec29577e71d33d5d5610cc12f2a487ee31dc5c2706daf70",
            "02b023318b56383845edf025251469fbe9407092b650647a560da57252d5cd7e",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x28328216d79a877b3ffdf068f894e3c7b37461ba",
            "BFZit0N3A+lxekhHGK+3VDVPXym63fRPw9BOKt03/OlnG7D2ISWprIBuwpV35x0z1dVhDMEvKkh+4x3FwnBtr3A=",
            "ArAjMYtWODhF7fAlJRRp++lAcJK2UGR6Vg2lclLVzX4=",
        ),
    ),
    # vanity/0x28428
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x28428d7aed1fbf4cf5979911faf0795bccdd6f72",
            "0x20cf1d4d6a0135fc79aee116f909c83686f06d989d98fd5b241823f536cc5d052f01235e4c6d7f124927f6a3cb870d4f3f993ec7cf2099192f3bf6d085c8049c",
            "84dac743bbccad05a9d97a25261d50c187b57e5bba523c4562dff855d39bceb4",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x28428d7aed1fbf4cf5979911faf0795bccdd6f72",
            "BCDPHU1qATX8ea7hFvkJyDaG8G2YnZj9WyQYI/U2zF0FLwEjXkxtfxJJJ/ajy4cNTz+ZPsfPIJkZLzv20IXIBJw=",
            "hNrHQ7vMrQWp2XolJh1QwYe1flu6UjxFYt/4VdObzrQ=",
        ),
    ),
    # vanity/0x28528
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x285281f1fa26eca309952de66eda2164063a4637",
            "0x8f492de12b62acdeb4e1d02221f1cd1e74536aac867ae2e1a94f525c5a218411ced2cd8ed3efd843f55d64f92c683110f9432723cc4981cccffb7832c73d55d2",
            "cd3c3bc7967512fbb244b3d15f7abbaa9b8b5b420f7617df26409cc60836c4db",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x285281f1fa26eca309952de66eda2164063a4637",
            "BI9JLeErYqzetOHQIiHxzR50U2qshnri4alPUlxaIYQRztLNjtPv2EP1XWT5LGgxEPlDJyPMSYHMz/t4Msc9VdI=",
            "zTw7x5Z1EvuyRLPRX3q7qpuLW0IPdhffJkCcxgg2xNs=",
        ),
    ),
    # vanity/0x28628
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x28628314d5879fc966df1e51bdd2e0895754e9bf",
            "0x8f01d0a81c562ae9dd0990b622e08c5b62d286473d1c3b2bdca6d31d37a4cf58040544404af5e81b473add6d68b34eefa7a6b20ea81c88771c2151dfbc7505a2",
            "bdc8d75c62613d39a220cdbcebc164a03a06d5962632ee833a3ca51d0842533b",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x28628314d5879fc966df1e51bdd2e0895754e9bf",
            "BI8B0KgcVirp3QmQtiLgjFti0oZHPRw7K9ym0x03pM9YBAVEQEr16BtHOt1taLNO76emsg6oHIh3HCFR37x1BaI=",
            "vcjXXGJhPTmiIM2868FkoDoG1ZYmMu6DOjylHQhCUzs=",
        ),
    ),
    # vanity/0x28728
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x28728f498e9df41e934d5447c7dd016269b803d5",
            "0xd1fd217971769985bef97dbb1e7f66386f44400e5b88291329d1ba1f41d6c4f9469026469ce42c279539cab729d1c15acae5c6e6baa97db0b2cb7fc5cea793b8",
            "f42209ee9b40a901e173786eba247bf7c04bec361682129e57f089bcf170103d",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x28728f498e9df41e934d5447c7dd016269b803d5",
            "BNH9IXlxdpmFvvl9ux5/ZjhvREAOW4gpEynRuh9B1sT5RpAmRpzkLCeVOcq3KdHBWsrlxua6qX2wsst/xc6nk7g=",
            "9CIJ7ptAqQHhc3huuiR798BL7DYWghKeV/CJvPFwED0=",
        ),
    ),
    # vanity/0x28828
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x288287ae055c096a140f794c49005c3503dda172",
            "0x3d8a4f5c677c56485167b1665146cf88031dc2ba44093dacc39c5e5ac981c404dc372129be06d0c758dfefa81f100ac340e836c9f1b021b710923a1ab061b89f",
            "12a0831d7cb73549d0f0190d61f103c7e3e9b10a9eb54366a97a55beef65fdec",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x288287ae055c096a140f794c49005c3503dda172",
            "BD2KT1xnfFZIUWexZlFGz4gDHcK6RAk9rMOcXlrJgcQE3DchKb4G0MdY3++oHxAKw0DoNsnxsCG3EJI6GrBhuJ8=",
            "EqCDHXy3NUnQ8BkNYfEDx+PpsQqetUNmqXpVvu9l/ew=",
        ),
    ),
    # vanity/0x28928
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x28928b65b970173f611981737f8cb490c4db703b",
            "0xf10e414eb1ed5937787634559c76f280ce9e3029e6104d623e03009dea0693d88d4019ea802cd08551dbd798a13daecc46f3bd313f2ebd4bee98f56a557b1110",
            "fd67352ae63f1f06915d70f0b044fb7ae38b269e0ab71f300cb754db4ede4ac7",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x28928b65b970173f611981737f8cb490c4db703b",
            "BPEOQU6x7Vk3eHY0VZx28oDOnjAp5hBNYj4DAJ3qBpPYjUAZ6oAs0IVR29eYoT2uzEbzvTE/Lr1L7pj1alV7ERA=",
            "/Wc1KuY/HwaRXXDwsET7euOLJp4Ktx8wDLdU207eSsc=",
        ),
    ),
    # vanity/0x29029
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x290293a024a236f0bdd94989371621442bb153ed",
            "0x180df0e9f9251f8e9b9327088aa4074fe58be9bf4ccc792bfd0ca15dd68ed8d36a5cf0ada032cf236958160a415290073c3cae2a644a9eaf2818ad7ce70e8142",
            "83513ad1e8bb89d5c4f215b88155d7fd2597e3995a8e0c2c302e4d880fd1e870",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x290293a024a236f0bdd94989371621442bb153ed",
            "BBgN8On5JR+Om5MnCIqkB0/li+m/TMx5K/0MoV3WjtjTalzwraAyzyNpWBYKQVKQBzw8ripkSp6vKBitfOcOgUI=",
            "g1E60ei7idXE8hW4gVXX/SWX45lajgwsMC5NiA/R6HA=",
        ),
    ),
    # vanity/0x29129
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x29129efb8c93d6846942485a4ab646e2da74b58e",
            "0xb9e957ffcb3923450cb48b10440b385a67b492bab90a71bfce933950de3b46513dbf8d501ef40698241fe01d2f6dd4ff5d1681c4094e70ffbc996340269e4730",
            "52c02688466c6eb6a54be31d20ec723fa0ad1a603b6ac954e1e58b55eee0db2a",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x29129efb8c93d6846942485a4ab646e2da74b58e",
            "BLnpV//LOSNFDLSLEEQLOFpntJK6uQpxv86TOVDeO0ZRPb+NUB70BpgkH+AdL23U/10WgcQJTnD/vJljQCaeRzA=",
            "UsAmiEZsbralS+MdIOxyP6CtGmA7aslU4eWLVe7g2yo=",
        ),
    ),
    # vanity/0x29229
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x29229f384aab68bd52539de78744cd67cff2c1a5",
            "0x8629a910001d5c3d22a175cf7bdb8d47d0a9940a1b3460089bf5e5b59efc16bf31234179d353106aeacb95a3ed00302ae239ab85d0f851f098bd34d3cd299a4d",
            "199cdc1fdf82c235e7aeecac7004dc563507ce4e1454522097794d524ceb1644",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x29229f384aab68bd52539de78744cd67cff2c1a5",
            "BIYpqRAAHVw9IqF1z3vbjUfQqZQKGzRgCJv15bWe/Ba/MSNBedNTEGrqy5Wj7QAwKuI5q4XQ+FHwmL00080pmk0=",
            "GZzcH9+CwjXnruyscATcVjUHzk4UVFIgl3lNUkzrFkQ=",
        ),
    ),
    # vanity/0x29329
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x293290db718aa25d2097c5a74b85407a7d2dc19c",
            "0x99b765e1d5885831d1b0c3ecc41fd8f82da165ba5303b03eb9aebd2888074dcb8a28a01207a8bee324b2f4e0cf31771da3378b529a03d9755e142715b23cbbba",
            "f57adf299a47ef10530ed3c882b6cf2a658d8c16d6f32d670e4bc304c0c7b62c",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x293290db718aa25d2097c5a74b85407a7d2dc19c",
            "BJm3ZeHViFgx0bDD7MQf2PgtoWW6UwOwPrmuvSiIB03LiiigEgeovuMksvTgzzF3HaM3i1KaA9l1XhQnFbI8u7o=",
            "9XrfKZpH7xBTDtPIgrbPKmWNjBbW8y1nDkvDBMDHtiw=",
        ),
    ),
    # vanity/0x29429
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x2942935247274c9a454749486f8bcdf2866534ec",
            "0xd8c9ae3a568d6c5fabcc193722b06b3802912cc1961f2969ccc1e9da757ee30cc8f3e85fd71b4e14ab1297d6b53d2368422231e4566024aad558cadb816f754f",
            "2741e488a31308c6ff82b4cc36a8e6cadc9dced310a149ed2484f829c527e4ff",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x2942935247274c9a454749486f8bcdf2866534ec",
            "BNjJrjpWjWxfq8wZNyKwazgCkSzBlh8paczB6dp1fuMMyPPoX9cbThSrEpfWtT0jaEIiMeRWYCSq1VjK24FvdU8=",
            "J0HkiKMTCMb/grTMNqjmytydztMQoUntJIT4KcUn5P8=",
        ),
    ),
    # vanity/0x29529
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x29529d6af09f6300fbb10feae502a2d3f3ca51b8",
            "0xcbe4aaf1e2eb52344bb838c0e2db2ca502fc3ab863b698d5715ac3d7c35a6808a287876283f680288e63679d1d4fd735dd85d002a16e3ef422c2c39ccc3828e6",
            "c7294b1f116be7021e9329255310d9503ea7eeb361bacc89cea55415755df750",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x29529d6af09f6300fbb10feae502a2d3f3ca51b8",
            "BMvkqvHi61I0S7g4wOLbLKUC/Dq4Y7aY1XFaw9fDWmgIooeHYoP2gCiOY2edHU/XNd2F0AKhbj70IsLDnMw4KOY=",
            "xylLHxFr5wIekyklUxDZUD6n7rNhusyJzqVUFXVd91A=",
        ),
    ),
    # vanity/0x29629
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x29629d3790549804754b98a1d62c336e1e0961b3",
            "0xc96a05cb689f5b8773f3161db503669e24442c7333ea71a094b475f38c690ac3f5e764373d9a67277f0e38bfec3ae4786ff4ecba25fb2f685f72dbae8ddb55c8",
            "faf73caa4db4970a27649b6541438e47fa20e3b4f45084c4b0a51b88ae8ca9b2",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x29629d3790549804754b98a1d62c336e1e0961b3",
            "BMlqBcton1uHc/MWHbUDZp4kRCxzM+pxoJS0dfOMaQrD9edkNz2aZyd/Dji/7DrkeG/07Lol+y9oX3Lbro3bVcg=",
            "+vc8qk20lwonZJtlQUOOR/og47T0UITEsKUbiK6MqbI=",
        ),
    ),
    # vanity/0x29729
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x29729a76ed9fee63953bcfbaf9184babfcd2372c",
            "0x9a254a22718959e5977617a07a61f5b31af721b3aab05cd48f4166ba11581734db609fdef7d285e9ea371135507afba26a71ecbc4cf3285f813533f6e960bcec",
            "e159fdfd63bbc31a0a4c4085c19c1cc71a02b61ccc11c4519bc22e06703111d4",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x29729a76ed9fee63953bcfbaf9184babfcd2372c",
            "BJolSiJxiVnll3YXoHph9bMa9yGzqrBc1I9BZroRWBc022Cf3vfShenqNxE1UHr7ompx7LxM8yhfgTUz9ulgvOw=",
            "4Vn9/WO7wxoKTECFwZwcxxoCthzMEcRRm8IuBnAxEdQ=",
        ),
    ),
    # vanity/0x29829
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x29829ecac15c796204473496b5fa6815f1899cad",
            "0x5fab7da15c079bab052da7f517e3905d7d1ed871055c0b7e3f76c6a14004c911efd91ab343c831d50aa64667822794a036018c9d60780c4c4f258625adff9ada",
            "59a473b6323d765fb00df593e58d57f0247f3e30c9d9bb2ba857e5f5522cd3bb",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x29829ecac15c796204473496b5fa6815f1899cad",
            "BF+rfaFcB5urBS2n9RfjkF19HthxBVwLfj92xqFABMkR79kas0PIMdUKpkZngieUoDYBjJ1geAxMTyWGJa3/mto=",
            "WaRztjI9dl+wDfWT5Y1X8CR/PjDJ2bsrqFfl9VIs07s=",
        ),
    ),
    # vanity/0x29929
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x299296f4c97256fe81d872203834ebac3c4b1382",
            "0x5956d1a21e5ce0d2d63a4d786d7b3f84fb0ed18bb60c9b04471b222dec6d37e85cec1512797b6e93ed4148b8096e5d3a6874b54795e18b33bafa2a1e222a57f9",
            "fef6cff3d38985dc80fdd0da896954138b0086340b95b72fb9f69bea1075514c",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x299296f4c97256fe81d872203834ebac3c4b1382",
            "BFlW0aIeXODS1jpNeG17P4T7DtGLtgybBEcbIi3sbTfoXOwVEnl7bpPtQUi4CW5dOmh0tUeV4YszuvoqHiIqV/k=",
            "/vbP89OJhdyA/dDaiWlUE4sAhjQLlbcvufab6hB1UUw=",
        ),
    ),
    # vanity/0x30030
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x300304f6c3544f5a4d4e80dc81354543bc4d2f80",
            "0xc451626a5436cd01bd2955230ba082b0a6ec45b350accf30f4e326df2ff9ed6722b631e09881e26728e41ffa9081a1fb7b059800c1c75b609dced4cb8f3e76c1",
            "89574cfae1e11a30dd00da35b09bae2d4849281ca87aabad76821fe096f41ad8",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x300304f6c3544f5a4d4e80dc81354543bc4d2f80",
            "BMRRYmpUNs0BvSlVIwuggrCm7EWzUKzPMPTjJt8v+e1nIrYx4JiB4mco5B/6kIGh+3sFmADBx1tgnc7Uy48+dsE=",
            "iVdM+uHhGjDdANo1sJuuLUhJKByoequtdoIf4Jb0Gtg=",
        ),
    ),
    # vanity/0x30130
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x30130ff687adfe4da1c304ba58059dcac728ad48",
            "0xf135f8e311c36d0ddd3380e98ebc0dcf1c8219e6c7de7c6921590fbe1b35234cd237cfa143ac2933cb81477c5f8ded3645c455336c079a33d3ece15dd4305bd6",
            "1a76d20083006fd16ae0075939204b5eabc09daa5ff51ff5b6ec67ca033849d2",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x30130ff687adfe4da1c304ba58059dcac728ad48",
            "BPE1+OMRw20N3TOA6Y68Dc8cghnmx958aSFZD74bNSNM0jfPoUOsKTPLgUd8X43tNkXEVTNsB5oz0+zhXdQwW9Y=",
            "GnbSAIMAb9Fq4AdZOSBLXqvAnapf9R/1tuxnygM4SdI=",
        ),
    ),
    # vanity/0x30230
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x302302ffd8d7a4372f5c2b5b1afbe97c58756af4",
            "0x3de9be5064ad04dab7fe6399c51fc60de817952cd3808b2e9485edd5022b6e98165a3f4ce536fff7aea438509cdb9ecd8b8ede24316a9bb4c634768f874fac7c",
            "223523161105fbc455711ad15a87e3dfd920533c53324ea36cf30c7d23838012",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x302302ffd8d7a4372f5c2b5b1afbe97c58756af4",
            "BD3pvlBkrQTat/5jmcUfxg3oF5Us04CLLpSF7dUCK26YFlo/TOU2//eupDhQnNuezYuO3iQxapu0xjR2j4dPrHw=",
            "IjUjFhEF+8RVcRrRWofj39kgUzxTMk6jbPMMfSODgBI=",
        ),
    ),
    # vanity/0x30330
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x3033080fdba3593fa4b9af7e10e04f403a7e2e37",
            "0x02e7f5f8cf75b6ddf4ee748cfba89ebedc4153a096a75ef706b6504d4dab83174829295d01d58832a1640459fdf2deca7a9995bd567cfcd6dbfb2c271445bffc",
            "b8a29c540d9b13747b12af02708d69246e7f1e9ff5ca7c5573edb572d2fd41b9",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x3033080fdba3593fa4b9af7e10e04f403a7e2e37",
            "BALn9fjPdbbd9O50jPuonr7cQVOglqde9wa2UE1Nq4MXSCkpXQHViDKhZARZ/fLeynqZlb1WfPzW2/ssJxRFv/w=",
            "uKKcVA2bE3R7Eq8CcI1pJG5/Hp/1ynxVc+21ctL9Qbk=",
        ),
    ),
    # vanity/0x30430
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x304308b4a710ed718b62ff9cbe43bd23853ac854",
            "0xe03323503bf985abce38b3af79b0e8ebc8a5bbadc2804bd5c94349e3ad387d6f2c7db7270cda3a5bc74e431e87cffb6c51a2a90e0141dfa80b498d5cd466b47d",
            "1799ed8dcb32c1443b89e6e49ed04da7bd257f0d4ecdb65425d1736656684c82",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x304308b4a710ed718b62ff9cbe43bd23853ac854",
            "BOAzI1A7+YWrzjizr3mw6OvIpbutwoBL1clDSeOtOH1vLH23JwzaOlvHTkMeh8/7bFGiqQ4BQd+oC0mNXNRmtH0=",
            "F5ntjcsywUQ7iebkntBNp70lfw1OzbZUJdFzZlZoTII=",
        ),
    ),
    # vanity/0x30530
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x30530eceeb2fc1f41d575df9aeeceb516e89e706",
            "0x595d2fcc84e42c1cdb68da87eb3ff36a8d747626de1dc340a87ee43fa1b8af117185233b797fe19f02a8f852938a9ae9ac4762763b252fecc4b3d99000ebf109",
            "dacdcb3035950fcc5497f4749eb70b47d8d3ae9a76b322ad87bb37d1a85d1c63",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x30530eceeb2fc1f41d575df9aeeceb516e89e706",
            "BFldL8yE5Cwc22jah+s/82qNdHYm3h3DQKh+5D+huK8RcYUjO3l/4Z8CqPhSk4qa6axHYnY7JS/sxLPZkADr8Qk=",
            "2s3LMDWVD8xUl/R0nrcLR9jTrpp2syKth7s30ahdHGM=",
        ),
    ),
    # vanity/0x30630
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x306302aeaa81960ad1b922eac095057adb32037b",
            "0x525f4f4bce84af2436bbb1cbff382da61f9ed7c21cc3cc3a8ef20484be1b82fa4101086c821dc6acfba7082d9ac00358076d9ce180b4f675c4b1ce82f7f5de25",
            "2b9659d36b436ff026791e045271dc43c5ad9fea5327a42fc91b9a3b7b5fbbaf",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x306302aeaa81960ad1b922eac095057adb32037b",
            "BFJfT0vOhK8kNruxy/84LaYfntfCHMPMOo7yBIS+G4L6QQEIbIIdxqz7pwgtmsADWAdtnOGAtPZ1xLHOgvf13iU=",
            "K5ZZ02tDb/AmeR4EUnHcQ8Wtn+pTJ6QvyRuaO3tfu68=",
        ),
    ),
    # vanity/0x30730
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x30730ad6d5a17de8b8ceaba8704f289af7c1276d",
            "0xf259c3ca7362c2609bb22a9a67648936057a7827e0a0ef0ae18b611b3fa8ee36ec207748afa337aca75c308e2340c5eef3a278fa65d57946988d19c0f3729cae",
            "ed2bd65b17dd882586064a5749d5474ad3db8a1a5e973ac998d9b169405bd76e",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x30730ad6d5a17de8b8ceaba8704f289af7c1276d",
            "BPJZw8pzYsJgm7IqmmdkiTYFengn4KDvCuGLYRs/qO427CB3SK+jN6ynXDCOI0DF7vOiePpl1XlGmI0ZwPNynK4=",
            "7SvWWxfdiCWGBkpXSdVHStPbihpelzrJmNmxaUBb124=",
        ),
    ),
    # vanity/0x30830
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x308302b7a52c8ac2fd01abaa101a4b9bea7a0986",
            "0x812e44a004e1398c9b737aab3d235122b60338b9b1ec4b8b11f13eb7b40f26a293d3a5d73cacd86b1ec16a2ffd0bb7db5892391ba0c2da10461042ea48759dca",
            "c7fd96e399c6f77ad5262eb6ae6ac56dc475e2acbfc4aa448c0ba5d942e7982e",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x308302b7a52c8ac2fd01abaa101a4b9bea7a0986",
            "BIEuRKAE4TmMm3N6qz0jUSK2Azi5sexLixHxPre0Dyaik9Ol1zys2GsewWov/Qu321iSORugwtoQRhBC6kh1nco=",
            "x/2W45nG93rVJi62rmrFbcR14qy/xKpEjAul2ULnmC4=",
        ),
    ),
    # vanity/0x30930
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x309302cc8cf14335ba104fa0b75cb6e1003d1ecc",
            "0x140e118cc74a57de4107c9f8f66dec2edf0ba5703a5adecda4ee3488196947410ecde28d65e77b0786aefa7cef5940a15914f9eb08ccdcedcef15acd4a575310",
            "a6ac98abba7d32cf8aa4a2358613958143afe6be596be4151c0f97b68dfaa5fa",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x309302cc8cf14335ba104fa0b75cb6e1003d1ecc",
            "BBQOEYzHSlfeQQfJ+PZt7C7fC6VwOlrezaTuNIgZaUdBDs3ijWXneweGrvp871lAoVkU+esIzNztzvFazUpXUxA=",
            "pqyYq7p9Ms+KpKI1hhOVgUOv5r5Za+QVHA+Xto36pfo=",
        ),
    ),
    # vanity/0x31031
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x31031d118f87853d6dc0337247b4acf83d55803a",
            "0x9d46f16507283662fbb4bef0aec5dfd9b32de75e526e34af582eaabfb092a146cab8c71c09e4ecbcffd51e76aa49ca6a5af5f13c9dd215341410dc932c204187",
            "27872598f1317051459c5447e40d7c2b216a69fd65dfc5c66e242613da17d179",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x31031d118f87853d6dc0337247b4acf83d55803a",
            "BJ1G8WUHKDZi+7S+8K7F39mzLedeUm40r1guqr+wkqFGyrjHHAnk7Lz/1R52qknKalr18Tyd0hU0FBDckywgQYc=",
            "J4clmPExcFFFnFRH5A18KyFqaf1l38XGbiQmE9oX0Xk=",
        ),
    ),
    # vanity/0x31131
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x311310f4ccbfa9a2345492fad58a7e07d34fc53f",
            "0x2b7014c7745302deb8e303df7c1c412671ce86aff7b4149aaac18c0e457de4d3671baf59fde26e7d1373880ffe001defa750183a504e30a9922081abc4aa1a03",
            "3ad87451274bb61fd037c987fc1a63e5e55cb6c42eafad5a903e6b2f0484b091",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x311310f4ccbfa9a2345492fad58a7e07d34fc53f",
            "BCtwFMd0UwLeuOMD33wcQSZxzoav97QUmqrBjA5FfeTTZxuvWf3ibn0Tc4gP/gAd76dQGDpQTjCpkiCBq8SqGgM=",
            "Oth0USdLth/QN8mH/Bpj5eVctsQur61akD5rLwSEsJE=",
        ),
    ),
    # vanity/0x31231
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x31231bfa7176727e3408cbe822fbd142d5510452",
            "0xa4679d335421fb8f8786b1680e3e40316fccc2e2d587b19d94fc752825fd643d3480351a35e8843eac8821edae5532e6a7025ae90ad69ba3e2b0e4c5bbb67847",
            "57206033609917d82ef234baad2fbe9fce088a75f8d51960ffdfcf0bc57c3bbe",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x31231bfa7176727e3408cbe822fbd142d5510452",
            "BKRnnTNUIfuPh4axaA4+QDFvzMLi1YexnZT8dSgl/WQ9NIA1GjXohD6siCHtrlUy5qcCWukK1puj4rDkxbu2eEc=",
            "VyBgM2CZF9gu8jS6rS++n84IinX41Rlg/9/PC8V8O74=",
        ),
    ),
    # vanity/0x31331
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x313317e0fe7f05860eadc78dece810aff44b29df",
            "0x80eca374f72996cf60ebf2f5d8ad8e978e86f90f991de53128f3286471ade357367151ca31cf9a36f5c34ca77b36f5b075a06a6a27fbe05ee2f7dbd5a41bfcb4",
            "c5d6104753118420ff8f5b4ea6cc8cde20b923f6c256d5b3e44edc26e6f17b7e",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x313317e0fe7f05860eadc78dece810aff44b29df",
            "BIDso3T3KZbPYOvy9ditjpeOhvkPmR3lMSjzKGRxreNXNnFRyjHPmjb1w0ynezb1sHWgamon++Be4vfb1aQb/LQ=",
            "xdYQR1MRhCD/j1tOpsyM3iC5I/bCVtWz5E7cJubxe34=",
        ),
    ),
    # vanity/0x31431
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x314315b8efbbd7db531891cfee280874ce82677a",
            "0x45874e5e157043374b9dfa16ee61aeb834f9c6aeb486b8c83fafe2cb81ba3ec61bcecf6b0a63d666aac6ece2eec809ee43bd9a63e61f1e4eb46ccb48bcd86694",
            "5320b533cb5e1fc5cec8fc5aa5708ec43efac882fa88d1e552540e5639d070f6",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x314315b8efbbd7db531891cfee280874ce82677a",
            "BEWHTl4VcEM3S536Fu5hrrg0+cautIa4yD+v4suBuj7GG87Pawpj1maqxuzi7sgJ7kO9mmPmHx5OtGzLSLzYZpQ=",
            "UyC1M8teH8XOyPxapXCOxD76yIL6iNHlUlQOVjnQcPY=",
        ),
    ),
    # vanity/0x31531
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x315311278e59521b24fd9a04f658831a1303d10f",
            "0xc775ca919cb276db6d77405b0684f03b70367da7346f53e629dc06a207b71a60e751849a0b2b7ec756c15982198ce9d4eca95f54f02b1a6156272c13cd7ab54f",
            "5e864b47550004fd2ed4d722871b70036b9861af4c09d36eb8101b831edaa442",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x315311278e59521b24fd9a04f658831a1303d10f",
            "BMd1ypGcsnbbbXdAWwaE8DtwNn2nNG9T5incBqIHtxpg51GEmgsrfsdWwVmCGYzp1OypX1TwKxphVicsE816tU8=",
            "XoZLR1UABP0u1NcihxtwA2uYYa9MCdNuuBAbgx7apEI=",
        ),
    ),
    # vanity/0x31631
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x316317561f8c7f54e8245c592465105b4d3ac205",
            "0xed85715032aa3dd62f06dc4023aec91bc7f25e480c8e9d06a9254eeab61df0bb6f6b13ae2d456176a5bc46822aee87f2d78113624a402100ab6a8404c4498e6a",
            "dec5a9cebcc6f2197ec417043ef95f6f896f203bb2044876446f55b36e82942b",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x316317561f8c7f54e8245c592465105b4d3ac205",
            "BO2FcVAyqj3WLwbcQCOuyRvH8l5IDI6dBqklTuq2HfC7b2sTri1FYXalvEaCKu6H8teBE2JKQCEAq2qEBMRJjmo=",
            "3sWpzrzG8hl+xBcEPvlfb4lvIDuyBEh2RG9Vs26ClCs=",
        ),
    ),
    # vanity/0x31731
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x31731d94c95918f26d58745703ea8c1035eb75bf",
            "0x36f1df40bb1bfaf748ced79cb0656b3de71ddc274fd0a2077075e08c194be40b1eb26d872140750f4d0ee3a5c9d11b66bcfb4c2418bc9f2a4ae3ed6b7931733b",
            "cc84d8bd120a211aa7a67f2d8a1ca181f66fc87c7b298a2402cb853b6dfbcebb",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x31731d94c95918f26d58745703ea8c1035eb75bf",
            "BDbx30C7G/r3SM7XnLBlaz3nHdwnT9CiB3B14IwZS+QLHrJthyFAdQ9NDuOlydEbZrz7TCQYvJ8qSuPta3kxczs=",
            "zITYvRIKIRqnpn8tihyhgfZvyHx7KYokAsuFO237zrs=",
        ),
    ),
    # vanity/0x31831
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x31831d854e798b718a3f2031451633db1c479024",
            "0x9c7ba666158aa04d948cc244c5f9705ae51868fe018e1cd32cbd24505bc0c1844cfec150e350c138f25e7da36149b58e813e9d3861ac92e8bf17c44f62136886",
            "a222dcf7293d0da1809bffd93f015d654b9e4bd3fa0f0b09a1b2231ac0e4211b",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x31831d854e798b718a3f2031451633db1c479024",
            "BJx7pmYViqBNlIzCRMX5cFrlGGj+AY4c0yy9JFBbwMGETP7BUONQwTjyXn2jYUm1joE+nThhrJLovxfET2ITaIY=",
            "oiLc9yk9DaGAm//ZPwFdZUueS9P6DwsJobIjGsDkIRs=",
        ),
    ),
    # vanity/0x31931
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x3193192148699bde58d1b9b3228079c4ae7055e9",
            "0x8710a2bad55715690bd330b3b46b4b4edf463883fbb73458c303e2cdd8fd25dc67bcd2c79bd9b5f5d8db17b4423b922bc113cd8f2f51c5f04e8bd06d102da6e0",
            "dae041baa98cae691a2c01e45226a63edb7e9a46e09869f2b180920d7967e090",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x3193192148699bde58d1b9b3228079c4ae7055e9",
            "BIcQorrVVxVpC9Mws7RrS07fRjiD+7c0WMMD4s3Y/SXcZ7zSx5vZtfXY2xe0QjuSK8ETzY8vUcXwTovQbRAtpuA=",
            "2uBBuqmMrmkaLAHkUiamPtt+mkbgmGnysYCSDXln4JA=",
        ),
    ),
    # vanity/0x32032
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x32032b8ab5da40d3aeec951298104b63d3384946",
            "0x7aefdf00e4e032589b7d76aaad2af089f27eed8c9ad59efbc93325f7e92374bb08a753f3308946a033cf23a06abddf97ef075ceffbc680831c45fa2000336bdf",
            "ba3a46c7f24ad93c846b7f51886d61c8e2f8ba8b46c2af2b404bb2162f5fd175",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x32032b8ab5da40d3aeec951298104b63d3384946",
            "BHrv3wDk4DJYm312qq0q8Inyfu2MmtWe+8kzJffpI3S7CKdT8zCJRqAzzyOgar3fl+8HXO/7xoCDHEX6IAAza98=",
            "ujpGx/JK2TyEa39RiG1hyOL4uotGwq8rQEuyFi9f0XU=",
        ),
    ),
    # vanity/0x32132
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x3213203bde807a2b10dfbfb21392f4cfcb13166d",
            "0xf1a1537480a39bf6a8ecc6ebcaf1e9ca49d9cd2b754ecc38602ba04e5dec0190f0a2c3713995d900f22045ee6d54ea81a3e1de7b19249b4db9368082c8b34f43",
            "21ff6ac66bcf61ad2252e344285a4e98af7ca16efabafee9e93a9989bfd7a342",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x3213203bde807a2b10dfbfb21392f4cfcb13166d",
            "BPGhU3SAo5v2qOzG68rx6cpJ2c0rdU7MOGAroE5d7AGQ8KLDcTmV2QDyIEXubVTqgaPh3nsZJJtNuTaAgsizT0M=",
            "If9qxmvPYa0iUuNEKFpOmK98oW76uv7p6TqZib/Xo0I=",
        ),
    ),
    # vanity/0x32232
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x322320ed3ea0560651c84d14e050484c2cf4f13d",
            "0x4b26782366181191218e2103d1ddffbf9f15b5cbeba0a30485491a584433c51c4161e6fcbaf325249f3b4e274881b0f89930e4198014eb6e4309e5920b1457ff",
            "09c35df4fd30208a5eabbd4a673c8d104a6e7efe4e7bf8dc889602b893f72163",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x322320ed3ea0560651c84d14e050484c2cf4f13d",
            "BEsmeCNmGBGRIY4hA9Hd/7+fFbXL66CjBIVJGlhEM8UcQWHm/LrzJSSfO04nSIGw+Jkw5BmAFOtuQwnlkgsUV/8=",
            "CcNd9P0wIIpeq71KZzyNEEpufv5Oe/jciJYCuJP3IWM=",
        ),
    ),
    # vanity/0x32332
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x323322cd3586bb2a3be77c1aa828f40b4129d0a6",
            "0x9bb950af6927413249399049eab0f558b8709ea0bf38a3bd78c0f2728bc2ef4736a6b5582daae9de66fe2b808cc9c321b4616e0ac59efbbec13175defaf34ab8",
            "23e9a3b6c21650f7d759f7842d4c530f55dccefb48a64aa471362ac4ff9989e4",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x323322cd3586bb2a3be77c1aa828f40b4129d0a6",
            "BJu5UK9pJ0EySTmQSeqw9Vi4cJ6gvzijvXjA8nKLwu9HNqa1WC2q6d5m/iuAjMnDIbRhbgrFnvu+wTF13vrzSrg=",
            "I+mjtsIWUPfXWfeELUxTD1XczvtIpkqkcTYqxP+ZieQ=",
        ),
    ),
    # vanity/0x32432
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x32432b5a38e7e87d959ca7462f10a24affcb9570",
            "0x049a58e1c76af8dcd11f584157b3f83233e4a8074f5096ddd05ffd404732282c6bc005bd678ab9ffd2d7cdfb725eaf93cb2525b4708ce24e3e383fae1bc5ec55",
            "d483ff08c056e614999b9e1e7e81ceafbdfb80a7c0ccee67fa042ca527af7512",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x32432b5a38e7e87d959ca7462f10a24affcb9570",
            "BASaWOHHavjc0R9YQVez+DIz5KgHT1CW3dBf/UBHMigsa8AFvWeKuf/S1837cl6vk8slJbRwjOJOPjg/rhvF7FU=",
            "1IP/CMBW5hSZm54efoHOr737gKfAzO5n+gQspSevdRI=",
        ),
    ),
    # vanity/0x32532
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x325322f81cd2766805e1b7761cf51315d314efa2",
            "0x7cca63c95a882117774b772c2859f45378e48ad3c536c00b5691089d6ddcad38d3ee83a6e68fd74f256f3e0963e4a74c32468250b9c844fdd6896095cd6639e9",
            "75143c41e1e07a68a9d3a868e00318a82efd00d15473f10dc7b70b1f5beb2353",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x325322f81cd2766805e1b7761cf51315d314efa2",
            "BHzKY8laiCEXd0t3LChZ9FN45IrTxTbAC1aRCJ1t3K040+6DpuaP108lbz4JY+SnTDJGglC5yET91olglc1mOek=",
            "dRQ8QeHgemip06ho4AMYqC79ANFUc/ENx7cLH1vrI1M=",
        ),
    ),
    # vanity/0x32632
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x326323255a8dad103b3074faacd52548c028bc8e",
            "0x6f0bda076386b55f3f1ebb2c60cae638fff1d751e613511789f7685d9b2ecd5a4c6be8649136cd71d57b82652db34c2fc9e4cb4eea759f1a6b75d1504fd5b6c5",
            "8ea421fec547bbbcce56d95c6b96e9cfa51968fab2ec719688df5347efb4a34e",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x326323255a8dad103b3074faacd52548c028bc8e",
            "BG8L2gdjhrVfPx67LGDK5jj/8ddR5hNRF4n3aF2bLs1aTGvoZJE2zXHVe4JlLbNML8nky07qdZ8aa3XRUE/VtsU=",
            "jqQh/sVHu7zOVtlca5bpz6UZaPqy7HGWiN9TR++0o04=",
        ),
    ),
    # vanity/0x32732
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x32732211a9ffbec5ca7462f873c0282d860eb7e2",
            "0x78ea4e8e214bb8e01383206a17116aa014a43a31168bf0e2cec7f84d96ee82d41938993117b03e517c9cded3cf58341571994e664575f037b799173720d40390",
            "eb116ed61e8d8a406410af0a5ae7aebb80281729b9162e5b4f9370cf91a3632a",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x32732211a9ffbec5ca7462f873c0282d860eb7e2",
            "BHjqTo4hS7jgE4MgahcRaqAUpDoxFovw4s7H+E2W7oLUGTiZMRewPlF8nN7Tz1g0FXGZTmZFdfA3t5kXNyDUA5A=",
            "6xFu1h6NikBkEK8KWueuu4AoFym5Fi5bT5Nwz5GjYyo=",
        ),
    ),
    # vanity/0x32832
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x328323618f46d63c8219beb7955c378c4c05a170",
            "0x131730af4d651b6d2be4d73e14bd9ae0e97cad8dfc64976751da668bc4b7d05b2ffc2d6d93b3099089ee072fc13107ee0a75901029c83fa38dd23f2489d77a8e",
            "601c028f67d369e03b0ed840e9a491489e772d10307ce9f4ae37102050a5623a",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x328323618f46d63c8219beb7955c378c4c05a170",
            "BBMXMK9NZRttK+TXPhS9muDpfK2N/GSXZ1HaZovEt9BbL/wtbZOzCZCJ7gcvwTEH7gp1kBApyD+jjdI/JInXeo4=",
            "YBwCj2fTaeA7DthA6aSRSJ53LRAwfOn0rjcQIFClYjo=",
        ),
    ),
    # vanity/0x32932
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x32932c51fae805d6d6c2ba64f3c91cad3c789a52",
            "0x84a626a225a89edaa421eb5e2e4d2477d6cd6f6287ef188a5115d9f8963363ff6eae302f854a8e21cdfee1afae7c2144f5c6a405b5b0354537e6f77421593c58",
            "409dd692dcc1809503a6e8777a570be3e365ac055393a470a7bf0dcc5db91c3c",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x32932c51fae805d6d6c2ba64f3c91cad3c789a52",
            "BISmJqIlqJ7apCHrXi5NJHfWzW9ih+8YilEV2fiWM2P/bq4wL4VKjiHN/uGvrnwhRPXGpAW1sDVFN+b3dCFZPFg=",
            "QJ3WktzBgJUDpuh3elcL4+NlrAVTk6Rwp78NzF25HDw=",
        ),
    ),
    # vanity/0x33033
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x3303366dfc60b3ac9bf7051fee3e4e75a3abb797",
            "0x0561e62e1395ded483411122138d7cda6c25a6ac5966d39e093ee48f072ffb7ceee4f6c730588845b65c48a78d240e50ec1ac0d2f55f8ae5b67834840aef8e91",
            "36d4f35c793a4db319789495b3ac1e82e217e2f304f1eaddd6e125ba7524b59c",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x3303366dfc60b3ac9bf7051fee3e4e75a3abb797",
            "BAVh5i4Tld7Ug0ERIhONfNpsJaasWWbTngk+5I8HL/t87uT2xzBYiEW2XEinjSQOUOwawNL1X4rltng0hArvjpE=",
            "NtTzXHk6TbMZeJSVs6weguIX4vME8erd1uElunUktZw=",
        ),
    ),
    # vanity/0x33133
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x331339d997dfca9a42a4ca9a740c21495f2e8adf",
            "0x31d716f9ebd50595c8daba178cd25e4371e50a2b254d0ec0323732c1eaf283f1fa0ea9a18698951f1be2ce5911ba3797ad0b141295787b87bfa4917dc45af55b",
            "9b42338b4751fdd0fb25572643673f06d852f4ada661b7ef4ce57f14e1b8f3cb",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x331339d997dfca9a42a4ca9a740c21495f2e8adf",
            "BDHXFvnr1QWVyNq6F4zSXkNx5QorJU0OwDI3MsHq8oPx+g6poYaYlR8b4s5ZEbo3l60LFBKVeHuHv6SRfcRa9Vs=",
            "m0Izi0dR/dD7JVcmQ2c/BthS9K2mYbfvTOV/FOG488s=",
        ),
    ),
    # vanity/0x33233
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x33233143c79b1c3aacf952feaf7c474151011e41",
            "0x31dcd0dc2654c19d639b7d1a35fbf312017c2333fe8461feec2d64feacb9680114933b90bee5f41df7e08f826c181061d2a2ba6ceb6763cb9e3491084ea5fa45",
            "f5105ecf24ffb590caf43180c3e8db8fc2e1f73e4a1fc025e339f87c604027d6",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x33233143c79b1c3aacf952feaf7c474151011e41",
            "BDHc0NwmVMGdY5t9GjX78xIBfCMz/oRh/uwtZP6suWgBFJM7kL7l9B334I+CbBgQYdKiumzrZ2PLnjSRCE6l+kU=",
            "9RBezyT/tZDK9DGAw+jbj8Lh9z5KH8Al4zn4fGBAJ9Y=",
        ),
    ),
    # vanity/0x33333
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x333339f8ed5b6040448831009130199110b7e999",
            "0x8a757a53b358843186a9d9473b97da45b82a5b4a3ccec5b36e60a6a654c0abadd6c3e53e6e4a3cffed5e4a4eff65ecc336b5099675522f35c73edc24560e3cef",
            "6f826c540dbada61c4198e6e78b015735b6724ea2a2276692e17ef11cd1af572",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x333339f8ed5b6040448831009130199110b7e999",
            "BIp1elOzWIQxhqnZRzuX2kW4KltKPM7Fs25gpqZUwKut1sPlPm5KPP/tXkpO/2Xswza1CZZ1Ui81xz7cJFYOPO8=",
            "b4JsVA262mHEGY5ueLAVc1tnJOoqInZpLhfvEc0a9XI=",
        ),
    ),
    # vanity/0x33433
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x33433966d42e904cdb3eebdd25decd25efaf0c46",
            "0xb8f8b5baf05b71d849e6af6892e1c61f53b17acef7e45e1517ccb5305aa1947f7387e6c06db640c2a429e861ba4cd71ac5c653c5ba26b3f954277ea9807a657d",
            "578778e2581bab1b9bf682a93a4f1fc79e17a20cfc61552db0966bd96fc6f096",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x33433966d42e904cdb3eebdd25decd25efaf0c46",
            "BLj4tbrwW3HYSeavaJLhxh9TsXrO9+ReFRfMtTBaoZR/c4fmwG22QMKkKehhukzXGsXGU8W6JrP5VCd+qYB6ZX0=",
            "V4d44lgbqxub9oKpOk8fx54Xogz8YVUtsJZr2W/G8JY=",
        ),
    ),
    # vanity/0x33533
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x335330267117aaffcf1ced464f5d248126a6164b",
            "0xf23b65d21c55557b951646efed1f7f32b535e74f7c394cf8400edd1ac624147c544dbb1009d8cb514226ddf1c1104830361fa5d4093272f219e7853f0e15e9a4",
            "c672e4733be32fb981752505596a81e1423c684f5228aba5aba3cbf669a21116",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x335330267117aaffcf1ced464f5d248126a6164b",
            "BPI7ZdIcVVV7lRZG7+0ffzK1NedPfDlM+EAO3RrGJBR8VE27EAnYy1FCJt3xwRBIMDYfpdQJMnLyGeeFPw4V6aQ=",
            "xnLkczvjL7mBdSUFWWqB4UI8aE9SKKulq6PL9mmiERY=",
        ),
    ),
    # vanity/0x33633
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x3363335f136cffb2a6195d685b4ee4cf0e669c3c",
            "0x76433c30a0e39ab8f9776dd5b11ca947ce676a11d328b5df628e2e34a24ac80f8cc9a4b6445ef51396491abd9f04ea22af62e464dac0d901a54f00782380c176",
            "95902b8cf7f3f2cb34276e5603d08fe2b5f239cf069b78ca7e020e0f65947d67",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x3363335f136cffb2a6195d685b4ee4cf0e669c3c",
            "BHZDPDCg45q4+Xdt1bEcqUfOZ2oR0yi132KOLjSiSsgPjMmktkRe9ROWSRq9nwTqIq9i5GTawNkBpU8AeCOAwXY=",
            "lZArjPfz8ss0J25WA9CP4rXyOc8Gm3jKfgIOD2WUfWc=",
        ),
    ),
    # vanity/0x33733
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x337339ee0d09dcac4a3e1cab0aea83bcf9ef7df2",
            "0x670ce45cca29f5159293368733d9d4310fd17139ab64376fbff22b9e889a692d30f3f0a06124b96e7eaac3964c3628162009947faafc2ee8791a847ede056fcf",
            "3d576cf1bc3eeb02ce59e5b9283857c9f5028dde6cddeb25d520ededea3dfa34",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x337339ee0d09dcac4a3e1cab0aea83bcf9ef7df2",
            "BGcM5FzKKfUVkpM2hzPZ1DEP0XE5q2Q3b7/yK56ImmktMPPwoGEkuW5+qsOWTDYoFiAJlH+q/C7oeRqEft4Fb88=",
            "PVds8bw+6wLOWeW5KDhXyfUCjd5s3esl1SDt7eo9+jQ=",
        ),
    ),
    # vanity/0x33833
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x33833acf34247f7291e4626c0c360aa5bebde00b",
            "0xf95702eb7847ae01e433fce01f9cbef5bc50180c61e66644ccc8e447d1c8acb4860dba79d6a2f2274e05a1aebf92c2cb15ff70cace92652ecb4a53f80c3c3b41",
            "a61dca9170138b093c4389812669c5e2fe823e2bccd005f2167a5ba28ee0259a",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x33833acf34247f7291e4626c0c360aa5bebde00b",
            "BPlXAut4R64B5DP84B+cvvW8UBgMYeZmRMzI5EfRyKy0hg26edai8idOBaGuv5LCyxX/cMrOkmUuy0pT+Aw8O0E=",
            "ph3KkXATiwk8Q4mBJmnF4v6CPivM0AXyFnpboo7gJZo=",
        ),
    ),
    # vanity/0x33933
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x3393386763347612ea438f855559a73d1f8f8e0b",
            "0x4191c636a693673ac48eccf917c3e97a2e9eeeac288a28143c923ffcd3d68266b8908bbb8fa928d1dc1ea884bc436c6a25cbd878038ea70ed4a7c99c5b2180d5",
            "a074e3a56cd2db0486b17cd00fd17ad26f7da3c334a0ca8cd9800b9e28ccf2a3",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x3393386763347612ea438f855559a73d1f8f8e0b",
            "BEGRxjamk2c6xI7M+RfD6Xounu6sKIooFDySP/zT1oJmuJCLu4+pKNHcHqiEvENsaiXL2HgDjqcO1KfJnFshgNU=",
            "oHTjpWzS2wSGsXzQD9F60m99o8M0oMqM2YALnijM8qM=",
        ),
    ),
    # vanity/0x34034
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x340340d6b024bb5fbb23be1c29bc789a022ee20f",
            "0xcd8d3b8674db397c8771b861db92e164f82f664206bfb76022abe51e4891ed10ef20db081b38fd9583df8251007267ed0983182fc28d211bda69c596e1bdd494",
            "3bd5542bc7c6d2e9b69835e0018013227701ff26034aa0d9395846dff65850d5",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x340340d6b024bb5fbb23be1c29bc789a022ee20f",
            "BM2NO4Z02zl8h3G4YduS4WT4L2ZCBr+3YCKr5R5Ike0Q7yDbCBs4/ZWD34JRAHJn7QmDGC/CjSEb2mnFluG91JQ=",
            "O9VUK8fG0um2mDXgAYATIncB/yYDSqDZOVhG3/ZYUNU=",
        ),
    ),
    # vanity/0x34134
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x34134c446116a64e95f17ca58785440ac21979eb",
            "0xd2f1d6e1fd630a87b199c0565814a14b3ffa8716bc51cf620ef2ef10c87f94d0ade85dc72fe4a020a137893bc2f411778d888d05f89452bad1d395b2c75b5e08",
            "5f2ca7bc43b0e05499e1e5fb1d14038994d4f8092b2134e36fde58170bc270f3",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x34134c446116a64e95f17ca58785440ac21979eb",
            "BNLx1uH9YwqHsZnAVlgUoUs/+ocWvFHPYg7y7xDIf5TQrehdxy/koCChN4k7wvQRd42IjQX4lFK60dOVssdbXgg=",
            "XyynvEOw4FSZ4eX7HRQDiZTU+AkrITTjb95YFwvCcPM=",
        ),
    ),
    # vanity/0x34234
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x3423429791831759233e35bf4abc0b53014b60aa",
            "0x963d4b428ec2f2356db4acd46bf15e4bca983f42d5d281ac6ec6853c34039878f797bec0d9fb47cf661f91397e4914df9a1e8a1f9f31a6bcd1fce50e06c6cf90",
            "86e0680f479fc134fbe8b7134e276d1d992a4ace1bf1c3f029b53e0ae78dfbcb",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x3423429791831759233e35bf4abc0b53014b60aa",
            "BJY9S0KOwvI1bbSs1GvxXkvKmD9C1dKBrG7GhTw0A5h495e+wNn7R89mH5E5fkkU35oeih+fMaa80fzlDgbGz5A=",
            "huBoD0efwTT76LcTTidtHZkqSs4b8cPwKbU+CueN+8s=",
        ),
    ),
    # vanity/0x34334
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x34334edca1faeeba4e6daa0c1663037ca3777084",
            "0xa41888d217f5f4e16c3b84279f6742490b3890797e1d2e3894618b4224c866090d39d3eecfdc126bb68de956f284c2e6504515b0585d958d5d6ddf9ca23b4ade",
            "8958d66d03ae23b2c3d1a7277c9a1c6fc7450cf7e3177c0a68d19f04abf69c90",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x34334edca1faeeba4e6daa0c1663037ca3777084",
            "BKQYiNIX9fThbDuEJ59nQkkLOJB5fh0uOJRhi0IkyGYJDTnT7s/cEmu2jelW8oTC5lBFFbBYXZWNXW3fnKI7St4=",
            "iVjWbQOuI7LD0acnfJocb8dFDPfjF3wKaNGfBKv2nJA=",
        ),
    ),
    # vanity/0x34434
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x34434ebaec0324d1c9420a6c16d855e9bfb46ca2",
            "0xaf007b37b504957d13bb0f7156d1f7dfd100a51fd0b5549ee1a298267a6fde5736a7127b3f0a107b9605b7a11e46c7d6427841dfd7ac27cf0877dd321c1d7370",
            "63e838bacf869569b5ed6d80fc6b12c5714c499767d409882399fcb550a811a6",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x34434ebaec0324d1c9420a6c16d855e9bfb46ca2",
            "BK8Aeze1BJV9E7sPcVbR99/RAKUf0LVUnuGimCZ6b95XNqcSez8KEHuWBbehHkbH1kJ4Qd/XrCfPCHfdMhwdc3A=",
            "Y+g4us+GlWm17W2A/GsSxXFMSZdn1AmII5n8tVCoEaY=",
        ),
    ),
    # vanity/0x34534
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x3453466116f94a268eff1658d7d03c59f791f9d9",
            "0xe5073bfaa5a73403e06e8b867a70f8c5b0b02d75a3969203cb93737e1e33fab248dbe33d46ae51665ddbfe5a382bed91f956e1c31ea2a9a8af62c825f42c98af",
            "ad1f3aab6d2c64c32e406e0f1ce771e0a5bb9f5239987e8dc1ab57750922030e",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x3453466116f94a268eff1658d7d03c59f791f9d9",
            "BOUHO/qlpzQD4G6Lhnpw+MWwsC11o5aSA8uTc34eM/qySNvjPUauUWZd2/5aOCvtkflW4cMeoqmor2LIJfQsmK8=",
            "rR86q20sZMMuQG4PHOdx4KW7n1I5mH6NwatXdQkiAw4=",
        ),
    ),
    # vanity/0x34634
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x3463443218c28f6b4a2a8534d8fd63ffd1177823",
            "0x20731fb0bc76276209cc99496ee58908ba76f0d319361506801bee19b99345e92619223ee39db68c55fd7f41394b78be2d255c8dad9b43ee000addf8b86b35a1",
            "51812c198331dd5ce28d7e96f5c7fd66b71cb7be9b35f6de8a04013be9b2f0c6",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x3463443218c28f6b4a2a8534d8fd63ffd1177823",
            "BCBzH7C8didiCcyZSW7liQi6dvDTGTYVBoAb7hm5k0XpJhkiPuOdtoxV/X9BOUt4vi0lXI2tm0PuAArd+LhrNaE=",
            "UYEsGYMx3VzijX6W9cf9Zrcct76bNfbeigQBO+my8MY=",
        ),
    ),
    # vanity/0x34734
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x3473439bd6b8816f85bda705e698d1f73d7e11fd",
            "0xd412504f2a256e8b55b034fd1907d66b957253f5c40118ddd4c0798770c31560c706bb8061b692516e2982d5a7501a591a0ca9576b7a5cf8e7f52efa7b81a107",
            "328c6e75070076555c037f6d17bdee57de5617b0f9e70158eb01a3bdac2903ef",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x3473439bd6b8816f85bda705e698d1f73d7e11fd",
            "BNQSUE8qJW6LVbA0/RkH1muVclP1xAEY3dTAeYdwwxVgxwa7gGG2klFuKYLVp1AaWRoMqVdrelz45/Uu+nuBoQc=",
            "MoxudQcAdlVcA39tF73uV95WF7D55wFY6wGjvawpA+8=",
        ),
    ),
    # vanity/0x34834
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x34834718c71ad74567a4aacdff93e386970ed6b2",
            "0x942fc25a1d67a4e2b6c591dc989d0076d62b141e2da3617b8cafcc0c6786611f99191e6c9e60947186320c5bc0c87c5a30cb74ecdee6aab4e0f646e23d38995a",
            "f646cd5ff7b9a1e13f8ceccf0e3c04e01da27275e0169719f48d8f55fd71a63c",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x34834718c71ad74567a4aacdff93e386970ed6b2",
            "BJQvwlodZ6TitsWR3JidAHbWKxQeLaNhe4yvzAxnhmEfmRkebJ5glHGGMgxbwMh8WjDLdOze5qq04PZG4j04mVo=",
            "9kbNX/e5oeE/jOzPDjwE4B2icnXgFpcZ9I2PVf1xpjw=",
        ),
    ),
    # vanity/0x34934
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x34934854c1207d0a15e546de624fb9aa27a58e28",
            "0xd5e4ec7f8192a12ba530787b9f0e16d16b716949195f0ec648cb4ff590786fc2fd4580f026e53c5f2ee6f33a5b714e1a7e41f2ccb6f5ad4b6292034eacbbbd45",
            "86af38f3b7192655552493466c755001361cc876b3ef9858b0556306718f6b51",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x34934854c1207d0a15e546de624fb9aa27a58e28",
            "BNXk7H+BkqErpTB4e58OFtFrcWlJGV8OxkjLT/WQeG/C/UWA8CblPF8u5vM6W3FOGn5B8sy29a1LYpIDTqy7vUU=",
            "hq8487cZJlVVJJNGbHVQATYcyHaz75hYsFVjBnGPa1E=",
        ),
    ),
    # vanity/0x35035
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x3503518d0191448e97428d2e5383ffe3eddc9d43",
            "0x2eb44eff5d9de09661027b13004d7ec7311a1332c7373fb9fa963d8ef03b5b3c0d244495e47da00526d0f9facb8f6d87a6f8a84c5a0a09fda228867a6b0c99ae",
            "5c2b25bb04efacacf25adadd79c07f54ac1cc63f4e84910dfc96fa5a61772c4d",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x3503518d0191448e97428d2e5383ffe3eddc9d43",
            "BC60Tv9dneCWYQJ7EwBNfscxGhMyxzc/ufqWPY7wO1s8DSREleR9oAUm0Pn6y49th6b4qExaCgn9oiiGemsMma4=",
            "XCsluwTvrKzyWtrdecB/VKwcxj9OhJEN/Jb6WmF3LE0=",
        ),
    ),
    # vanity/0x35135
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x3513587955f428707192cda2d88ac216be51e437",
            "0x3cbc35b3785b29a15c46e301ef5d77b2f341f04486459d95a4aa6b1f6f7973d01233271c0e6ccef25cc0da90e47a9360d17131e9c83a4f32018469e23e551597",
            "b23d5de7da151e1763a59577f70fe306759d534387495ab17fbac85fa7b2067a",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x3513587955f428707192cda2d88ac216be51e437",
            "BDy8NbN4WymhXEbjAe9dd7LzQfBEhkWdlaSqax9veXPQEjMnHA5szvJcwNqQ5HqTYNFxMenIOk8yAYRp4j5VFZc=",
            "sj1d59oVHhdjpZV39w/jBnWdU0OHSVqxf7rIX6eyBno=",
        ),
    ),
    # vanity/0x35235
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x35235c1b056ac628b993e083102e53648848a9d6",
            "0xbad46c77a318ead47eeb6e573c42ad924725f51e9a184915b00d9f1423090fcdad7cb968422cfa6e004b5a895885efd84f8fccf969edecb6fe1fee07b0315681",
            "76ab22b9102c390b108c5f497e73e2b41723a1a7922c6269430c5d8ec0d4076f",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x35235c1b056ac628b993e083102e53648848a9d6",
            "BLrUbHejGOrUfutuVzxCrZJHJfUemhhJFbANnxQjCQ/NrXy5aEIs+m4AS1qJWIXv2E+PzPlp7ey2/h/uB7AxVoE=",
            "dqsiuRAsOQsQjF9JfnPitBcjoaeSLGJpQwxdjsDUB28=",
        ),
    ),
    # vanity/0x35335
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x35335f3632606f2f256ac9d24e924039c98e4ad0",
            "0xd95d11049731e7fde40ef76ce2729686c9383700368b6c3da4c3037c3d687c471f5f481be06eee9c96ae75e6ed01c692d63a485581cb792545be7d862c5d1b06",
            "0ee8000744e782a06b33394bbe9e8694a1015511f8c60e9bee1d6ce51a6db977",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x35335f3632606f2f256ac9d24e924039c98e4ad0",
            "BNldEQSXMef95A73bOJylobJODcANotsPaTDA3w9aHxHH19IG+Bu7pyWrnXm7QHGktY6SFWBy3klRb59hixdGwY=",
            "DugAB0TngqBrMzlLvp6GlKEBVRH4xg6b7h1s5RptuXc=",
        ),
    ),
    # vanity/0x35435
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x35435addca2b62a83f42cd789d6639f7ba0d1a8e",
            "0x17265f9cae589f7fac8234e1c914b11f9d8534f6ee6573c6b76cdaba3e0f41d60602d9609ebf00b119beca0e2b819489f8cd150f780144b8ebb641f53ed3645f",
            "36672220981499b13bfa0cfb058f6a2312aa46c2e485ba1cafa590a82d5d2052",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x35435addca2b62a83f42cd789d6639f7ba0d1a8e",
            "BBcmX5yuWJ9/rII04ckUsR+dhTT27mVzxrds2ro+D0HWBgLZYJ6/ALEZvsoOK4GUifjNFQ94AUS467ZB9T7TZF8=",
            "NmciIJgUmbE7+gz7BY9qIxKqRsLkhbocr6WQqC1dIFI=",
        ),
    ),
    # vanity/0x35535
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x35535dd8aecd9e017a0ceb95dce7a78ca93f3a79",
            "0x03de296a29944054e1463b6af10d396fbdbd671dbca176a2d711d2650ad1645baee096622b09ce240a891ec52bc35433d95e98bb6d614edc2f7c1f9bd4661abd",
            "4f26afa8b8188687bb39c294e3bbee852076f1e36e11a4a224942e37b24bb3e1",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x35535dd8aecd9e017a0ceb95dce7a78ca93f3a79",
            "BAPeKWoplEBU4UY7avENOW+9vWcdvKF2otcR0mUK0WRbruCWYisJziQKiR7FK8NUM9lemLttYU7cL3wfm9RmGr0=",
            "TyavqLgYhoe7OcKU47vuhSB28eNuEaSiJJQuN7JLs+E=",
        ),
    ),
    # vanity/0x35635
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x356354fc32d1939e18f89ff21dd3729fb67383e0",
            "0xf8e59d5e873d93369d7f1b4357b50ff367352e1cede9fe415b9fda61731a959f0aca2cd4baec54da66004d9bf72bb12271aaf58a6e98b7a2bdfffd276c3a8680",
            "7bda1423b0828b1af3755cb1ef2ee472a3a61b52bff38a107b1871210fa8c05b",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x356354fc32d1939e18f89ff21dd3729fb67383e0",
            "BPjlnV6HPZM2nX8bQ1e1D/NnNS4c7en+QVuf2mFzGpWfCsos1LrsVNpmAE2b9yuxInGq9YpumLeivf/9J2w6hoA=",
            "e9oUI7CCixrzdVyx7y7kcqOmG1K/84oQexhxIQ+owFs=",
        ),
    ),
    # vanity/0x35735
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x35735045b2fca8149b19d9b72586719594769f1a",
            "0xe9ed0be8ee86d339c20fb751371ec9440271ccadcce1e3d76c7111fba10a16f332f1da9abc4e007b75934c85c06b5255ed1152e1adcdfee2c571d8d1aa3c5041",
            "76c915807a58b7ee5486581e4d2b13ec7bf7e3889b2ef665845043cb515ff0a6",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x35735045b2fca8149b19d9b72586719594769f1a",
            "BOntC+juhtM5wg+3UTceyUQCccytzOHj12xxEfuhChbzMvHamrxOAHt1k0yFwGtSVe0RUuGtzf7ixXHY0ao8UEE=",
            "dskVgHpYt+5UhlgeTSsT7Hv344ibLvZlhFBDy1Ff8KY=",
        ),
    ),
    # vanity/0x35835
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x358353d75b8f4272d724143b38aabaf60918e423",
            "0xcc59fdc0159efa2ff0e188c7a8ae0dda16d135a01c3d4b1c554ec98df9f20398963d2849a846bfb63fd008d983fc0927fd77608bf1e2399d14287f26581ddd1b",
            "90f34cf8203f6535615c5625049ada7b657efc655a9ef9d825e62f281cc97ada",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x358353d75b8f4272d724143b38aabaf60918e423",
            "BMxZ/cAVnvov8OGIx6iuDdoW0TWgHD1LHFVOyY358gOYlj0oSahGv7Y/0AjZg/wJJ/13YIvx4jmdFCh/Jlgd3Rs=",
            "kPNM+CA/ZTVhXFYlBJrae2V+/GVanvnYJeYvKBzJeto=",
        ),
    ),
    # vanity/0x35935
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x35935fb06bb61ff2e8ee8c05f764b962a381276e",
            "0x7d8fa8cbd01f34e260e0bc4bea0b60ca8486bdfe36da75810cc04d9508253fd408f5e193cb07fbdda88e8b94d19fa6daa5f284c8af0478727f4788e7cd59c303",
            "574510a48bf9e7144a2aad1cc3d559aa696b4e4e0cde9ef846034e99b370b9fb",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x35935fb06bb61ff2e8ee8c05f764b962a381276e",
            "BH2PqMvQHzTiYOC8S+oLYMqEhr3+Ntp1gQzATZUIJT/UCPXhk8sH+92ojouU0Z+m2qXyhMivBHhyf0eI581ZwwM=",
            "V0UQpIv55xRKKq0cw9VZqmlrTk4M3p74RgNOmbNwufs=",
        ),
    ),
    # vanity/0x36036
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x360362560481382a426c59478e17262e35766fb6",
            "0xb467ec9a056f006f73771d6acdd7b1331ba82d8b7b2b259d2692ff107db88af8f8ee7579f54fe7afe72dc6dbfaf8bccb6163f9bcf6cf2ae60347cec504870582",
            "dd19ab002da8871463adb1e7de68c870c7d8cd434cdf18915436930ba5fe1c03",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x360362560481382a426c59478e17262e35766fb6",
            "BLRn7JoFbwBvc3cdas3XsTMbqC2LeyslnSaS/xB9uIr4+O51efVP56/nLcbb+vi8y2Fj+bz2zyrmA0fOxQSHBYI=",
            "3RmrAC2ohxRjrbHn3mjIcMfYzUNM3xiRVDaTC6X+HAM=",
        ),
    ),
    # vanity/0x36136
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x361360924debc0790b157f39ae139745a0df7cae",
            "0x7eea0c0027b557f6e6398b8b4d877528b154fc1fe926adc80965dce85012002b04f967bccaa43bb9bd23001ab11dd7a6e8983d7f3257e07be784e7de4088396e",
            "e117292ed7f2fb098bdaf368e96c4859f2481421a2aed42b7cbfc3455b6b9619",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x361360924debc0790b157f39ae139745a0df7cae",
            "BH7qDAAntVf25jmLi02HdSixVPwf6SatyAll3OhQEgArBPlnvMqkO7m9IwAasR3XpuiYPX8yV+B754Tn3kCIOW4=",
            "4RcpLtfy+wmL2vNo6WxIWfJIFCGirtQrfL/DRVtrlhk=",
        ),
    ),
    # vanity/0x36236
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x36236c4df7b8ba555d770a975b4aac212d34a87c",
            "0x87614e465b5876733dff5fc448d0287dd2d693f3cd285c11f35817bddce34668fcbd2d0088636b08fb3d9e5b6fdd8c93a2dcd9380983680e2ee12b25d8e2f5d9",
            "7df5d772d756b301ec2eee743377bc03282619ee06aec1488df18f6fefc572e0",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x36236c4df7b8ba555d770a975b4aac212d34a87c",
            "BIdhTkZbWHZzPf9fxEjQKH3S1pPzzShcEfNYF73c40Zo/L0tAIhjawj7PZ5bb92Mk6Lc2TgJg2gOLuErJdji9dk=",
            "ffXXctdWswHsLu50M3e8AygmGe4GrsFIjfGPb+/FcuA=",
        ),
    ),
    # vanity/0x36336
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x363362e25fd7f77abf03f4b2a2b285f3da6bc107",
            "0x9a3b2b90e8103a1b4158e89c476aa1a0d46049ff6ce078156cd1237378a03bf38842e7a89559083026c9845d1c633725654e1afa9e2edef734f851f31e1008df",
            "93b03205defd8578386d4a9db1dafd572783c422964c52369171ce6a01ce3069",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x363362e25fd7f77abf03f4b2a2b285f3da6bc107",
            "BJo7K5DoEDobQVjonEdqoaDUYEn/bOB4FWzRI3N4oDvziELnqJVZCDAmyYRdHGM3JWVOGvqeLt73NPhR8x4QCN8=",
            "k7AyBd79hXg4bUqdsdr9VyeDxCKWTFI2kXHOagHOMGk=",
        ),
    ),
    # vanity/0x36436
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x36436ce5be5eb788acf0cdd4fd2de9d61f8eec16",
            "0x885508159e3dcbeba1b9eb93e97297c4a50766a8567e4fe15705e6630017439ec1625975ec488f4b526607379c1aef9bc85cd9ff4ad98fe70f39b5e6f86ef916",
            "d5b64b59187785c02d391b9822ed2cffcf9abe3d3541d5cfdcf463feceac2bea",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x36436ce5be5eb788acf0cdd4fd2de9d61f8eec16",
            "BIhVCBWePcvrobnrk+lyl8SlB2aoVn5P4VcF5mMAF0OewWJZdexIj0tSZgc3nBrvm8hc2f9K2Y/nDzm15vhu+RY=",
            "1bZLWRh3hcAtORuYIu0s/8+avj01QdXP3PRj/s6sK+o=",
        ),
    ),
    # vanity/0x36536
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x3653666b7d0c0a3593a8935b3f2315121930394a",
            "0xe967b7b35b638fc8b0543e2b7bf4a337554038ed4e60af0563271f36f4611d94240effb0b7d8924751e6ad4e0feba1df67519d093e3a786c56f5a2d371eaa39f",
            "6c558767a55d240f556294ac018b3f68847770327cce3c50d5cf156182db5c7c",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x3653666b7d0c0a3593a8935b3f2315121930394a",
            "BOlnt7NbY4/IsFQ+K3v0ozdVQDjtTmCvBWMnHzb0YR2UJA7/sLfYkkdR5q1OD+uh32dRnQk+OnhsVvWi03Hqo58=",
            "bFWHZ6VdJA9VYpSsAYs/aIR3cDJ8zjxQ1c8VYYLbXHw=",
        ),
    ),
    # vanity/0x36636
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x3663614a224466150e20189d0e6782e54f8a68b8",
            "0xb3b14af0227d1ec1c9ba7492878421d5ad982f0f810c12dde94e4deace927190ce2a999eb82e662d85ee431ff8d9b69b4563f539547805c6d29baaaa51c34bef",
            "6b207dd5970cc58ec98fe40ddeb2f593d02b8b19a6dbe75b4e64325d0d5e34de",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x3663614a224466150e20189d0e6782e54f8a68b8",
            "BLOxSvAifR7Bybp0koeEIdWtmC8PgQwS3elOTerOknGQziqZnrguZi2F7kMf+Nm2m0Vj9TlUeAXG0puqqlHDS+8=",
            "ayB91ZcMxY7Jj+QN3rL1k9Arixmm2+dbTmQyXQ1eNN4=",
        ),
    ),
    # vanity/0x36736
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x36736ffa1bfa8e94d1226184ad79d67f27ad385d",
            "0x323ab1c0aac33b053d861cc005e8716ae1d4abc4b53387d7d6a86a0c6c36d4d9389f795a41daa4839b3fd19e7aacbd9b0fd61a129867cac1f7317334bc534c76",
            "4b51fbab18718d7c0b482309b2ecfe69188880581f1ae51de6e9c3418cf30a57",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x36736ffa1bfa8e94d1226184ad79d67f27ad385d",
            "BDI6scCqwzsFPYYcwAXocWrh1KvEtTOH19aoagxsNtTZOJ95WkHapIObP9Geeqy9mw/WGhKYZ8rB9zFzNLxTTHY=",
            "S1H7qxhxjXwLSCMJsuz+aRiIgFgfGuUd5unDQYzzClc=",
        ),
    ),
    # vanity/0x36836
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x3683693716c4632c194cf1a2edfec6f8c0f027ae",
            "0x04bccfb2bdc0e80a06d5f87128c43bd79cecb00c9267abadc2d6703cb6c94104be06b873e7e6cb03a25a627717e1f4e9165d9e6c99afc08fa2c074774d299bf4",
            "f16c763ce7d5ec32b740942f77850ad635e5be38d2aeeca80fff5c4f98ef29f2",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x3683693716c4632c194cf1a2edfec6f8c0f027ae",
            "BAS8z7K9wOgKBtX4cSjEO9ec7LAMkmerrcLWcDy2yUEEvga4c+fmywOiWmJ3F+H06RZdnmyZr8CPosB0d00pm/Q=",
            "8Wx2POfV7DK3QJQvd4UK1jXlvjjSruyoD/9cT5jvKfI=",
        ),
    ),
    # vanity/0x36936
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x36936db2574fcac517d61ef55d6615fea5a7ccdf",
            "0x54b6a23ccd2b97bb064aede40b081e05b02fbab4b17a3285689f6ddb618b3c6a6a826f085db259927c4197b2f7014e0a07bde69a07eef431004787600410f2fc",
            "26996daf312a3058717fdb657e0f893e4a4435c5330c73f111cf724c988ba1db",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x36936db2574fcac517d61ef55d6615fea5a7ccdf",
            "BFS2ojzNK5e7Bkrt5AsIHgWwL7q0sXoyhWifbdthizxqaoJvCF2yWZJ8QZey9wFOCge95poH7vQxAEeHYAQQ8vw=",
            "JpltrzEqMFhxf9tlfg+JPkpENcUzDHPxEc9yTJiLods=",
        ),
    ),
    # vanity/0x37037
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x370371ddeb2419860eb1bbfb29e74f26e02501ea",
            "0x6e3e99b59f13a636a0ccb0d44e122932201bfed230f359c4e0e2707485834eddb0f8d1d21a7b3aaac71078d7be60ff0ee53d6d9b5eec91ceaf8370632edbd93a",
            "5ef31f552d18a67a32313b000b05f32f6b85acedcee9c011eefbfb79395a1319",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x370371ddeb2419860eb1bbfb29e74f26e02501ea",
            "BG4+mbWfE6Y2oMyw1E4SKTIgG/7SMPNZxODicHSFg07dsPjR0hp7OqrHEHjXvmD/DuU9bZte7JHOr4NwYy7b2To=",
            "XvMfVS0YpnoyMTsACwXzL2uFrO3O6cAR7vv7eTlaExk=",
        ),
    ),
    # vanity/0x37137
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x37137a8154583c9067fe1043242686ae3459b626",
            "0x4d276510f48150bc6e24eb3474119cbac6da6cc98f78211b4918a106100802433575931e8a91dfc7809e40c7f1e47fec827c019bceb8c3c10cb15e83a5777afa",
            "a72aeaee1ffe828068e33847b896e2a0ed19c09eb0c091bfddea6a559d305428",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x37137a8154583c9067fe1043242686ae3459b626",
            "BE0nZRD0gVC8biTrNHQRnLrG2mzJj3ghG0kYoQYQCAJDNXWTHoqR38eAnkDH8eR/7IJ8AZvOuMPBDLFeg6V3evo=",
            "pyrq7h/+goBo4zhHuJbioO0ZwJ6wwJG/3epqVZ0wVCg=",
        ),
    ),
    # vanity/0x37237
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x372372523b30605df4ece41e9aa9e6e2961df13d",
            "0xf086e8a45ce8aa7ad955140ca01a64264666f1d816287814a3d0614ac5c3680ee218f46f208909a7a772eea60cb8bb4b9127a67f70a19d9a64bb13e77a0a594b",
            "c55abd1d8636738f840effd34b2e1c753b7ca036a30d9a259deddbfa70818779",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x372372523b30605df4ece41e9aa9e6e2961df13d",
            "BPCG6KRc6Kp62VUUDKAaZCZGZvHYFih4FKPQYUrFw2gO4hj0byCJCaencu6mDLi7S5Enpn9woZ2aZLsT53oKWUs=",
            "xVq9HYY2c4+EDv/TSy4cdTt8oDajDZolne3b+nCBh3k=",
        ),
    ),
    # vanity/0x37337
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x37337e2a425f564a0268869e7a2753b93b56c278",
            "0xba218a788187b37f640790ec4fa98fea876a6ad2cc30b4e2cc1b2a6981b8a8872317d721f13409cff77e754c084c71503b1b8bdb18eab1e2b9f20414205cb6e5",
            "6a9e292804a05fa4b783ed0123a4bb3dec59137d0803972ea63fa9dceb9096ab",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x37337e2a425f564a0268869e7a2753b93b56c278",
            "BLohiniBh7N/ZAeQ7E+pj+qHamrSzDC04swbKmmBuKiHIxfXIfE0Cc/3fnVMCExxUDsbi9sY6rHiufIEFCBctuU=",
            "ap4pKASgX6S3g+0BI6S7PexZE30IA5cupj+p3OuQlqs=",
        ),
    ),
    # vanity/0x37437
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x3743798c54cf45d21eedd32fcb7c2b47ed083120",
            "0x102ca045857a42af3b2964d5522c28bf57eea951a6cbf48220d8a92ae311114433bff29454564a23927809e7b26230aae530f768ea85c81d476420f5f061f0c5",
            "55344711aa4de7aeecbcb2f3ec8babad57085d71dd45431f49607202a36393e1",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x3743798c54cf45d21eedd32fcb7c2b47ed083120",
            "BBAsoEWFekKvOylk1VIsKL9X7qlRpsv0giDYqSrjERFEM7/ylFRWSiOSeAnnsmIwquUw92jqhcgdR2Qg9fBh8MU=",
            "VTRHEapN567svLLz7IurrVcIXXHdRUMfSWByAqNjk+E=",
        ),
    ),
    # vanity/0x37537
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x375370cb24dca741df290631dcd7c50cc0c9b3d8",
            "0xf2d9f5bd8fd8e873c101c894e8e74f5bde48b90b8b60e416728772bb74109935a8ede4483e0231a1a4353acbbb7d2b5cfd3fc9c693b7f9da64a7898da17e02a2",
            "2fec18ebfe1b31b4445fb8dcd25826e4c9cf6ae060bb65c410b35cef2e993257",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x375370cb24dca741df290631dcd7c50cc0c9b3d8",
            "BPLZ9b2P2OhzwQHIlOjnT1veSLkLi2DkFnKHcrt0EJk1qO3kSD4CMaGkNTrLu30rXP0/ycaTt/naZKeJjaF+AqI=",
            "L+wY6/4bMbREX7jc0lgm5MnPauBgu2XEELNc7y6ZMlc=",
        ),
    ),
    # vanity/0x37637
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x3763778f16097f453e70cc84602e375f15165239",
            "0x0bf5ce474c5f7f9d60fa012d1fd6268feadcaf49676efd89f24c29b16fbeeee6806ee43b02afebe2a723d2444638f69345eabfdd031fb0a834380bdf0e76f746",
            "5536afc04a95e67f0787177087b0569436c0ab69a1a327cc94bf4d3fe41cab6d",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x3763778f16097f453e70cc84602e375f15165239",
            "BAv1zkdMX3+dYPoBLR/WJo/q3K9JZ279ifJMKbFvvu7mgG7kOwKv6+KnI9JERjj2k0Xqv90DH7CoNDgL3w5290Y=",
            "VTavwEqV5n8Hhxdwh7BWlDbAq2mhoyfMlL9NP+Qcq20=",
        ),
    ),
    # vanity/0x37737
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x377374345d469e89ea3f6d6ef551c489d70b9d9c",
            "0x6a7dc02eda3857f9097112ae402fe2217419023d1aa285c86ff3436f32a39f2174ea0674bc4a0ab2c62db2d0826ae9dff4a8e2b84f46b1e6cf27ac4317d17b34",
            "6c20bb3026f0be5340b63075968a3cd6018d52c0158a62802b77db41ec1532ae",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x377374345d469e89ea3f6d6ef551c489d70b9d9c",
            "BGp9wC7aOFf5CXESrkAv4iF0GQI9GqKFyG/zQ28yo58hdOoGdLxKCrLGLbLQgmrp3/So4rhPRrHmzyesQxfRezQ=",
            "bCC7MCbwvlNAtjB1loo81gGNUsAVimKAK3fbQewVMq4=",
        ),
    ),
    # vanity/0x37837
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x3783778c97a988350356bff4bde05d89d36d874e",
            "0xa34d52c0e04b6c27a2afe29955af1c8e5eb0e1cee1477f6f583f31aa48ae7f5c66db080d8d37ada833d07548e052f6cb914e745460b60c553423ef394e4f0958",
            "b1650daea6cc2734a9b2fb00203d82404163e38b49b4f06765b7263f4c8285fb",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x3783778c97a988350356bff4bde05d89d36d874e",
            "BKNNUsDgS2wnoq/imVWvHI5esOHO4Ud/b1g/MapIrn9cZtsIDY03ragz0HVI4FL2y5FOdFRgtgxVNCPvOU5PCVg=",
            "sWUNrqbMJzSpsvsAID2CQEFj44tJtPBnZbcmP0yChfs=",
        ),
    ),
    # vanity/0x37937
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x37937c50cf35f1927e2e3404a04ba03e0365d449",
            "0x022d8b64699328c07346bacefb5b8b4e07be976d0731ecb2057a5fadef4a266588780ffae16ee7bf48e05066838dff429773881052c565690187e36f42e91b94",
            "5c1d4e87200fc3aa5c233f45cd63a86753acfdac9f860df8dcec8833bdfeb8f1",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x37937c50cf35f1927e2e3404a04ba03e0365d449",
            "BAIti2RpkyjAc0a6zvtbi04HvpdtBzHssgV6X63vSiZliHgP+uFu579I4FBmg43/QpdziBBSxWVpAYfjb0LpG5Q=",
            "XB1OhyAPw6pcIz9FzWOoZ1Os/ayfhg343OyIM73+uPE=",
        ),
    ),
    # vanity/0x38038
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x380387f1853a1eadd5dfbcd8002745ca8a3ef195",
            "0xdba235a76d3bf42b518ef9600d8f1ac8ab707c5f6429feb7469af27f32954024c869b5f09cbebfb1785476fa6622d735e0778df104e1c50b6b98d1fdaa1ca0fc",
            "aa8ad28c692de3d22c9b2b32851512f3938094e5145e8103a8165d56f9a97ca9",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x380387f1853a1eadd5dfbcd8002745ca8a3ef195",
            "BNuiNadtO/QrUY75YA2PGsircHxfZCn+t0aa8n8ylUAkyGm18Jy+v7F4VHb6ZiLXNeB3jfEE4cULa5jR/aocoPw=",
            "qorSjGkt49IsmysyhRUS85OAlOUUXoEDqBZdVvmpfKk=",
        ),
    ),
    # vanity/0x38138
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x381386e04e51a320c9156ea9519c0bdd9a3beda2",
            "0x68e465e53086aa2eb660fa275d4cfc4977766ba8dd4af4a9724a91d9f26ac00987f4986ed1771492ba09e5cf1e141e2e38ef1521091cce5bec3093c589a9ceca",
            "c7a6d929deb82fa3d68ddd47f0276f7248d06731e6f7bc13b4ee62d3106361c8",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x381386e04e51a320c9156ea9519c0bdd9a3beda2",
            "BGjkZeUwhqoutmD6J11M/El3dmuo3Ur0qXJKkdnyasAJh/SYbtF3FJK6CeXPHhQeLjjvFSEJHM5b7DCTxYmpzso=",
            "x6bZKd64L6PWjd1H8CdvckjQZzHm97wTtO5i0xBjYcg=",
        ),
    ),
    # vanity/0x38238
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x38238ed367ad6434998387f1f4eebe57031e146b",
            "0x8b27d673001cdfd0d2a5adc522dbafe045b2c20eccdef4a77ef9f098b7da3ef8022e49be3c9e28352ac317f30675d9a7a6e3f4d216f2aa2766807657c9bc86f1",
            "cabe5e51eeadc55fcda0630c0ab5874c935cb8c4488a0095040f6135f946ecc3",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x38238ed367ad6434998387f1f4eebe57031e146b",
            "BIsn1nMAHN/Q0qWtxSLbr+BFssIOzN70p3758Ji32j74Ai5JvjyeKDUqwxfzBnXZp6bj9NIW8qonZoB2V8m8hvE=",
            "yr5eUe6txV/NoGMMCrWHTJNcuMRIigCVBA9hNflG7MM=",
        ),
    ),
    # vanity/0x38338
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x38338cf54a1f35ed5e75b5e7a3155bccadcd82bb",
            "0xd34183294668ef4a3397acbf8a438dfa8196507700ba8635a31df488b1f8bd5bf3f82c8d1beb0da7bbbef6c6490f6c2acf1157bbc62f71ad1b9176113b7e0004",
            "4c908919bbea31f4ad362735374530fe5352753e2ccf548397e6d80a1ca7d135",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x38338cf54a1f35ed5e75b5e7a3155bccadcd82bb",
            "BNNBgylGaO9KM5esv4pDjfqBllB3ALqGNaMd9Iix+L1b8/gsjRvrDae7vvbGSQ9sKs8RV7vGL3GtG5F2ETt+AAQ=",
            "TJCJGbvqMfStNic1N0Uw/lNSdT4sz1SDl+bYChyn0TU=",
        ),
    ),
    # vanity/0x38438
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x3843821eaed816899161dbf84f1762da9376d592",
            "0x7b8ca8a72ec04d4d03939aaa98730d58102306816124e3b176b4d40901079c8f0acb3b7f5df6dde1b468749ff96ba32d47cd3fb4e3e7355a3cfb032038522566",
            "bc6dafaf13d8787659e13c9117b7fc3789128a5ea7c5e0ed9a733c32a729befd",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x3843821eaed816899161dbf84f1762da9376d592",
            "BHuMqKcuwE1NA5OaqphzDVgQIwaBYSTjsXa01AkBB5yPCss7f1323eG0aHSf+WujLUfNP7Tj5zVaPPsDIDhSJWY=",
            "vG2vrxPYeHZZ4TyRF7f8N4kSil6nxeDtmnM8Mqcpvv0=",
        ),
    ),
    # vanity/0x38538
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x38538310954ce80515e3c3826836ff02e2423246",
            "0xace5762bc86f4701436c83ac822c76c2c6d16069ed7730df83f5012a5c7783dbb386f4ff2dbb9bd5272bf2668f1665af82f14088757b4aa7cbf65c3e8f3ec185",
            "a6281e8f254fcc0e71dcb0fa141874ecf5b93d64b4e5556c5ea79b035d120540",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x38538310954ce80515e3c3826836ff02e2423246",
            "BKzldivIb0cBQ2yDrIIsdsLG0WBp7Xcw34P1ASpcd4Pbs4b0/y27m9UnK/JmjxZlr4LxQIh1e0qny/ZcPo8+wYU=",
            "pigejyVPzA5x3LD6FBh07PW5PWS05VVsXqebA10SBUA=",
        ),
    ),
    # vanity/0x38638
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x38638776b11ccc0c2e2f53bd8aed56f49cb70c50",
            "0xd4340e8bcc8e31b67ad73b0c548fccd354a380b884fd6ebc25c56d114fca0b1805696dbdc01ecb94cf4c581c7488850a15750f974cdd2a8db5e2d830cc2cd2fa",
            "13f5ca85ada5f3ac275c95874831e2cc7dd2934f958a76485a2fcdec99d5a57f",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x38638776b11ccc0c2e2f53bd8aed56f49cb70c50",
            "BNQ0DovMjjG2etc7DFSPzNNUo4C4hP1uvCXFbRFPygsYBWltvcAey5TPTFgcdIiFChV1D5dM3SqNteLYMMws0vo=",
            "E/XKha2l86wnXJWHSDHizH3Sk0+VinZIWi/N7JnVpX8=",
        ),
    ),
    # vanity/0x38738
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x387384612b263df2475e228cd095cb314b6d69ea",
            "0x541f24b6dc370955dcd5bfa99288c6c55d0f34ce26e12135cabbf0b9726902ad95cf687a095672fe0de3b0f669c54225b20cdf0b1287f7e394fbee5c518c2a35",
            "49dcbddc7e7f3974320e20aa674e8fac6bfa8afd6241c35f58c141820a68effe",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x387384612b263df2475e228cd095cb314b6d69ea",
            "BFQfJLbcNwlV3NW/qZKIxsVdDzTOJuEhNcq78LlyaQKtlc9oeglWcv4N47D2acVCJbIM3wsSh/fjlPvuXFGMKjU=",
            "Sdy93H5/OXQyDiCqZ06PrGv6iv1iQcNfWMFBggpo7/4=",
        ),
    ),
    # vanity/0x38838
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x388385b7e498bc52adef71b8d01315cb59ec86ab",
            "0x213056ff63e7f3050592c367973fec4f9d7c34a1c792e1f0bba1851cfab2eae27205939b12f29c636a9bc7d2f8ea7115be1283863e7f4a7fba4f889a0a94751d",
            "b0c6cde0cb35a32ed93e8ec24d3d416720802994f6fee7d19b4d3c62d1ccc5a4",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x388385b7e498bc52adef71b8d01315cb59ec86ab",
            "BCEwVv9j5/MFBZLDZ5c/7E+dfDShx5Lh8LuhhRz6suricgWTmxLynGNqm8fS+OpxFb4Sg4Y+f0p/uk+ImgqUdR0=",
            "sMbN4Ms1oy7ZPo7CTT1BZyCAKZT2/ufRm008YtHMxaQ=",
        ),
    ),
    # vanity/0x38938
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x38938ec1de9204b771aa01d4617fa7991049189a",
            "0x3e83d31008983d124787ab903a2a74dbc7f9ee4dab77c375e2b42170a2f0e971fb15c23aa9efe9b9e6b37781e59619dc8c67695ee707770277c9209701551cb7",
            "f77771e1ced91728d137c1ca7c5b5666f1ccda3733fe28b365856ff3c2a94549",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x38938ec1de9204b771aa01d4617fa7991049189a",
            "BD6D0xAImD0SR4erkDoqdNvH+e5Nq3fDdeK0IXCi8Olx+xXCOqnv6bnms3eB5ZYZ3IxnaV7nB3cCd8kglwFVHLc=",
            "93dx4c7ZFyjRN8HKfFtWZvHM2jcz/iizZYVv88KpRUk=",
        ),
    ),
    # vanity/0x39039
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x390394d3d59b967a8e6452d5f43fa5fb16231d5d",
            "0xfc0bb361363d2108ac424e0a491fa785b927af13d40942e7e38cc67d52fdc83de887050d1fe8f27cfc64b07ceeed53e72c9bb48f6a0f8e644dfff048aecd26a5",
            "345b35130ecc6f78239416a2d989e78b6aa9e4b20a87880a2eea938a8ffe5acf",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x390394d3d59b967a8e6452d5f43fa5fb16231d5d",
            "BPwLs2E2PSEIrEJOCkkfp4W5J68T1AlC5+OMxn1S/cg96IcFDR/o8nz8ZLB87u1T5yybtI9qD45kTf/wSK7NJqU=",
            "NFs1Ew7Mb3gjlBai2Ynni2qp5LIKh4gKLuqTio/+Ws8=",
        ),
    ),
    # vanity/0x39139
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x3913947df7bfa981c2f9536e7bf9b4c883c8e20f",
            "0x473bf9c590fbafb9d617c40e16ba8f934c54f9a09b21463613a2b3aa08d1681f830d7092844f29c617d9c7a365f3d5ab5b50d770358456cd56e0ff1dffbff15a",
            "4162eee92fc5a44957b74769ec3eec0be585ff4cfd055325f02d0b20842a3a2f",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x3913947df7bfa981c2f9536e7bf9b4c883c8e20f",
            "BEc7+cWQ+6+51hfEDha6j5NMVPmgmyFGNhOis6oI0Wgfgw1wkoRPKcYX2cejZfPVq1tQ13A1hFbNVuD/Hf+/8Vo=",
            "QWLu6S/FpElXt0dp7D7sC+WF/0z9BVMl8C0LIIQqOi8=",
        ),
    ),
    # vanity/0x39239
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x39239b0508d2f83635db1f088237b8d1644328a6",
            "0xf6bba3a12e0f95bfc1b438624e26fcf546a13fd521e449df7fc018cd50e916a113c53491f315b14196bbc73d0bc3cdfe3e3501e913424ecf85e881895df8ecd4",
            "e6ca8ea40fd41cc90e237b1f453b4552bd83c7e32b5f51f71d6c36be932574c4",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x39239b0508d2f83635db1f088237b8d1644328a6",
            "BPa7o6EuD5W/wbQ4Yk4m/PVGoT/VIeRJ33/AGM1Q6RahE8U0kfMVsUGWu8c9C8PN/j41AekTQk7PheiBiV347NQ=",
            "5sqOpA/UHMkOI3sfRTtFUr2Dx+MrX1H3HWw2vpMldMQ=",
        ),
    ),
    # vanity/0x39339
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x39339bdacb2620e113451a91515a680eb2a10b2a",
            "0x9aabf36fc44163784fc231fbe592623c7766a89540fbe741f697c962b5a608beeade48a1c6af2995f6c25969d0e9885aef44d29c7c52af75a670b9fd0e8093c9",
            "80c0d6deeeeef1e760c414b655b4abed57f4bba80c739e6dfa8dfdacf75ecd83",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x39339bdacb2620e113451a91515a680eb2a10b2a",
            "BJqr82/EQWN4T8Ix++WSYjx3ZqiVQPvnQfaXyWK1pgi+6t5IocavKZX2wllp0OmIWu9E0px8Uq91pnC5/Q6Ak8k=",
            "gMDW3u7u8edgxBS2VbSr7Vf0u6gMc55t+o39rPdezYM=",
        ),
    ),
    # vanity/0x39439
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x39439155059c65bfe74c3b15c8b11c96553aefc8",
            "0x9fce1e2ab9e1ee323d845c2a9166b81bf68784060386856692d2d2e22f05ad31deb1164ba88baec797a5ec4a5986f81f2c1e32f3f22b395788a59f7348104377",
            "7489f763cac3ca24ff56da7fca11cd05fb7340dd80307832790d0ac9d40a51ed",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x39439155059c65bfe74c3b15c8b11c96553aefc8",
            "BJ/OHiq54e4yPYRcKpFmuBv2h4QGA4aFZpLS0uIvBa0x3rEWS6iLrseXpexKWYb4HyweMvPyKzlXiKWfc0gQQ3c=",
            "dIn3Y8rDyiT/Vtp/yhHNBftzQN2AMHgyeQ0KydQKUe0=",
        ),
    ),
    # vanity/0x39539
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x395397ab8e5aafbcd2332c511e9787192b3198d3",
            "0x83a0aa2ce76cb6bb4d352f289454319232fe5c3b14700a8baab3c84eb90da984f50a357f1ce94b236789e6b99ca445153105a9536ddd3371184d21392df2cee1",
            "40d48eb8fd284af319a801bb74db5178af3161411a82a551d9d39618af909f0e",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x395397ab8e5aafbcd2332c511e9787192b3198d3",
            "BIOgqiznbLa7TTUvKJRUMZIy/lw7FHAKi6qzyE65DamE9Qo1fxzpSyNniea5nKRFFTEFqVNt3TNxGE0hOS3yzuE=",
            "QNSOuP0oSvMZqAG7dNtReK8xYUEagqVR2dOWGK+Qnw4=",
        ),
    ),
    # vanity/0x39639
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x39639ad717350158f5795a9bccaf6ac62f3f5868",
            "0x0450ba0f3509c19e1dee7a23b64719d55068428971a8cf1d59d2c9267b273b4c0a212f404700b19d4467f18877e1af6e1b120f1cd1da738b407edb4852472244",
            "d123e5f2d466b8934986412938f31690189c04e464a5ca5e11e124806a18df77",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x39639ad717350158f5795a9bccaf6ac62f3f5868",
            "BARQug81CcGeHe56I7ZHGdVQaEKJcajPHVnSySZ7JztMCiEvQEcAsZ1EZ/GId+GvbhsSDxzR2nOLQH7bSFJHIkQ=",
            "0SPl8tRmuJNJhkEpOPMWkBicBORkpcpeEeEkgGoY33c=",
        ),
    ),
    # vanity/0x39739
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x39739835dc43e3b1377259f41e7140ee4a79e4f1",
            "0xd5f4dc14eb12a6a41de2f17227a8b7e5aff60a7025b162cb18f16c0d92805788461b66ae97954f5a3c6128f37cf0884e6e7ea8d4dbbdc6915d4b1d349b99e6ae",
            "4136df13e19619163501fb19721e8eba0acffe38277a18389672f1e050fba3bb",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x39739835dc43e3b1377259f41e7140ee4a79e4f1",
            "BNX03BTrEqakHeLxcieot+Wv9gpwJbFiyxjxbA2SgFeIRhtmrpeVT1o8YSjzfPCITm5+qNTbvcaRXUsdNJuZ5q4=",
            "QTbfE+GWGRY1AfsZch6OugrP/jgnehg4lnLx4FD7o7s=",
        ),
    ),
    # vanity/0x39839
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x3983926e29485e83c57959eb95a4a790f7a30f5b",
            "0x09bc34bc186dfb17ec2a850015b2c718ef23589ba1b647b075916034cb67982d502f4fa50fda16e6842b6b5d1ce65b81988799fd30e392eade5fba823bcc69a2",
            "0e9dca15606d34da5c48682f4495e483688f09ba8a3326f16b024a22894a55ba",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x3983926e29485e83c57959eb95a4a790f7a30f5b",
            "BAm8NLwYbfsX7CqFABWyxxjvI1ibobZHsHWRYDTLZ5gtUC9PpQ/aFuaEK2tdHOZbgZiHmf0w45Lq3l+6gjvMaaI=",
            "Dp3KFWBtNNpcSGgvRJXkg2iPCbqKMybxawJKIolKVbo=",
        ),
    ),
    # vanity/0x39939
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x3993963fee69f9909669c451dd7586ac9da629f3",
            "0x1c28f3a660623ad924b5c2561d6efe300394f3a847ff809da69c7a469493744ac9646dd4326e317a029453090ff88656ff0f102ef966f834e12949d42ca8f415",
            "419e3d4a5e1fdb4ba78f77cb831ae18fb5f84952347643d9b5d4512232f48b3d",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x3993963fee69f9909669c451dd7586ac9da629f3",
            "BBwo86ZgYjrZJLXCVh1u/jADlPOoR/+AnaacekaUk3RKyWRt1DJuMXoClFMJD/iGVv8PEC75Zvg04SlJ1Cyo9BU=",
            "QZ49Sl4f20unj3fLgxrhj7X4SVI0dkPZtdRRIjL0iz0=",
        ),
    ),
    # vanity/0x40040
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x400400ab4bb6a424664714d937d31866acc506c2",
            "0xbede9f3f7dade232a9060d3e3f5f680074005eb5cc1b9983e5f8d27b4118245fe272ea774af39daa0d84306cc4bbd09cfdb7c8762632a92b876e86f655dd5dcc",
            "aafbef4bfd8706102b28c656bea92b2d5ddd419454097281b1c37144faccf2d0",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x400400ab4bb6a424664714d937d31866acc506c2",
            "BL7enz99reIyqQYNPj9faAB0AF61zBuZg+X40ntBGCRf4nLqd0rznaoNhDBsxLvQnP23yHYmMqkrh26G9lXdXcw=",
            "qvvvS/2HBhArKMZWvqkrLV3dQZRUCXKBscNxRPrM8tA=",
        ),
    ),
    # vanity/0x40140
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x40140b093632d722a7efeb4b4af797355a79b2c0",
            "0xc2a5e53d02adc840e8387ab5def126ea47931687665eb6245712bf0a7ff2f9e2b5d4067a0397d29efbf3909bf5fef08156b59add1cebfc217b768300b36818df",
            "2120da5f5e22c6b66ac19d8a0b0ddb64f3531983617881a481491826f6c38f9b",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x40140b093632d722a7efeb4b4af797355a79b2c0",
            "BMKl5T0CrchA6Dh6td7xJupHkxaHZl62JFcSvwp/8vnitdQGegOX0p7785Cb9f7wgVa1mt0c6/whe3aDALNoGN8=",
            "ISDaX14ixrZqwZ2KCw3bZPNTGYNheIGkgUkYJvbDj5s=",
        ),
    ),
    # vanity/0x40240
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x40240d91a14c6f0c63984d8cc1bedad6e64ecd79",
            "0xe7e918a84150bcba1836a55c7789d33ab761a969381ff2d3675207a09622e153f8c2f70087688e1479f338f814b1bc775844a240c9dea2c176eda9c44358abd9",
            "78c6083a9183f2ea5826b72e7a18082b5c6057f7e1a7c0dc5667a33217f147e4",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x40240d91a14c6f0c63984d8cc1bedad6e64ecd79",
            "BOfpGKhBULy6GDalXHeJ0zq3YalpOB/y02dSB6CWIuFT+ML3AIdojhR58zj4FLG8d1hEokDJ3qLBdu2pxENYq9k=",
            "eMYIOpGD8upYJrcuehgIK1xgV/fhp8DcVmejMhfxR+Q=",
        ),
    ),
    # vanity/0x40340
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x40340cbbab8ded58f17160cef612abba9708584f",
            "0xbb2ba5b0c4609cfb45a23a7557c00f05156e7e65c4f6861142122773ca831cd33848c3e45d150c214b0566fc5ea84bcdacf1cd8891e782e98183ad5a5f5555b9",
            "9f9530e53f19ebdeaf2d418db728e1fe05c08178678cdc563fceb8ec9011911b",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x40340cbbab8ded58f17160cef612abba9708584f",
            "BLsrpbDEYJz7RaI6dVfADwUVbn5lxPaGEUISJ3PKgxzTOEjD5F0VDCFLBWb8XqhLzazxzYiR54LpgYOtWl9VVbk=",
            "n5Uw5T8Z696vLUGNtyjh/gXAgXhnjNxWP8647JARkRs=",
        ),
    ),
    # vanity/0x40440
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x40440b0c82f4d80b3b6a2b6e71e8e210e9de82a2",
            "0x20bd5eac7b4d335b50f2ef583292fc91b4a6141082e2416e7fa8e7d2f1885be5f21ee5a4150a1a8d11036c99c2ee36c49a7362e62b19564b1a760fe2cbe72a41",
            "9df62ee93516892ebea8f647da34ff8da2f0cad3a634d239dc78cfae79251d53",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x40440b0c82f4d80b3b6a2b6e71e8e210e9de82a2",
            "BCC9Xqx7TTNbUPLvWDKS/JG0phQQguJBbn+o59LxiFvl8h7lpBUKGo0RA2yZwu42xJpzYuYrGVZLGnYP4svnKkE=",
            "nfYu6TUWiS6+qPZH2jT/jaLwytOmNNI53HjPrnklHVM=",
        ),
    ),
    # vanity/0x40540
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x405401169d4cde776b7cdebdaa84d141e412bb2d",
            "0x7786a0bcde201b40ed27717dbe79d18ddb27b64fdaa43d7514a48465c10c4725b3b5bc672753d723c82078e9d8c8c82e8676c8ae439e3ac2b659501d1071f58c",
            "1098a7c8d203cfc053cbaef6fdf8e83c742ec6066a5b82c6db695d204e4268e3",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x405401169d4cde776b7cdebdaa84d141e412bb2d",
            "BHeGoLzeIBtA7Sdxfb550Y3bJ7ZP2qQ9dRSkhGXBDEcls7W8ZydT1yPIIHjp2MjILoZ2yK5DnjrCtllQHRBx9Yw=",
            "EJinyNIDz8BTy672/fjoPHQuxgZqW4LG22ldIE5CaOM=",
        ),
    ),
    # vanity/0x40640
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x406409833a932650c0476c7467431a5ff9a0a3aa",
            "0x0732656e454a85b7ff81a58ef1e48563ac63d5b9ffd2e4676933016ca9bcec901c612e2c7169b6ab33509c23c89d07f7ea4598e826f7cb02c107c8786b388db4",
            "b5bec6e8f6abfcc2e393e3a4b0d72b96a6ed495814ed40780b3501d09c4d61da",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x406409833a932650c0476c7467431a5ff9a0a3aa",
            "BAcyZW5FSoW3/4GljvHkhWOsY9W5/9LkZ2kzAWypvOyQHGEuLHFptqszUJwjyJ0H9+pFmOgm98sCwQfIeGs4jbQ=",
            "tb7G6Par/MLjk+OksNcrlqbtSVgU7UB4CzUB0JxNYdo=",
        ),
    ),
    # vanity/0x40740
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x40740276ae17dc9b344ee2b0e82e13ee00892f93",
            "0xa3a511b1aa12c9bc90d4eefdc1ddb2101424312758c19709cbb1744a1005c56941189fe601adede4fe571c510fb3f1843d2a0fda44ace35e9398da96ccb33989",
            "c65d6d245c8ca2f4c5ed079f287057019c788cd5e6cf704597dafe38beaa804f",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x40740276ae17dc9b344ee2b0e82e13ee00892f93",
            "BKOlEbGqEsm8kNTu/cHdshAUJDEnWMGXCcuxdEoQBcVpQRif5gGt7eT+VxxRD7PxhD0qD9pErONek5jalsyzOYk=",
            "xl1tJFyMovTF7QefKHBXAZx4jNXmz3BFl9r+OL6qgE8=",
        ),
    ),
    # vanity/0x40840
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x4084039abe540d709328271b8e7a71d31b82f2dc",
            "0xa172fc9a8ffe41af1c43db713da1163c598b996ec28bc51c92b10c78c63af7f3f9ff76f37dfceb6cbaa80f396cabc35018693525c946f4dda005e4d8ee4d7b0f",
            "c1e69d54f4482499708c239ca9fa976d17010823afb7bed8fa59b8989b50fed4",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x4084039abe540d709328271b8e7a71d31b82f2dc",
            "BKFy/JqP/kGvHEPbcT2hFjxZi5luwovFHJKxDHjGOvfz+f92833862y6qA85bKvDUBhpNSXJRvTdoAXk2O5New8=",
            "weadVPRIJJlwjCOcqfqXbRcBCCOvt77Y+lm4mJtQ/tQ=",
        ),
    ),
    # vanity/0x40940
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x40940a28a5daf3c8b157139295b9a08e4505335e",
            "0x8f9dbf34b9518c5ca5689b79ec8d52c709df0a2b7cda22c59323935465aad4041770742b1ff835bca4073f31ac766a7999c495f04dbdd6c8dfd390d6e9477d48",
            "8f6492717f40c80e1c27e560cb2a36553d659072f0d40a3c0b8910887b2785e1",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x40940a28a5daf3c8b157139295b9a08e4505335e",
            "BI+dvzS5UYxcpWibeeyNUscJ3worfNoixZMjk1RlqtQEF3B0Kx/4NbykBz8xrHZqeZnElfBNvdbI39OQ1ulHfUg=",
            "j2SScX9AyA4cJ+Vgyyo2VT1lkHLw1Ao8C4kQiHsnheE=",
        ),
    ),
    # vanity/0x41041
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x41041d2d45c36989a4aefe1ba17d3ee7acd68129",
            "0xce3d826b92562b9f7a330b6c2ce11810c90c46dfb592d356907482115323b716b99e007bb730de701500e7bc31179da58b3dfef295306c663722d1f150845041",
            "f8086ced35a5ce34921f28261a3278946b9e3a55f8a5ef6c4e5b82a4cb470980",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x41041d2d45c36989a4aefe1ba17d3ee7acd68129",
            "BM49gmuSViufejMLbCzhGBDJDEbftZLTVpB0ghFTI7cWuZ4Ae7cw3nAVAOe8MRedpYs9/vKVMGxmNyLR8VCEUEE=",
            "+Ahs7TWlzjSSHygmGjJ4lGueOlX4pe9sTluCpMtHCYA=",
        ),
    ),
    # vanity/0x41141
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x41141355a9e261288528b112dc057a2fb6a07c9e",
            "0x7258135e431697984fc55aac79c5ee2704c09d591c7eb199aa2045fe0cc5302c04a0f7f2669c18ff14fb798da053206976dfbf52a2bcbfb4f1ff44ef2812d568",
            "82d606508e36f7d4ea1375bf983e710c13659a99f0539691dea726d8e721a566",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x41141355a9e261288528b112dc057a2fb6a07c9e",
            "BHJYE15DFpeYT8VarHnF7icEwJ1ZHH6xmaogRf4MxTAsBKD38macGP8U+3mNoFMgaXbfv1KivL+08f9E7ygS1Wg=",
            "gtYGUI4299TqE3W/mD5xDBNlmpnwU5aR3qcm2OchpWY=",
        ),
    ),
    # vanity/0x41241
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x412417446138a2ef7764e2245de31e6cbb577579",
            "0xd7abe5a494e8a8c1567856b465f9f1fe8e8351d6219f3ef2658722c7a08e1b960e8def34eb697abfb8092cd24bd15171a9689c70adeaca20d28e080d5ead51ba",
            "7127d7e5535231804b6d206f01f97fdf5efaeacdddf3f6a352204930e703a366",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x412417446138a2ef7764e2245de31e6cbb577579",
            "BNer5aSU6KjBVnhWtGX58f6Og1HWIZ8+8mWHIsegjhuWDo3vNOtper+4CSzSS9FRcalonHCt6sog0o4IDV6tUbo=",
            "cSfX5VNSMYBLbSBvAfl/31766s3d8/ajUiBJMOcDo2Y=",
        ),
    ),
    # vanity/0x41341
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x41341cea883768136c5d4ee3fb14c125641155c9",
            "0x7ab0037cd311c767a0c6975fcdc78842bc5e07e348938513dc5ee6795db0ec1b5fc34541d76233d58e7f60e657b61b85d0f576c071b3b5d639263667ece8b136",
            "b28665d35496d6ecc2c5c320d7bbc9a5d6893d8052a3ab11b046c1590a6099b9",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x41341cea883768136c5d4ee3fb14c125641155c9",
            "BHqwA3zTEcdnoMaXX83HiEK8XgfjSJOFE9xe5nldsOwbX8NFQddiM9WOf2DmV7YbhdD1dsBxs7XWOSY2Z+zosTY=",
            "soZl01SW1uzCxcMg17vJpdaJPYBSo6sRsEbBWQpgmbk=",
        ),
    ),
    # vanity/0x41441
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x414413bbc8eee91bae4c384169760af8dfae76fd",
            "0x2d6402d34bbca67cc8b678629c8254eec074a46f444e4459341fb54fd8dc45b1c0baaf58ad2d2fdb1201f87cffbf093a9857922ffc69b7180696654e983ceb04",
            "d6b2c6e002ea4af7cf34d6c7edfb25fa5fe2c1a016426593c7d040c1a9a388d2",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x414413bbc8eee91bae4c384169760af8dfae76fd",
            "BC1kAtNLvKZ8yLZ4YpyCVO7AdKRvRE5EWTQftU/Y3EWxwLqvWK0tL9sSAfh8/78JOphXki/8abcYBpZlTpg86wQ=",
            "1rLG4ALqSvfPNNbH7fsl+l/iwaAWQmWTx9BAwamjiNI=",
        ),
    ),
    # vanity/0x41541
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x415417ee85fad013222cbd696ab48af02168dcaf",
            "0x6ac52a20f233c7a68479d62e7f738c59585fe9040a69b931b70fd8634ba227c5cad641a5a892fcf5dced219729097c901e78ce9e6c7f2af4d25d43a6f4bb90e8",
            "788d26e0e613edf5ae59029a1dde57a0d8f67468a8fb1bd35d72e0266d1cbe6b",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x415417ee85fad013222cbd696ab48af02168dcaf",
            "BGrFKiDyM8emhHnWLn9zjFlYX+kECmm5MbcP2GNLoifFytZBpaiS/PXc7SGXKQl8kB54zp5sfyr00l1DpvS7kOg=",
            "eI0m4OYT7fWuWQKaHd5XoNj2dGio+xvTXXLgJm0cvms=",
        ),
    ),
    # vanity/0x41641
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x41641cd3835b3a926ea5e04eafce4982fe861855",
            "0xbad948f8a677fb2d238da65784f15647aea2424f085ed915f6478591fa6a09150192d9dc58845f9c9b5d46d3bef38a045a5bfdd1658163c122b479325814713d",
            "44b6ef9be90da09285f34cc071cbf8b35e0d622bb3607f2d50fb4c1cc529ef92",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x41641cd3835b3a926ea5e04eafce4982fe861855",
            "BLrZSPimd/stI42mV4TxVkeuokJPCF7ZFfZHhZH6agkVAZLZ3FiEX5ybXUbTvvOKBFpb/dFlgWPBIrR5MlgUcT0=",
            "RLbvm+kNoJKF80zAccv4s14NYiuzYH8tUPtMHMUp75I=",
        ),
    ),
    # vanity/0x41741
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x41741e35f1e7a3134114190f792524a17ed0d8b6",
            "0x54788f434f5bd4a295ef1c43d033a28f6564624e442581a0a43b589b68a9814d3e9216650081773401852a30ecfe2bea718e87cb225ef3787c52c7e5eec0e460",
            "1e6b6011a12789232f37e7dc09dcfb4fd86a2e31f2c86697c0aeabcb458253b8",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x41741e35f1e7a3134114190f792524a17ed0d8b6",
            "BFR4j0NPW9Sile8cQ9Azoo9lZGJORCWBoKQ7WJtoqYFNPpIWZQCBdzQBhSow7P4r6nGOh8siXvN4fFLH5e7A5GA=",
            "HmtgEaEniSMvN+fcCdz7T9hqLjHyyGaXwK6ry0WCU7g=",
        ),
    ),
    # vanity/0x41841
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x418415347ac2c4b95dc4e581b738ce0daf9f6100",
            "0x6ca27a8b2b295ce93dd5bdc961440a588b9ca195f8b18d554776ac769bcbbda9ad5d7c2d51c39ed4b0a6ccc27ce3b21a3bfe460d7df729f338213d346a024ed4",
            "7809f0e6cd6667e5db5485b4e1a533923833b93abc6e40185af194ad9d0e1b57",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x418415347ac2c4b95dc4e581b738ce0daf9f6100",
            "BGyieosrKVzpPdW9yWFECliLnKGV+LGNVUd2rHaby72prV18LVHDntSwpszCfOOyGjv+Rg199ynzOCE9NGoCTtQ=",
            "eAnw5s1mZ+XbVIW04aUzkjgzuTq8bkAYWvGUrZ0OG1c=",
        ),
    ),
    # vanity/0x41941
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x4194134c03f6fc9589e2102b35dbdc39006b2b5e",
            "0x87d5caf6c6b013c407e85109527816debd0e3680071f763a0d8cd888a264dc54e2e0bebc078e535b01012346222c1afee941c68d96fa476aaaefc32900c89141",
            "8558b486ef3ac2f0c791c78b7b47641434f01bc52f0729581889bcf80ab13627",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x4194134c03f6fc9589e2102b35dbdc39006b2b5e",
            "BIfVyvbGsBPEB+hRCVJ4Ft69DjaABx92Og2M2IiiZNxU4uC+vAeOU1sBASNGIiwa/ulBxo2W+kdqqu/DKQDIkUE=",
            "hVi0hu86wvDHkceLe0dkFDTwG8UvBylYGIm8+AqxNic=",
        ),
    ),
    # vanity/0x42042
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x420420abd646d9a99d73bdaa3f9d64536f2f86ef",
            "0x8955cecaecd94373cf808a1082bd16585bcf09cbe4b7706774594260426ff7ff6e59697b55dbeb6f3754b8ecde2a0c0573400c4dc47e370eedd71e2741910394",
            "9d5639c6ddb83faa2dbe036afb4e80b8fc6c3598abb42deb35ebc059f44847b8",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x420420abd646d9a99d73bdaa3f9d64536f2f86ef",
            "BIlVzsrs2UNzz4CKEIK9FlhbzwnL5LdwZ3RZQmBCb/f/bllpe1Xb6283VLjs3ioMBXNADE3EfjcO7dceJ0GRA5Q=",
            "nVY5xt24P6otvgNq+06AuPxsNZirtC3rNevAWfRIR7g=",
        ),
    ),
    # vanity/0x42142
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x421424fb3c48fd473c917dcb39b874249bee163b",
            "0xe6b1893b04d3f46e038835d3d2ef8c85108ef357bd7943f1bd57e57eabdb45d812982261f18d4964d6bfd8f4d4c156263a4be7b7938c133384ff595f7e994bd7",
            "57af4469117bf6ad716e21fd25ddaca052efb3b56f462de814a23811b78fe5c6",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x421424fb3c48fd473c917dcb39b874249bee163b",
            "BOaxiTsE0/RuA4g109LvjIUQjvNXvXlD8b1X5X6r20XYEpgiYfGNSWTWv9j01MFWJjpL57eTjBMzhP9ZX36ZS9c=",
            "V69EaRF79q1xbiH9Jd2soFLvs7VvRi3oFKI4EbeP5cY=",
        ),
    ),
    # vanity/0x42242
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x4224235a34f4d1fc35328e6d95ec485afe5a3c75",
            "0x72f50391e211f06aa725ddda0ab9bc8afdbc96c2800bed7cfef512c6ece7cba31315251f4d5bc50760aea2eaf722adf1aa0b9e504516cf58322f9ba40bfe9612",
            "d5c340e856a2ac5b9a59307a5f6aa1821726f720c5b8fed67564feb38dcb8611",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x4224235a34f4d1fc35328e6d95ec485afe5a3c75",
            "BHL1A5HiEfBqpyXd2gq5vIr9vJbCgAvtfP71Esbs58ujExUlH01bxQdgrqLq9yKt8aoLnlBFFs9YMi+bpAv+lhI=",
            "1cNA6FairFuaWTB6X2qhghcm9yDFuP7WdWT+s43LhhE=",
        ),
    ),
    # vanity/0x42342
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x42342cbce8d453cc7d07c089fcf1bcaf25690ce3",
            "0x6c67edf1c31d1b31bc2c0dbfcdfdb2bf6ce053be09e21d81ccadcf172841430302501057a63eae31011bb4b3bc77e4709c6e4bc46a4d30a658b68219e761d6d8",
            "bd7497a815a2a9fec1db724db07d3d3c9c5e05225016d43c5f3810db612fa732",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x42342cbce8d453cc7d07c089fcf1bcaf25690ce3",
            "BGxn7fHDHRsxvCwNv839sr9s4FO+CeIdgcytzxcoQUMDAlAQV6Y+rjEBG7SzvHfkcJxuS8RqTTCmWLaCGedh1tg=",
            "vXSXqBWiqf7B23JNsH09PJxeBSJQFtQ8XzgQ22EvpzI=",
        ),
    ),
    # vanity/0x42442
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x42442b47fab512964b20753a593690041b36be5c",
            "0xbe1ea066c454ee639e33468d068b13c8767114128dfc9eb1d55b56d35d27af65d6ec22822dfde7c89c3e69d45c31e9e1398da20feb2a88a1d3ba533546c5e5cc",
            "f24d01b76814941e7b0d840ddb52ee80b4d5388ce26f336598448d5763de9bba",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x42442b47fab512964b20753a593690041b36be5c",
            "BL4eoGbEVO5jnjNGjQaLE8h2cRQSjfyesdVbVtNdJ69l1uwigi3958icPmnUXDHp4TmNog/rKoih07pTNUbF5cw=",
            "8k0Bt2gUlB57DYQN21LugLTVOIzibzNlmESNV2Pem7o=",
        ),
    ),
    # vanity/0x42542
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x425426c7ed1aa42bbeadd01b3a39d2e6f3abc576",
            "0x8c60d656595b9a822beae3bffdeb13f1d558b60a59f0f06b48d6e4a472784b2023ba11ba9753640d92a518190f79b7b2ba84332462ed7724dbffa649a064ccfb",
            "545fd16f16c1f28fb5c0cbc3c4cc34881ab010a63b3ebacc077f9b1744ec61f1",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x425426c7ed1aa42bbeadd01b3a39d2e6f3abc576",
            "BIxg1lZZW5qCK+rjv/3rE/HVWLYKWfDwa0jW5KRyeEsgI7oRupdTZA2SpRgZD3m3srqEMyRi7Xck2/+mSaBkzPs=",
            "VF/RbxbB8o+1wMvDxMw0iBqwEKY7PrrMB3+bF0TsYfE=",
        ),
    ),
    # vanity/0x42642
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x4264269250976deafd8252a21fa7477767681a06",
            "0x7e103654088487502eec261e7ff01f4708497cf4850a96e97cb8838c5b758d12bca52a0f652caacf504acc53debf9ad1ffaeb75a937177a49c4f50dac19d1fc2",
            "d872ce2209dbc7b7cc9661e4c5703ed6424a746b274eca91de0cb91147dc7f5c",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x4264269250976deafd8252a21fa7477767681a06",
            "BH4QNlQIhIdQLuwmHn/wH0cISXz0hQqW6Xy4g4xbdY0SvKUqD2Usqs9QSsxT3r+a0f+ut1qTcXeknE9Q2sGdH8I=",
            "2HLOIgnbx7fMlmHkxXA+1kJKdGsnTsqR3gy5EUfcf1w=",
        ),
    ),
    # vanity/0x42742
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x4274252d593f9a66673cf00dedd347f9dcf91a68",
            "0xdddccf36298ee3e131cd330bbaf86bd85e476d01d6f7aab42765b2704ce65da80e15c8a1adff0e3d37e02f1017a8725c97ecb400bdff2de6b0f680cbf4fe6690",
            "250f4627db4c0a138680894c9bd8f3d5ac03a082231d3c7594d8850197bbc0e2",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x4274252d593f9a66673cf00dedd347f9dcf91a68",
            "BN3czzYpjuPhMc0zC7r4a9heR20B1veqtCdlsnBM5l2oDhXIoa3/Dj034C8QF6hyXJfstAC9/y3msPaAy/T+ZpA=",
            "JQ9GJ9tMChOGgIlMm9jz1awDoIIjHTx1lNiFAZe7wOI=",
        ),
    ),
    # vanity/0x42842
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x428424945580d6101e1097f536dcf9bc5ffb94ff",
            "0x17707702b56adb53aa76e68b2d671e5005abac7c365db105560e3e0d0f76a1443672c2018e67ef293ee8415c5353c872258a0a9fb083724dda96a1a15d7c06a0",
            "a81604b1412af831c6b11442cfb12785988c576ce97d38863fef95b107495d9a",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x428424945580d6101e1097f536dcf9bc5ffb94ff",
            "BBdwdwK1attTqnbmiy1nHlAFq6x8Nl2xBVYOPg0PdqFENnLCAY5n7yk+6EFcU1PIciWKCp+wg3JN2pahoV18BqA=",
            "qBYEsUEq+DHGsRRCz7EnhZiMV2zpfTiGP++VsQdJXZo=",
        ),
    ),
    # vanity/0x42942
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x42942a4ba5cfc18651684b1f08c946f06ab0d451",
            "0x8ab3ae62e0b7247c8b3835a02d40baa0f08311567dc0f3882ce9a2dd31606b91acfd12bdfef918935c38f4094cd855f366fcceeee56c66275bcdaf5b56cc4061",
            "43051540d8ef9e46847cb22fe86566daaac1554d06e8b12d705e422ff74ca1be",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x42942a4ba5cfc18651684b1f08c946f06ab0d451",
            "BIqzrmLgtyR8izg1oC1AuqDwgxFWfcDziCzpot0xYGuRrP0Svf75GJNcOPQJTNhV82b8zu7lbGYnW82vW1bMQGE=",
            "QwUVQNjvnkaEfLIv6GVm2qrBVU0G6LEtcF5CL/dMob4=",
        ),
    ),
    # vanity/0x43043
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x430438f170f1855fb21e60d20d00f982e90d53d3",
            "0x59f4ab7af378f3073d24f9d36d07e22502c36aeef7a27594ac4b03d4e327ada3f4094c2a78401cfaa4892cb8ba61f8efdf2cbfcce3a0f5a26e2fee2416bc7be1",
            "3249b64d1004e5d5c6c24354ff538adb942abe8ca29809abd6ecd81592c9f6ac",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x430438f170f1855fb21e60d20d00f982e90d53d3",
            "BFn0q3rzePMHPST5020H4iUCw2ru96J1lKxLA9TjJ62j9AlMKnhAHPqkiSy4umH4798sv8zjoPWibi/uJBa8e+E=",
            "Mkm2TRAE5dXGwkNU/1OK25QqvoyimAmr1uzYFZLJ9qw=",
        ),
    ),
    # vanity/0x43143
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x43143aeb0c60299fa3395b069604c88add0bc8cf",
            "0x197918ca2ccc085a8311dd1afe54019a9a349ee89f324213bf5a448b52eb611fd1d74375a1e99b346938c78052946284600c5f0b02aae8b5388fbcc7b7bf8c37",
            "ba8270b8ec5079863bb62c99ff245a8d4c89acecaa5f79e48ddc0bd03e856c7d",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x43143aeb0c60299fa3395b069604c88add0bc8cf",
            "BBl5GMoszAhagxHdGv5UAZqaNJ7onzJCE79aRItS62Ef0ddDdaHpmzRpOMeAUpRihGAMXwsCqui1OI+8x7e/jDc=",
            "uoJwuOxQeYY7tiyZ/yRajUyJrOyqX3nkjdwL0D6FbH0=",
        ),
    ),
    # vanity/0x43243
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x432438529d501a1ec96f409164ea50b9bffa7ee3",
            "0xd094bba5b8dc7bb2a5873b7f139fcdf70cb48dfab8f6c9a3cea2506b56451cc85081a2a5834dda9d88e880a7b1f56a47fef5f17ad35ed15739465eb9bb064b86",
            "7a94a38b326c981e07f1ceba969c16605165ce7b5260bbc4d637e73a09137aae",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x432438529d501a1ec96f409164ea50b9bffa7ee3",
            "BNCUu6W43HuypYc7fxOfzfcMtI36uPbJo86iUGtWRRzIUIGipYNN2p2I6ICnsfVqR/718XrTXtFXOUZeubsGS4Y=",
            "epSjizJsmB4H8c66lpwWYFFlzntSYLvE1jfnOgkTeq4=",
        ),
    ),
    # vanity/0x43343
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x4334325d8e9c9363564061593c515d94cdfd4619",
            "0x9c8fa11f99da80e402c27343e6b6a2a5053466cf74b8a719fb5f9ffd1600cea403e3b4e6a7b93c1afaa37c0fc20ffa7a9925258a70cc1a6b8f2941c640434c7d",
            "442d2d642e5f580b1ac87e2598387b0ff8453ffb4f35133221fba499d607b279",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x4334325d8e9c9363564061593c515d94cdfd4619",
            "BJyPoR+Z2oDkAsJzQ+a2oqUFNGbPdLinGftfn/0WAM6kA+O05qe5PBr6o3wPwg/6epklJYpwzBprjylBxkBDTH0=",
            "RC0tZC5fWAsayH4lmDh7D/hFP/tPNRMyIfukmdYHsnk=",
        ),
    ),
    # vanity/0x43443
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x434433c86287ba92eb632cb782e6c778d63207fa",
            "0x170074a804e717874022921a463eede396bac535d809f4087601be849edc7d46b3eafc362222ec5946fb591f0d67d5d0b7b17972b0ad88fac9351dfc6d156c0f",
            "e9acb3b2141dd46f5201c9b4fd9f1fd724df8d707c8eef576ecb3725c031afb8",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x434433c86287ba92eb632cb782e6c778d63207fa",
            "BBcAdKgE5xeHQCKSGkY+7eOWusU12An0CHYBvoSe3H1Gs+r8NiIi7FlG+1kfDWfV0LexeXKwrYj6yTUd/G0VbA8=",
            "6ayzshQd1G9SAcm0/Z8f1yTfjXB8ju9Xbss3JcAxr7g=",
        ),
    ),
    # vanity/0x43543
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x43543ee8536812f5fd83f3c7b9419918e80a6c0e",
            "0x7d3add40494d06ab71747a9ff7761d145788a5328e3038ad0e8f1f226b79706c29af91020452491c424ed10faedf519691e8317557883cff5009209f3b7dbd8d",
            "fa371fefa02569a20869b32e711517b5c6ecf066f49356fe5751059b9c5bf2bd",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x43543ee8536812f5fd83f3c7b9419918e80a6c0e",
            "BH063UBJTQarcXR6n/d2HRRXiKUyjjA4rQ6PHyJreXBsKa+RAgRSSRxCTtEPrt9RlpHoMXVXiDz/UAkgnzt9vY0=",
            "+jcf76AlaaIIabMucRUXtcbs8Gb0k1b+V1EFm5xb8r0=",
        ),
    ),
    # vanity/0x43643
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x436435079abbeb43646930f785fd83e9b0fe21b0",
            "0xd14a5835ddbc1e012f5dbc18e3317f38bd47fe9c4c21707011ac74aafc432aeb8345e9ca4f17544ce53449a4856551a046e0222847b0ccc6487240d6872946a5",
            "1ddcf79e2d321ec3811a6dfcd75090ebaa843dc8d127081ffddfd382c623e620",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x436435079abbeb43646930f785fd83e9b0fe21b0",
            "BNFKWDXdvB4BL128GOMxfzi9R/6cTCFwcBGsdKr8Qyrrg0Xpyk8XVEzlNEmkhWVRoEbgIihHsMzGSHJA1ocpRqU=",
            "Hdz3ni0yHsOBGm3811CQ66qEPcjRJwgf/d/TgsYj5iA=",
        ),
    ),
    # vanity/0x43743
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x43743c2080eab22cecf0686556340c806da4bb99",
            "0x10a049f867989c6578ebc00bf473d71c2fa33ee8d2319cb3d0cc14353673646b0e48db87cf5b519b3758d8487f2d9f39de9bfbf3495eb3503edcb78eb9266708",
            "63c85aa4d6aff40f8d0b0bc6aa37becfe2a58cc2760c53f35c32012142f25380",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x43743c2080eab22cecf0686556340c806da4bb99",
            "BBCgSfhnmJxleOvAC/Rz1xwvoz7o0jGcs9DMFDU2c2RrDkjbh89bUZs3WNhIfy2fOd6b+/NJXrNQPty3jrkmZwg=",
            "Y8hapNav9A+NCwvGqje+z+KljMJ2DFPzXDIBIULyU4A=",
        ),
    ),
    # vanity/0x43843
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x43843871e20a0382ce79e2086ec6be6f07437ed3",
            "0x142483bc166eb581dfd063f95333c85818976cd3a98f765b3f82e2bc7994aa235dfc876b58cd38d7225416cb35b47631aafc7917002db8709ba2bb705bce0975",
            "b2c2e42fab52a7612b73946acee1ea4cdaba2294f51afd520903bf1f90bbf8a4",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x43843871e20a0382ce79e2086ec6be6f07437ed3",
            "BBQkg7wWbrWB39Bj+VMzyFgYl2zTqY92Wz+C4rx5lKojXfyHa1jNONciVBbLNbR2Mar8eRcALbhwm6K7cFvOCXU=",
            "ssLkL6tSp2Erc5RqzuHqTNq6IpT1Gv1SCQO/H5C7+KQ=",
        ),
    ),
    # vanity/0x43943
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x43943d28ed2fb1d0208a8407c7c3bf296c286bcb",
            "0x0d99d6fddcd1b0147572644a721c6992056a0fb4cf0010eeea4f057f3a9e35c79614adb0231f8525f6c7275b018c776a7cdb6d2c3acd9ff53ddc626c80b71ff4",
            "495ba02871dd85db3353b1a610ea393162ab1927e3002875a88082556e47082b",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x43943d28ed2fb1d0208a8407c7c3bf296c286bcb",
            "BA2Z1v3c0bAUdXJkSnIcaZIFag+0zwAQ7upPBX86njXHlhStsCMfhSX2xydbAYx3anzbbSw6zZ/1PdxibIC3H/Q=",
            "SVugKHHdhdszU7GmEOo5MWKrGSfjACh1qICCVW5HCCs=",
        ),
    ),
    # vanity/0x44044
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x440448398934ed24cbb5eeff9e28d1ec9b512ffb",
            "0x0eef98cf010b2801398825ec417c81c6bf21d683bd3c5ea7c780fd7b1e40b63e5a46b6a6922c24eba784b46d546b141cc1184d7cc9681780b9a7479b539a9a4f",
            "9a52a698ef074be9b61f09db912cf84949fb19553f006d8bb3fe38163534a868",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x440448398934ed24cbb5eeff9e28d1ec9b512ffb",
            "BA7vmM8BCygBOYgl7EF8gca/IdaDvTxep8eA/XseQLY+Wka2ppIsJOunhLRtVGsUHMEYTXzJaBeAuadHm1Oamk8=",
            "mlKmmO8HS+m2HwnbkSz4SUn7GVU/AG2Ls/44FjU0qGg=",
        ),
    ),
    # vanity/0x44144
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x4414487ed27206b7f0e4dc1b9f6c29bbf6e73526",
            "0xc5ba7811fac44ff184a9fedf12900893836088ef8432707cfbe23e664303da66fd35e2759d39f9f06f48e6ed89024b4bd3d86170792e21b66aa88d415d9f7467",
            "e80a5cfa0df0b8e1573a263b5af9a532a00aa642657a76b251c5cb1ad1e6d7e5",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x4414487ed27206b7f0e4dc1b9f6c29bbf6e73526",
            "BMW6eBH6xE/xhKn+3xKQCJODYIjvhDJwfPviPmZDA9pm/TXidZ05+fBvSObtiQJLS9PYYXB5LiG2aqiNQV2fdGc=",
            "6Apc+g3wuOFXOiY7WvmlMqAKpkJlenayUcXLGtHm1+U=",
        ),
    ),
    # vanity/0x44244
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x442444255ec1d7e43a77836476ca5cd3bb5bd8d5",
            "0xf2a37b1879011809a5044725fd590e5a6df0ed2f6789b732231dacbb5ff0931a663f8407e3a5129f9f58ffb5bd25afd6c3abaaea704bb0abeb5112bc66c953cc",
            "93c4f710fafdafd795a6e86d4399ed8b6b5df95879c1cd3f55d214f610d7e4cb",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x442444255ec1d7e43a77836476ca5cd3bb5bd8d5",
            "BPKjexh5ARgJpQRHJf1ZDlpt8O0vZ4m3MiMdrLtf8JMaZj+EB+OlEp+fWP+1vSWv1sOrqupwS7Cr61ESvGbJU8w=",
            "k8T3EPr9r9eVpuhtQ5nti2td+Vh5wc0/VdIU9hDX5Ms=",
        ),
    ),
    # vanity/0x44344
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x443447ad65baf2aee64d2169a6a1000560eb2c66",
            "0x7f2440f1704584563dd1a9ac05ea88fb59e9e4f774d01f8956c4e3b0679cadd9adebfc7d22f676f361f547b1f9addc30f44dfb88d8e30ab9ef37a639b643a0a7",
            "615bc7ebdf364f838da5e74aa9a669c965cb1499d0f658c460b1ff36c1a2ea5b",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x443447ad65baf2aee64d2169a6a1000560eb2c66",
            "BH8kQPFwRYRWPdGprAXqiPtZ6eT3dNAfiVbE47BnnK3Zrev8fSL2dvNh9Uex+a3cMPRN+4jY4wq57zemObZDoKc=",
            "YVvH6982T4ONpedKqaZpyWXLFJnQ9ljEYLH/NsGi6ls=",
        ),
    ),
    # vanity/0x44444
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x44444df6733ec074d352da44fe0ed7b8ae98e14a",
            "0xd3831ad79a7cb0c659174ab7979c9a0899c6370df7c832beb4ac3b8ad2f4166f642fcc9aa50221f4a740fb8a9b30eae015012614981716d74a6907cebbf876fe",
            "881272b44365214274ecd3c9ed1fcf75811a94b83a98da691bc244f01b198d51",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x44444df6733ec074d352da44fe0ed7b8ae98e14a",
            "BNODGteafLDGWRdKt5ecmgiZxjcN98gyvrSsO4rS9BZvZC/MmqUCIfSnQPuKmzDq4BUBJhSYFxbXSmkHzrv4dv4=",
            "iBJytENlIUJ07NPJ7R/PdYEalLg6mNppG8JE8BsZjVE=",
        ),
    ),
    # vanity/0x44544
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x445441a949b248ebdff52de863c84210148cfa3d",
            "0xb795eb3f94cd619ad1335b17ad661619a5128fb5dc4ab0803c09cf6bd57ac26e81b2a653d9d5330460c077ee56627cc07403d2b3b0daf4081f005050c403cd03",
            "d961c0689495387dca28af6771dba8535e95267f471006aaded402b6200e5e62",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x445441a949b248ebdff52de863c84210148cfa3d",
            "BLeV6z+UzWGa0TNbF61mFhmlEo+13EqwgDwJz2vVesJugbKmU9nVMwRgwHfuVmJ8wHQD0rOw2vQIHwBQUMQDzQM=",
            "2WHAaJSVOH3KKK9ncduoU16VJn9HEAaq3tQCtiAOXmI=",
        ),
    ),
    # vanity/0x44644
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x44644b5c6ddc9fd8fc6160d4e623c034033a5da4",
            "0x913a97390242595bf32df2f6860ad907a9c852b84cc3e85e5155eb02b88c2006cfae734e3dcc1f9d46c8da49798569622a849ee51b67047310eccbca74d7bd5c",
            "16f3822f01631a4d2e6070343f6ba84296d9693cff70b0a497b7f9806f957f08",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x44644b5c6ddc9fd8fc6160d4e623c034033a5da4",
            "BJE6lzkCQllb8y3y9oYK2QepyFK4TMPoXlFV6wK4jCAGz65zTj3MH51GyNpJeYVpYiqEnuUbZwRzEOzLynTXvVw=",
            "FvOCLwFjGk0uYHA0P2uoQpbZaTz/cLCkl7f5gG+Vfwg=",
        ),
    ),
    # vanity/0x44744
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x44744856c46142e4e71799d383e09bc5cf145389",
            "0x789510d9d51f00ec3bc1c565f4f7f6193d8f5b849c668a00f007493724dcc85c516861e82d15ef8650f9b490a3b137276b964fdc2121c1ede5d0535baa4b8bf3",
            "56fdf4a392475c7d76f62e0bc818d891a2a183307f0e59e038c992d982403529",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x44744856c46142e4e71799d383e09bc5cf145389",
            "BHiVENnVHwDsO8HFZfT39hk9j1uEnGaKAPAHSTck3MhcUWhh6C0V74ZQ+bSQo7E3J2uWT9whIcHt5dBTW6pLi/M=",
            "Vv30o5JHXH129i4LyBjYkaKhgzB/DlngOMmS2YJANSk=",
        ),
    ),
    # vanity/0x44844
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x4484419ee46ebbb21e60a47dbd88f158a695fb12",
            "0x11836fd50e81b87b7a8de707b70011ee522fa181a42c0436007421453f31f49f9d543653b3ac5a0d30aff48f00c94d025c52e9c2c15343fd2f3270b8c9353870",
            "f2bd2762daa87e322c3e39b022bcf65ac0eed14deb2fc29b1d586066b1e42f00",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x4484419ee46ebbb21e60a47dbd88f158a695fb12",
            "BBGDb9UOgbh7eo3nB7cAEe5SL6GBpCwENgB0IUU/MfSfnVQ2U7OsWg0wr/SPAMlNAlxS6cLBU0P9LzJwuMk1OHA=",
            "8r0nYtqofjIsPjmwIrz2WsDu0U3rL8KbHVhgZrHkLwA=",
        ),
    ),
    # vanity/0x44944
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x449444691b1c08a50f79e5d25bc46ea3ac218b6b",
            "0x5c9d352b1965b9cc308681c2735168119a4c5bbaede7ccb3635014e73e9fb18751e909bf91d8570da4a26168e4119ec77915bef3704377bc3f4cec00845b3e51",
            "a88d60baf89a47073de1e0679d03531db5c80ef20db1465a26604380b733cf33",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x449444691b1c08a50f79e5d25bc46ea3ac218b6b",
            "BFydNSsZZbnMMIaBwnNRaBGaTFu67efMs2NQFOc+n7GHUekJv5HYVw2komFo5BGex3kVvvNwQ3e8P0zsAIRbPlE=",
            "qI1guviaRwc94eBnnQNTHbXIDvINsUZaJmBDgLczzzM=",
        ),
    ),
    # vanity/0x45045
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x450455b967eb3899e595d837ee93c7bc1ee0ad4f",
            "0xfe933778ce4d3b5dc982e0e6be6e0064251c2bc7097321745be7786541ecd466450f10f4147b357d1e67d2a457a4bab478bdfb0a7aa711a68ad5122230f20c7d",
            "95179de71c3341ad4a275a788facaa8bc2cf74a1828cb82671b86acebf19bbe1",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x450455b967eb3899e595d837ee93c7bc1ee0ad4f",
            "BP6TN3jOTTtdyYLg5r5uAGQlHCvHCXMhdFvneGVB7NRmRQ8Q9BR7NX0eZ9KkV6S6tHi9+wp6pxGmitUSIjDyDH0=",
            "lRed5xwzQa1KJ1p4j6yqi8LPdKGCjLgmcbhqzr8Zu+E=",
        ),
    ),
    # vanity/0x45145
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x451459210058fa7fb582387f06650aa80ffdc62b",
            "0x844633775a8137d8927524a3e3e6b406dd6fc10c80f89233d6598358141947d0d321af8100329ee469e310855a4d50f372a8957277f8d4e22f6f6b2bf5eb8628",
            "ccfbdd22f8981ef3c9b52b2f87ea02b0f2f79eaa97c82e9dd1c86406ed3da271",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x451459210058fa7fb582387f06650aa80ffdc62b",
            "BIRGM3dagTfYknUko+PmtAbdb8EMgPiSM9ZZg1gUGUfQ0yGvgQAynuRp4xCFWk1Q83KolXJ3+NTiL29rK/Xrhig=",
            "zPvdIviYHvPJtSsvh+oCsPL3nqqXyC6d0chkBu09onE=",
        ),
    ),
    # vanity/0x45245
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x452453da7032b8e661e366e60305adf182ba8c1a",
            "0x937e5e636e768163306a98b77eb1c5fe6644869a37e0be994edd6922caeb20e3c9272d992e168873ed27dd10aeabcfe432a2c6cf215440796ba8ddcd89e3f680",
            "af47c67f6321c9bedc5cef802c56b53703ee1c609d687773d13751e8dffd2ba4",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x452453da7032b8e661e366e60305adf182ba8c1a",
            "BJN+XmNudoFjMGqYt36xxf5mRIaaN+C+mU7daSLK6yDjySctmS4WiHPtJ90QrqvP5DKixs8hVEB5a6jdzYnj9oA=",
            "r0fGf2Mhyb7cXO+ALFa1NwPuHGCdaHdz0TdR6N/9K6Q=",
        ),
    ),
    # vanity/0x45345
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x45345890f3ddc485d4c904484cc6af4f436ac6c7",
            "0xd8717c98816471013ed9ae77f83da233393875113437d1452f81e46ced352ddd34333792edb8b4a2472b51888e8ab01cd012ec9dc11f575ad3a047f2d922af16",
            "d43f64300eb6f9840070620d5028a1aa60c53f8f9faa2376d4058c5aa9918695",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x45345890f3ddc485d4c904484cc6af4f436ac6c7",
            "BNhxfJiBZHEBPtmud/g9ojM5OHURNDfRRS+B5GztNS3dNDM3ku24tKJHK1GIjoqwHNAS7J3BH1da06BH8tkirxY=",
            "1D9kMA62+YQAcGINUCihqmDFP4+fqiN21AWMWqmRhpU=",
        ),
    ),
    # vanity/0x45445
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x454453c31b192e0a271c939b6ef088b43d201bf5",
            "0xc9225bddd66ed87478b17e4e3d64202232a1d72ac76e29d88fdda3b06aad2491e8296faba1a786471a7f541ef7eafc05d83d71f043eba9ad2858e26733332a87",
            "c486bc2aba3f706834df16bbdd6ddeb38e4edac5825e12bb279f18545cb1f0ad",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x454453c31b192e0a271c939b6ef088b43d201bf5",
            "BMkiW93Wbth0eLF+Tj1kICIyodcqx24p2I/do7BqrSSR6Clvq6Gnhkcaf1Qe9+r8Bdg9cfBD66mtKFjiZzMzKoc=",
            "xIa8Kro/cGg03xa73W3es45O2sWCXhK7J58YVFyx8K0=",
        ),
    ),
    # vanity/0x45545
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x455458f610f2ca73e1bf44502aa09c9c3f1a3af5",
            "0x04bb0faca4c55ea7d471a9a08b5ce20de2c8181c6ab8a9d8878d9cd8094781c8c06453cf47273c0315ea3b861901ab8ddca876606fd7653f10518dd7f996f699",
            "90b53c8d83a3628bc4c9b3400c4c9f9410f03e17d13c9b2fd83855a8f2449012",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x455458f610f2ca73e1bf44502aa09c9c3f1a3af5",
            "BAS7D6ykxV6n1HGpoItc4g3iyBgcarip2IeNnNgJR4HIwGRTz0cnPAMV6juGGQGrjdyodmBv12U/EFGN1/mW9pk=",
            "kLU8jYOjYovEybNADEyflBDwPhfRPJsv2DhVqPJEkBI=",
        ),
    ),
    # vanity/0x45645
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x456459c2de6d8e1cfce1adb416d07681182a237b",
            "0xb16892031ff88bcdc1974ebb84c05f5d390cf724ac9c9dac3e08afc593f894faede3c5b1cfcdefc8a4a4afda0f317354dd341963b6ab473b1e9c978d3834a6b9",
            "aadcdea067066ee50f109fa392de6e2ce2d99cca70ede6a13cc13d375f2a79d8",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x456459c2de6d8e1cfce1adb416d07681182a237b",
            "BLFokgMf+IvNwZdOu4TAX105DPckrJydrD4Ir8WT+JT67ePFsc/N78ikpK/aDzFzVN00GWO2q0c7HpyXjTg0prk=",
            "qtzeoGcGbuUPEJ+jkt5uLOLZnMpw7eahPME9N18qedg=",
        ),
    ),
    # vanity/0x45745
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x457451f0e3a559514f25bbb18a0cc184ee8e28a8",
            "0x4476cd819bec440437e7933d70c7779d53d48e284c1699c640f174aecc1675a6944eb19c5957c68f9adcb0ca66c46c5a0777103215deb44ef7130429cf345d36",
            "b7b2ad8d256880625541c49d2c58c7ec544e7ecca29c2f3d5d9490c3c723fc6e",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x457451f0e3a559514f25bbb18a0cc184ee8e28a8",
            "BER2zYGb7EQEN+eTPXDHd51T1I4oTBaZxkDxdK7MFnWmlE6xnFlXxo+a3LDKZsRsWgd3EDIV3rRO9xMEKc80XTY=",
            "t7KtjSVogGJVQcSdLFjH7FROfsyinC89XZSQw8cj/G4=",
        ),
    ),
    # vanity/0x45845
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x45845c318e18c888b9441ea4b264a8996b8892b4",
            "0xe684d5959aeb2edc837d1d0c30a75b468c627a86e8650127ee5d7fc164729e6c6479a5f7b944a564c9cb206fbb89a6c052183941b2e044ad7eb285e3f0fa5fd9",
            "d1e29fff1029dddc2326bae9ebf59d4cf39c3486bf1cc15d8eede5a9e0d1f3c5",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x45845c318e18c888b9441ea4b264a8996b8892b4",
            "BOaE1ZWa6y7cg30dDDCnW0aMYnqG6GUBJ+5df8Fkcp5sZHml97lEpWTJyyBvu4mmwFIYOUGy4EStfrKF4/D6X9k=",
            "0eKf/xAp3dwjJrrp6/WdTPOcNIa/HMFdju3lqeDR88U=",
        ),
    ),
    # vanity/0x45945
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x45945e00c502ad631719fb140cb4a33a014543a6",
            "0xa169561c344be2250102ac65f463c4a3df9e26236ce4d0c68f4871f07e21f7a12dcc1198c35804cc592670fe10866ecbcbc3666f506bc480b377f8fe6b270d8e",
            "6013d8218bac645eaf3edfec46d49278cf36153f23a54aad486bdb2a2072e94e",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x45945e00c502ad631719fb140cb4a33a014543a6",
            "BKFpVhw0S+IlAQKsZfRjxKPfniYjbOTQxo9IcfB+IfehLcwRmMNYBMxZJnD+EIZuy8vDZm9Qa8SAs3f4/msnDY4=",
            "YBPYIYusZF6vPt/sRtSSeM82FT8jpUqtSGvbKiBy6U4=",
        ),
    ),
    # vanity/0x46046
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x460464be1aa076930a3c7a5a73d31fa4519122d5",
            "0x3b3e7120a77c58b681d5b8062e8b340fcf7ea5525a133a16b5146e0c1b0a93ba163f2fc9aed66e824d953d5a1b6c0bf04b49a8e2a968cd11775717665ebe70d8",
            "dad925a812108e1f563bbbfb56650031c87006109b38a40c28d4656b54d78a36",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x460464be1aa076930a3c7a5a73d31fa4519122d5",
            "BDs+cSCnfFi2gdW4Bi6LNA/PfqVSWhM6FrUUbgwbCpO6Fj8vya7WboJNlT1aG2wL8EtJqOKpaM0Rd1cXZl6+cNg=",
            "2tklqBIQjh9WO7v7VmUAMchwBhCbOKQMKNRla1TXijY=",
        ),
    ),
    # vanity/0x46146
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x4614633200a847c16244dbedf379620ee916dff8",
            "0x86b71120cd623bfd04621e551e26a04513fe0bb4f1b9731ace25132ab9b9fb4d268856c88d06505686db10f67f3a2757d0146f08bd44c2c63926d0565ea190bf",
            "9eeaafb6e604fdb838278e6ffc45f442d8f2a3c4e04ee1da5c32ccf9d3f98a38",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x4614633200a847c16244dbedf379620ee916dff8",
            "BIa3ESDNYjv9BGIeVR4moEUT/gu08blzGs4lEyq5uftNJohWyI0GUFaG2xD2fzonV9AUbwi9RMLGOSbQVl6hkL8=",
            "nuqvtuYE/bg4J45v/EX0Qtjyo8TgTuHaXDLM+dP5ijg=",
        ),
    ),
    # vanity/0x46246
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x462468347969e3fd2c3424897c7dbc45c33e0ca1",
            "0xf51e8845378ab27617b55fe7f3f0cfa56a0a1673e39f92a123ff8863447b53b3a4728fdeabb135bad877537e96c19a62496b709362993f10bc60a597bbd62358",
            "6881e63c1185e9afa603a8e249fece10137794d86f4fd45b967ba88cccdcfeca",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x462468347969e3fd2c3424897c7dbc45c33e0ca1",
            "BPUeiEU3irJ2F7Vf5/Pwz6VqChZz45+SoSP/iGNEe1OzpHKP3quxNbrYd1N+lsGaYklrcJNimT8QvGCll7vWI1g=",
            "aIHmPBGF6a+mA6jiSf7OEBN3lNhvT9RblnuojMzc/so=",
        ),
    ),
    # vanity/0x46346
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x46346caa879e47900dbbcdfb0e237243e2a06491",
            "0x0138919e4d3420aaa52b53b47189d6574f7efaa5ac9c1bc5652da00baecc3889414188d7b3676cb07bcc8567731daecf9aa97a7e00db2e5c12f200a01a646e04",
            "929d3f4e51cc65bb220916a476cc2fa02556d1d0888d531caa256fc0b462cda1",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x46346caa879e47900dbbcdfb0e237243e2a06491",
            "BAE4kZ5NNCCqpStTtHGJ1ldPfvqlrJwbxWUtoAuuzDiJQUGI17NnbLB7zIVncx2uz5qpen4A2y5cEvIAoBpkbgQ=",
            "kp0/TlHMZbsiCRakdswvoCVW0dCIjVMcqiVvwLRizaE=",
        ),
    ),
    # vanity/0x46446
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x46446e099c17380940c6926a5e6d0e4444532767",
            "0x3577325cf5c61683b081c51b47dd60d4e1e8f2ebc45b45a3a0a08a4c24eb67c48da3345862da024e79c56119a059f65eee040ed7869150efe3cbb536f33e4f95",
            "436384cf91af925dcb5fe1e658c3789a076b5ff1de3a3d94f1cade63569b6829",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x46446e099c17380940c6926a5e6d0e4444532767",
            "BDV3Mlz1xhaDsIHFG0fdYNTh6PLrxFtFo6Cgikwk62fEjaM0WGLaAk55xWEZoFn2Xu4EDteGkVDv48u1NvM+T5U=",
            "Q2OEz5Gvkl3LX+HmWMN4mgdrX/HeOj2U8creY1abaCk=",
        ),
    ),
    # vanity/0x46546
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x465461388dbf5a5a4df84406e3f0a455722e67cb",
            "0x9071ae06492056a8f6eb0e078d80605d37f7f0deaa6d5fd6a09cca3bcd1df3b385f00fd72c33d2effcbb0883f0d4ebf83bcf5852b94fefe16941893f47cccd72",
            "56c4c4d7bc4b5528bf79844d43c8f5368639f7ea128c0f697442d269660b2426",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x465461388dbf5a5a4df84406e3f0a455722e67cb",
            "BJBxrgZJIFao9usOB42AYF039/Deqm1f1qCcyjvNHfOzhfAP1ywz0u/8uwiD8NTr+DvPWFK5T+/haUGJP0fMzXI=",
            "VsTE17xLVSi/eYRNQ8j1NoY59+oSjA9pdELSaWYLJCY=",
        ),
    ),
    # vanity/0x46646
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x46646775a95a5e51b62c3594334ed80f03c87a14",
            "0xcf414c6837af1cd498dde2d350a928e52d2f2e2054598e47586e51c6bfa7b5a99487ed613ddb7780d0d12780e4140cf326f24a58f4d0233637c678b57da66ba6",
            "8ab286dcabf20942c021eb6195d02db220d3bd881abbb3940c0ed296eb223612",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x46646775a95a5e51b62c3594334ed80f03c87a14",
            "BM9BTGg3rxzUmN3i01CpKOUtLy4gVFmOR1huUca/p7WplIftYT3bd4DQ0SeA5BQM8ybySlj00CM2N8Z4tX2ma6Y=",
            "irKG3KvyCULAIethldAtsiDTvYgau7OUDA7SlusiNhI=",
        ),
    ),
    # vanity/0x46746
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x46746bcd4d5627a3776b58f9cf58d205767c1fed",
            "0x2cc1219f8b391fd03165efdd2af4e8959519379e8472517323fa3e4754028e7b801fcd0f98495e322a43ca89630969d6dfd1211b20e3a1db94d78a0ae430df98",
            "c04947b617542a9b0e602dfdec53573fcc3983e69c89b220e5ed0ddf8e2acab6",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x46746bcd4d5627a3776b58f9cf58d205767c1fed",
            "BCzBIZ+LOR/QMWXv3Sr06JWVGTeehHJRcyP6PkdUAo57gB/ND5hJXjIqQ8qJYwlp1t/RIRsg46HblNeKCuQw35g=",
            "wElHthdUKpsOYC397FNXP8w5g+acibIg5e0N344qyrY=",
        ),
    ),
    # vanity/0x46846
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x46846e8fd9f7b6b0a5381c08a764c15750989e85",
            "0x0468f81db981fdd201e0436e4259df4e8e74cb14cd960715b0539c83b956140616160ad9ab852f28d122195212d0d73a3eca50e92691a6e8ada67f12c391b233",
            "332a19e4b141c973285e9b65e949a73eb7621ed1a0d37f2fd4045fc91698def5",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x46846e8fd9f7b6b0a5381c08a764c15750989e85",
            "BARo+B25gf3SAeBDbkJZ306OdMsUzZYHFbBTnIO5VhQGFhYK2auFLyjRIhlSEtDXOj7KUOkmkaboraZ/EsORsjM=",
            "MyoZ5LFByXMoXptl6UmnPrdiHtGg038v1ARfyRaY3vU=",
        ),
    ),
    # vanity/0x46946
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x46946caa61b239af81a32f4b63452dca5b02c481",
            "0xeac51ea160d01d316c3579449a35d7e87e6814a09a7e96628490a879a142b7d9b49b639ff2f536803b7de8c4f55c0a6e4acbc6b3a0a781cc6b2038eabefa6857",
            "759cbae534b915a558f377db1b60d57f7f9d04558604540a37205910658c3f9b",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x46946caa61b239af81a32f4b63452dca5b02c481",
            "BOrFHqFg0B0xbDV5RJo11+h+aBSgmn6WYoSQqHmhQrfZtJtjn/L1NoA7fejE9VwKbkrLxrOgp4HMayA46r76aFc=",
            "dZy65TS5FaVY83fbG2DVf3+dBFWGBFQKNyBZEGWMP5s=",
        ),
    ),
    # vanity/0x47047
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x47047ef723e89aad9a6e55f09174eb870fedf809",
            "0xc93106df018ceb0b91fe3623e942d0095e24abe849869d2bd3809a2efed99dc11988114a17d90b2bc07938f47d270631457f779273aa845eff89233cbd2e6cdc",
            "e0a886224e359de6a330cb1f5467d1a4e1cb37d2da16050cb9f633d9c1275f92",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x47047ef723e89aad9a6e55f09174eb870fedf809",
            "BMkxBt8BjOsLkf42I+lC0AleJKvoSYadK9OAmi7+2Z3BGYgRShfZCyvAeTj0fScGMUV/d5JzqoRe/4kjPL0ubNw=",
            "4KiGIk41neajMMsfVGfRpOHLN9LaFgUMufYz2cEnX5I=",
        ),
    ),
    # vanity/0x47147
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x4714780c2e66fa359d1459cf990b76f15a6b45a3",
            "0x35c643fe1271749b130fec7207bfd595f2448a0af7340db5c21c57290351e0478032a4f975b358eb62228840b2753c6a25616a79937ddadadd4f0eaff8cc7de6",
            "3d0d726ec367d252a5783063a0b725aa67e0feb31dc107056262dedab7533604",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x4714780c2e66fa359d1459cf990b76f15a6b45a3",
            "BDXGQ/4ScXSbEw/scge/1ZXyRIoK9zQNtcIcVykDUeBHgDKk+XWzWOtiIohAsnU8aiVhanmTfdra3U8Or/jMfeY=",
            "PQ1ybsNn0lKleDBjoLclqmfg/rMdwQcFYmLe2rdTNgQ=",
        ),
    ),
    # vanity/0x47247
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x4724702625197cb4bba6576da72120d16889daa6",
            "0x432cb6797b979b552d6d8897cbd3c902695f4029c517bf40ce710d559a1e59f96ac4f6ca2effe303f9700801920b00cd83e428aa6f2cdd2fe98198d043f78e45",
            "d7967e721b9574c7cd22b83bba072398c7ab1f48cae052035b780a6e64d5c305",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x4724702625197cb4bba6576da72120d16889daa6",
            "BEMstnl7l5tVLW2Il8vTyQJpX0ApxRe/QM5xDVWaHln5asT2yi7/4wP5cAgBkgsAzYPkKKpvLN0v6YGY0EP3jkU=",
            "15Z+chuVdMfNIrg7ugcjmMerH0jK4FIDW3gKbmTVwwU=",
        ),
    ),
    # vanity/0x47347
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x4734749175ea9b8806d772a4e90b8ab736b99c4c",
            "0xe7ff2b9060150a35a575d0ef8ad15f73180676e8b2f090952d97acb695abf48fbed30004f5cf7efff02398de5573a5c92ce74ff88d138957fc911f3deba11ca4",
            "d600f1d12daeb221a6c776f75a0c02c101fa9fc6b2d3480844e2ac331adaf0bc",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x4734749175ea9b8806d772a4e90b8ab736b99c4c",
            "BOf/K5BgFQo1pXXQ74rRX3MYBnbosvCQlS2XrLaVq/SPvtMABPXPfv/wI5jeVXOlySznT/iNE4lX/JEfPeuhHKQ=",
            "1gDx0S2usiGmx3b3WgwCwQH6n8ay00gIROKsMxra8Lw=",
        ),
    ),
    # vanity/0x47447
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x474470fcd406b9309f92fabf154717e1d2c02d4b",
            "0x763f638c5080ebae2a3972ef3e9fc3caadff91c7d522682025acc9f8526e914520e452eb399003b35e2f19e72310756be7a1c344f546f860ca0416295d445ca3",
            "b85e8c2e0ba76b30a3fef9689a2d1f74868ba38cde6282c384a29b2ca5dbfb10",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x474470fcd406b9309f92fabf154717e1d2c02d4b",
            "BHY/Y4xQgOuuKjly7z6fw8qt/5HH1SJoICWsyfhSbpFFIORS6zmQA7NeLxnnIxB1a+ehw0T1RvhgygQWKV1EXKM=",
            "uF6MLgunazCj/vlomi0fdIaLo4zeYoLDhKKbLKXb+xA=",
        ),
    ),
    # vanity/0x47547
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x475472b7f96f2a195122c2e1a94b5418a8a13d0d",
            "0xee266745c3de40c7467f4f63085c969aa3ec0aba4d4d16abfaa2650f2fd95ed4228913d59fb112f9d3920e5005192ac9e9ef38c58c89fc74a74697ef313f45eb",
            "c585dd3018107e655485601bdd01adda082ffce6b2b359790ff79262d7e9759a",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x475472b7f96f2a195122c2e1a94b5418a8a13d0d",
            "BO4mZ0XD3kDHRn9PYwhclpqj7Aq6TU0Wq/qiZQ8v2V7UIokT1Z+xEvnTkg5QBRkqyenvOMWMifx0p0aX7zE/Res=",
            "xYXdMBgQfmVUhWAb3QGt2ggv/Oays1l5D/eSYtfpdZo=",
        ),
    ),
    # vanity/0x47647
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x47647ea6d2c6804115143113fe74b3732dadb04b",
            "0x163ece75b4f295e256d8b0a9dfb801538b7a988b5ea8c693f5261c89c009c9bb31f19b4809320984b6e2608fa5d7d187aa4879392e8447b091c6cf286ee12d0c",
            "1623e55decb52c087977ec982b8b977ce30d9b1fcd357d76525c3706c83369f7",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x47647ea6d2c6804115143113fe74b3732dadb04b",
            "BBY+znW08pXiVtiwqd+4AVOLepiLXqjGk/UmHInACcm7MfGbSAkyCYS24mCPpdfRh6pIeTkuhEewkcbPKG7hLQw=",
            "FiPlXey1LAh5d+yYK4uXfOMNmx/NNX12Ulw3Bsgzafc=",
        ),
    ),
    # vanity/0x47747
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x47747cd3c5afcf55d3e4a69514fc19d6da1e198f",
            "0x815c4792dc3192096408a08ebbc7c7bd21e7e3092f9572e0bb2dbdacab3266936da9861dd815f438f7ba051493b9565d8f22b45450aa37eaabb7948884fb821a",
            "7aa0dc87ebab1e1252945bb90554eac0b4132c56f184646f318a5b72f15be5aa",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x47747cd3c5afcf55d3e4a69514fc19d6da1e198f",
            "BIFcR5LcMZIJZAigjrvHx70h5+MJL5Vy4LstvayrMmaTbamGHdgV9Dj3ugUUk7lWXY8itFRQqjfqq7eUiIT7gho=",
            "eqDch+urHhJSlFu5BVTqwLQTLFbxhGRvMYpbcvFb5ao=",
        ),
    ),
    # vanity/0x47847
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x47847e6883b26a0561ed5cf3f422216f7283b5f4",
            "0xd600570713f8627a016a5f06d4d7e501d83e0aa5bb165095bb9221972aeacf01b7cc7f83558ff3c0c095ee74e0e78a0458ad159ab9664966260b81c542df1b6e",
            "fd7ed889b093552db96d30f27711bc32bf819804ff02a555b54b71def6198355",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x47847e6883b26a0561ed5cf3f422216f7283b5f4",
            "BNYAVwcT+GJ6AWpfBtTX5QHYPgqluxZQlbuSIZcq6s8Bt8x/g1WP88DAle504OeKBFitFZq5ZklmJguBxULfG24=",
            "/X7YibCTVS25bTDydxG8Mr+BmAT/AqVVtUtx3vYZg1U=",
        ),
    ),
    # vanity/0x47947
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x479470fc43e3ebba32c8cfd854f3f90f64183793",
            "0x367a25c90ff3417e8a5065e3a033fb01931b095d958241640ffb96b4467e8fd44efdee5cea3604b85e0a3573ec17b038dc8b88c94ab43aa044d7d706349a78b1",
            "36f17946c3f4c1380544613963e15644bf88c609d0e04ab6e9f54b1d14e8ef12",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x479470fc43e3ebba32c8cfd854f3f90f64183793",
            "BDZ6JckP80F+ilBl46Az+wGTGwldlYJBZA/7lrRGfo/UTv3uXOo2BLheCjVz7BewONyLiMlKtDqgRNfXBjSaeLE=",
            "NvF5RsP0wTgFRGE5Y+FWRL+IxgnQ4Eq26fVLHRTo7xI=",
        ),
    ),
    # vanity/0x48048
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x480483f69988c11a9059ab4a9b84400f88c0d24d",
            "0x68db01a241bc796f3f281820997fe3492491cb996e9a82df6598fa31216aef8e37cb67818222db573a32c48b91dc0ee45476be058cd2e0757ff23c01ffacd46b",
            "b5a2cf943e0147c9e582a2cb8b11e0ec9bea91e22d865aeb50ebe26a2ec5300c",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x480483f69988c11a9059ab4a9b84400f88c0d24d",
            "BGjbAaJBvHlvPygYIJl/40kkkcuZbpqC32WY+jEhau+ON8tngYIi21c6MsSLkdwO5FR2vgWM0uB1f/I8Af+s1Gs=",
            "taLPlD4BR8nlgqLLixHg7JvqkeIthlrrUOviai7FMAw=",
        ),
    ),
    # vanity/0x48148
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x48148c175ccc533667ca7001d71e81abcef98e2a",
            "0xb52ec728e394fc6b8a081a525580d69081f880abf28ccd42f738cefe61490f15c2efa51b2e86701b7c1185e1a4b3bfbcc0e44dbffab4f3004e270e6f5a2e4b2b",
            "597f04692b4d9654c2ad97b64b71fd7816c820e004051d1cd1167cd944bf624f",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x48148c175ccc533667ca7001d71e81abcef98e2a",
            "BLUuxyjjlPxriggaUlWA1pCB+ICr8ozNQvc4zv5hSQ8Vwu+lGy6GcBt8EYXhpLO/vMDkTb/6tPMATicOb1ouSys=",
            "WX8EaStNllTCrZe2S3H9eBbIIOAEBR0c0RZ82US/Yk8=",
        ),
    ),
    # vanity/0x48248
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x482483f2ad63c2669fb2c5f3c03d22e176682ff1",
            "0x38d17ae8154a4067a636447b3022c7d00b52f86e70b0fbb6f29a776ee14c45bce65cb983170be0c486598637a663d1e849c234ab20bf925c57da38e2a32dac22",
            "83aa984f007522b61c76560154b87dc8045df940c05f63638727bbced2ac2cdf",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x482483f2ad63c2669fb2c5f3c03d22e176682ff1",
            "BDjReugVSkBnpjZEezAix9ALUvhucLD7tvKad27hTEW85ly5gxcL4MSGWYY3pmPR6EnCNKsgv5JcV9o44qMtrCI=",
            "g6qYTwB1IrYcdlYBVLh9yARd+UDAX2Njhye7ztKsLN8=",
        ),
    ),
    # vanity/0x48348
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x483481ff1b40bc2b67bf5c914612b2248169e562",
            "0xba9c4de357e52f98a43be23ce3f8f48687a21695a6d887eca0fb9f75d946e53c2cfd6b60d231e81c36f1303e9a2232abb199ad97f34433383c4ad43d70f804c6",
            "4e96be00667896287241ee130fd744d81d522b0d406ca1dabcf1b0beb1da93a5",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x483481ff1b40bc2b67bf5c914612b2248169e562",
            "BLqcTeNX5S+YpDviPOP49IaHohaVptiH7KD7n3XZRuU8LP1rYNIx6Bw28TA+miIyq7GZrZfzRDM4PErUPXD4BMY=",
            "Tpa+AGZ4lihyQe4TD9dE2B1SKw1AbKHavPGwvrHak6U=",
        ),
    ),
    # vanity/0x48448
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x484484ab6d1916608ce13effb730ba76b143ac77",
            "0xaea154771f88beef92db27c216d63ce877b14d2fa7a1da9658925f0851ed7fea58757097c1e7f7734b3cd2d2e5cb09c74e70986eefd7d8e7de9a0168cf9a9978",
            "0a1829f5a038da434160f83b831c4ac24e5f7424160b2456dd8f2ac45d44ae7c",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x484484ab6d1916608ce13effb730ba76b143ac77",
            "BK6hVHcfiL7vktsnwhbWPOh3sU0vp6HalliSXwhR7X/qWHVwl8Hn93NLPNLS5csJx05wmG7v19jn3poBaM+amXg=",
            "Chgp9aA42kNBYPg7gxxKwk5fdCQWCyRW3Y8qxF1Ernw=",
        ),
    ),
    # vanity/0x48548
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x48548f91068ccb2b1c584793cabb0d0997ef3fd8",
            "0x44fea013f42d246f7da7e25b049f88877bf8c6aab7d655f9fb893324b9586cc86dd06fdc72bec5a48ab3b120cfe1ed0689ee832d6f26e9ca2b3d11d0eb475fe9",
            "22885d6276c345e33f7fc4a0dcf586d4ce2259a9bc42fcaef6f514c1ec1ed491",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x48548f91068ccb2b1c584793cabb0d0997ef3fd8",
            "BET+oBP0LSRvfafiWwSfiId7+Maqt9ZV+fuJMyS5WGzIbdBv3HK+xaSKs7Egz+HtBonugy1vJunKKz0R0OtHX+k=",
            "IohdYnbDReM/f8Sg3PWG1M4iWam8Qvyu9vUUwewe1JE=",
        ),
    ),
    # vanity/0x48648
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x486488d217a57c21f17c581e34dc92f7b4e34a0c",
            "0x8e0310c2dd48532d688faa2b0a06d0e1f9b07dcbfd1a08e9921dd9a89b81ddb43097965b05cf1e858eefea3beca60e7bc888deca24519e285cf598496085cf95",
            "b36bee8de012955642bc3e8947e3c010af37c456cd64b98f4365b4c4ac01cc3b",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x486488d217a57c21f17c581e34dc92f7b4e34a0c",
            "BI4DEMLdSFMtaI+qKwoG0OH5sH3L/RoI6ZId2aibgd20MJeWWwXPHoWO7+o77KYOe8iI3sokUZ4oXPWYSWCFz5U=",
            "s2vujeASlVZCvD6JR+PAEK83xFbNZLmPQ2W0xKwBzDs=",
        ),
    ),
    # vanity/0x48748
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x487487cb6fcd21366bfd34eca4d02bdf57e082c2",
            "0xedf81358f6a11e180f539cd8cefd0c2d87cdd4162a82960d41a592827ce67a11670906c0fb0262ee16a09332543415b641eaff33a6e159ee6c8b26da267b6e4d",
            "f5697cd663a256003a819b41c758dea513dab23a5b5b3f50bd447d4c165aa965",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x487487cb6fcd21366bfd34eca4d02bdf57e082c2",
            "BO34E1j2oR4YD1Oc2M79DC2HzdQWKoKWDUGlkoJ85noRZwkGwPsCYu4WoJMyVDQVtkHq/zOm4VnubIsm2iZ7bk0=",
            "9Wl81mOiVgA6gZtBx1jepRPasjpbWz9QvUR9TBZaqWU=",
        ),
    ),
    # vanity/0x48848
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x48848978c91432e89fd8d06b8dbd467eed3ca40d",
            "0x4dfe003e4782cbb7dfe3e55889deb2dd4b566ae15a3f687535d7f4111f24e9fd2d76369c890cbc58f5afa1ae3acb2ac8ffea9ebe3b72b7430226abb0187b9ae6",
            "3c4789f75f84a628076f00edbb901ad16f892b6592f6afa219e97b75f0066111",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x48848978c91432e89fd8d06b8dbd467eed3ca40d",
            "BE3+AD5Hgsu33+PlWInest1LVmrhWj9odTXX9BEfJOn9LXY2nIkMvFj1r6GuOssqyP/qnr47crdDAiarsBh7muY=",
            "PEeJ91+EpigHbwDtu5Aa0W+JK2WS9q+iGel7dfAGYRE=",
        ),
    ),
    # vanity/0x48948
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x48948aa8a684ebe5c710ecb345809ef4d1952e90",
            "0x490cb12679157a0247b5366b01a90823d0fd384cae992134a5c16d5507641e3fbe36aec1d70440185148d4592d71a3eee39e2378b0416874371015f66ea86180",
            "867ef768f7d61c53c97a92c9cdccf969d6370aed3cffc8783bb88e4055152028",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x48948aa8a684ebe5c710ecb345809ef4d1952e90",
            "BEkMsSZ5FXoCR7U2awGpCCPQ/ThMrpkhNKXBbVUHZB4/vjauwdcEQBhRSNRZLXGj7uOeI3iwQWh0NxAV9m6oYYA=",
            "hn73aPfWHFPJepLJzcz5adY3Cu08/8h4O7iOQFUVICg=",
        ),
    ),
    # vanity/0x49049
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x490494a871efc4d473ddba56d7c4f9ba20084784",
            "0x23be152225dfb2df5f5b7add0714bc17f21551fe9741a83f65f9d49a8e907888da0971c8374b53dc3c59de6a5e2c4c39bb6b098595dc5d763732aa3a1a3ab5f2",
            "9793ca97232c92aad6fd9832ffb53adee70de02b7a9bc00cbc01455eaffc84a5",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x490494a871efc4d473ddba56d7c4f9ba20084784",
            "BCO+FSIl37LfX1t63QcUvBfyFVH+l0GoP2X51JqOkHiI2glxyDdLU9w8Wd5qXixMObtrCYWV3F12NzKqOho6tfI=",
            "l5PKlyMskqrW/Zgy/7U63ucN4Ct6m8AMvAFFXq/8hKU=",
        ),
    ),
    # vanity/0x49149
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x49149c41d262f702780c651f3fc2d5e770859055",
            "0x517e790d0fc46d18ab24719a91c681ff3429f10fd7e08c2a7d8a995569f76d59228423f0c9dcda322f91692617f69b4f0737ed8d577374a3a9b256887ec1612e",
            "cd30e466a643e3a26985c41fc3c409d9a6140e0ac46b68f3070a40afed55ad0f",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x49149c41d262f702780c651f3fc2d5e770859055",
            "BFF+eQ0PxG0YqyRxmpHGgf80KfEP1+CMKn2KmVVp921ZIoQj8Mnc2jIvkWkmF/abTwc37Y1Xc3SjqbJWiH7BYS4=",
            "zTDkZqZD46JphcQfw8QJ2aYUDgrEa2jzBwpAr+1VrQ8=",
        ),
    ),
    # vanity/0x49249
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x492491390c629a019095989682e63972ab1705db",
            "0xd9b8d0c1ff36c3f4ea3080f4b08ca3c5ef83f26baa4bb74d6d81b3175cc82761576b882601efd7518f8ecbad9e467e50a25d1766513060b38ac7e5798cd9c1c4",
            "a0c95a7d207c840ba1b24d56679ab445ca44e4b5085da403dc49e057e2ff517d",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x492491390c629a019095989682e63972ab1705db",
            "BNm40MH/NsP06jCA9LCMo8Xvg/Jrqku3TW2BsxdcyCdhV2uIJgHv11GPjsutnkZ+UKJdF2ZRMGCzisfleYzZwcQ=",
            "oMlafSB8hAuhsk1WZ5q0RcpE5LUIXaQD3EngV+L/UX0=",
        ),
    ),
    # vanity/0x49349
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x49349aec7ba1802ddc45f6fa0662644e2b2584bf",
            "0xa17ffd44cd3f334fe28e0abc2c2cf0355b8f876cb1276dc01e935ac31eac2ee7b3944425ed946376e607fe8790195c4ebe4be9761f0be02177c40cb8a16df82e",
            "9bbe5a278462a625d1c716cf432f509cff95f06bfc6ea7011e19e9c39c423408",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x49349aec7ba1802ddc45f6fa0662644e2b2584bf",
            "BKF//UTNPzNP4o4KvCws8DVbj4dssSdtwB6TWsMerC7ns5REJe2UY3bmB/6HkBlcTr5L6XYfC+Ahd8QMuKFt+C4=",
            "m75aJ4RipiXRxxbPQy9QnP+V8Gv8bqcBHhnpw5xCNAg=",
        ),
    ),
    # vanity/0x49449
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x49449df51b5c4841036cf15909b8b168e42e1bab",
            "0xa4e26d04378a4047d94ddd4fea23420a3a014857bc8408469870ea71cd2127fec0aa12eb9b228d05d4d49f237ba0d2725b0c6d433499b20cfda5e88bf05e3e17",
            "5e4f00c220fa696770109fb35c35aa354cd9e45780ac01e8d6513bb25dda95b0",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x49449df51b5c4841036cf15909b8b168e42e1bab",
            "BKTibQQ3ikBH2U3dT+ojQgo6AUhXvIQIRphw6nHNISf+wKoS65sijQXU1J8je6DSclsMbUM0mbIM/aXoi/BePhc=",
            "Xk8AwiD6aWdwEJ+zXDWqNUzZ5FeArAHo1lE7sl3albA=",
        ),
    ),
    # vanity/0x49549
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x495498be7f674e6c68a8bb33f17cda9dba193373",
            "0xffac7381c2a2c124f1caa1615726cb035fb3976acb912ce9888a6ef51098b2d6652c6d382f93bbadfa3e34d540039af2b266889e5cb1705099d100d6976ee34b",
            "04418c3ffe447447a8dc6090ea76eaf7a0b6f4afba4090a51b01172b2078285d",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x495498be7f674e6c68a8bb33f17cda9dba193373",
            "BP+sc4HCosEk8cqhYVcmywNfs5dqy5Es6YiKbvUQmLLWZSxtOC+Tu636PjTVQAOa8rJmiJ5csXBQmdEA1pdu40s=",
            "BEGMP/5EdEeo3GCQ6nbq96C29K+6QJClGwEXKyB4KF0=",
        ),
    ),
    # vanity/0x49649
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x4964939398fdfbd37e15d9bba52ccccc1a00acd1",
            "0x64701459ec96ea8e658ec9c14f430526314050ecbb4b335a5806678f3b989767757d4ae019ed9fbf865cca6a7cf141b41379a0923d459bbf3fb5967c67eac818",
            "c3366f3b702901786faa30a1207ab854e8018b2b45b5737487901581745eed90",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x4964939398fdfbd37e15d9bba52ccccc1a00acd1",
            "BGRwFFnsluqOZY7JwU9DBSYxQFDsu0szWlgGZ487mJdndX1K4Bntn7+GXMpqfPFBtBN5oJI9RZu/P7WWfGfqyBg=",
            "wzZvO3ApAXhvqjChIHq4VOgBiytFtXN0h5AVgXRe7ZA=",
        ),
    ),
    # vanity/0x49749
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x49749881ec57f12ce5aa623250114230c3823faf",
            "0x1df6dc50ad593e5a5e7361ad3c01a47c9eb9318347f950e7e69084284e92d97ec23d811699f211be8196b0a61ad4d25c5c9893c9b542409a61e5cdb91ef8f0db",
            "2579281028ad8afe59a16c7b6b5cb384a937447685e4f9aeee5a8bbd56b32e39",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x49749881ec57f12ce5aa623250114230c3823faf",
            "BB323FCtWT5aXnNhrTwBpHyeuTGDR/lQ5+aQhChOktl+wj2BFpnyEb6BlrCmGtTSXFyYk8m1QkCaYeXNuR748Ns=",
            "JXkoECitiv5ZoWx7a1yzhKk3RHaF5Pmu7lqLvVazLjk=",
        ),
    ),
    # vanity/0x49849
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x49849ca941cc9bab955cf6bbfee1ffe6cd74e42b",
            "0x5d625ebb41252e221bfb43595a5ce37146f6d901240d0d3454278b524f021fdbed8d3636f7c519b1add4c4f4ed499f79c858608152cca91a4fac0b1115ef89d9",
            "e80fc488d372a149be824bfc903937e04bb83d50f5fa9ea690b7c6073cc9481b",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x49849ca941cc9bab955cf6bbfee1ffe6cd74e42b",
            "BF1iXrtBJS4iG/tDWVpc43FG9tkBJA0NNFQni1JPAh/b7Y02NvfFGbGt1MT07UmfechYYIFSzKkaT6wLERXvidk=",
            "6A/EiNNyoUm+gkv8kDk34Eu4PVD1+p6mkLfGBzzJSBs=",
        ),
    ),
    # vanity/0x49949
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x49949dc7b691a0e523dd1897c4b56acf30435d1f",
            "0xbcf15fc9cbac4f982ea223a29b136a6f511cf9cd67d48d17942f80a0ee884f50822146ff558fef4495e2b9baa7ecc625235809e6315c7eec23d4078f95db560b",
            "4eae7b994d52050154cdb361221cf7ae13ee5c455e33f6fad16839118117e23b",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x49949dc7b691a0e523dd1897c4b56acf30435d1f",
            "BLzxX8nLrE+YLqIjopsTam9RHPnNZ9SNF5QvgKDuiE9QgiFG/1WP70SV4rm6p+zGJSNYCeYxXH7sI9QHj5XbVgs=",
            "Tq57mU1SBQFUzbNhIhz3rhPuXEVeM/b60Wg5EYEX4js=",
        ),
    ),
    # vanity/0x50050
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x50050bb799e846835adcb9d74ede9900d15d234a",
            "0x40a88d854c4213931b6870be8222ec3cbd0a9cdc5b933bf8446652364a9333627c29b1c0b2dbaf9ec84b9ee30541a567368672d388532f08a4d728889da73db0",
            "ab6472d875015b4f4ac1d018039f8cb7ba9ff58873ad0c67b75bfc9b1e3e3237",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x50050bb799e846835adcb9d74ede9900d15d234a",
            "BECojYVMQhOTG2hwvoIi7Dy9CpzcW5M7+ERmUjZKkzNifCmxwLLbr57IS57jBUGlZzaGctOIUy8IpNcoiJ2nPbA=",
            "q2Ry2HUBW09KwdAYA5+Mt7qf9YhzrQxnt1v8mx4+Mjc=",
        ),
    ),
    # vanity/0x50150
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x501507119f0c8ff0923c3aa8d59f963763bb6a64",
            "0x5ba7248c68d610d6977687141821ac8111a0b6de225754b4c18bbd282463bc32061107a2b9f832cee795f6adb807ec794c79f801fe3403b84fe42401d69ad5cb",
            "05fb3a725bb4649b7163e6289d5e24fc13e802348c15fdefdeb8991a18daa29d",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x501507119f0c8ff0923c3aa8d59f963763bb6a64",
            "BFunJIxo1hDWl3aHFBghrIERoLbeIldUtMGLvSgkY7wyBhEHorn4Ms7nlfatuAfseUx5+AH+NAO4T+QkAdaa1cs=",
            "Bfs6clu0ZJtxY+YonV4k/BPoAjSMFf3v3riZGhjaop0=",
        ),
    ),
    # vanity/0x50250
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x502506d91ce7c8717c0847985fe601b4800f3833",
            "0x950a5902899bc7ae1af93b560e95d6550dd8cdb4639198d3285ccfe74bac7f0ed1e2b717933f30fbffe565391f1a40049e53e8f7c35b4468edad424ed8351254",
            "75170ff61b7072cfaece7266aee59e0ee75ba6d10b1d4b198f93d6e8d7977e11",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x502506d91ce7c8717c0847985fe601b4800f3833",
            "BJUKWQKJm8euGvk7Vg6V1lUN2M20Y5GY0yhcz+dLrH8O0eK3F5M/MPv/5WU5HxpABJ5T6PfDW0Ro7a1CTtg1ElQ=",
            "dRcP9htwcs+uznJmruWeDudbptELHUsZj5PW6NeXfhE=",
        ),
    ),
    # vanity/0x50350
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x5035020e55e3c9f2eba5e21ba96953823e736caf",
            "0x49459a009699ac765c2ea7d2c3912416a1da6661cc42e7aaf52b38e4b266ec36ab549af105d2179917ca25c980beed17450686669fb062b95fcf2d179085d8dd",
            "d5bc5a4300c742ac4e2cf8d7975559774cae6649646ec263b482766a712665d1",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x5035020e55e3c9f2eba5e21ba96953823e736caf",
            "BElFmgCWmax2XC6n0sORJBah2mZhzELnqvUrOOSyZuw2q1Sa8QXSF5kXyiXJgL7tF0UGhmafsGK5X88tF5CF2N0=",
            "1bxaQwDHQqxOLPjXl1VZd0yuZklkbsJjtIJ2anEmZdE=",
        ),
    ),
    # vanity/0x50450
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x50450ed4145216bd10d2c93c303ad8d44b6ee74b",
            "0xce86f7bc140f468761866013d32dc795f5f82a860f4d2a2ae8c3366c51cd9a0b64cbdf3552dadf7bafd6a6c8a11050bd56ed1b89b7f4af52d8f2149198be6681",
            "ccd34a2764685016a9cf333def6921de4c1933c0cf761d46130f0be0bff47ae1",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x50450ed4145216bd10d2c93c303ad8d44b6ee74b",
            "BM6G97wUD0aHYYZgE9Mtx5X1+CqGD00qKujDNmxRzZoLZMvfNVLa33uv1qbIoRBQvVbtG4m39K9S2PIUkZi+ZoE=",
            "zNNKJ2RoUBapzzM972kh3kwZM8DPdh1GEw8L4L/0euE=",
        ),
    ),
    # vanity/0x50550
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x50550b29ffc96f552c153321e355c70603e4b3b6",
            "0x765eb12fb267aa4baa89c983577e6732e114e24f3f0a0da1348579888a9786357a3ed9cb7653483ec588bf216aa076cf972a79a4a60bfef4c06525da86469601",
            "8b35ffbbbf1fea47fc360307b0d330b46eb191a1178520b01e3b72c860184fd4",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x50550b29ffc96f552c153321e355c70603e4b3b6",
            "BHZesS+yZ6pLqonJg1d+ZzLhFOJPPwoNoTSFeYiKl4Y1ej7Zy3ZTSD7FiL8haqB2z5cqeaSmC/70wGUl2oZGlgE=",
            "izX/u78f6kf8NgMHsNMwtG6xkaEXhSCwHjtyyGAYT9Q=",
        ),
    ),
    # vanity/0x50650
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x5065001c85dffcdef530beb228ce066d543293c1",
            "0x2e1712e739324cc36c2a90ee69129d56ceafceb212ac27e1ef369e625e17063c389094ccc4d83e3ddd9187de023b3a3ac6c3a4211a77f33dac2d619715491ae4",
            "b6709a80c4f98bd8d4d101232af9003cf3fd3526168df0c19ed75cda5efb6175",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x5065001c85dffcdef530beb228ce066d543293c1",
            "BC4XEuc5MkzDbCqQ7mkSnVbOr86yEqwn4e82nmJeFwY8OJCUzMTYPj3dkYfeAjs6OsbDpCEad/M9rC1hlxVJGuQ=",
            "tnCagMT5i9jU0QEjKvkAPPP9NSYWjfDBntdc2l77YXU=",
        ),
    ),
    # vanity/0x50750
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x5075028eade0d9a4e1f6b6571ef13569a46d3542",
            "0x9f54f1f629416524dfc64c61b1fd209d4ce8298f87b839e1d8d71d5cd139ab3117f915334965ed14f1c2bd1e0a4cda0ee48bed71bc24b692e911d61e525650c6",
            "cf4c1949897b7fa916ed0b1ec49111b99b068b20513605fa11462f79ad11aaf0",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x5075028eade0d9a4e1f6b6571ef13569a46d3542",
            "BJ9U8fYpQWUk38ZMYbH9IJ1M6CmPh7g54djXHVzROasxF/kVM0ll7RTxwr0eCkzaDuSL7XG8JLaS6RHWHlJWUMY=",
            "z0wZSYl7f6kW7QsexJERuZsGiyBRNgX6EUYvea0RqvA=",
        ),
    ),
    # vanity/0x50850
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x50850a55b1668e6658c4f3b9c2d555b325bc9968",
            "0x6fa6b7068e88e91a3cf5643ccf83445ba750f5881b632d286662c67a3eba35dc43868c969689eaaee56a98cdb3e37bcd1e6f270c8bb22aa215892af9fbe9fcb0",
            "fb1e1bd743c87527ee58506093862de82030e79af73a26487419ec8eb65a2654",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x50850a55b1668e6658c4f3b9c2d555b325bc9968",
            "BG+mtwaOiOkaPPVkPM+DRFunUPWIG2MtKGZixno+ujXcQ4aMlpaJ6q7lapjNs+N7zR5vJwyLsiqiFYkq+fvp/LA=",
            "+x4b10PIdSfuWFBgk4Yt6CAw55r3OiZIdBnsjrZaJlQ=",
        ),
    ),
    # vanity/0x50950
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x50950a2e7e53353c8bc7d1bead0e90fbc641239a",
            "0xa72bbf1307bb63926e8afbe8916b29ae39421540b062668e2bc7a90d0c7421ec641e70da94f4675fb50a28296c8cf5431b25b25c3d7eb9aadf6aeb1f6cd8d348",
            "02f3f6026b2174f4c361d98e835ee3cba8ac2e547ee01e2a0100aafdb5bc45db",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x50950a2e7e53353c8bc7d1bead0e90fbc641239a",
            "BKcrvxMHu2OSbor76JFrKa45QhVAsGJmjivHqQ0MdCHsZB5w2pT0Z1+1CigpbIz1Qxslslw9frmq32rrH2zY00g=",
            "AvP2AmshdPTDYdmOg17jy6isLlR+4B4qAQCq/bW8Rds=",
        ),
    ),
    # vanity/0x51051
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x51051150f561fb84fb631bf00aeee070d4a64092",
            "0x5976762373b1328b1d23299312a0daf078ed2d2f42f66a6bb481943cfe48835e583e24c9406e58fb23a16fdaab689a9f95806ec50b89bfdcbdf5a4317e747c6f",
            "f36b18e394f1515940628057e98cd120be2c40cbc22adf7b8eedc38dc2411329",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x51051150f561fb84fb631bf00aeee070d4a64092",
            "BFl2diNzsTKLHSMpkxKg2vB47S0vQvZqa7SBlDz+SINeWD4kyUBuWPsjoW/aq2ian5WAbsULib/cvfWkMX50fG8=",
            "82sY45TxUVlAYoBX6YzRIL4sQMvCKt97ju3DjcJBEyk=",
        ),
    ),
    # vanity/0x51151
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x51151cc1224f1d03abc049005b029a77019618ff",
            "0x9292b6b6ac493b818429f7f4dd9ce195404a1c89123ef5605e3447e056553c3c41fa7fa98331ce4d51e4365d8200f4d960509994e89506830f0843831069e422",
            "0c048ef0eed5768efdb09c7153668d1de046e687b1577b18622accc3d8fb7a5e",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x51151cc1224f1d03abc049005b029a77019618ff",
            "BJKStrasSTuBhCn39N2c4ZVAShyJEj71YF40R+BWVTw8Qfp/qYMxzk1R5DZdggD02WBQmZTolQaDDwhDgxBp5CI=",
            "DASO8O7Vdo79sJxxU2aNHeBG5oexV3sYYirMw9j7el4=",
        ),
    ),
    # vanity/0x51251
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x51251f51b2784f3550a5e4592bf06b1e29dfd539",
            "0x6e08f40f792a8895dd4a931ff5222222ad55fa228b6869392f9e1841fe52ceb1a392c99494b1b68242140d7018c4e4f4d1c94db101681d6d20371d07b0798c53",
            "b3ed96fec8425c75a1a52aa8d7ad28e2768f1f63e8ace8b51d5d78d01ce30c39",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x51251f51b2784f3550a5e4592bf06b1e29dfd539",
            "BG4I9A95KoiV3UqTH/UiIiKtVfoii2hpOS+eGEH+Us6xo5LJlJSxtoJCFA1wGMTk9NHJTbEBaB1tIDcdB7B5jFM=",
            "s+2W/shCXHWhpSqo160o4naPH2PorOi1HV140BzjDDk=",
        ),
    ),
    # vanity/0x51351
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x513516cd424b03841ab31c7ad860bb96f193dc5e",
            "0xffb621c2a7ba9a60415ed5ad78d4ecc29567dc29188792868f005c0b7b635c70ede1fadb5fc17845fa7a82fb98c90646e92cc29eb291e02d3434029e0f80bff0",
            "634c2e679bf22ae85e9176d576f1c48a0d5d1ab27f01b396d8812e1c7e0612ab",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x513516cd424b03841ab31c7ad860bb96f193dc5e",
            "BP+2IcKnuppgQV7VrXjU7MKVZ9wpGIeSho8AXAt7Y1xw7eH621/BeEX6eoL7mMkGRukswp6ykeAtNDQCng+Av/A=",
            "Y0wuZ5vyKuhekXbVdvHEig1dGrJ/AbOW2IEuHH4GEqs=",
        ),
    ),
    # vanity/0x51451
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x51451f7d0cc82f9dc8555570d03eb57b2cafb0df",
            "0xd15ecffe0a56436f69e2fac4da4b01d807432cb1f293902e90e2310e008012e31464cb6b986d2bbdd12468eb0719d4bd0a7504bc2d8062b1579b88c58c270a10",
            "39d1a8495f2a5fa0baffbd8cba46993b60e510e762f3838e44c213c34ba7c65e",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x51451f7d0cc82f9dc8555570d03eb57b2cafb0df",
            "BNFez/4KVkNvaeL6xNpLAdgHQyyx8pOQLpDiMQ4AgBLjFGTLa5htK73RJGjrBxnUvQp1BLwtgGKxV5uIxYwnChA=",
            "OdGoSV8qX6C6/72MukaZO2DlEOdi84OORMITw0unxl4=",
        ),
    ),
    # vanity/0x51551
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x515512b629c13d4928da578ae4c531cab18e7d90",
            "0xc0b7146be8ee6a290b4fa07008919740746fae71a51c504e019aab7b644b465680c0411ebfbc1b3e9b241d9a3ed204378abb8bd830c2430fca4fa0470feffe74",
            "e4b2488ebe082f02cab767a5e64731fc4f2686279fb67ca26c4fb88950e99787",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x515512b629c13d4928da578ae4c531cab18e7d90",
            "BMC3FGvo7mopC0+gcAiRl0B0b65xpRxQTgGaq3tkS0ZWgMBBHr+8Gz6bJB2aPtIEN4q7i9gwwkMPyk+gRw/v/nQ=",
            "5LJIjr4ILwLKt2el5kcx/E8mhieftnyibE+4iVDpl4c=",
        ),
    ),
    # vanity/0x51651
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x51651c8c271f47c9820123e59a8e1e7705c9bf1e",
            "0x808c7c1c38ba510c66db1e1dae95fd95a23f59b70d6e24bac12e9dc229410eebea7c3305ed91afbb5aca4a025a19bd40e92db78376ff45a6797400c45c67edc0",
            "0081c30b70771627ab32b64ba5fa494590609774742c2ced57133fc1cb34105b",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x51651c8c271f47c9820123e59a8e1e7705c9bf1e",
            "BICMfBw4ulEMZtseHa6V/ZWiP1m3DW4kusEuncIpQQ7r6nwzBe2Rr7taykoCWhm9QOktt4N2/0WmeXQAxFxn7cA=",
            "AIHDC3B3FierMrZLpfpJRZBgl3R0LCztVxM/wcs0EFs=",
        ),
    ),
    # vanity/0x51751
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x51751c85233cbf8b36ae343b39a03ad0286df07f",
            "0xa58b6d04b001b46323c168ec8fd24405bf9dd1997fdcccd6029fa5de68e3bc7552bf56bdfecb906a08b4bc929b92155d8200655674bc8a02eb176b2b067648ae",
            "36573ff88fa9837af53243d7e6a6d47a13310c2b6f04e850d04b98d350811ccc",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x51751c85233cbf8b36ae343b39a03ad0286df07f",
            "BKWLbQSwAbRjI8Fo7I/SRAW/ndGZf9zM1gKfpd5o47x1Ur9Wvf7LkGoItLySm5IVXYIAZVZ0vIoC6xdrKwZ2SK4=",
            "Nlc/+I+pg3r1MkPX5qbUehMxDCtvBOhQ0EuY01CBHMw=",
        ),
    ),
    # vanity/0x51851
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x51851bc52354082c812cd3567210944ee3cd9ec5",
            "0xed6781c7cb9a0af80a55af53bcfd519460e30d92da6a97a414e81117284e2564116253b053940d7281fac3211715165289aed547d1cbb77c457cd2b991c97420",
            "8b3b9eacdbb1038ced5b863144466691d0d566463fcc96d5693fdaeaa74514db",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x51851bc52354082c812cd3567210944ee3cd9ec5",
            "BO1ngcfLmgr4ClWvU7z9UZRg4w2S2mqXpBToERcoTiVkEWJTsFOUDXKB+sMhFxUWUomu1UfRy7d8RXzSuZHJdCA=",
            "izuerNuxA4ztW4YxREZmkdDVZkY/zJbVaT/a6qdFFNs=",
        ),
    ),
    # vanity/0x51951
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x5195197f620eb288659598413282ecbd3acf08a2",
            "0xaceae2667b7a3db1883b1a420e003ffd546808218210e6435a93b9b3afd6c5ada39f2ab3c1f7b8a89cac051cbeffcf049343c133162fbf56f03bee2eae58ee48",
            "47ee138a774ac1f636985dc0baaf16381b7423db21f6082de5b73a42721867c6",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x5195197f620eb288659598413282ecbd3acf08a2",
            "BKzq4mZ7ej2xiDsaQg4AP/1UaAghghDmQ1qTubOv1sWto58qs8H3uKicrAUcvv/PBJNDwTMWL79W8DvuLq5Y7kg=",
            "R+4TindKwfY2mF3Auq8WOBt0I9sh9ggt5bc6QnIYZ8Y=",
        ),
    ),
    # vanity/0x52052
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x520526dd3d001d615bcb7354fb8f6b21b5f965a7",
            "0x1e7427793e70394836caebc63c888e87559dcdd31632ba6753c6e9aece989474746d46081fc2d540f0ca9b3cf495cc3fef43f837f601f4783ca5cdb545e1a58c",
            "0fb222c4a30a9b8c04a8d19f941d99124f02eb01976d519416a848a483a4532a",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x520526dd3d001d615bcb7354fb8f6b21b5f965a7",
            "BB50J3k+cDlINsrrxjyIjodVnc3TFjK6Z1PG6a7OmJR0dG1GCB/C1UDwyps89JXMP+9D+Df2AfR4PKXNtUXhpYw=",
            "D7IixKMKm4wEqNGflB2ZEk8C6wGXbVGUFqhIpIOkUyo=",
        ),
    ),
    # vanity/0x52152
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x521525fc8d38573f86adc9b487356807b7619f3f",
            "0x7894e4c37a441add27f70307ffb2b602a556e9488a7de6cbe15dadc5872398461202b7eee220493cce26c76c772316ab98bafd079f0ee00ec20a5278458ffbfa",
            "e149914a44b66a6cda9393478e795b053e78df4b9592c0d07294e34ec3b9ecb5",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x521525fc8d38573f86adc9b487356807b7619f3f",
            "BHiU5MN6RBrdJ/cDB/+ytgKlVulIin3my+FdrcWHI5hGEgK37uIgSTzOJsdsdyMWq5i6/QefDuAOwgpSeEWP+/o=",
            "4UmRSkS2amzak5NHjnlbBT5430uVksDQcpTjTsO57LU=",
        ),
    ),
    # vanity/0x52252
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x52252e0c5a1c41287f0553881e33b871670d4d68",
            "0x5eb6948c71cb76efc59dde6b7ecf5241d7ec1645f2e19c5f167a384f21941c60504ab382ee48c8ec7f7fa158f3376f591880d19c8dfec50a5b995737e418cec4",
            "7da0dfd24174bcf1b5d04654fdedccc7e4b6c1618b93bdc8bfb584e0218f14f1",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x52252e0c5a1c41287f0553881e33b871670d4d68",
            "BF62lIxxy3bvxZ3ea37PUkHX7BZF8uGcXxZ6OE8hlBxgUEqzgu5IyOx/f6FY8zdvWRiA0ZyN/sUKW5lXN+QYzsQ=",
            "faDf0kF0vPG10EZU/e3Mx+S2wWGLk73Iv7WE4CGPFPE=",
        ),
    ),
    # vanity/0x52352
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x5235231f3a60f384f77b624114b5dc01a1a7bc4f",
            "0xa5be785481372ab5ee5b6054ecb68e0797836f035d6ae464474921a6240ffb1f557b7fe2c921a11cb8c8cc3c9f7ad0b86ff8591946bef96a64dfa25cb4b11b14",
            "3b8660cf40ee4cbfae6f7d55ad27b8503a846cb723e33df37c4309a3d6fc13a6",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x5235231f3a60f384f77b624114b5dc01a1a7bc4f",
            "BKW+eFSBNyq17ltgVOy2jgeXg28DXWrkZEdJIaYkD/sfVXt/4skhoRy4yMw8n3rQuG/4WRlGvvlqZN+iXLSxGxQ=",
            "O4Zgz0DuTL+ub31VrSe4UDqEbLcj4z3zfEMJo9b8E6Y=",
        ),
    ),
    # vanity/0x52452
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x5245250f9d244eab7e773b050600cc5eb03d02c4",
            "0x3ed612bdc6ace2f68c09968ef15589aacebfbd059bb0f79a2107bbda38321fcae1e10661b867a5fdcf2778404ee2e439f128788b14910988e2f3006e3c94a1ab",
            "46e61abfe824471ee3998b423ea813451dd41c57e3b7fe53ff8490262d172b55",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x5245250f9d244eab7e773b050600cc5eb03d02c4",
            "BD7WEr3GrOL2jAmWjvFViarOv70Fm7D3miEHu9o4Mh/K4eEGYbhnpf3PJ3hATuLkOfEoeIsUkQmI4vMAbjyUoas=",
            "RuYav+gkRx7jmYtCPqgTRR3UHFfjt/5T/4SQJi0XK1U=",
        ),
    ),
    # vanity/0x52552
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x52552b557bba8693c41dbe26978bd4fb15dca499",
            "0x9446801d847f43aa9b7c1858339245b6414c7d235dee68438a54ad01e6ce88419fe14fce9f50de417aa306cb62ca7908d0609e46ef62e881bd24241c80279a45",
            "9df975b4f2b9a3ff5e29593c8519b8b89e015ad8cba8f0ff58f9b8fb9bcae6e5",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x52552b557bba8693c41dbe26978bd4fb15dca499",
            "BJRGgB2Ef0Oqm3wYWDOSRbZBTH0jXe5oQ4pUrQHmzohBn+FPzp9Q3kF6owbLYsp5CNBgnkbvYuiBvSQkHIAnmkU=",
            "nfl1tPK5o/9eKVk8hRm4uJ4BWtjLqPD/WPm4+5vK5uU=",
        ),
    ),
    # vanity/0x52652
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x52652754a6ab06671dc148dec6ac12059e16548f",
            "0xaf9fbd7f1ba1a76db21e93c49f4920aa387d574f0d02c794e6762c0da30e863e5169490cba7a72914c0de36315f62d0099a010ad2c934a3db9cd54fda0fb001e",
            "4473bea9c529d26b5d857e24d677c0d7a20301fcd6024b8a09027e37e87c2ca0",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x52652754a6ab06671dc148dec6ac12059e16548f",
            "BK+fvX8boadtsh6TxJ9JIKo4fVdPDQLHlOZ2LA2jDoY+UWlJDLp6cpFMDeNjFfYtAJmgEK0sk0o9uc1U/aD7AB4=",
            "RHO+qcUp0mtdhX4k1nfA16IDAfzWAkuKCQJ+N+h8LKA=",
        ),
    ),
    # vanity/0x52752
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x5275289d7bcfd28a09f77f1ea70952897537b1fe",
            "0x2cfb4babcf46b2bf399434dab5fc00cc2e61b5e27ab623d3de1f43cd879f3d49443c4de138ede9ef7ac6807feab65ae05f248e91f5a5935739ce829edfe332da",
            "04fe82d9c978f30dbcb9d6ebcdb8d01315cd57853b432ba18143f4344a2ac45a",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x5275289d7bcfd28a09f77f1ea70952897537b1fe",
            "BCz7S6vPRrK/OZQ02rX8AMwuYbXierYj094fQ82Hnz1JRDxN4Tjt6e96xoB/6rZa4F8kjpH1pZNXOc6Cnt/jMto=",
            "BP6C2cl48w28udbrzbjQExXNV4U7QyuhgUP0NEoqxFo=",
        ),
    ),
    # vanity/0x52852
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x528524f9a684b2e78ebbf8b5b7c425a6b33b7a78",
            "0x02abcfec03440fac89001dbdca46212d4d0570ac2545f0c4e7d32c65b5fe0431f63f31f1c1abb2f26d64d2b2dfc127b3f1621f7eb95451af148afc21597a2705",
            "90eb4f4072046c84c3011111c67130a7d124631a9e757dfee5fbb4a2a5f03788",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x528524f9a684b2e78ebbf8b5b7c425a6b33b7a78",
            "BAKrz+wDRA+siQAdvcpGIS1NBXCsJUXwxOfTLGW1/gQx9j8x8cGrsvJtZNKy38Ens/FiH365VFGvFIr8IVl6JwU=",
            "kOtPQHIEbITDARERxnEwp9EkYxqedX3+5fu0oqXwN4g=",
        ),
    ),
    # vanity/0x52952
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x529527b47398ba2f4a86510f2d7c24cbca6a37e2",
            "0xbb4299ac3be47efa054f585629be0e1498aba0fea7222fa0c119afabf73b5180f9a5adef86577e6d7939c2ac051f222092b1335ef0665a4f16d0ef73d8760b1c",
            "9e9652970d7321652f3330065b440b41972cb2ca15be442be93e4256f37895c3",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x529527b47398ba2f4a86510f2d7c24cbca6a37e2",
            "BLtCmaw75H76BU9YVim+DhSYq6D+pyIvoMEZr6v3O1GA+aWt74ZXfm15OcKsBR8iIJKxM17wZlpPFtDvc9h2Cxw=",
            "npZSlw1zIWUvMzAGW0QLQZcsssoVvkQr6T5CVvN4lcM=",
        ),
    ),
    # vanity/0x53053
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x5305317848d5ef285a56838f23bfee0684d1ed63",
            "0x32dc05b9973c10787cc4bfb99baf922b7f22404c7144c7442e02d199e530d3580b5cb1724064d5db844b9cbdc584293895c1b68a7c325bebfdc82569debf76f0",
            "1ae093edf2c3741ca545cb66bdce0ae480d9062949203f1b768184fb9eac1330",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x5305317848d5ef285a56838f23bfee0684d1ed63",
            "BDLcBbmXPBB4fMS/uZuvkit/IkBMcUTHRC4C0ZnlMNNYC1yxckBk1duES5y9xYQpOJXBtop8Mlvr/cglad6/dvA=",
            "GuCT7fLDdBylRctmvc4K5IDZBilJID8bdoGE+56sEzA=",
        ),
    ),
    # vanity/0x53153
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x5315375af67277311a2368420ab6b713a474e749",
            "0x0b62ca7e420456195cf7a92c5b2b61c77289f137a65001a17982ffe34243f9b4979e4ffb93c99cfca32d20e588be5478b45a4b3282cae1a94fb09481061e66d0",
            "c970647334ae0fc78e47941e9856aca62f398ef71c3cc4f84eff17d384a9c95f",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x5315375af67277311a2368420ab6b713a474e749",
            "BAtiyn5CBFYZXPepLFsrYcdyifE3plABoXmC/+NCQ/m0l55P+5PJnPyjLSDliL5UeLRaSzKCyuGpT7CUgQYeZtA=",
            "yXBkczSuD8eOR5QemFaspi85jvccPMT4Tv8X04SpyV8=",
        ),
    ),
    # vanity/0x53253
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x53253e528ec1b154f834b386877c2e02fb921a6a",
            "0x746ca6574ead332cf6ed915c73e98e1cb239afc38486871d47b0448de8e85a55826b759b036d33d1065fb6be18de08903d342338b5f3c645303d790f180f6f4c",
            "8af44d4b3b4c08f63e6995abd132e386948c15bec3c73de2302ad6443ba4e62f",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x53253e528ec1b154f834b386877c2e02fb921a6a",
            "BHRspldOrTMs9u2RXHPpjhyyOa/DhIaHHUewRI3o6FpVgmt1mwNtM9EGX7a+GN4IkD00Izi188ZFMD15DxgPb0w=",
            "ivRNSztMCPY+aZWr0TLjhpSMFb7Dxz3iMCrWRDuk5i8=",
        ),
    ),
    # vanity/0x53353
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x533533165caa0e70e9a8389ca1396a64107ebeab",
            "0x76ab0feac25626ffac5fcc9d2df6bde2a3db254541a850ffbe19b58b8ed062f4f57448c5a4a466a4bc4a06b617275d40035e3a54139e9a922bd110db296577bd",
            "e34162ae9302c85c138b57de4209772874cb513c0ded967abcdd5dad167f3f9c",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x533533165caa0e70e9a8389ca1396a64107ebeab",
            "BHarD+rCVib/rF/MnS32veKj2yVFQahQ/74ZtYuO0GL09XRIxaSkZqS8Sga2FyddQANeOlQTnpqSK9EQ2ylld70=",
            "40FirpMCyFwTi1feQgl3KHTLUTwN7ZZ6vN1drRZ/P5w=",
        ),
    ),
    # vanity/0x53453
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x534533764a21f1512f7fad017ae7071e7717a89c",
            "0x1ca7103e775332b254ccee930f0385bb6c00c321dc5d287b45660ece53d04b41ba2371651e22210abc117b25b42da90f91a4d866d156611c81f54b897eac3c31",
            "df04b47a4fc3dd6387ad42f5aeef8d9e2a79c12db35bbf471807e84b2ee738a4",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x534533764a21f1512f7fad017ae7071e7717a89c",
            "BBynED53UzKyVMzukw8DhbtsAMMh3F0oe0VmDs5T0EtBuiNxZR4iIQq8EXsltC2pD5Gk2GbRVmEcgfVLiX6sPDE=",
            "3wS0ek/D3WOHrUL1ru+Nnip5wS2zW79HGAfoSy7nOKQ=",
        ),
    ),
    # vanity/0x53553
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x535534fb90e4d8e61938a286caae1169972ccc48",
            "0xa731d66be8f15640bae21d8cc1d0d8e35bc8412d140d655192d9d559c8ba949df1da2921f9cc00d89c675f425f94d95a7ff9e911b3ef18bb8ff3e021a14509c5",
            "f04935e815c91599c4637a1ac474b2891ff1629d528ddd567b9d5c5361dd5902",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x535534fb90e4d8e61938a286caae1169972ccc48",
            "BKcx1mvo8VZAuuIdjMHQ2ONbyEEtFA1lUZLZ1VnIupSd8dopIfnMANicZ19CX5TZWn/56RGz7xi7j/PgIaFFCcU=",
            "8Ek16BXJFZnEY3oaxHSyiR/xYp1Sjd1We51cU2HdWQI=",
        ),
    ),
    # vanity/0x53653
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x53653c543f5633474650cc0fe86f1f2172c451ba",
            "0x43718eaed313bec829548987c52f07cb404902d492e228c1b7e04d6ac69ba352639d7ea95f07feb55e60b04a08f9fe357ef7e7101fe2e149dceeab2c3110ceda",
            "947bd69713b22aca80cdea5b1bb72cf2028a68ce6a2d36929389470350cba9e6",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x53653c543f5633474650cc0fe86f1f2172c451ba",
            "BENxjq7TE77IKVSJh8UvB8tASQLUkuIowbfgTWrGm6NSY51+qV8H/rVeYLBKCPn+NX735xAf4uFJ3O6rLDEQzto=",
            "lHvWlxOyKsqAzepbG7cs8gKKaM5qLTaSk4lHA1DLqeY=",
        ),
    ),
    # vanity/0x53753
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x53753f79b3c300d4ff0e3008110b5157ae9c8ece",
            "0x2b3b326baace29cd8cc3447c20050e830f556ef8d79d6d5b52ab224c453062da9d205f12918f38aee049ef4168261d3b508c0d25b9ac339662b6dc3ae1d27dad",
            "01bd1bee31ffa62bd449b0e86452daffeb2609b36cd1fbd600eb88d1bfcd0720",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x53753f79b3c300d4ff0e3008110b5157ae9c8ece",
            "BCs7MmuqzinNjMNEfCAFDoMPVW74151tW1KrIkxFMGLanSBfEpGPOK7gSe9BaCYdO1CMDSW5rDOWYrbcOuHSfa0=",
            "Ab0b7jH/pivUSbDoZFLa/+smCbNs0fvWAOuI0b/NByA=",
        ),
    ),
    # vanity/0x53853
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x5385371efb0a253a04e6b604b859e471003e136a",
            "0x317f06b4c5ebcdf81f86bb26474eeaf269dea24eae21295df10fae1205a04844e3aa44da657fe686d5b56f719264c5bb78f089d909d1ebc881c4dcb70025a6a0",
            "1a2ca07c6cc7a0111c9aa8c16a5529aad8d41a4964af0bfd62cb48058be807a4",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x5385371efb0a253a04e6b604b859e471003e136a",
            "BDF/BrTF6834H4a7JkdO6vJp3qJOriEpXfEPrhIFoEhE46pE2mV/5obVtW9xkmTFu3jwidkJ0evIgcTctwAlpqA=",
            "GiygfGzHoBEcmqjBalUpqtjUGklkrwv9YstIBYvoB6Q=",
        ),
    ),
    # vanity/0x53953
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x5395321e1c3deebbd4512cbc53282a8769e7f134",
            "0x0a04474d28567a36443c2e2373cdfed88938e8d916f827a062b252d25dd35ff73df5e266e8196e89d0af3461ccf52f201e6942b0d7a736e6ad5574e9b2ee0f8a",
            "d2e37e44023fb0bfce711424b130a6d66650805697ed0b25f00d56cdeb431405",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x5395321e1c3deebbd4512cbc53282a8769e7f134",
            "BAoER00oVno2RDwuI3PN/tiJOOjZFvgnoGKyUtJd01/3PfXiZugZbonQrzRhzPUvIB5pQrDXpzbmrVV06bLuD4o=",
            "0uN+RAI/sL/OcRQksTCm1mZQgFaX7Qsl8A1WzetDFAU=",
        ),
    ),
    # vanity/0x54054
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x54054d8257754921e4ecf9d1f41d2ca1dd965685",
            "0x5de26d94fee338e1362690e1d1ea7d62cc52b75cd42dca1491e41f03844b305219726d4959f919ec04eb395c23612a101ad37a628273c9eb492a8dd19f5ae48f",
            "b1048f40903c47e96cec8cda39bd32b484965b3f363e045ee432daa6bbd581a7",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x54054d8257754921e4ecf9d1f41d2ca1dd965685",
            "BF3ibZT+4zjhNiaQ4dHqfWLMUrdc1C3KFJHkHwOESzBSGXJtSVn5GewE6zlcI2EqEBrTemKCc8nrSSqN0Z9a5I8=",
            "sQSPQJA8R+ls7IzaOb0ytISWWz82PgRe5DLaprvVgac=",
        ),
    ),
    # vanity/0x54154
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x54154b555acb53c360a130122de77f837f15eb8d",
            "0xcadac1c20aa936f8a1fd21a0394729f2370c43acab95906e9f65177c37677004fdce95ae872e92864583f03873808474bbbcef91831bfa1cd6b7511369032b95",
            "41a1f328fecf3b9ac444ae09b483cf96d58c8422d634c52f17f7a7bae2bc7fda",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x54154b555acb53c360a130122de77f837f15eb8d",
            "BMrawcIKqTb4of0hoDlHKfI3DEOsq5WQbp9lF3w3Z3AE/c6VrocukoZFg/A4c4CEdLu875GDG/oc1rdRE2kDK5U=",
            "QaHzKP7PO5rERK4JtIPPltWMhCLWNMUvF/enuuK8f9o=",
        ),
    ),
    # vanity/0x54254
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x542542daa6b0c031dfd0778b701abeb327bb2a7e",
            "0x983b3b0ba0e87dc0f1efc9fc3370e2d89e641579511447978e6d2ca80b1675150f84588fc682410bc0f140b85272bb3104dd5baf5a23ed361e916b14ebb3c85d",
            "0e35086fc1666bcb73463e99fda8c6ed9510253da52457ae99c2aa91f93db3e5",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x542542daa6b0c031dfd0778b701abeb327bb2a7e",
            "BJg7Owug6H3A8e/J/DNw4tieZBV5URRHl45tLKgLFnUVD4RYj8aCQQvA8UC4UnK7MQTdW69aI+02HpFrFOuzyF0=",
            "DjUIb8Fma8tzRj6Z/ajG7ZUQJT2lJFeumcKqkfk9s+U=",
        ),
    ),
    # vanity/0x54354
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x543545dc65b271d494257e586b95bf2dfdfcb49d",
            "0x1b75cdf8d7c850eef91c9c507797246b1a9da766f1b59ed8aa1e043c82360a37ab2ec1c69a5aca8d0c2cc81fab64dcd3e944a62c18c20b8adfffd234fe45b229",
            "30a63d1cf17b157db6833296ad4a4efee74b0f14193156b08de3f0cb89d61e2e",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x543545dc65b271d494257e586b95bf2dfdfcb49d",
            "BBt1zfjXyFDu+RycUHeXJGsanadm8bWe2KoeBDyCNgo3qy7Bxppayo0MLMgfq2Tc0+lEpiwYwguK3//SNP5Fsik=",
            "MKY9HPF7FX22gzKWrUpO/udLDxQZMVawjePwy4nWHi4=",
        ),
    ),
    # vanity/0x54454
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x5445423a73661a8c19f7d02ee276c071b63bf9ec",
            "0x535700c8f8eb6843d63541032087b5044b77673166db21254571e8aa48df46433fc328bf5338573b3fe7d77d2c74a8f9643fb2947e647e64a032e99d298dd86f",
            "87f0d07bb805cd6f305398e173f7b03bfe71e8effbd4dace5f35b00e34edb8ad",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x5445423a73661a8c19f7d02ee276c071b63bf9ec",
            "BFNXAMj462hD1jVBAyCHtQRLd2cxZtshJUVx6KpI30ZDP8Mov1M4Vzs/59d9LHSo+WQ/spR+ZH5koDLpnSmN2G8=",
            "h/DQe7gFzW8wU5jhc/ewO/5x6O/71NrOXzWwDjTtuK0=",
        ),
    ),
    # vanity/0x54554
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x545542925dd91c49f1f0f616a5a9d1f461268141",
            "0xa89e5b3a8ea7ffde1399ab8f46fd33054a9c147dfd42c8592f77769f8b684d3823ae92a554e93581a50d05d468916dbf35794ca5786055456520b8cf46702dae",
            "37bf8316778c25b8394d9925c37640f9db4c30b7136ab5ea8039a4fe2c75fb8c",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x545542925dd91c49f1f0f616a5a9d1f461268141",
            "BKieWzqOp//eE5mrj0b9MwVKnBR9/ULIWS93dp+LaE04I66SpVTpNYGlDQXUaJFtvzV5TKV4YFVFZSC4z0ZwLa4=",
            "N7+DFneMJbg5TZklw3ZA+dtMMLcTarXqgDmk/ix1+4w=",
        ),
    ),
    # vanity/0x54654
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x5465406675661a5f857a4ddfd5c0a0c0d057bcc0",
            "0x7ee0c7fa40c84d76559c796e1a476ef8a891bdb45effab8fa8614e445e1588f0b3d1091ff72b752e585534711899e0ebc5c5fda596a5e6edae4596506f74969f",
            "4c2698b590cc2e32cc47627b4e78b9b627f3cb987a0a89c1e9b5afc8fcd48880",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x5465406675661a5f857a4ddfd5c0a0c0d057bcc0",
            "BH7gx/pAyE12VZx5bhpHbviokb20Xv+rj6hhTkReFYjws9EJH/crdS5YVTRxGJng68XF/aWWpebtrkWWUG90lp8=",
            "TCaYtZDMLjLMR2J7Tni5tifzy5h6ConB6bWvyPzUiIA=",
        ),
    ),
    # vanity/0x54754
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x54754bba9819153a398255b732c48a8fda2b5964",
            "0x08da51e2ddd04056060aa770fe4d56c25f736c95f3f0ae24fd7b786cb4e7c6210127d8079ec0753cf245224ef9e7917280f8e4ed63db4de63133e67e7ab0142b",
            "696de910e9048142d8fb0b7a94689449966eab919c5f97ef71e3644ec8c1d248",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x54754bba9819153a398255b732c48a8fda2b5964",
            "BAjaUeLd0EBWBgqncP5NVsJfc2yV8/CuJP17eGy058YhASfYB57AdTzyRSJO+eeRcoD45O1j203mMTPmfnqwFCs=",
            "aW3pEOkEgULY+wt6lGiUSZZuq5GcX5fvceNkTsjB0kg=",
        ),
    ),
    # vanity/0x54854
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x5485476608386083ad9195252425de04dd5a1cf0",
            "0x50f30fa29a8b3f71647a1027b5b71078e4e1e966d9f0ef5219b7fa3d61bf4a33cec00e7146804de1776cc045f44eeee2ec9f0fbe3b5a160ab90ac32b8d6ff218",
            "f450210bb0061ae4b7c4ebfbd35eb235db1da6ba3e5a602c5e2bb2d2ed5561f2",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x5485476608386083ad9195252425de04dd5a1cf0",
            "BFDzD6Kaiz9xZHoQJ7W3EHjk4elm2fDvUhm3+j1hv0ozzsAOcUaATeF3bMBF9E7u4uyfD747WhYKuQrDK41v8hg=",
            "9FAhC7AGGuS3xOv7016yNdsdpro+WmAsXiuy0u1VYfI=",
        ),
    ),
    # vanity/0x54954
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x549546377ae6118969329cae90758470c0f9ad96",
            "0x3171b654b0fe2c362b897d520d3087c693ce82d72b406ddcc576cb24f7d68dcf6108330b4fac69ed4b9e5e206d3d8554949570759e10da5585a87c83497b89c7",
            "40a3489d32dfc11b2c0c97a580229bad173c43f16eba3ca2d218869733afdda6",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x549546377ae6118969329cae90758470c0f9ad96",
            "BDFxtlSw/iw2K4l9Ug0wh8aTzoLXK0Bt3MV2yyT31o3PYQgzC0+sae1Lnl4gbT2FVJSVcHWeENpVhah8g0l7icc=",
            "QKNInTLfwRssDJelgCKbrRc8Q/Fuujyi0hiGlzOv3aY=",
        ),
    ),
    # vanity/0x55055
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x55055817d6767ef5384bc90c5f218fcd018c913a",
            "0x7172fdbdfba15fcdcbcd746c3955795f2abaa057063acc81491d181ae7866f1d3ba3722b0186999207c810622164c2e876fe348f1b5a049f8ffcb63cdade201d",
            "134237a8342528069e67cc38c69a5457a84e5c047fa7d5fdac6b5c19fded6d56",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x55055817d6767ef5384bc90c5f218fcd018c913a",
            "BHFy/b37oV/Ny810bDlVeV8quqBXBjrMgUkdGBrnhm8dO6NyKwGGmZIHyBBiIWTC6Hb+NI8bWgSfj/y2PNreIB0=",
            "E0I3qDQlKAaeZ8w4xppUV6hOXAR/p9X9rGtcGf3tbVY=",
        ),
    ),
    # vanity/0x55155
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x551556e0fefd6d80475dc51f97f8e33974570650",
            "0x0d6ea233dac86133e7e7a5d6a1be8376062ff2d34ce30e2b9717bd0d68990974c1d7d3dcd6dec7c48f21620c0a59696a3a660229cc71fbdec4b938fc70121360",
            "d04337d9aaa15632ad64b1c987c0ea0c0a09760d57c1cf550d4b0ba9257c05b1",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x551556e0fefd6d80475dc51f97f8e33974570650",
            "BA1uojPayGEz5+el1qG+g3YGL/LTTOMOK5cXvQ1omQl0wdfT3Nbex8SPIWIMCllpajpmAinMcfvexLk4/HASE2A=",
            "0EM32aqhVjKtZLHJh8DqDAoJdg1Xwc9VDUsLqSV8BbE=",
        ),
    ),
    # vanity/0x55255
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x552556899405966615ec625f99d1889b90e1004a",
            "0xc7a73b4b3b96fdf657efe4aa1dcefdb53b5ad63c730efe812496930cd6676a6a76c9aac85a9215ab6b232ae6aecc243d3f307ad58d803d243ea73570072418b2",
            "0cfb56dc09121313e2c647deb7ae74e84670836934cdaedc27b15c977229da80",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x552556899405966615ec625f99d1889b90e1004a",
            "BMenO0s7lv32V+/kqh3O/bU7WtY8cw7+gSSWkwzWZ2pqdsmqyFqSFatrIyrmrswkPT8wetWNgD0kPqc1cAckGLI=",
            "DPtW3AkSExPixkfet6506EZwg2k0za7cJ7Fcl3Ip2oA=",
        ),
    ),
    # vanity/0x55355
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x553554bec61c56cdfaad0b0d7e0acd6c41bac429",
            "0xac9628526a8a4bf1f22ed9ffde765d53fd54feb57b99409371cf4df7d91809beb4b3be32baf62f86b2af84c01b88a48ca12c8928f329bcd7206e3ae9bcc9aaaa",
            "3ac8cadc67512ab5c915abc60d632c0af8ca7f93277277d36c31a0d81dfcd28f",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x553554bec61c56cdfaad0b0d7e0acd6c41bac429",
            "BKyWKFJqikvx8i7Z/952XVP9VP61e5lAk3HPTffZGAm+tLO+Mrr2L4ayr4TAG4ikjKEsiSjzKbzXIG466bzJqqo=",
            "OsjK3GdRKrXJFavGDWMsCvjKf5MncnfTbDGg2B380o8=",
        ),
    ),
    # vanity/0x55455
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x5545516a4e43e03048a82a2674cd2282c8a59427",
            "0x47db1b2c0b05d3bc5a1577e31988112bd9e1476e5b2381c02b3e13efca08a8f17c7293c56619aceac3636cfad44367e49b585cfabc7d6e43b22f33f6252a59b1",
            "1b20213e3b3a1c39929d2c9dc5b895b45019ac0478729edd3f61cd8802f4621d",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x5545516a4e43e03048a82a2674cd2282c8a59427",
            "BEfbGywLBdO8WhV34xmIESvZ4UduWyOBwCs+E+/KCKjxfHKTxWYZrOrDY2z61ENn5JtYXPq8fW5Dsi8z9iUqWbE=",
            "GyAhPjs6HDmSnSydxbiVtFAZrAR4cp7dP2HNiAL0Yh0=",
        ),
    ),
    # vanity/0x55555
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x55555e9705e4bacd872a6a61955fd7a6f8fd80f2",
            "0x6be832165a6fab7633d93de10b84500791c0bf8309b449c93467b0f78d50f01f662fbf4dbf4bfd42f26256df7a9ebd8845a859a70b70d839263083e2ec2586ea",
            "7c2fd09d70e5f9c05b725f1467288d8fc6a1394426e83887278bfc53a64295ba",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x55555e9705e4bacd872a6a61955fd7a6f8fd80f2",
            "BGvoMhZab6t2M9k94QuEUAeRwL+DCbRJyTRnsPeNUPAfZi+/Tb9L/ULyYlbfep69iEWoWacLcNg5JjCD4uwlhuo=",
            "fC/QnXDl+cBbcl8UZyiNj8ahOUQm6DiHJ4v8U6ZClbo=",
        ),
    ),
    # vanity/0x55655
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x55655053b877130f8172f13d991d51f5850f0191",
            "0x4330b48aef16c8f6b384bef2ffa1ff93a84bb96f45d25c97e6832e956ef127c6e53913209dd4ffc1e8d160fee326f5c5ee7771dfbc1e07a5f0ba3f0fc35608fb",
            "2ea9c6751ec5378ad401829a5ce44ba7d3e84bd0ff002f96ef2a59c3f9abf991",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x55655053b877130f8172f13d991d51f5850f0191",
            "BEMwtIrvFsj2s4S+8v+h/5OoS7lvRdJcl+aDLpVu8SfG5TkTIJ3U/8Ho0WD+4yb1xe53cd+8Hgel8Lo/D8NWCPs=",
            "LqnGdR7FN4rUAYKaXORLp9PoS9D/AC+W7ypZw/mr+ZE=",
        ),
    ),
    # vanity/0x55755
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x55755e9fde5eb86891f9a001d63edad2fcf35cff",
            "0x17962dedcb03694bfa98c25ac0b777c0ba40336b8877736479840d656a09fb90af4025a1112fce09aa7bda5e441733690b24f665bb813c8d6f953fa7ffde3129",
            "541ad5ce4da62e535b7e366d262cd79a283c62cfff8490d417072b487df66364",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x55755e9fde5eb86891f9a001d63edad2fcf35cff",
            "BBeWLe3LA2lL+pjCWsC3d8C6QDNriHdzZHmEDWVqCfuQr0AloREvzgmqe9peRBczaQsk9mW7gTyNb5U/p//eMSk=",
            "VBrVzk2mLlNbfjZtJizXmig8Ys//hJDUFwcrSH32Y2Q=",
        ),
    ),
    # vanity/0x55855
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x5585564e5082f67bcae6c274e9faea4c3f2b0ba1",
            "0xf5023b3848ae801e79b03b8e04c613f7513951559430d9182dd209b3b59b38db177cdc8ec214339f12b23d16917c0199ad8a694d8b782a218577d0d8221caaf2",
            "7bd22b5f3d642f97fd629dab4d942060dbfc3056958a25c609a58dec2e5fd525",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x5585564e5082f67bcae6c274e9faea4c3f2b0ba1",
            "BPUCOzhIroAeebA7jgTGE/dROVFVlDDZGC3SCbO1mzjbF3zcjsIUM58Ssj0WkXwBma2KaU2LeCohhXfQ2CIcqvI=",
            "e9IrXz1kL5f9Yp2rTZQgYNv8MFaViiXGCaWN7C5f1SU=",
        ),
    ),
    # vanity/0x55955
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x559558f75f9087ec13457ec3bd06b61a0229e20f",
            "0x59d7595c0febdd6f498a9f92d93fe6b1586a05f7c4f200a232336907dced43b2fc551b4e91e8231ec890916e6ef28b0062bc26962e5b5d70abc5e14ffbe05e6f",
            "f1fc4d53f32199c709a752da3971d42c09e55c1a2b2b2279444ea1e06b5e23b0",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x559558f75f9087ec13457ec3bd06b61a0229e20f",
            "BFnXWVwP691vSYqfktk/5rFYagX3xPIAojIzaQfc7UOy/FUbTpHoIx7IkJFubvKLAGK8JpYuW11wq8XhT/vgXm8=",
            "8fxNU/MhmccJp1LaOXHULAnlXBorKyJ5RE6h4GteI7A=",
        ),
    ),
    # vanity/0x56056
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x5605695420ad80df5eba7d9eb760eb2f04ccee5b",
            "0x6ce21eb2627f5da957a278c6e02e84b9496363fa22e325bc71567cba9bb1c63c0cfaf40d55d4b9ff48601653a097fe79e736df8d4f05e7e8f83ed18f9bb7bfff",
            "657d0b0245edce5345e01b427993d3ec1932bc74643d1442632f42558efd442d",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x5605695420ad80df5eba7d9eb760eb2f04ccee5b",
            "BGziHrJif12pV6J4xuAuhLlJY2P6IuMlvHFWfLqbscY8DPr0DVXUuf9IYBZToJf+eec2341PBefo+D7Rj5u3v/8=",
            "ZX0LAkXtzlNF4BtCeZPT7BkyvHRkPRRCYy9CVY79RC0=",
        ),
    ),
    # vanity/0x56156
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x56156b4210c22af24096919aca73a1b34eedf68d",
            "0xdb6e880273414eee841b925b3567e9e42cce0aee85feb5d0215e693676e34a5e33720e8bff4ab4f7c5a416247b8f9ca11cfabc89aa9e99b58fbe1990ce4e7980",
            "f570c625e8d40e5cf3adb35c4aa8f84401284e869593d5c98933bd04d1108a30",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x56156b4210c22af24096919aca73a1b34eedf68d",
            "BNtuiAJzQU7uhBuSWzVn6eQszgruhf610CFeaTZ240peM3IOi/9KtPfFpBYke4+coRz6vImqnpm1j74ZkM5OeYA=",
            "9XDGJejUDlzzrbNcSqj4RAEoToaVk9XJiTO9BNEQijA=",
        ),
    ),
    # vanity/0x56256
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x56256fb4f533e92dbd886736e44a2aa38101cc45",
            "0x1d498a7441badffd7d9f45df81f6563c0dfa2d13a7af18c7579dcb257028b4077e24c7732687e03e27db53c90a7f463bfa1e028dfec36d95b45c96a88a754964",
            "225a33fc4810b5adfcfbe4838e4aae7a1b1df7606e04b759bb8fcc25126371ad",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x56256fb4f533e92dbd886736e44a2aa38101cc45",
            "BB1JinRBut/9fZ9F34H2VjwN+i0Tp68Yx1edyyVwKLQHfiTHcyaH4D4n21PJCn9GO/oeAo3+w22VtFyWqIp1SWQ=",
            "Iloz/EgQta38++SDjkquehsd92BuBLdZu4/MJRJjca0=",
        ),
    ),
    # vanity/0x56356
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x563567a7708e44172fe846065724ddc020c99723",
            "0x8773981cddedffe70be6e4e6eb497eb95fb052f4f578f55f175d62383ca9e8e2b5ab6aa09171954a066e90d0ea4a56b48f1adf22774a51731385b7c9cdf17eba",
            "7659d023f10f14e56dde59cc24a7d37fbb627fe747e5930a06a0ae2aee01d167",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x563567a7708e44172fe846065724ddc020c99723",
            "BIdzmBzd7f/nC+bk5utJfrlfsFL09Xj1XxddYjg8qejitatqoJFxlUoGbpDQ6kpWtI8a3yJ3SlFzE4W3yc3xfro=",
            "dlnQI/EPFOVt3lnMJKfTf7tif+dH5ZMKBqCuKu4B0Wc=",
        ),
    ),
    # vanity/0x56456
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x564563159f30d72391bab97433db91559900f108",
            "0x299d354e4657536ae09c8f96f881a20f49b28b2e974a569fbc0971c6ac72215abd2c856f41cbd4cb26090cd4864fe1d1d031a7423a449b11f6c37ce35fb7e886",
            "f7490d9309198179125968033ce282b1d7bb5561a31d1dbe6664059fc5094465",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x564563159f30d72391bab97433db91559900f108",
            "BCmdNU5GV1Nq4JyPlviBog9Jsosul0pWn7wJccasciFavSyFb0HL1MsmCQzUhk/h0dAxp0I6RJsR9sN841+36IY=",
            "90kNkwkZgXkSWWgDPOKCsde7VWGjHR2+ZmQFn8UJRGU=",
        ),
    ),
    # vanity/0x56556
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x56556429653eea5e5626e283a7a56347b73e2e7a",
            "0x67356559ea528967ecfeef1dc049250007cdcbb26304c16f07761cce7c00dd06d8bf25863848ac15c280b92e8e5ee2647ef474aa1ca4dbd9b2d4e3d37c743561",
            "4c8df5071c0b19b19fa0b86c0adea4d815d38c5547b8fb0d7663a0f4a67f8fc1",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x56556429653eea5e5626e283a7a56347b73e2e7a",
            "BGc1ZVnqUoln7P7vHcBJJQAHzcuyYwTBbwd2HM58AN0G2L8lhjhIrBXCgLkujl7iZH70dKocpNvZstTj03x0NWE=",
            "TI31BxwLGbGfoLhsCt6k2BXTjFVHuPsNdmOg9KZ/j8E=",
        ),
    ),
    # vanity/0x56656
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x56656d8f6f06ddb03e468b9dc5269c812a126f78",
            "0xa5169de6128f471ba8b21d4b89fa37ecf4d4aa8a8ac6847b5bb0ffc949fc402ad31095eb6a4802ec8679c797b3e7229260de77c6ac785193d0aa45292b4d477b",
            "f55f0cce6aa811352bb0d6a596804451339dde6f2411c085a4eb08685ce5a11f",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x56656d8f6f06ddb03e468b9dc5269c812a126f78",
            "BKUWneYSj0cbqLIdS4n6N+z01KqKisaEe1uw/8lJ/EAq0xCV62pIAuyGeceXs+cikmDed8aseFGT0KpFKStNR3s=",
            "9V8MzmqoETUrsNalloBEUTOd3m8kEcCFpOsIaFzloR8=",
        ),
    ),
    # vanity/0x56756
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x5675602f6f907b92a3e9f70027168bf6a1d19545",
            "0x83d6dcc7ec9da3260b6e077e3f461ba5c1dfcf49a62318d32fa722c8e56972ec3303e77341a89f1aed93a160e7b02aa61af0108e52199495b4ff73a4fc37e6e9",
            "30317158451d40b8a9842c6564a0b099ee49c8438767584d5e21b16450ded99b",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x5675602f6f907b92a3e9f70027168bf6a1d19545",
            "BIPW3MfsnaMmC24Hfj9GG6XB389JpiMY0y+nIsjlaXLsMwPnc0Gonxrtk6Fg57AqphrwEI5SGZSVtP9zpPw35uk=",
            "MDFxWEUdQLiphCxlZKCwme5JyEOHZ1hNXiGxZFDe2Zs=",
        ),
    ),
    # vanity/0x56856
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x56856c3fcaffd607cbd0753a58bacf6529627443",
            "0x1c3a2b4d7c8e1ad6155d1815747ad7927a104869e9b94c3dc6ff402d775d29a469643c91506006c693b6f892f0c238a362390e013a8fcd87a6814f63d9ffc799",
            "aa7cce24d684dcdc0403a1dc8ab34ba5cfeb0cf203baf702cfd2a681a70d95b6",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x56856c3fcaffd607cbd0753a58bacf6529627443",
            "BBw6K018jhrWFV0YFXR615J6EEhp6blMPcb/QC13XSmkaWQ8kVBgBsaTtviS8MI4o2I5DgE6j82HpoFPY9n/x5k=",
            "qnzOJNaE3NwEA6HcirNLpc/rDPIDuvcCz9KmgacNlbY=",
        ),
    ),
    # vanity/0x56956
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x5695697ca284d7f3ce302e30168c52d2105bcf2a",
            "0xb598078c58ff9b7e728dbd651f56007d9f857cfd927cbebce65f1c86ea0b734150318c636c6aeaf3fc97a86cb152b157272fa712c9402b3a53dc0e74030dc1bb",
            "b4b9f4a7c9ba1015a28f58faa919fc96a5e63ff9b1914d637e93d5050de972dc",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x5695697ca284d7f3ce302e30168c52d2105bcf2a",
            "BLWYB4xY/5t+co29ZR9WAH2fhXz9kny+vOZfHIbqC3NBUDGMY2xq6vP8l6hssVKxVycvpxLJQCs6U9wOdAMNwbs=",
            "tLn0p8m6EBWij1j6qRn8lqXmP/mxkU1jfpPVBQ3pctw=",
        ),
    ),
    # vanity/0x57057
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x57057443d65daa261d8fb65437595883f51b8cad",
            "0x83dc80763472661fc780a1efc27bb1412553eb725e418ca7a22a2124be3a03a3ef10be27640ce72455541853a258df7bb7e8e125e2370d678ce3a4f08b341ea8",
            "803bd5b79faed717abb072785b3da258da581e4e5b5d6f2f97ad90ae0996c628",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x57057443d65daa261d8fb65437595883f51b8cad",
            "BIPcgHY0cmYfx4Ch78J7sUElU+tyXkGMp6IqISS+OgOj7xC+J2QM5yRVVBhToljfe7fo4SXiNw1njOOk8Is0Hqg=",
            "gDvVt5+u1xersHJ4Wz2iWNpYHk5bXW8vl62QrgmWxig=",
        ),
    ),
    # vanity/0x57157
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x5715736ab82a4f2bdf571b396bfadb2c1045d328",
            "0xa46ef624bb60dd4721d684954a77e1b0938ab29dcb793584b99d6e07998b61650cb4d6ce1388edec7e457b1f070daa6ed9e2f4f46cd01b07f3adf893c1f8d978",
            "57e172d96948e01025f20d887b0161cb3d6e2f416667f61fb897aca7963adb0e",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x5715736ab82a4f2bdf571b396bfadb2c1045d328",
            "BKRu9iS7YN1HIdaElUp34bCTirKdy3k1hLmdbgeZi2FlDLTWzhOI7ex+RXsfBw2qbtni9PRs0BsH8634k8H42Xg=",
            "V+Fy2WlI4BAl8g2IewFhyz1uL0FmZ/YfuJesp5Y62w4=",
        ),
    ),
    # vanity/0x57257
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x572573afadcb5c9e74e8d25c6dfc11697d362733",
            "0x3eade9d02d4cf4d17765ccad04183b5d67d0e653c8718df10b3d9c93b0ceac3adcfc4a2aef06ca0973c0af4299446b98376065783889c09d73de2a99901e2544",
            "6f7236c41ca14e0561186485120c79b5ab9fcce32e5ac857f0fb40ab4d93ad3b",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x572573afadcb5c9e74e8d25c6dfc11697d362733",
            "BD6t6dAtTPTRd2XMrQQYO11n0OZTyHGN8Qs9nJOwzqw63PxKKu8GyglzwK9CmURrmDdgZXg4icCdc94qmZAeJUQ=",
            "b3I2xByhTgVhGGSFEgx5taufzOMuWshX8PtAq02TrTs=",
        ),
    ),
    # vanity/0x57357
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x57357e09109a14a26f1376419d6bfb5ff1a6e224",
            "0x72fc6f95774e974d5186e9f4c53683e4cc2d9a9e60b6bc3be802343a1dbabb47d193fcc3a27d55a9ed5b549280baf838e040bc9810f384eb8295e2ffaa47d80f",
            "e93e714250c25d106fda43772cf6f465dab8418ddca5db21a0b2ee4fc972641e",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x57357e09109a14a26f1376419d6bfb5ff1a6e224",
            "BHL8b5V3TpdNUYbp9MU2g+TMLZqeYLa8O+gCNDodurtH0ZP8w6J9VantW1SSgLr4OOBAvJgQ84TrgpXi/6pH2A8=",
            "6T5xQlDCXRBv2kN3LPb0Zdq4QY3cpdshoLLuT8lyZB4=",
        ),
    ),
    # vanity/0x57457
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x5745731fa4b12562163b5775b5af78b29e6230cb",
            "0xcf60ef7122fae81c682563aca34196ef29b060fe9eda1011c080de9818bec84a5bda23f283a1e6f1ca70a8958298af88d3b0a37d26e2e4192726ed1bad5692ac",
            "a5405a0e32d24d76510f934039779beb6bf43635d36c16ab5db0e310e907ddd0",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x5745731fa4b12562163b5775b5af78b29e6230cb",
            "BM9g73Ei+ugcaCVjrKNBlu8psGD+ntoQEcCA3pgYvshKW9oj8oOh5vHKcKiVgpiviNOwo30m4uQZJybtG61Wkqw=",
            "pUBaDjLSTXZRD5NAOXeb62v0NjXTbBarXbDjEOkH3dA=",
        ),
    ),
    # vanity/0x57557
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x575577bc87660746e1590779ac8ddf8fa661657c",
            "0x1a341a9e85b4e0516e0b9203d0db0c0bf37332fae1a671d12ddab2f12005f623ca2c0f4addd01ed9fc20b85b7e6bd35cbec39527000c60c08ee3cd256a18f4d7",
            "92eef1d15148c1c40173c39a4197553d1884077994ded62b14fa9947621005da",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x575577bc87660746e1590779ac8ddf8fa661657c",
            "BBo0Gp6FtOBRbguSA9DbDAvzczL64aZx0S3asvEgBfYjyiwPSt3QHtn8ILhbfmvTXL7DlScADGDAjuPNJWoY9Nc=",
            "ku7x0VFIwcQBc8OaQZdVPRiEB3mU3tYrFPqZR2IQBdo=",
        ),
    ),
    # vanity/0x57657
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x576576a763d8bd7f7f7e5863bdad15deb7d436b3",
            "0xc6f2c57cd13e29510b8251c6173f496c5011499d59ef535c952fd3d61f9bce508990af844d3bee9d28e1e0f8d38207c5ec56da91c18d0de7c4e6e52d25568c88",
            "c37127121a03741b2b589a471a6fe555b5f9e552455418403da4259c38be0729",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x576576a763d8bd7f7f7e5863bdad15deb7d436b3",
            "BMbyxXzRPilRC4JRxhc/SWxQEUmdWe9TXJUv09Yfm85QiZCvhE077p0o4eD404IHxexW2pHBjQ3nxOblLSVWjIg=",
            "w3EnEhoDdBsrWJpHGm/lVbX55VJFVBhAPaQlnDi+Byk=",
        ),
    ),
    # vanity/0x57757
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x57757b0457962389af32709bc3034813859377c9",
            "0x1c2333274cd102947148654eb48ef144e5410bccf09342f314d2ab1cd245968395a6ecab0d8c1f3bf2f59ad6c4eb8d542df05107ad894a5a741516e8010d9002",
            "775442630fbb22d9e0026126dcd07799d91bfc943446c03c82a2ef6d4e616e8d",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x57757b0457962389af32709bc3034813859377c9",
            "BBwjMydM0QKUcUhlTrSO8UTlQQvM8JNC8xTSqxzSRZaDlabsqw2MHzvy9ZrWxOuNVC3wUQetiUpadBUW6AENkAI=",
            "d1RCYw+7ItngAmEm3NB3mdkb/JQ0RsA8gqLvbU5hbo0=",
        ),
    ),
    # vanity/0x57857
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x5785783682510912d1d066b214ba8e360a07c251",
            "0xa91308d7b1ec8f18417818d9bff27b51b39e2eb0062ef034643575d559a91c8ce7b2499bd8a242a36b5c7e017ced2df3bfeec20ff80046ee88293fb97122437c",
            "aec80d960e755fdee3853240153cdbbe884e13510bc7ac1e3f93f40a0d41c5ef",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x5785783682510912d1d066b214ba8e360a07c251",
            "BKkTCNex7I8YQXgY2b/ye1Gzni6wBi7wNGQ1ddVZqRyM57JJm9iiQqNrXH4BfO0t87/uwg/4AEbuiCk/uXEiQ3w=",
            "rsgNlg51X97jhTJAFTzbvohOE1ELx6weP5P0Cg1Bxe8=",
        ),
    ),
    # vanity/0x57957
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x57957b4137300a6ea3c773aac9f9aceb686167f4",
            "0xe5920bc7cec3f44d0dc74a8457b7534b9f0aed78f0a6af688ad634e98c6a185b096cf04ab91397deaf0cc0ea7f1eb0384315fb01b47010686ba17445b2475176",
            "179de8cfcb75af323339ff6def227d336991ccd8856118ea3290d703c56c83fc",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x57957b4137300a6ea3c773aac9f9aceb686167f4",
            "BOWSC8fOw/RNDcdKhFe3U0ufCu148KavaIrWNOmMahhbCWzwSrkTl96vDMDqfx6wOEMV+wG0cBBoa6F0RbJHUXY=",
            "F53oz8t1rzIzOf9t7yJ9M2mRzNiFYRjqMpDXA8Vsg/w=",
        ),
    ),
    # vanity/0x58058
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x58058f39feb8eff58016ee8d6d1e07380768dcc3",
            "0x305da62572eb8efc44ce2ad428e72206776c2914be382b70c6f4d5726dfef6c332491f2dcbcda10b96c3b311f8a533c73e3a90681e951cca3e0c3ac7107f1e37",
            "382a13d52936c430c1f0e6f41296ef0738ee5e56d9ea83ab083fdd3ed20fe071",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x58058f39feb8eff58016ee8d6d1e07380768dcc3",
            "BDBdpiVy6478RM4q1CjnIgZ3bCkUvjgrcMb01XJt/vbDMkkfLcvNoQuWw7MR+KUzxz46kGgelRzKPgw6xxB/Hjc=",
            "OCoT1Sk2xDDB8Ob0EpbvBzjuXlbZ6oOrCD/dPtIP4HE=",
        ),
    ),
    # vanity/0x58158
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x5815806009639aab8b91579cf729b1b8bb269130",
            "0x5f9be1ff336d73cff5782f5c568271eb4c2d2a0bcde001db1969dd43d325beb23955851caaf0ddd96b4933d11c22c201d85c0c88480e6b9f353c0799c20c9903",
            "5c3af69885f506ded8a3992aca842eba2e0c9a49f2718e90d6b922a147516445",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x5815806009639aab8b91579cf729b1b8bb269130",
            "BF+b4f8zbXPP9XgvXFaCcetMLSoLzeAB2xlp3UPTJb6yOVWFHKrw3dlrSTPRHCLCAdhcDIhIDmufNTwHmcIMmQM=",
            "XDr2mIX1Bt7Yo5kqyoQuui4MmknycY6Q1rkioUdRZEU=",
        ),
    ),
    # vanity/0x58258
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x58258a69461730d2c46abcf5ddf11b95be0da2a3",
            "0xd6e55863f62d1b3fbbb96cf1ebba51d5461ad781497d25bec1c061d7b731cd14851eab1758d777392271cc5de3ab218257244c35a76dd959ff70182f273bddee",
            "55d21aabed743fed9dc275f6249dcacc85ee658ba4fc8aaa1dadc3bda71cd0c2",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x58258a69461730d2c46abcf5ddf11b95be0da2a3",
            "BNblWGP2LRs/u7ls8eu6UdVGGteBSX0lvsHAYde3Mc0UhR6rF1jXdzkiccxd46shglckTDWnbdlZ/3AYLyc73e4=",
            "VdIaq+10P+2dwnX2JJ3KzIXuZYuk/IqqHa3Dvacc0MI=",
        ),
    ),
    # vanity/0x58358
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x58358e0a12b12d02acf204b89a32444566cf9faa",
            "0xecf736513001cafb6b64a82f84a709b6053259ec0b2797cf885905861ced57cce370161e6c23ddb8504ac9fb7681318cf9f3ab1d4941be83a9364972afbc239a",
            "a7b92e32ce63f5190b339bc10a3b2123bd615786882cdb514e2f3ada46553fda",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x58358e0a12b12d02acf204b89a32444566cf9faa",
            "BOz3NlEwAcr7a2SoL4SnCbYFMlnsCyeXz4hZBYYc7VfM43AWHmwj3bhQSsn7doExjPnzqx1JQb6DqTZJcq+8I5o=",
            "p7kuMs5j9RkLM5vBCjshI71hV4aILNtRTi862kZVP9o=",
        ),
    ),
    # vanity/0x58458
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x584585ab8b832786d28d7d5a2f37ebaa399e2868",
            "0x989209d388d97e6572c50b529bd07a662c5b1f3040995b6563eec3b84b7e5e21c4a7b8151a7b6369c6df7f75b37c9d71623c553445b2b1e62db97fc443d55e0b",
            "88692f7e7a61114f57c8a354a41d22b2d485863184a8c949efb1d9058062869f",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x584585ab8b832786d28d7d5a2f37ebaa399e2868",
            "BJiSCdOI2X5lcsULUpvQemYsWx8wQJlbZWPuw7hLfl4hxKe4FRp7Y2nG3391s3ydcWI8VTRFsrHmLbl/xEPVXgs=",
            "iGkvfnphEU9XyKNUpB0istSFhjGEqMlJ77HZBYBihp8=",
        ),
    ),
    # vanity/0x58558
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x5855845567369ba64850d8c76a24c5eba542d81f",
            "0x6140dbe278f0a6c3affcd118f0c3ca4246f206b801632713fbff6ba30a686b59563612e3026cf24dff0a5d75108824bfac569f8e79b6cf6c76cb7d3d4e43e97f",
            "61a24fedb796d8282fe64eca84504ae00b2e6972c37a4d095e63b19d68da37c2",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x5855845567369ba64850d8c76a24c5eba542d81f",
            "BGFA2+J48KbDr/zRGPDDykJG8ga4AWMnE/v/a6MKaGtZVjYS4wJs8k3/Cl11EIgkv6xWn455ts9sdst9PU5D6X8=",
            "YaJP7beW2Cgv5k7KhFBK4AsuaXLDek0JXmOxnWjaN8I=",
        ),
    ),
    # vanity/0x58658
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x58658f3b62df2dd7bf25f5bf0a9c728c58cc386b",
            "0x49ff66bc47ed5485438f00c04bfb1f9eaec351bb4c24e70aa03eaf53a6f614a29cd127cddba2dcfff85034eb448528907a3d59d987578743b05f6f102478a6b8",
            "abc9f41b15eff5751404463e8da8ad22f32aa805df69fb17115d8fddf2139a52",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x58658f3b62df2dd7bf25f5bf0a9c728c58cc386b",
            "BEn/ZrxH7VSFQ48AwEv7H56uw1G7TCTnCqA+r1Om9hSinNEnzdui3P/4UDTrRIUokHo9WdmHV4dDsF9vECR4prg=",
            "q8n0GxXv9XUUBEY+jaitIvMqqAXfafsXEV2P3fITmlI=",
        ),
    ),
    # vanity/0x58758
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x5875892bf4daf9d5d48d00755250de09003c6b92",
            "0x238d87d961a6b965e6df138f9a18db44878edf04fea078fdd3832ea11108bd9d35e70815b68ca3bc3a1a881cf3716e311c269c94e9311ea9180ae34baf7a554d",
            "dd0dcfc70aa366844f269de5f51c30926b8a092a5542ca47b19e055bb881027b",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x5875892bf4daf9d5d48d00755250de09003c6b92",
            "BCONh9lhprll5t8Tj5oY20SHjt8E/qB4/dODLqERCL2dNecIFbaMo7w6Gogc83FuMRwmnJTpMR6pGArjS696VU0=",
            "3Q3PxwqjZoRPJp3l9RwwkmuKCSpVQspHsZ4FW7iBAns=",
        ),
    ),
    # vanity/0x58858
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x58858c5fcfbad1f552de9539b562eefe43daee7a",
            "0x273db0fb30b5f75a6960e73d37cb88b74faf39b9fb0a0e6005f78564eed9b8ef88cb3769ebe7a9bc96820ba622c6f39189d9f5e3c1c3f7cdd0ef6b2455c7aa1e",
            "393f5e4a597eefd784523bb21d66229649e56bc09a15e3e7d3e1628ecafc35b5",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x58858c5fcfbad1f552de9539b562eefe43daee7a",
            "BCc9sPswtfdaaWDnPTfLiLdPrzm5+woOYAX3hWTu2bjviMs3aevnqbyWggumIsbzkYnZ9ePBw/fN0O9rJFXHqh4=",
            "OT9eSll+79eEUjuyHWYilknla8CaFePn0+Fijsr8NbU=",
        ),
    ),
    # vanity/0x58958
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x58958da5bae915af9dccdcf13e7212858ade35c4",
            "0x908edd417645e510d658633d8a0a1a218fc798f9bfbf3435286638af60c4c74178370c225b9f051eab74bf9f28dc84c63a6ce201c92a822ba238be4c1bf54327",
            "744b83f8c9e1920b5a51d89c6d6d574630f169ab71b5e3e47230591ee6fcb27d",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x58958da5bae915af9dccdcf13e7212858ade35c4",
            "BJCO3UF2ReUQ1lhjPYoKGiGPx5j5v780NShmOK9gxMdBeDcMIlufBR6rdL+fKNyExjps4gHJKoIroji+TBv1Qyc=",
            "dEuD+MnhkgtaUdicbW1XRjDxaatxtePkcjBZHub8sn0=",
        ),
    ),
    # vanity/0x59059
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x59059ec62290eb339f44390585adce36588b71b3",
            "0xab1eaf45ae33bf0e328727e28e72d4354c701a6c68dec884156bcfcafbb7fff4e32e5f244feb7ef9c4d9b8630aa363e58969966a9dc728a54cbd1f7df02e5af6",
            "c738560af2e69ed63ea1e57da19612fef2ccadb93cc73abfe7ff34bb5b1d58b1",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x59059ec62290eb339f44390585adce36588b71b3",
            "BKser0WuM78OMocn4o5y1DVMcBpsaN7IhBVrz8r7t//04y5fJE/rfvnE2bhjCqNj5YlplmqdxyilTL0fffAuWvY=",
            "xzhWCvLmntY+oeV9oZYS/vLMrbk8xzq/5/80u1sdWLE=",
        ),
    ),
    # vanity/0x59159
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x59159fc2ae53a792a52ae4823bdcb9b58a54a845",
            "0x3afffdd02342d884264194db3412154b37d863f782016d48f995583f8fd6bb3a4d97157a30ac125015a4148ca52e906464127710733ac7d5946b21a35a8d8d05",
            "c316294ab547e77fef3035dd36ee4bf49637f7a9bc74bc7851b7c0738246ec62",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x59159fc2ae53a792a52ae4823bdcb9b58a54a845",
            "BDr//dAjQtiEJkGU2zQSFUs32GP3ggFtSPmVWD+P1rs6TZcVejCsElAVpBSMpS6QZGQSdxBzOsfVlGsho1qNjQU=",
            "wxYpSrVH53/vMDXdNu5L9JY396m8dLx4UbfAc4JG7GI=",
        ),
    ),
    # vanity/0x59259
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x5925958d5885b0880164c5788fb8efd379ea62d2",
            "0xc1fc1d563a1e579eea786e1370efaa2ed844dc25183e5b756d3b32a622512c117011ff4f1c7ca9d493664fedc7728ac325335d0239b0ba5d5f25fc02e457d478",
            "7daca335b455a8ec2d859685e67543d195ce06222388f66412959115d339038e",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x5925958d5885b0880164c5788fb8efd379ea62d2",
            "BMH8HVY6Hlee6nhuE3Dvqi7YRNwlGD5bdW07MqYiUSwRcBH/Txx8qdSTZk/tx3KKwyUzXQI5sLpdXyX8AuRX1Hg=",
            "fayjNbRVqOwthZaF5nVD0ZXOBiIjiPZkEpWRFdM5A44=",
        ),
    ),
    # vanity/0x59359
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x593593d982b49bacceff9e7ad829b4bdcf2ae6d5",
            "0x68d6ed8ae796454fa5c508c830b0a07c2c4b089895882700f04a213cb97f192b5e147b5ae2d025c4732d76a4f53652501bc02c1d7a994ce088872d19a34be61c",
            "7076bd3bbe956776346da41ad4aec9dd31ff1e29ed8a0eeb439ffce821a681f4",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x593593d982b49bacceff9e7ad829b4bdcf2ae6d5",
            "BGjW7YrnlkVPpcUIyDCwoHwsSwiYlYgnAPBKITy5fxkrXhR7WuLQJcRzLXak9TZSUBvALB16mUzgiIctGaNL5hw=",
            "cHa9O76VZ3Y0baQa1K7J3TH/Hintig7rQ5/86CGmgfQ=",
        ),
    ),
    # vanity/0x59459
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x59459d62097487678e905a56c796de301a56b832",
            "0x00fddbf5d4c86324b2dfb16159cc101051f5cfe58ce02cb883679977b22ba6a2c3d6b5032f3e02732e4c461388a772822f063ab54947d263aba4eb9e2ad8b74f",
            "5636b2b909fb9b2ac06b388a2a0c129388a663a30a1cbf7e28878036114b2c34",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x59459d62097487678e905a56c796de301a56b832",
            "BAD92/XUyGMkst+xYVnMEBBR9c/ljOAsuINnmXeyK6aiw9a1Ay8+AnMuTEYTiKdygi8GOrVJR9Jjq6TrnirYt08=",
            "VjayuQn7myrAaziKKgwSk4imY6MKHL9+KIeANhFLLDQ=",
        ),
    ),
    # vanity/0x59559
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x595592deb99978c5be7285a0a1732c731da517f2",
            "0xae76607491f694ce09db4fa0129854dfe7cf2f9a924237d50b25600856bb9db4a283f801d5d0637b3baf6f6a42ff696ee53ca0c946cea0da3725df1d6e935ee9",
            "449d50d8773ece448ad2d17c1a6804e090293d25339a6f1cbb55cd577e270b5a",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x595592deb99978c5be7285a0a1732c731da517f2",
            "BK52YHSR9pTOCdtPoBKYVN/nzy+akkI31QslYAhWu520ooP4AdXQY3s7r29qQv9pbuU8oMlGzqDaNyXfHW6TXuk=",
            "RJ1Q2Hc+zkSK0tF8GmgE4JApPSUzmm8cu1XNV34nC1o=",
        ),
    ),
    # vanity/0x59659
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x59659837736418ba3216370cda1d488c52c4dbbe",
            "0x5078d96b500e571e4f643a22ecc2bb7e5bf93f44e62a5b926db31b924ef265576ce0e42588c5ce1e436a202fb90fd33db8c0c69755c6ec9f4b748f96ba029c0b",
            "3d64c937b39b1b9c76e5e2ba25565424d972a092cd7f8fd4772550af36c344db",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x59659837736418ba3216370cda1d488c52c4dbbe",
            "BFB42WtQDlceT2Q6IuzCu35b+T9E5ipbkm2zG5JO8mVXbODkJYjFzh5DaiAvuQ/TPbjAxpdVxuyfS3SPlroCnAs=",
            "PWTJN7ObG5x25eK6JVZUJNlyoJLNf4/UdyVQrzbDRNs=",
        ),
    ),
    # vanity/0x59759
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x5975956fcff764e892514295f268ad644fb64efb",
            "0x1bfb97624f1870d311400cb6915bd8ab16462b392d0c57406b07d53e315d720b940bd529215cd41ffd54888f93c80c020ea5426d462688d7c554e69a98830f97",
            "7e1b65687d1f5bf56d7d806aa3b47ff50395179f2cf72ee9cd294ceb31ae6c74",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x5975956fcff764e892514295f268ad644fb64efb",
            "BBv7l2JPGHDTEUAMtpFb2KsWRis5LQxXQGsH1T4xXXILlAvVKSFc1B/9VIiPk8gMAg6lQm1GJojXxVTmmpiDD5c=",
            "fhtlaH0fW/VtfYBqo7R/9QOVF58s9y7pzSlM6zGubHQ=",
        ),
    ),
    # vanity/0x59859
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x59859d94dd98fe845176daa2b62969c565d7fe2f",
            "0x35bd5d574db21f161f6602a1ce3dafa9485bdcc2d4edbbda84d322d5c8fdb38d4d8497d013311213d8ca9f6c176c04c73513f175998b5870ecbdcbc9e76b7507",
            "fbb335ce2c30abe520708ebf350219002ae09bc3caef811b86119d0f86c60100",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x59859d94dd98fe845176daa2b62969c565d7fe2f",
            "BDW9XVdNsh8WH2YCoc49r6lIW9zC1O272oTTItXI/bONTYSX0BMxEhPYyp9sF2wExzUT8XWZi1hw7L3LyedrdQc=",
            "+7M1ziwwq+UgcI6/NQIZACrgm8PK74EbhhGdD4bGAQA=",
        ),
    ),
    # vanity/0x59959
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x599591afd56728f5ae5067c6ecd5b4246a845826",
            "0x2409f53857464891b886296795b71661f4c9e088a0a36f8643ca02ebe6c727a7246e2369316aefe4a096172dcb32270c655c1d3672b232277992e6d7bbfbdc4a",
            "0e47d8b413edd992f306cb5aca1223c37e3fb21b8ec99bd87189c12116dc41e5",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x599591afd56728f5ae5067c6ecd5b4246a845826",
            "BCQJ9ThXRkiRuIYpZ5W3FmH0yeCIoKNvhkPKAuvmxyenJG4jaTFq7+SglhctyzInDGVcHTZysjIneZLm17v73Eo=",
            "DkfYtBPt2ZLzBstayhIjw34/shuOyZvYcYnBIRbcQeU=",
        ),
    ),
    # vanity/0x60060
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x600600c38dd999e3904ba16131a3b1dfacd72878",
            "0x2d309b753fb7c82d660a165e3188f9ad5c49911f79ac0f66ee37fa470c35b6d6b4218e39f6e5a56b664996fbe23b23dd10cd08b242d28759fe8072fec3ea847e",
            "dbf9e6df3d0e2c17dcfc6df0f938053ea505a1112ac1ad93be12a800e7f7c0b3",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x600600c38dd999e3904ba16131a3b1dfacd72878",
            "BC0wm3U/t8gtZgoWXjGI+a1cSZEfeawPZu43+kcMNbbWtCGOOfblpWtmSZb74jsj3RDNCLJC0odZ/oBy/sPqhH4=",
            "2/nm3z0OLBfc/G3w+TgFPqUFoREqwa2TvhKoAOf3wLM=",
        ),
    ),
    # vanity/0x60160
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x6016068b9643ee890950da5c7af2bac21df3ce9f",
            "0x136952d7b18764ba45af0bde8a18135451e6ef15e6c86e2c7f94229dac089b6806c7d9bef4d1d14c4f3274a7f10c19063e474636006a3a8c5ba8e3ec4e0d06a1",
            "2cc59a64332259e3c221c02cac6ec8dd4f1e2d20cadcb5d104cc5c8872424734",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x6016068b9643ee890950da5c7af2bac21df3ce9f",
            "BBNpUtexh2S6Ra8L3ooYE1RR5u8V5shuLH+UIp2sCJtoBsfZvvTR0UxPMnSn8QwZBj5HRjYAajqMW6jj7E4NBqE=",
            "LMWaZDMiWePCIcAsrG7I3U8eLSDK3LXRBMxciHJCRzQ=",
        ),
    ),
    # vanity/0x60260
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x602601aec5d52c0d50a6e4a0f9e6b5fdb0a8d267",
            "0x254ec0ea5e7410fd367893f37c1453a83c63ecbe76fb570f1611bda86e546aade9456c6f2647f689ed833ce5ac7c9d76c55a099c3f1719fc48c365e76a3425dd",
            "83b9e70ceec12e1e4d9a11f3b2c80ac971ddce220784835e27b888912945ad49",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x602601aec5d52c0d50a6e4a0f9e6b5fdb0a8d267",
            "BCVOwOpedBD9NniT83wUU6g8Y+y+dvtXDxYRvahuVGqt6UVsbyZH9ontgzzlrHyddsVaCZw/Fxn8SMNl52o0Jd0=",
            "g7nnDO7BLh5NmhHzssgKyXHdziIHhINeJ7iIkSlFrUk=",
        ),
    ),
    # vanity/0x60360
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x60360a91003d0f67457a12eb7c067f5a2ac19ce3",
            "0x68829f06915066d6a08b6cdd416135a16f57fb44c14fc08d731931e1d94b3289c0745f1757ab71976bf05594cf566e278f0d3bde2efd199953c44c5ad24b4a49",
            "cdccd1a5ad5d48cdb1b270dd383ad70e0a495cd45edfadb8b296528d1006c266",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x60360a91003d0f67457a12eb7c067f5a2ac19ce3",
            "BGiCnwaRUGbWoIts3UFhNaFvV/tEwU/AjXMZMeHZSzKJwHRfF1ercZdr8FWUz1ZuJ48NO94u/RmZU8RMWtJLSkk=",
            "zczRpa1dSM2xsnDdODrXDgpJXNRe3624spZSjRAGwmY=",
        ),
    ),
    # vanity/0x60460
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x604602c22bc1f6215ffff11a89c829ddcb4590dd",
            "0xa8eb28c05e30c816eb4318b248fdb55179ca64db429e4d0339c17e39ff2d2894c430991153ce44049ee8c34d8db42aec7bd957b9942d2759490f818b0778a6fe",
            "e2fe00f7ba0ffbab766323ced60fd951941594c4c2faee67f921a6c93ac8fff2",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x604602c22bc1f6215ffff11a89c829ddcb4590dd",
            "BKjrKMBeMMgW60MYskj9tVF5ymTbQp5NAznBfjn/LSiUxDCZEVPORASe6MNNjbQq7HvZV7mULSdZSQ+Biwd4pv4=",
            "4v4A97oP+6t2YyPO1g/ZUZQVlMTC+u5n+SGmyTrI//I=",
        ),
    ),
    # vanity/0x60560
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x605601abe842e378ff904d9f60804b12d5d8dc7f",
            "0x004d5f092542cf8a0a355d2b5d6c921e25860094d826d903a18efb4769b2f9bab4826593ffdb495dc6ef20e88e7926e6a40d53cd242b49d6c8fc455bfa235c47",
            "d8e6c8fa78678c61fcb3ca0e07d80e60fb27e80c42cdc15997217d543bda6597",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x605601abe842e378ff904d9f60804b12d5d8dc7f",
            "BABNXwklQs+KCjVdK11skh4lhgCU2CbZA6GO+0dpsvm6tIJlk//bSV3G7yDojnkm5qQNU80kK0nWyPxFW/ojXEc=",
            "2ObI+nhnjGH8s8oOB9gOYPsn6AxCzcFZlyF9VDvaZZc=",
        ),
    ),
    # vanity/0x60660
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x606600ce80cdc69703439404e107c05571f875f9",
            "0x802e9fbb514890bfc4775b26de23ebed5ddb27d6e247ee610d897153c560f6fd9abd58681e2406025ff12e371007b1f14513bda22c9e7ae3d23ac237f2144fb2",
            "413b28dde91a62d38c47535121511927911b899711ae694a5c71283dbb475bd0",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x606600ce80cdc69703439404e107c05571f875f9",
            "BIAun7tRSJC/xHdbJt4j6+1d2yfW4kfuYQ2JcVPFYPb9mr1YaB4kBgJf8S43EAex8UUTvaIsnnrj0jrCN/IUT7I=",
            "QTso3ekaYtOMR1NRIVEZJ5EbiZcRrmlKXHEoPbtHW9A=",
        ),
    ),
    # vanity/0x60760
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x607606cce089f162c80c787c94ac89ca02d9afec",
            "0x763f7e93978952114f10d4f6b2d155904dbe8c2a6380d2578bfad7e855ff557d9fa02355c19710ae75e916a606aef5cd394ce7073136547148a8ff47c323469b",
            "1dce7f56399788129096bfe281cfc3f4f84a85d15177f451c522b6b8f4ab3af2",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x607606cce089f162c80c787c94ac89ca02d9afec",
            "BHY/fpOXiVIRTxDU9rLRVZBNvowqY4DSV4v61+hV/1V9n6AjVcGXEK516RamBq71zTlM5wcxNlRxSKj/R8MjRps=",
            "Hc5/VjmXiBKQlr/igc/D9PhKhdFRd/RRxSK2uPSrOvI=",
        ),
    ),
    # vanity/0x60860
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x60860828bd64c053de111ff52ef8359e21a26a9c",
            "0x9a5281bbbb36ec44c113555244f1ce056ab5d92522df84a8ec3b26185e3f2e83be7339756d4c393055858439e8c2cf539911d5a8e5c3f8fb37e68bad5b59d64a",
            "0e20dea9c2ea39f0fcbe5e0213b76799c344220b23e6d805f4aad2684d095744",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x60860828bd64c053de111ff52ef8359e21a26a9c",
            "BJpSgbu7NuxEwRNVUkTxzgVqtdklIt+EqOw7JhhePy6DvnM5dW1MOTBVhYQ56MLPU5kR1ajlw/j7N+aLrVtZ1ko=",
            "DiDeqcLqOfD8vl4CE7dnmcNEIgsj5tgF9KrSaE0JV0Q=",
        ),
    ),
    # vanity/0x60960
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x60960e4cfa439af66f851e2eeeca860ae8b2e03a",
            "0xcfc3c927d79292c62021cc11e9a951e2e2b2cc0a0e89afbbf6d6e9da61920deca9c359f706e31b2daaf2040814e61eeccc4c181401a5900cebe0d3c26a3b2148",
            "c1b673a6a3e2d492627e4ad4ab8d63387add305de87442fef9de6d2e1032ac02",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x60960e4cfa439af66f851e2eeeca860ae8b2e03a",
            "BM/DySfXkpLGICHMEempUeLisswKDomvu/bW6dphkg3sqcNZ9wbjGy2q8gQIFOYe7MxMGBQBpZAM6+DTwmo7IUg=",
            "wbZzpqPi1JJifkrUq41jOHrdMF3odEL++d5tLhAyrAI=",
        ),
    ),
    # vanity/0x61061
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x6106118073621438ac12c23b6c04311fcede157f",
            "0xed2bde0c97e86cfbd6c9484a47e105f1c01d25bd9f8eca66cde6513672ff551421ce861a4f20aaabc7ddcb4b8969c5b5d99bec277369a8fcc8f520374f40e112",
            "5cf70adf5a459d914fbf03d7a84d75964abafe216e7c2e83c13dde212187eaa9",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x6106118073621438ac12c23b6c04311fcede157f",
            "BO0r3gyX6Gz71slISkfhBfHAHSW9n47KZs3mUTZy/1UUIc6GGk8gqqvH3ctLiWnFtdmb7Cdzaaj8yPUgN09A4RI=",
            "XPcK31pFnZFPvwPXqE11lkq6/iFufC6DwT3eISGH6qk=",
        ),
    ),
    # vanity/0x61161
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x611614e7a021695f4f78b9ae1b36edf68c27b097",
            "0xac03ee39ca205e14d8f5d79e615517bda6c4677d7627cc28e889229f79eda143eb077aed65e56c964775cea760867a86253c9f76341e5d18a633f657d4c9bd44",
            "9f2930f78928a757a92da577d512184abd5665ff71c8dd877182f23d96ff3860",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x611614e7a021695f4f78b9ae1b36edf68c27b097",
            "BKwD7jnKIF4U2PXXnmFVF72mxGd9difMKOiJIp957aFD6wd67WXlbJZHdc6nYIZ6hiU8n3Y0Hl0YpjP2V9TJvUQ=",
            "nykw94kop1epLaV31RIYSr1WZf9xyN2HcYLyPZb/OGA=",
        ),
    ),
    # vanity/0x61261
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x6126109108bf8033b8b24b92cf1764e234194970",
            "0x48a713a78ae8d8ce0d2a98db60a09d849912f01475f4d34af54ed40336c5c6808152bcda5ac905499517cd200aa62a8c870322c358e9c7a0b22e7918975df150",
            "a233958890e3749559e3f4cca67a63457773ddcd5c2a825aa6aade4c207fd3c9",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x6126109108bf8033b8b24b92cf1764e234194970",
            "BEinE6eK6NjODSqY22CgnYSZEvAUdfTTSvVO1AM2xcaAgVK82lrJBUmVF80gCqYqjIcDIsNY6cegsi55GJdd8VA=",
            "ojOViJDjdJVZ4/TMpnpjRXdz3c1cKoJapqreTCB/08k=",
        ),
    ),
    # vanity/0x61361
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x613610723111e2a515edd9de7b9c01a97737a834",
            "0x999d6954df70d57ae123494e512ad5559af4041140c2c9a2518711277e9b33b9f8911c7a99f8f0366f0f573c59c2b8549729d5ca2df3ca4f4934b33c393b33e6",
            "6bde6686b07f22cf9b9a05ee17f3055cbab2d6f68329fc61a9ccef57ffa3b60e",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x613610723111e2a515edd9de7b9c01a97737a834",
            "BJmdaVTfcNV64SNJTlEq1VWa9AQRQMLJolGHESd+mzO5+JEcepn48DZvD1c8WcK4VJcp1cot88pPSTSzPDk7M+Y=",
            "a95mhrB/Is+bmgXuF/MFXLqy1vaDKfxhqczvV/+jtg4=",
        ),
    ),
    # vanity/0x61461
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x61461caae01522755f3d08e5030fb87c822fd54f",
            "0x6867100614aec6b5cae2fd308dc8bc5216c2ddccf59b4b0febe0e0b63fa505499c00625c52180c83dbb47fc01c4c066f8fa4feef0731904f8f0f1c41d35a5753",
            "89c0cd2846a3e1394a4b0bd454d58dd8849ffc706e5ad1e5a80f381a3749fd0c",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x61461caae01522755f3d08e5030fb87c822fd54f",
            "BGhnEAYUrsa1yuL9MI3IvFIWwt3M9ZtLD+vg4LY/pQVJnABiXFIYDIPbtH/AHEwGb4+k/u8HMZBPjw8cQdNaV1M=",
            "icDNKEaj4TlKSwvUVNWN2ISf/HBuWtHlqA84GjdJ/Qw=",
        ),
    ),
    # vanity/0x61561
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x61561128bca33261dd9f7f1fc0f83b01982a4bb5",
            "0x756455e3d4e0d2bc4248a1740e0eba76393c7de8e791bdfa59249abbfb5f7aa7697a1764c94856c4b09fd237d05e4957f75dbd5ceb1c0d46870c6418a1eed1ec",
            "4d54ff3d7a6dea822b5e7bda7513c34395dbef784f763b188860764b1c6d4f10",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x61561128bca33261dd9f7f1fc0f83b01982a4bb5",
            "BHVkVePU4NK8QkihdA4OunY5PH3o55G9+lkkmrv7X3qnaXoXZMlIVsSwn9I30F5JV/ddvVzrHA1GhwxkGKHu0ew=",
            "TVT/PXpt6oIrXnvadRPDQ5Xb73hPdjsYiGB2SxxtTxA=",
        ),
    ),
    # vanity/0x61661
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x616612abf4ffe5915ed58498dc109b86cddd2bc0",
            "0x32f1725689057fae3ab3befa7c74127616a5d0a2a032747af64fce8e98d65c2f4eeb429a12ab4e1ddd76ea6fd35a0594dc4de7f8a0c1a641da15ad80f28833b8",
            "46de4f718d48001a6f4c66b2bd8d563f1e08cc03bb7c8cc88f8fa6aa1ef1e7fd",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x616612abf4ffe5915ed58498dc109b86cddd2bc0",
            "BDLxclaJBX+uOrO++nx0EnYWpdCioDJ0evZPzo6Y1lwvTutCmhKrTh3ddupv01oFlNxN5/igwaZB2hWtgPKIM7g=",
            "Rt5PcY1IABpvTGayvY1WPx4IzAO7fIzIj4+mqh7x5/0=",
        ),
    ),
    # vanity/0x61761
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x617616ba5ad39e10e127f6b4ff55769f92cb691b",
            "0xc8d2e096de33fd7e3ef7fde438405a68d5571ca9740506b8c49ac65f2e3448b9ac32aafa90e4b364f6b8db959f5b62640dd1bca05c2fd994e89d163264b32687",
            "4aca142bed155fc5eab92a4f0b60f6e889bb8e5d56a5d1db496983ef76008d5c",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x617616ba5ad39e10e127f6b4ff55769f92cb691b",
            "BMjS4JbeM/1+Pvf95DhAWmjVVxypdAUGuMSaxl8uNEi5rDKq+pDks2T2uNuVn1tiZA3RvKBcL9mU6J0WMmSzJoc=",
            "SsoUK+0VX8XquSpPC2D26Im7jl1WpdHbSWmD73YAjVw=",
        ),
    ),
    # vanity/0x61861
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x618611a73dd687d3febcf24b1397fef3923caca5",
            "0x4b96cc610bc84d8fb21f40434eb952db1f3dbdac5149053c42e5ed793bccd5b652df0731af6a455a0ebc279f1ef42e8a50e27f349b4c21e639e68992341f0df6",
            "55558483f4676eda89c21143dfef9dfdc1d54e823b4b09a38f82aed885d91909",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x618611a73dd687d3febcf24b1397fef3923caca5",
            "BEuWzGELyE2Psh9AQ065UtsfPb2sUUkFPELl7Xk7zNW2Ut8HMa9qRVoOvCefHvQuilDifzSbTCHmOeaJkjQfDfY=",
            "VVWEg/RnbtqJwhFD3++d/cHVToI7Swmjj4Ku2IXZGQk=",
        ),
    ),
    # vanity/0x61961
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x61961f86fc2b724a2dc23af2fb64a297409dc99c",
            "0x50a315856690c1bae9eecb8b83f132afb909f2ba1d3880b11b84d6e5eb1a3bab3005703d417011c90e0d04e66b648c41f2b32e035bdd1c08c58d29b80344399c",
            "fa786e1d63c4a687b165396554243eaf643d64c927af56c3a5ef379409c42cde",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x61961f86fc2b724a2dc23af2fb64a297409dc99c",
            "BFCjFYVmkMG66e7Li4PxMq+5CfK6HTiAsRuE1uXrGjurMAVwPUFwEckODQTma2SMQfKzLgNb3RwIxY0puANEOZw=",
            "+nhuHWPEpoexZTllVCQ+r2Q9ZMknr1bDpe83lAnELN4=",
        ),
    ),
    # vanity/0x62062
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x62062efec84612200464bf2678f8391e73da0fb2",
            "0x6e501faa7315a930f0fddc093f0fa133673c0de29e2a69dc4fea0086d248fb965428fbfff60a18d3f45407de4c1ca8120f3cc9159fbb54f7f306b6c3feb45fe6",
            "63c30064e6ecbbcaa666a033e9c4c97fe058b5b4a19eb8eb0e1c431e8c9b72fe",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x62062efec84612200464bf2678f8391e73da0fb2",
            "BG5QH6pzFakw8P3cCT8PoTNnPA3inipp3E/qAIbSSPuWVCj7//YKGNP0VAfeTByoEg88yRWfu1T38wa2w/60X+Y=",
            "Y8MAZObsu8qmZqAz6cTJf+BYtbShnrjrDhxDHoybcv4=",
        ),
    ),
    # vanity/0x62162
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x621621a305ac140405f6e30e5e9799d5cffc3791",
            "0xde9c7574a82b787295c6c3c67b72157cd24119103c865c0f750cd86fed0535576486ce7a1a09fb390121b8890fbf6f16c10dafe4391d9e4b0cbde596e17f9aa7",
            "89828107e7453ffca681bc9c534594ffd307328c7d56c909e81b751f7a4662ad",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x621621a305ac140405f6e30e5e9799d5cffc3791",
            "BN6cdXSoK3hylcbDxntyFXzSQRkQPIZcD3UM2G/tBTVXZIbOehoJ+zkBIbiJD79vFsENr+Q5HZ5LDL3lluF/mqc=",
            "iYKBB+dFP/ymgbycU0WU/9MHMox9VskJ6Bt1H3pGYq0=",
        ),
    ),
    # vanity/0x62262
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x6226251e184e2569b8ba25fa67027b2187b27acc",
            "0xba6c76de5acb457443f1c84d629303336afb469534aa91a1da689a3deb21a01fb0fa03afd194457fcddc4b3e76ef55f62dfc6a755552dfcb6e78b72d8c31c7ec",
            "9112a5dfe1de48300e79d62ba152d05be08e8de465e4922a0b7f489dc1522298",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x6226251e184e2569b8ba25fa67027b2187b27acc",
            "BLpsdt5ay0V0Q/HITWKTAzNq+0aVNKqRodpomj3rIaAfsPoDr9GURX/N3Es+du9V9i38anVVUt/Lbni3LYwxx+w=",
            "kRKl3+HeSDAOedYroVLQW+COjeRl5JIqC39IncFSIpg=",
        ),
    ),
    # vanity/0x62362
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x623628708704d21f2188844e37626c2035b9b907",
            "0xe9e52fc484295fddaea679a5893c5b4b1775c0c1d91ab91ca219e417726cc7e05b54e084ed3af46cb529096d48945301392e079232ede3a5ed418d97c9fd5bb2",
            "03e7012ba1a42584dfa6929f2e52de2957d134024a123281e5d4cb632165e5e5",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x623628708704d21f2188844e37626c2035b9b907",
            "BOnlL8SEKV/drqZ5pYk8W0sXdcDB2Rq5HKIZ5BdybMfgW1TghO069Gy1KQltSJRTATkuB5Iy7eOl7UGNl8n9W7I=",
            "A+cBK6GkJYTfppKfLlLeKVfRNAJKEjKB5dTLYyFl5eU=",
        ),
    ),
    # vanity/0x62462
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x62462b58f536433e2b33f7f8ff94d64357b2ca06",
            "0xb41c0da867c8427b0c79cf92bc2b9c7731bfd51fd14b4491f7db1b2461fdfc6d5d933fd98fe5f297939c0cf71fb5aa54cb7608a4f86c40a949b37119fc27f041",
            "435f4542ff89688b44ceaef9151d25b891ded855bb575aaa2140eb92cc9db37c",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x62462b58f536433e2b33f7f8ff94d64357b2ca06",
            "BLQcDahnyEJ7DHnPkrwrnHcxv9Uf0UtEkffbGyRh/fxtXZM/2Y/l8peTnAz3H7WqVMt2CKT4bECpSbNxGfwn8EE=",
            "Q19FQv+JaItEzq75FR0luJHe2FW7V1qqIUDrksyds3w=",
        ),
    ),
    # vanity/0x62562
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x625620e54a8c1e071f392fa565d3a2e53979aeb1",
            "0x2e6be4cca4973197a53ee15fbde990c962ece9ba838f8c6ab0febbaea91eeabc370db802a6c53fa152fc24dfe3b6279cdcecb3fa81467684c54948f3cd8988ac",
            "92809c74b7b5489beaabfaca6d02962252546527c6980d1a154ba808a27b9402",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x625620e54a8c1e071f392fa565d3a2e53979aeb1",
            "BC5r5MyklzGXpT7hX73pkMli7Om6g4+MarD+u66pHuq8Nw24AqbFP6FS/CTf47YnnNzss/qBRnaExUlI882JiKw=",
            "koCcdLe1SJvqq/rKbQKWIlJUZSfGmA0aFUuoCKJ7lAI=",
        ),
    ),
    # vanity/0x62662
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x62662d6ce3d0ccf87e1c01542b2fc3b73873f562",
            "0xac4205d2987eb1c345f237dc26f9627d941772a1a494ee87f6fd57ed031c29660b70b2168fbfc6ff0f6fcbb1f6cd334bf252b777de15fb67548c384f7a076926",
            "684577346691fa23273401e9bcf69ef1f4ddff7253bd8421b8a9a39173769c00",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x62662d6ce3d0ccf87e1c01542b2fc3b73873f562",
            "BKxCBdKYfrHDRfI33Cb5Yn2UF3KhpJTuh/b9V+0DHClmC3CyFo+/xv8Pb8ux9s0zS/JSt3feFftnVIw4T3oHaSY=",
            "aEV3NGaR+iMnNAHpvPae8fTd/3JTvYQhuKmjkXN2nAA=",
        ),
    ),
    # vanity/0x62762
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x62762fea756397544d6ab0b39b15e43841904f87",
            "0x1e118716b74ef32ca0fbfcb0ce4fe1f24da71e742148fb5c5a5aeb8312fde3fe59247b2202e39c877e1d59d2f308311f15ed996e5d78d56bd006df12c072959c",
            "8c163e8722ca010a4935788e00d41ea9b2c147eaa08a535463f8a4c55cbe6238",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x62762fea756397544d6ab0b39b15e43841904f87",
            "BB4Rhxa3TvMsoPv8sM5P4fJNpx50IUj7XFpa64MS/eP+WSR7IgLjnId+HVnS8wgxHxXtmW5deNVr0AbfEsBylZw=",
            "jBY+hyLKAQpJNXiOANQeqbLBR+qgilNUY/ikxVy+Yjg=",
        ),
    ),
    # vanity/0x62862
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x62862a58df2ebd36aa40221fef7663d74f8c581f",
            "0xe6136124ace02ac793fb3ae4444015fcdaf7f0cbc223fc596cd3fe3fb2d51496aaae62f06fa0a1c0933aadc93ec9efa2620954f6656ea4d444b19bf1dbeeff12",
            "914ed3b7343dfdea1185f46fc0fa3974f940ad7fe14231f7b803187b4b0ee273",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x62862a58df2ebd36aa40221fef7663d74f8c581f",
            "BOYTYSSs4CrHk/s65ERAFfza9/DLwiP8WWzT/j+y1RSWqq5i8G+gocCTOq3JPsnvomIJVPZlbqTURLGb8dvu/xI=",
            "kU7TtzQ9/eoRhfRvwPo5dPlArX/hQjH3uAMYe0sO4nM=",
        ),
    ),
    # vanity/0x62962
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x629625e8753afc635a7691cde8a40cfb8ff50503",
            "0x61758361136998b9f836fa0b3bd33f8a78e5d735706d07f929b11bff805893669a1c1adf12befaa42d561ed173df2ce94b91515e590c058143eac01493c7bfd6",
            "6a0370e6faecabe9b57a799a315cfa145f132ea61eba4735535a737c2c7a5021",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x629625e8753afc635a7691cde8a40cfb8ff50503",
            "BGF1g2ETaZi5+Db6CzvTP4p45dc1cG0H+SmxG/+AWJNmmhwa3xK++qQtVh7Rc98s6UuRUV5ZDAWBQ+rAFJPHv9Y=",
            "agNw5vrsq+m1enmaMVz6FF8TLqYeukc1U1pzfCx6UCE=",
        ),
    ),
    # vanity/0x63063
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x6306361ef045365750dfcb5b555b0f215c09a77f",
            "0x159c3e2b602e5f045ecfb0630ae8f4567c16a1547598a3f5100cfa9b33419ebc4c09822a47993017065b8e715fe79a1ed195baec0ca42c08c23c1c07256fac73",
            "934ff86d4776adc567aa3ed44a754768ce55f82c3de0631c7967ec3d9b6c7988",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x6306361ef045365750dfcb5b555b0f215c09a77f",
            "BBWcPitgLl8EXs+wYwro9FZ8FqFUdZij9RAM+pszQZ68TAmCKkeZMBcGW45xX+eaHtGVuuwMpCwIwjwcByVvrHM=",
            "k0/4bUd2rcVnqj7USnVHaM5V+Cw94GMceWfsPZtseYg=",
        ),
    ),
    # vanity/0x63163
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x63163fe2ce5da94230f5c4c4579081d1fade0c60",
            "0xe46c51e01dcfc804d06dd77adb0f8afe785918223651560150abbfea37dbd0aac06afd03fe24efed2b143481afbcef3cca07264c0f098f4dc9fe3e7204dbe3fc",
            "4c8916e4af1ad4fca971601c7dc59fa580bbf74f6bfdbb5c5cd02a33be36d64b",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x63163fe2ce5da94230f5c4c4579081d1fade0c60",
            "BORsUeAdz8gE0G3XetsPiv54WRgiNlFWAVCrv+o329CqwGr9A/4k7+0rFDSBr7zvPMoHJkwPCY9Nyf4+cgTb4/w=",
            "TIkW5K8a1PypcWAcfcWfpYC7909r/btcXNAqM7421ks=",
        ),
    ),
    # vanity/0x63263
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x632635b52cca6102fe1e0385f5e3fbb79f7c0e0a",
            "0xf3d358629fc05c36f8e2e8b22f31f444cf7fffaa304fc6c64c39d4b0a43075282a0462268c5610a73e3ecba8c8aec705efb21e8f23cad70f77fe57de7d0e4b1b",
            "9c57762f764f4d9567cdb90c1b341c7bc141db1e15f620939af5f775049a30cd",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x632635b52cca6102fe1e0385f5e3fbb79f7c0e0a",
            "BPPTWGKfwFw2+OLosi8x9ETPf/+qME/Gxkw51LCkMHUoKgRiJoxWEKc+PsuoyK7HBe+yHo8jytcPd/5X3n0OSxs=",
            "nFd2L3ZPTZVnzbkMGzQce8FB2x4V9iCTmvX3dQSaMM0=",
        ),
    ),
    # vanity/0x63363
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x63363eb4a6935f4b1eca58079171529cc714f91d",
            "0x932ed69baa320d5a600fc730564a4aba84572345ca9e810d3412a20e5f15d1262068b95e0f3ad1a7ea0573ba04f8385a905afa52cc014a3f2f17af7c86a08c40",
            "46008ae18eb97f109626f5ec5717d887698cd1795ca050f38b90046f244d614d",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x63363eb4a6935f4b1eca58079171529cc714f91d",
            "BJMu1puqMg1aYA/HMFZKSrqEVyNFyp6BDTQSog5fFdEmIGi5Xg860afqBXO6BPg4WpBa+lLMAUo/LxevfIagjEA=",
            "RgCK4Y65fxCWJvXsVxfYh2mM0XlcoFDzi5AEbyRNYU0=",
        ),
    ),
    # vanity/0x63463
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x634632b6f6381b28ff7f5cbdf2e19e82e97b0e7d",
            "0xcfb9819655ff288a06217fed1c9e43544bd752d76ba58840969cd6f7e7f7a4e8b0d4504c53f0b6f34b6728a3cf1e13aa5995d1188ba9ddf75969b8b4bb3e23d0",
            "2793e6b9ce52954df7a050f64a65fde5b2a5ccaf39f7cbdfe96b1874eb92d8a7",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x634632b6f6381b28ff7f5cbdf2e19e82e97b0e7d",
            "BM+5gZZV/yiKBiF/7RyeQ1RL11LXa6WIQJac1vfn96TosNRQTFPwtvNLZyijzx4TqlmV0RiLqd33WWm4tLs+I9A=",
            "J5Pmuc5SlU33oFD2SmX95bKlzK8598vf6WsYdOuS2Kc=",
        ),
    ),
    # vanity/0x63563
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x63563c7215c1cdb5e5237d061ebdaa34bbb457c9",
            "0x7f54ad7dcd9fcfdf1ab0319ec1aa92d718305c81f21c45952dcd4885d613709537f8321fbb41438bc978c8bda54ab592cf4c4fc7646a8969f07f73da523dee30",
            "0fad00aadae3c28d7794156eb05e96501f9c894b2a1d15c566dde350325c5684",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x63563c7215c1cdb5e5237d061ebdaa34bbb457c9",
            "BH9UrX3Nn8/fGrAxnsGqktcYMFyB8hxFlS3NSIXWE3CVN/gyH7tBQ4vJeMi9pUq1ks9MT8dkaolp8H9z2lI97jA=",
            "D60Aqtrjwo13lBVusF6WUB+ciUsqHRXFZt3jUDJcVoQ=",
        ),
    ),
    # vanity/0x63663
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x63663dfc4994589b3720283d8eae84546782a37c",
            "0xe19c5d6ddc4487b2250b243d180ba9edf7b5a98551f18e85bb28c2b1b6830eb381305dc288f5554c684ab51c617a9f013c798cf0c75aeaf8855cc507ea981f03",
            "666d1ef34915335c1b36bcaa3854115c44cd1abd919575d9404fd65b98cac569",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x63663dfc4994589b3720283d8eae84546782a37c",
            "BOGcXW3cRIeyJQskPRgLqe33tamFUfGOhbsowrG2gw6zgTBdwoj1VUxoSrUcYXqfATx5jPDHWur4hVzFB+qYHwM=",
            "Zm0e80kVM1wbNryqOFQRXETNGr2RlXXZQE/WW5jKxWk=",
        ),
    ),
    # vanity/0x63763
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x63763e3fe462a9f5dff82be1982d90a31a9fd90c",
            "0x1c520af989fe2da522ebca8fc83ba425e2bde6c84ecd2a0cea962bb1fc8107ba5b8435cdd1069ea2db30721e3b7c94aa1a943ec790fdaf9df757c09ea7f9ae8d",
            "82649c38e4b71485f44ccb4266e1f3a5882bcd34749fa819423412e2afc85ae1",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x63763e3fe462a9f5dff82be1982d90a31a9fd90c",
            "BBxSCvmJ/i2lIuvKj8g7pCXivebITs0qDOqWK7H8gQe6W4Q1zdEGnqLbMHIeO3yUqhqUPseQ/a+d91fAnqf5ro0=",
            "gmScOOS3FIX0TMtCZuHzpYgrzTR0n6gZQjQS4q/IWuE=",
        ),
    ),
    # vanity/0x63863
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x63863826ee7615d44e1eb96a1c25abd1df3b81ee",
            "0x5d3a1115ff60fcb962646ec70b24092fe48965a18583df8246080c1500271d135ffe44f0c32f7ba583882bfe16bfab07db936eb6ee04735ed4d1827a8c43b171",
            "e15adc9b7b80e5dc085f136b07ee18260fdc95dabbb3fb473600b41312228cb4",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x63863826ee7615d44e1eb96a1c25abd1df3b81ee",
            "BF06ERX/YPy5YmRuxwskCS/kiWWhhYPfgkYIDBUAJx0TX/5E8MMve6WDiCv+Fr+rB9uTbrbuBHNe1NGCeoxDsXE=",
            "4Vrcm3uA5dwIXxNrB+4YJg/cldq7s/tHNgC0ExIijLQ=",
        ),
    ),
    # vanity/0x63963
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x63963748cc664167c21003cedce9cae0097ee6aa",
            "0xbdd0cc222249d720c40289163cab2c6ebc2e75af994892427571507ae27c0b31ab36d170d91c66a41ca8f2ab10a37b4a181ba34a0be79c1276bf63c6c2dcce25",
            "924f97cfbdf658526bb4c05455b0bfccec9688f2749c71c9929d0a80fbb07b1c",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x63963748cc664167c21003cedce9cae0097ee6aa",
            "BL3QzCIiSdcgxAKJFjyrLG68LnWvmUiSQnVxUHrifAsxqzbRcNkcZqQcqPKrEKN7Shgbo0oL55wSdr9jxsLcziU=",
            "kk+Xz732WFJrtMBUVbC/zOyWiPJ0nHHJkp0KgPuwexw=",
        ),
    ),
    # vanity/0x64064
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x64064a0822d0a0bb0ad4ccc087455e3f4d0171ea",
            "0x5cf46622b8cac394815a765ac88f03ba6a7536eedc37f3e2d4f054fbe8e605a6eb32f1a8e2bcccfa9928bf1cb2b939e85092afb97601a7e8c5ea92703b9652a4",
            "4865dd8c42c3560e21ebe8b1936cd996f8635c03a87a7852b6306588dadb3c24",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x64064a0822d0a0bb0ad4ccc087455e3f4d0171ea",
            "BFz0ZiK4ysOUgVp2WsiPA7pqdTbu3Dfz4tTwVPvo5gWm6zLxqOK8zPqZKL8csrk56FCSr7l2AafoxeqScDuWUqQ=",
            "SGXdjELDVg4h6+ixk2zZlvhjXAOoenhStjBliNrbPCQ=",
        ),
    ),
    # vanity/0x64164
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x64164c40ae95eb426227a88d6c4423a28dc53c96",
            "0xd8d0a6037f9f2aa9036f8cdd3536203b8acb2af8dddaf8e40b921664298725901bf90a56c9217686832396feb5e10f790c49c20fbd280c4479b78a9ea3c5b7b6",
            "eadddd4f1341e890bab9d5dff8f203fc14c219bde124d216c341e9a8100c99e8",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x64164c40ae95eb426227a88d6c4423a28dc53c96",
            "BNjQpgN/nyqpA2+M3TU2IDuKyyr43dr45AuSFmQphyWQG/kKVskhdoaDI5b+teEPeQxJwg+9KAxEebeKnqPFt7Y=",
            "6t3dTxNB6JC6udXf+PID/BTCGb3hJNIWw0HpqBAMmeg=",
        ),
    ),
    # vanity/0x64264
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x6426428f7accf97b2a764a5ec57a21c18d05efd2",
            "0x0ac46fad9073a152d5d55603a61dc4272b0f9b97b807f5a4070baed8031ae1cdd5962d4ca86014ff875767ae5061a773569aaa3d60f45c89f8831578c99ae7fe",
            "dca5869606a26c21d2bf07c4c9ef46612147b39d0eddd6e28ddb420cf9b4e1ef",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x6426428f7accf97b2a764a5ec57a21c18d05efd2",
            "BArEb62Qc6FS1dVWA6YdxCcrD5uXuAf1pAcLrtgDGuHN1ZYtTKhgFP+HV2euUGGnc1aaqj1g9FyJ+IMVeMma5/4=",
            "3KWGlgaibCHSvwfEye9GYSFHs50O3dbijdtCDPm04e8=",
        ),
    ),
    # vanity/0x64364
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x643647d05cd0f3968be0650fa0dc08fd6f3dd0cb",
            "0x9bdeae831d37b9686daf68ce4adc9e25ca3be5b274e5384583f018041469df37038e55a87ed3490ce4a1f73aa410e64b41f375d8905a8b994df8427649b1d20f",
            "96d3848fd5a0e4ac4c303e5d51f686a6b4a4c8ab4a88f60ae4dd00eaac2235ab",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x643647d05cd0f3968be0650fa0dc08fd6f3dd0cb",
            "BJveroMdN7loba9ozkrcniXKO+WydOU4RYPwGAQUad83A45VqH7TSQzkofc6pBDmS0HzddiQWouZTfhCdkmx0g8=",
            "ltOEj9Wg5KxMMD5dUfaGprSkyKtKiPYK5N0A6qwiNas=",
        ),
    ),
    # vanity/0x64464
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x644645b1bc886b9e22fe80d2c17fd6fba06a7957",
            "0xc60e594e34a265d85cf340825daafbe22d162e06a5c483cef276a87ab392efca2e44bba5cad6b91ffa9d1d3f78a9a4e3a8cb2814f88756e50da2118566697a8f",
            "9f91aab47a0318f08c24543a22eeabe861399df7a37d7f0a67d1e2b40f17c801",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x644645b1bc886b9e22fe80d2c17fd6fba06a7957",
            "BMYOWU40omXYXPNAgl2q++ItFi4GpcSDzvJ2qHqzku/KLkS7pcrWuR/6nR0/eKmk46jLKBT4h1blDaIRhWZpeo8=",
            "n5GqtHoDGPCMJFQ6Iu6r6GE5nfejfX8KZ9HitA8XyAE=",
        ),
    ),
    # vanity/0x64564
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x6456483b5a1662f3ea845d9b1a31d28b4f9dc97e",
            "0x9d18205b204bde3e4b683bbcd183ce0ec049336cbb467eecf385b05f05efdfc970ed50856fc494097cbff00581b2bed916b86c1e90607496598076a02865f748",
            "1bebf309301e3a4bbd700223a9a45667577c0ee3a5f0730fb7db3a957a335d31",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x6456483b5a1662f3ea845d9b1a31d28b4f9dc97e",
            "BJ0YIFsgS94+S2g7vNGDzg7ASTNsu0Z+7POFsF8F79/JcO1QhW/ElAl8v/AFgbK+2Ra4bB6QYHSWWYB2oChl90g=",
            "G+vzCTAeOku9cAIjqaRWZ1d8DuOl8HMPt9s6lXozXTE=",
        ),
    ),
    # vanity/0x64664
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x646644cdd2b5cd6aeb066f87a481317b6f538113",
            "0xb5bddcae026955cadff8eb7fe2d31a48acab73ddb193f25d7decafd962c214a20f77bd1c6e5519b767dbc4634d10815d215084b5e2f5d277d870cb186b40509a",
            "124029f464e397d0bb1794e38d78ad1c519e13e799d30094dc6bc14a100a226a",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x646644cdd2b5cd6aeb066f87a481317b6f538113",
            "BLW93K4CaVXK3/jrf+LTGkisq3PdsZPyXX3sr9liwhSiD3e9HG5VGbdn28RjTRCBXSFQhLXi9dJ32HDLGGtAUJo=",
            "EkAp9GTjl9C7F5TjjXitHFGeE+eZ0wCU3GvBShAKImo=",
        ),
    ),
    # vanity/0x64764
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x64764ed5f316f0af7ca43fb79e81bd35b7160622",
            "0x9269d0d0dda2a2b2aceabdc29be5092e7d5fc28c8e36632154696474789c21d4d9612c32b2fb647e94a56b3a5239e3dab570e82e5eecb0817b2074f5ccb7f871",
            "d1eca9b67c8672aff5a85927e7f48142cec311932a246c8a6e68c3a708c1edd8",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x64764ed5f316f0af7ca43fb79e81bd35b7160622",
            "BJJp0NDdoqKyrOq9wpvlCS59X8KMjjZjIVRpZHR4nCHU2WEsMrL7ZH6UpWs6Ujnj2rVw6C5e7LCBeyB09cy3+HE=",
            "0eyptnyGcq/1qFkn5/SBQs7DEZMqJGyKbmjDpwjB7dg=",
        ),
    ),
    # vanity/0x64864
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x64864351204d0b1ca74ef7bf0a0e57228d4538d8",
            "0x781e5d925305de2ef4b90e086020e9d83afb261ea24e67047b8d3afb176da712bbe258fc34004a15312d1e21b449fcc9b1dd9c21661d50be0da5418de1e394f5",
            "55ca7a6c665f989cafe8de1b3a1213068d3496b358eabe80066a0e2711a6592b",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x64864351204d0b1ca74ef7bf0a0e57228d4538d8",
            "BHgeXZJTBd4u9LkOCGAg6dg6+yYeok5nBHuNOvsXbacSu+JY/DQAShUxLR4htEn8ybHdnCFmHVC+DaVBjeHjlPU=",
            "Vcp6bGZfmJyv6N4bOhITBo00lrNY6r6ABmoOJxGmWSs=",
        ),
    ),
    # vanity/0x64964
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x64964b9a1f67568e83c55cf109814cb140a16978",
            "0x64ef45d963eff3fc91c71380db9c99224b30877f7ff3f297d4bccdb061819624bff46c4e647dbd6ec7a6b89df1d298d793f8168716dafc57937e775f8d7f3ff5",
            "f3cefefb4b6bdb5d0bf98b74f8478ae9df0e852895b258d486af6921548469d7",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x64964b9a1f67568e83c55cf109814cb140a16978",
            "BGTvRdlj7/P8kccTgNucmSJLMId/f/Pyl9S8zbBhgZYkv/RsTmR9vW7Hprid8dKY15P4FocW2vxXk353X41/P/U=",
            "887++0tr210L+Yt0+EeK6d8OhSiVsljUhq9pIVSEadc=",
        ),
    ),
    # vanity/0x65065
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x650658d519c15869976a96a54a9cac66455be8cc",
            "0x4ee1626150c82d59150760c310bd5e7660b47b291b96859001d5aac361377315093cfcfe34354399dbfebee7fce9b0544e025744974d57d192e828e016ae6f7b",
            "e8b3b8caee9703038960b3962b94186974a7e3705cbe8f1c2e9bf8f635818668",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x650658d519c15869976a96a54a9cac66455be8cc",
            "BE7hYmFQyC1ZFQdgwxC9XnZgtHspG5aFkAHVqsNhN3MVCTz8/jQ1Q5nb/r7n/OmwVE4CV0SXTVfRkugo4Baub3s=",
            "6LO4yu6XAwOJYLOWK5QYaXSn43Bcvo8cLpv49jWBhmg=",
        ),
    ),
    # vanity/0x65165
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x651656b877841af7c62065a88bf4a73567228ab7",
            "0x0b22d59bef36923c872ab093b3a1a34917b52e7cf2dcf2f46fd2e69b06c8d97f000bab7be200f9229c2a6385bdc5cd68c7ccc942cd961a8c3e4e6fcc4ffc780a",
            "40068dbfb349e4b0d0c295f915a97ac38ba38eed40ea080660e4145c1da7d474",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x651656b877841af7c62065a88bf4a73567228ab7",
            "BAsi1ZvvNpI8hyqwk7Oho0kXtS588tzy9G/S5psGyNl/AAure+IA+SKcKmOFvcXNaMfMyULNlhqMPk5vzE/8eAo=",
            "QAaNv7NJ5LDQwpX5Fal6w4ujju1A6ggGYOQUXB2n1HQ=",
        ),
    ),
    # vanity/0x65265
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x652657ae69331c163a0233a13b62a9bc739a840f",
            "0xde70d6ad129752d5ebd8c4b9a7e7a729c251d127e4c7702b75c39e1a6256b0d277db4dcb8508ae299a7b58578ff478db4fcfd2b0f03d7bb279c47cb14f8b5f4a",
            "d2328a088a5cf63e3d0886fce0cc497d0136c8bbc25bdd8b9838497eff47aff5",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x652657ae69331c163a0233a13b62a9bc739a840f",
            "BN5w1q0Sl1LV69jEuafnpynCUdEn5MdwK3XDnhpiVrDSd9tNy4UIrimae1hXj/R420/P0rDwPXuyecR8sU+LX0o=",
            "0jKKCIpc9j49CIb84MxJfQE2yLvCW92LmDhJfv9Hr/U=",
        ),
    ),
    # vanity/0x65365
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x653656d013fefc71ee3d098cd05cd49d73ac3f22",
            "0x7d67215e18057d6448dd0ba82f94343ebe51535ed9a2c712a7db5da921067a4db8db3741942ce1cfd0dce3c5a4c01f70420ea480441ae3673bcf235ca839d61b",
            "ea1d741410c04fb225a68a079fc13f7cd3bed5cad8d994fdd09b77ee33fef023",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x653656d013fefc71ee3d098cd05cd49d73ac3f22",
            "BH1nIV4YBX1kSN0LqC+UND6+UVNe2aLHEqfbXakhBnpNuNs3QZQs4c/Q3OPFpMAfcEIOpIBEGuNnO88jXKg51hs=",
            "6h10FBDAT7IlpooHn8E/fNO+1crY2ZT90Jt37jP+8CM=",
        ),
    ),
    # vanity/0x65465
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x65465247cf272adbea54e3c71d0e979357f54c33",
            "0x7fce2c8bce7b38d48e594b6adb39234bb7bf51e53c441c5b31097e66ad0bf2bebb6b89f245f6b8ade258e66cc002b1c3f138afb67001ba9defbf5ddd1d0347f8",
            "4522c1a06e3e00c240f2d3a83c1ace16cfc1bb38bbb19d9c7f24bbc57fc9495d",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x65465247cf272adbea54e3c71d0e979357f54c33",
            "BH/OLIvOezjUjllLats5I0u3v1HlPEQcWzEJfmatC/K+u2uJ8kX2uK3iWOZswAKxw/E4r7ZwAbqd779d3R0DR/g=",
            "RSLBoG4+AMJA8tOoPBrOFs/Buzi7sZ2cfyS7xX/JSV0=",
        ),
    ),
    # vanity/0x65565
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x655652189877732f54396693f7830b9536b8cafa",
            "0x7d5075c03db6d91aa4353f051f4b3334aab51046bdaf404a3897252641053f0d499d82ef9d2427307eb7daddcb8602ed8ab1a71613a479d649240209766f0314",
            "bcf3b7b036f44c3925d6e161628850f8b5931c5d3d1e75e36752a198987ef0c0",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x655652189877732f54396693f7830b9536b8cafa",
            "BH1QdcA9ttkapDU/BR9LMzSqtRBGva9ASjiXJSZBBT8NSZ2C750kJzB+t9rdy4YC7YqxpxYTpHnWSSQCCXZvAxQ=",
            "vPO3sDb0TDkl1uFhYohQ+LWTHF09HnXjZ1KhmJh+8MA=",
        ),
    ),
    # vanity/0x65665
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x656659c269fa5b882b0b519f8ecddde35795c31b",
            "0x9ca9bd85cf16a26bea6f05bad6ef75bacc78276b682bcf2d59a37c11551880a7facbfb1332ce918f17b9e5d350ed5d39a1307da7e6f3e887dc93ebeeb37ec1c7",
            "875be092c9af9cd4c5ed00dcb0f4e461cc1500a3566015981e0ff1972db5eb33",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x656659c269fa5b882b0b519f8ecddde35795c31b",
            "BJypvYXPFqJr6m8FutbvdbrMeCdraCvPLVmjfBFVGICn+sv7EzLOkY8XueXTUO1dOaEwfafm8+iH3JPr7rN+wcc=",
            "h1vgksmvnNTF7QDcsPTkYcwVAKNWYBWYHg/xly216zM=",
        ),
    ),
    # vanity/0x65765
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x6576500c14d0eb67db6554c8c797137817ded2ab",
            "0xb2f5458d8903ef80f4d1a34c1ca1d0263f72136ce67d3e8dfcd3c4590a8a7db7674029d6b580ef92a9d13f4649f1090678eea095d9e17a6f40eacbc15a039397",
            "223796ee90e996e4fbb82a75db2350eab81b099f63b6641dbf3c601a7b797985",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x6576500c14d0eb67db6554c8c797137817ded2ab",
            "BLL1RY2JA++A9NGjTByh0CY/chNs5n0+jfzTxFkKin23Z0Ap1rWA75Kp0T9GSfEJBnjuoJXZ4XpvQOrLwVoDk5c=",
            "IjeW7pDpluT7uCp12yNQ6rgbCZ9jtmQdvzxgGnt5eYU=",
        ),
    ),
    # vanity/0x65865
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x658656638bff195731958c229ecb72f79a069b1a",
            "0xa1345e86834ff987b32e989a3e4a3059008fd93fa2ef15b0ff0399dfa7883855eb6dc30b821e12240917f9e5179baa492472ed32627701edf503bd64364fbdff",
            "c4349c14e5f8e60f1bd0b997e64ba1af7146aef6ef7ed51a652314aac4b74aee",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x658656638bff195731958c229ecb72f79a069b1a",
            "BKE0XoaDT/mHsy6Ymj5KMFkAj9k/ou8VsP8Dmd+niDhV623DC4IeEiQJF/nlF5uqSSRy7TJidwHt9QO9ZDZPvf8=",
            "xDScFOX45g8b0LmX5kuhr3FGrvbvftUaZSMUqsS3Su4=",
        ),
    ),
    # vanity/0x65965
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x659653bd4901d34a57f19615711f06167f1f7e7e",
            "0xf2832f86cc67582d912fa4ff4f4c8ea0e34dc944a42349434dcdc71357cf0d0c636c6a53325bf508bad2ad4c953e698aa6b395d4c9f13d14cd348d791f7c16fc",
            "d6a5a157333f1913fa7cdf5611dea726296d10113b99d7cb75a76299f768c93f",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x659653bd4901d34a57f19615711f06167f1f7e7e",
            "BPKDL4bMZ1gtkS+k/09MjqDjTclEpCNJQ03NxxNXzw0MY2xqUzJb9Qi60q1MlT5piqazldTJ8T0UzTSNeR98Fvw=",
            "1qWhVzM/GRP6fN9WEd6nJiltEBE7mdfLdadimfdoyT8=",
        ),
    ),
    # vanity/0x66066
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x6606670813f56d7f69573356b150fe13db81edd8",
            "0x5412379daabe35e03ae2fd31edb31501358d8557ee688e40d5bb6c5d5cb699164b2851ac602b1dde583f0e9443a03c8d998b8901efcf03f14784a72cb046c90b",
            "a084f45d6f5e4add848281edbd110f5d6183099968b8048c61824967ad1c148b",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x6606670813f56d7f69573356b150fe13db81edd8",
            "BFQSN52qvjXgOuL9Me2zFQE1jYVX7miOQNW7bF1ctpkWSyhRrGArHd5YPw6UQ6A8jZmLiQHvzwPxR4SnLLBGyQs=",
            "oIT0XW9eSt2EgoHtvREPXWGDCZlouASMYYJJZ60cFIs=",
        ),
    ),
    # vanity/0x66166
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x66166eaedc18cee1aff7f9e214b082d03220c976",
            "0x49af416d6e2be99959fb2c4c71e9b894e7ccb4f3df33fe7ee010b4eb3e427fc8d79764d2e98ee1f6b28e5fb9857114d915be8f5f2e783976d8de046ab56265fe",
            "8481344900e68961a9a7c062fe9f218d24bb0509f0ce125c634607d72c04f228",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x66166eaedc18cee1aff7f9e214b082d03220c976",
            "BEmvQW1uK+mZWfssTHHpuJTnzLTz3zP+fuAQtOs+Qn/I15dk0umO4fayjl+5hXEU2RW+j18ueDl22N4EarViZf4=",
            "hIE0SQDmiWGpp8Bi/p8hjSS7BQnwzhJcY0YH1ywE8ig=",
        ),
    ),
    # vanity/0x66266
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x66266fd58559ba14cf9427ec8663ea3c4290b81e",
            "0xb57abaa3a78d47a9388fc24f584fb01c911d842d5a9a9ae018910c8d962d1db059d6376eac18aedd9c0171bfedf541c3bc52bf184bebd258398fd61025c706cf",
            "d6e751e7d120253be1e56daee92ae7fb20ddc701501c59dc5615730c113d1ddc",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x66266fd58559ba14cf9427ec8663ea3c4290b81e",
            "BLV6uqOnjUepOI/CT1hPsByRHYQtWpqa4BiRDI2WLR2wWdY3bqwYrt2cAXG/7fVBw7xSvxhL69JYOY/WECXHBs8=",
            "1udR59EgJTvh5W2u6Srn+yDdxwFQHFncVhVzDBE9Hdw=",
        ),
    ),
    # vanity/0x66366
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x6636685992e1d1b32b3cec90ffdb878f608f35f4",
            "0x95deafa4561bd150a576a1db393094d6b66e184dc82017f1987418d8a2adc4ca2aa1112356aa0e7041b95e5c53dc83120cd9460719c93566935f0f3a2f980e12",
            "e8df02aa11bf70f8d38088c9ad8f1b3c0d64dc628c9d9c2c82154940e76476a9",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x6636685992e1d1b32b3cec90ffdb878f608f35f4",
            "BJXer6RWG9FQpXah2zkwlNa2bhhNyCAX8Zh0GNiircTKKqERI1aqDnBBuV5cU9yDEgzZRgcZyTVmk18POi+YDhI=",
            "6N8CqhG/cPjTgIjJrY8bPA1k3GKMnZwsghVJQOdkdqk=",
        ),
    ),
    # vanity/0x66466
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x664662ca9b631c67657a83b32650fd7ea8ce5442",
            "0x18f5ab4bcdf2aca0b058659e252e4a0e06a3ce3f1a786a952693b8c98dd7f780c4747dbc914e0775886f8cb4ab34044120067c8330c92b1ecf8ebb624cdf27e4",
            "58f864be8f29f9e3dc8c05ae3d64560ba09b20f61421f35e2ce6b60fd5588762",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x664662ca9b631c67657a83b32650fd7ea8ce5442",
            "BBj1q0vN8qygsFhlniUuSg4Go84/GnhqlSaTuMmN1/eAxHR9vJFOB3WIb4y0qzQEQSAGfIMwySsez467YkzfJ+Q=",
            "WPhkvo8p+ePcjAWuPWRWC6CbIPYUIfNeLOa2D9VYh2I=",
        ),
    ),
    # vanity/0x66566
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x66566121ef21503e7b43bafb2f4d833e57df3561",
            "0xb16fdb27b91ff9af8adb415dafbd7e9031e3dc8f211cf4f1fcc5ae9078592021e9f41a7611d1546f76ae2ea84becd650bd58d5d35153e81cb36ee97b58a00716",
            "698dca371f11f9a28889e35a27d203c4bcdd2f57fb87fe94df808bbae358843b",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x66566121ef21503e7b43bafb2f4d833e57df3561",
            "BLFv2ye5H/mvittBXa+9fpAx49yPIRz08fzFrpB4WSAh6fQadhHRVG92ri6oS+zWUL1Y1dNRU+gcs27pe1igBxY=",
            "aY3KNx8R+aKIieNaJ9IDxLzdL1f7h/6U34CLuuNYhDs=",
        ),
    ),
    # vanity/0x66666
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x666662c731da04ebb0dece3742d500bca6303734",
            "0x938e9e98a8dc33ce68e8fd94f64e574a30eee1b64f940122806e87f2ec94190e449dbef6bc4a146d61607bac6ecd556da53ed7c30344a34b33cea65e6b5ec9c6",
            "82d83979c5556553e3034654f58912370e8cecfdd4a7d1edd0e2e27be95f25cd",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x666662c731da04ebb0dece3742d500bca6303734",
            "BJOOnpio3DPOaOj9lPZOV0ow7uG2T5QBIoBuh/LslBkORJ2+9rxKFG1hYHusbs1VbaU+18MDRKNLM86mXmteycY=",
            "gtg5ecVVZVPjA0ZU9YkSNw6M7P3Up9Ht0OLie+lfJc0=",
        ),
    ),
    # vanity/0x66766
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x66766aa7731cc96e7710dc3b37f273956486f820",
            "0x6144c7c83674736bcde510c7a70074fa7169ecfeab98a6a7c405a1c8ed830169f64ff761a08a05cf3fdba6063964ba98ff938ec86034b629930fee01cbd871a6",
            "8e2b05d8191d955f1940c7343dfec266c5d052c92bff99bfc822f966f9a7fadd",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x66766aa7731cc96e7710dc3b37f273956486f820",
            "BGFEx8g2dHNrzeUQx6cAdPpxaez+q5imp8QFocjtgwFp9k/3YaCKBc8/26YGOWS6mP+TjshgNLYpkw/uAcvYcaY=",
            "jisF2BkdlV8ZQMc0Pf7CZsXQUskr/5m/yCL5Zvmn+t0=",
        ),
    ),
    # vanity/0x66866
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x6686692d0c77f57d0271c685ef40b86ba3bf73e8",
            "0x8e34510a456dba5b00e6f907ff877c7c2afbc87d8d29517ca3ac247778d02014f4f7896d88b781bb10efe2f3dfb2d582717cef3008202acbd6afdeb9377c8775",
            "6815bf6095d6a96fadb3c1e40657d15df3de2e51d3450e6c9eee4c338c08d19f",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x6686692d0c77f57d0271c685ef40b86ba3bf73e8",
            "BI40UQpFbbpbAOb5B/+HfHwq+8h9jSlRfKOsJHd40CAU9PeJbYi3gbsQ7+Lz37LVgnF87zAIICrL1q/euTd8h3U=",
            "aBW/YJXWqW+ts8HkBlfRXfPeLlHTRQ5snu5MM4wI0Z8=",
        ),
    ),
    # vanity/0x66966
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x6696645639f071b369279599fd56e96e772d84bb",
            "0x536ca13df168dcc03ff0406e44b8905526ba8d7d3b8c6d0d4d3d571c6c003aa9646282f4cca5d2bd48ae96630a45e3744b17a3e211a05b8a022f4a695ee12bc8",
            "73fea7d3bec8083393ea629b49f05e4db08c9d81d1df43b07cd3dbbec45b064c",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x6696645639f071b369279599fd56e96e772d84bb",
            "BFNsoT3xaNzAP/BAbkS4kFUmuo19O4xtDU09VxxsADqpZGKC9Myl0r1IrpZjCkXjdEsXo+IRoFuKAi9KaV7hK8g=",
            "c/6n077ICDOT6mKbSfBeTbCMnYHR30OwfNPbvsRbBkw=",
        ),
    ),
    # vanity/0x67067
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x67067b2086ed2191d02151062565609eb3d25406",
            "0xb19e09100e6441c5b81f41804c59a1cac3b82c0390f93a05c76dda8d3669e63343cc47dd09ca22d224a954cb6c40647887ba2477846655a2a1fc5fd9f47478b2",
            "8bdeaeb2362bdb04aacedf65b7a771a6c14bb45773263ec6fce409f3565d0bc9",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x67067b2086ed2191d02151062565609eb3d25406",
            "BLGeCRAOZEHFuB9BgExZocrDuCwDkPk6Bcdt2o02aeYzQ8xH3QnKItIkqVTLbEBkeIe6JHeEZlWiofxf2fR0eLI=",
            "i96usjYr2wSqzt9lt6dxpsFLtFdzJj7G/OQJ81ZdC8k=",
        ),
    ),
    # vanity/0x67167
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x67167dbd1529b6d8af007e2db55c863f6d831006",
            "0x3d0127a6b0ecc2f6f7355a1b9f8ef4838fea910b48bf3a4175d81293299ca4f01a70186e2970401e4221240888e8269c24d2ecc8eb121108cd92153572fcc039",
            "b4d4bcae9a84077926346662faed7b1df0a8e0b8b792e33ffd1054e5b73be9f5",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x67167dbd1529b6d8af007e2db55c863f6d831006",
            "BD0BJ6aw7ML29zVaG5+O9IOP6pELSL86QXXYEpMpnKTwGnAYbilwQB5CISQIiOgmnCTS7MjrEhEIzZIVNXL8wDk=",
            "tNS8rpqEB3kmNGZi+u17HfCo4Li3kuM//RBU5bc76fU=",
        ),
    ),
    # vanity/0x67267
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x672671af6afab15624a649e409f800d26c35942e",
            "0x7f97f5a48b427ea481a5128ce7281983311c453af050c63600ce5315c811b3a0ba19ff89d3241d00266ae3c7324af1bdcd452236fdbef2c575a50ca346c77c23",
            "a967b757e3cb9bc612b7076569f4cce6887ec07fb2b4ed418de721c832f72e56",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x672671af6afab15624a649e409f800d26c35942e",
            "BH+X9aSLQn6kgaUSjOcoGYMxHEU68FDGNgDOUxXIEbOguhn/idMkHQAmauPHMkrxvc1FIjb9vvLFdaUMo0bHfCM=",
            "qWe3V+PLm8YStwdlafTM5oh+wH+ytO1BjechyDL3LlY=",
        ),
    ),
    # vanity/0x67367
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x67367aa021a4e655159990ce0f2c4957dbd4260e",
            "0x66dfb3273bd180ec3b0e1aadf4b4f2c8b18b593bdbd4c10d0d7c6798d5de2ae758d0e501dacddc97ade4ea04842d6ef035c6596e0bfcb08b22e9eab448ed95bf",
            "1904c21ed2c1e95632505f1fb8729c75217ed759cecd511366a88ca0fd1328fa",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x67367aa021a4e655159990ce0f2c4957dbd4260e",
            "BGbfsyc70YDsOw4arfS08sixi1k729TBDQ18Z5jV3irnWNDlAdrN3Jet5OoEhC1u8DXGWW4L/LCLIunqtEjtlb8=",
            "GQTCHtLB6VYyUF8fuHKcdSF+11nOzVETZqiMoP0TKPo=",
        ),
    ),
    # vanity/0x67467
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x67467db898555590d5927ec55101d9432934bed3",
            "0xf6a2f61eae5f180653b8e8b7ad49c5ee635ed2f6b81e09811aae1a6e1137a87e60752c1ce64161a18766b3f9ce27ed182a7089da9e08b0dda756458dec0ce071",
            "5ca71a78759d7da0e4982b56195564ec05512090a8c2898b200d53f6ad758741",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x67467db898555590d5927ec55101d9432934bed3",
            "BPai9h6uXxgGU7jot61Jxe5jXtL2uB4JgRquGm4RN6h+YHUsHOZBYaGHZrP5ziftGCpwidqeCLDdp1ZFjewM4HE=",
            "XKcaeHWdfaDkmCtWGVVk7AVRIJCowomLIA1T9q11h0E=",
        ),
    ),
    # vanity/0x67567
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x67567a28a29be567a037aeed7619159b64d3c24e",
            "0xd2cb74dbf9b93a66a66557c9b56de59e4cb76021510fa4df2f025762a33a8536339235fccd1eb66375333d9ff268ba26d3ccf4d651f926b445e5c70d8ec9db48",
            "882fd88a9c84dedd5cfa6449a76c05f736e3eadf6b1ab1429ffbb640d8f66579",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x67567a28a29be567a037aeed7619159b64d3c24e",
            "BNLLdNv5uTpmpmVXybVt5Z5Mt2AhUQ+k3y8CV2KjOoU2M5I1/M0etmN1Mz2f8mi6JtPM9NZR+Sa0ReXHDY7J20g=",
            "iC/YipyE3t1c+mRJp2wF9zbj6t9rGrFCn/u2QNj2ZXk=",
        ),
    ),
    # vanity/0x67667
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x676673034778e6329eb9c0c60ccf5777c78b00e7",
            "0xdff7327f37f362e45eebefae154e3bf4200f1cedb3760c175c8e608158e99356144fd2f027482d170e7a1fca5e762f1aaf5892c95ecbce81881931676dc2ec7b",
            "8f8fdc86abee81886b14adc2eb8f391ebfba72b6dffe12edd8135cd2e091aa50",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x676673034778e6329eb9c0c60ccf5777c78b00e7",
            "BN/3Mn8382LkXuvvrhVOO/QgDxzts3YMF1yOYIFY6ZNWFE/S8CdILRcOeh/KXnYvGq9Yksley86BiBkxZ23C7Hs=",
            "j4/chqvugYhrFK3C6485Hr+6crbf/hLt2BNc0uCRqlA=",
        ),
    ),
    # vanity/0x67767
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x6776789e8c147732d6ea6f9500577f50a169965d",
            "0x3c79e126c9bccea5f053a7271cf49e354209202b48fc1a2186bb3575f8a270e4d7a4d2e65a6b7ed1be24a71c35f7ffa818d0a3a6f8af3e5185a568e1999077a5",
            "6ec33fbeb46cfb480b274272942da57be919375d6166f88c9d3f4adef7a37fc1",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x6776789e8c147732d6ea6f9500577f50a169965d",
            "BDx54SbJvM6l8FOnJxz0njVCCSArSPwaIYa7NXX4onDk16TS5lprftG+JKccNff/qBjQo6b4rz5RhaVo4ZmQd6U=",
            "bsM/vrRs+0gLJ0JylC2le+kZN11hZviMnT9K3vejf8E=",
        ),
    ),
    # vanity/0x67867
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x67867b48424a04c7ab53f165e9348c814f57aee0",
            "0x92d3a30f582af19bafc9a75dc299a6308dad32248e5c4ab4d8dec774b358cf44f4ac23685ff8cac4c306fea88f25ba5c14ca068a677cfe1a6373e4bee29921fc",
            "3a993050e2840fba1490ffd8ba21932663f0d41d6272ec5e9f9add0280dc4455",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x67867b48424a04c7ab53f165e9348c814f57aee0",
            "BJLTow9YKvGbr8mnXcKZpjCNrTIkjlxKtNjex3SzWM9E9KwjaF/4ysTDBv6ojyW6XBTKBopnfP4aY3PkvuKZIfw=",
            "OpkwUOKED7oUkP/YuiGTJmPw1B1icuxen5rdAoDcRFU=",
        ),
    ),
    # vanity/0x67967
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x67967741f10ff7332121d7325739c543e6195f78",
            "0x15218751d3ef73a7c272417d1bcf605847f877dbc41fabb8fa012b8cb230fc7db95b4a0e1e53b2070d4af3620ed40bf94dcf417ef265fd78fae144ccfdef13f2",
            "6e232d5fdf082d520f64726f700a0086de1dfcad2daab5b5b5ddc062d692eaad",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x67967741f10ff7332121d7325739c543e6195f78",
            "BBUhh1HT73OnwnJBfRvPYFhH+HfbxB+ruPoBK4yyMPx9uVtKDh5TsgcNSvNiDtQL+U3PQX7yZf14+uFEzP3vE/I=",
            "biMtX98ILVIPZHJvcAoAht4d/K0tqrW1td3AYtaS6q0=",
        ),
    ),
    # vanity/0x68068
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x680687e6dab90c5a4802458afa070dde766eb74e",
            "0x9982044a6d6456ffd794e52a8ba95d8d2bfdea4885736983c29e6a83fbcf31b46030e82af6c2aec00ee0b3560570c11c271f33dd0ebcda2695f74893ec247a36",
            "0b24c2c53491ac6cd514e74d1e5fc78902da1a1925e9c60d334275ee9f48d0fe",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x680687e6dab90c5a4802458afa070dde766eb74e",
            "BJmCBEptZFb/15TlKoupXY0r/epIhXNpg8KeaoP7zzG0YDDoKvbCrsAO4LNWBXDBHCcfM90OvNomlfdIk+wkejY=",
            "CyTCxTSRrGzVFOdNHl/HiQLaGhkl6cYNM0J17p9I0P4=",
        ),
    ),
    # vanity/0x68168
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x68168fdd35395166bb3be9155864731ee06bc45e",
            "0xa77338517d6b049f5bd9a84090ffead4aa26e683737df62a6fdeebd417f329d1b48cd79de03fcd45d6d5c514482c1dd196724456b876479518c7940f9fca4d17",
            "2cffba59144cc5831875e3cbe87890d7cbbf4a571c040980e794ff640a80ed49",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x68168fdd35395166bb3be9155864731ee06bc45e",
            "BKdzOFF9awSfW9moQJD/6tSqJuaDc332Km/e69QX8ynRtIzXneA/zUXW1cUUSCwd0ZZyRFa4dkeVGMeUD5/KTRc=",
            "LP+6WRRMxYMYdePL6HiQ18u/SlccBAmA55T/ZAqA7Uk=",
        ),
    ),
    # vanity/0x68268
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x68268998006429fc0c9e41262882b4d382f09591",
            "0x6a5a3c958da2fab9dd060bcf9a8b65e0e32d339b5c027905de121bc3333061be004aac948a104d9864a870961cc863c8800db01001843f1758af8870e7f123d4",
            "6d14f69ca16f9c04235db4eb546e56ef985c5053cce02a31937636c93b2f5528",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x68268998006429fc0c9e41262882b4d382f09591",
            "BGpaPJWNovq53QYLz5qLZeDjLTObXAJ5Bd4SG8MzMGG+AEqslIoQTZhkqHCWHMhjyIANsBABhD8XWK+IcOfxI9Q=",
            "bRT2nKFvnAQjXbTrVG5W75hcUFPM4Coxk3Y2yTsvVSg=",
        ),
    ),
    # vanity/0x68368
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x683687acbcd458d628abb29dfed90fd44c6ea539",
            "0x9d72fd0ee49068bd0062c1da53c15abcb431316b0234fc543534b55938eb063b4723ac6655384b2382e3acfd578b4c6804f1f411ed58b54b371f4fa9b3d8e07f",
            "441b2f441df769331b4e74c1be3f82c97a774371f15cab2675ced641d9ea8684",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x683687acbcd458d628abb29dfed90fd44c6ea539",
            "BJ1y/Q7kkGi9AGLB2lPBWry0MTFrAjT8VDU0tVk46wY7RyOsZlU4SyOC46z9V4tMaATx9BHtWLVLNx9PqbPY4H8=",
            "RBsvRB33aTMbTnTBvj+CyXp3Q3HxXKsmdc7WQdnqhoQ=",
        ),
    ),
    # vanity/0x68468
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x684685ccba3cb2c9b3c635e05394a86212e2a7db",
            "0xe681c95c0fb9fd40948f2951b02654f1fe77d62229133812e5469953d3de921fe23ee30a84a917785ddf50dc89d9dd22be7f63e762b45c451c4ccef3fd8848df",
            "3ca5410c2a395de3055e5238d1c460d9fcd546fd3a1b9566744d5d516cb90183",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x684685ccba3cb2c9b3c635e05394a86212e2a7db",
            "BOaByVwPuf1AlI8pUbAmVPH+d9YiKRM4EuVGmVPT3pIf4j7jCoSpF3hd31DcidndIr5/Y+ditFxFHEzO8/2ISN8=",
            "PKVBDCo5XeMFXlI40cRg2fzVRv06G5VmdE1dUWy5AYM=",
        ),
    ),
    # vanity/0x68568
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x68568642edb592ac8aadfab03fb043553542bdf1",
            "0x79d3ea44657f06f809b85da9446e9ef6e7dba05d3b36fc81eab2d8025887cd4c61a0f5de0d4af9dc44a22c5a0f548166e4c5fda8433116e8ef05a04412f55c79",
            "342ff61b28326f6a61e04285221fec90ccbe9d20a23765bb1ceddf98f222c755",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x68568642edb592ac8aadfab03fb043553542bdf1",
            "BHnT6kRlfwb4CbhdqURunvbn26BdOzb8geqy2AJYh81MYaD13g1K+dxEoixaD1SBZuTF/ahDMRbo7wWgRBL1XHk=",
            "NC/2Gygyb2ph4EKFIh/skMy+nSCiN2W7HO3fmPIix1U=",
        ),
    ),
    # vanity/0x68668
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x68668f58e902a64b067e79ee5f9677647b7dfa33",
            "0xaebc91dba9a874f9df0fee0550739995a986085fcb3e983754a32120f0a7b7def6ad721676f31dfb502b9a02fde92587156b27da8235879bb51ffcdd8a3ee459",
            "973cd664fb4bfc75df9f3d5e48db5299e414a58264bce24c71fa9ae3752ffc79",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x68668f58e902a64b067e79ee5f9677647b7dfa33",
            "BK68kdupqHT53w/uBVBzmZWphghfyz6YN1SjISDwp7fe9q1yFnbzHftQK5oC/eklhxVrJ9qCNYebtR/83Yo+5Fk=",
            "lzzWZPtL/HXfnz1eSNtSmeQUpYJkvOJMcfqa43Uv/Hk=",
        ),
    ),
    # vanity/0x68768
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x687689e7eeca974212853b7796c110578fb14a0b",
            "0x7531907661879145fb7c6a4b142b30bf205ae49218804f3d4435e263ebe80ae33adeb06f41132b3e0a5350831cda82b84b207bf1da235ec09bd7f9164f60dc5d",
            "062ab5ab2bcef44527f14939bdb58fb0d79894cc29f35ebbf3184aa0534dff53",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x687689e7eeca974212853b7796c110578fb14a0b",
            "BHUxkHZhh5FF+3xqSxQrML8gWuSSGIBPPUQ14mPr6ArjOt6wb0ETKz4KU1CDHNqCuEsge/HaI17Am9f5Fk9g3F0=",
            "Biq1qyvO9EUn8Uk5vbWPsNeYlMwp81678xhKoFNN/1M=",
        ),
    ),
    # vanity/0x68868
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x68868992eecd541aa150460008a8fedaec0055f8",
            "0x9b8bc4feb14614fbf66aaafed2f8527b87db7d574c8eae1ebcccb113e17c2c52dde72822242cb603b507e7a6e9fb16b2c916d51316f8e6eccf8210e203172bee",
            "91a83ab341e3b4d3b476c94b6c198624f1f3555b44176660939ef8cb030f4220",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x68868992eecd541aa150460008a8fedaec0055f8",
            "BJuLxP6xRhT79mqq/tL4UnuH231XTI6uHrzMsRPhfCxS3ecoIiQstgO1B+em6fsWsskW1RMW+Obsz4IQ4gMXK+4=",
            "kag6s0HjtNO0dslLbBmGJPHzVVtEF2Zgk574ywMPQiA=",
        ),
    ),
    # vanity/0x68968
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x68968fb8533d255e2a71dacf00d6455934e79eb5",
            "0x8dce95991de7043e162d8ca895cbb4686a13fd277c9badbdc5930417c9500622812ba500b1a83d972e775f658fdb19b1a543641a72647e216b866357f5a0da32",
            "60653467c38f97bf69bb9a452c94367aaaae391e7d897f30de793962e5c73cdb",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x68968fb8533d255e2a71dacf00d6455934e79eb5",
            "BI3OlZkd5wQ+Fi2MqJXLtGhqE/0nfJutvcWTBBfJUAYigSulALGoPZcud19lj9sZsaVDZBpyZH4ha4ZjV/Wg2jI=",
            "YGU0Z8OPl79pu5pFLJQ2eqquOR59iX8w3nk5YuXHPNs=",
        ),
    ),
    # vanity/0x69069
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x69069187fefad2cc5dcfd2d0b82afa99d5b6ff1a",
            "0x26fba77dc06abf002c56dc67f8ed2d70468fc80e43d4eecdd2714db57f887e84acca0904cf0c1568fdcb0ae38f5ae4574e7d996028ef6b0c4dc1052a08bd64a4",
            "31061ab980f8374f09c52e3af198caa31201b9279f323e72a33f4130bbd0fd02",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x69069187fefad2cc5dcfd2d0b82afa99d5b6ff1a",
            "BCb7p33Aar8ALFbcZ/jtLXBGj8gOQ9TuzdJxTbV/iH6ErMoJBM8MFWj9ywrjj1rkV059mWAo72sMTcEFKgi9ZKQ=",
            "MQYauYD4N08JxS468ZjKoxIBuSefMj5yoz9BMLvQ/QI=",
        ),
    ),
    # vanity/0x69169
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x69169fa0eb97e981a0c62365ddbdad9454021504",
            "0x2c966662cfd35cf98c963231b514b42b11220e37929b809ef9d81ece850e0ba577ec9a497e4c355df4cbcf114f994596b7af3f74da04f9e608b0f0816138a8f9",
            "7fbd8c1c2add99646f0e3210e05ea1a7acb2d6bd22b9554afd17120187484eed",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x69169fa0eb97e981a0c62365ddbdad9454021504",
            "BCyWZmLP01z5jJYyMbUUtCsRIg43kpuAnvnYHs6FDguld+yaSX5MNV30y88RT5lFlrevP3TaBPnmCLDwgWE4qPk=",
            "f72MHCrdmWRvDjIQ4F6hp6yy1r0iuVVK/RcSAYdITu0=",
        ),
    ),
    # vanity/0x69269
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x692693922689e60c73ca81e2300ee0882d3c016b",
            "0x5abcc02c447b710c65307c8d9ac91cf8540f9142548e9598f6a07f6b5972439d58834ba1b02c0c70db000798144ef2f6bdffb922f5721af826a19353666738f8",
            "0ba612b64b9ddcb0bb715d3d16f6a0bc631d700eca1d303e4904c635a1be79f2",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x692693922689e60c73ca81e2300ee0882d3c016b",
            "BFq8wCxEe3EMZTB8jZrJHPhUD5FCVI6VmPagf2tZckOdWINLobAsDHDbAAeYFE7y9r3/uSL1chr4JqGTU2ZnOPg=",
            "C6YStkud3LC7cV09FvagvGMdcA7KHTA+SQTGNaG+efI=",
        ),
    ),
    # vanity/0x69369
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x69369a997a9becf902b8f32a6244df3347c07c2e",
            "0x4c089c7beec90714b8785fa995abc954278756dfe9caad185b443687fddbdcba6aacabf38b123f71499e51f3484d30660b04aa6ffe3f81b9e70dac19944e8f8f",
            "f3830e2d24425fe5fe350f30b78a961947eefa7b9ff5cf71defb721f3d95d8f8",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x69369a997a9becf902b8f32a6244df3347c07c2e",
            "BEwInHvuyQcUuHhfqZWryVQnh1bf6cqtGFtENof929y6aqyr84sSP3FJnlHzSE0wZgsEqm/+P4G55w2sGZROj48=",
            "84MOLSRCX+X+NQ8wt4qWGUfu+nuf9c9x3vtyHz2V2Pg=",
        ),
    ),
    # vanity/0x69469
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x6946961c97c0cd1181fff12c549e4f5055eecb7b",
            "0x782629565f93b91f4dbc55afa67cef71b0fa1db8049ea7e768b189de1e44ebadd4651a29ddfad5684ad753a04e87b6ffd62d03ca5fffe904992a94514125b53c",
            "18e81cef42ebea25a258847e46da7b360ffcf59cac7f78b8b5f50479af0a71f0",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x6946961c97c0cd1181fff12c549e4f5055eecb7b",
            "BHgmKVZfk7kfTbxVr6Z873Gw+h24BJ6n52ixid4eROut1GUaKd361WhK11OgToe2/9YtA8pf/+kEmSqUUUEltTw=",
            "GOgc70Lr6iWiWIR+Rtp7Ng/89Zysf3i4tfUEea8KcfA=",
        ),
    ),
    # vanity/0x69569
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x69569ec97231c2a3bb880773fc49aba100b83c25",
            "0x3443c1060adcde4ab03007439e2e634995c293830c5309fad3eff0077938e9338754b15b3ad5008443ae604083b7a35283a249a8e361901d07bad8c1239fbea6",
            "4be818e9220daaa5e25ac959ed94b0dace5a1c6990b3d0e63108d3560f7a9115",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x69569ec97231c2a3bb880773fc49aba100b83c25",
            "BDRDwQYK3N5KsDAHQ54uY0mVwpODDFMJ+tPv8Ad5OOkzh1SxWzrVAIRDrmBAg7ejUoOiSajjYZAdB7rYwSOfvqY=",
            "S+gY6SINqqXiWslZ7ZSw2s5aHGmQs9DmMQjTVg96kRU=",
        ),
    ),
    # vanity/0x69669
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x6966904a5ae8a3956248bee13c81310f6c4006ab",
            "0x4e5734d040dc8dc15d829dc0e9c7e6c3e4d5f9ac9621246ab5c67dcad358125cf564375f1302bed2fa2f6e3ff26a8f6c209d5c0435086b8d9577eb60c892b401",
            "f60933a7e84cf0097a792fe92852883e77a95cef4a7043f0be1e804990d73a24",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x6966904a5ae8a3956248bee13c81310f6c4006ab",
            "BE5XNNBA3I3BXYKdwOnH5sPk1fmsliEkarXGfcrTWBJc9WQ3XxMCvtL6L24/8mqPbCCdXAQ1CGuNlXfrYMiStAE=",
            "9gkzp+hM8Al6eS/pKFKIPnepXO9KcEPwvh6ASZDXOiQ=",
        ),
    ),
    # vanity/0x69769
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x69769ffc60c282df111b23690cc43f4d38c648ba",
            "0x73920a818a519836adae4d500adaf473c057559e6389ecc389255234daacafff243b43abfa4c7d83aa660e786c44ae80c8aa7a4dee6a4ed53d828ccd47d64369",
            "757d3441a31e116c9485592ee572d6cd2bf0ce5b61eab05e09d31b2144a8b6d6",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x69769ffc60c282df111b23690cc43f4d38c648ba",
            "BHOSCoGKUZg2ra5NUAra9HPAV1WeY4nsw4klUjTarK//JDtDq/pMfYOqZg54bESugMiqek3uak7VPYKMzUfWQ2k=",
            "dX00QaMeEWyUhVku5XLWzSvwzlth6rBeCdMbIUSottY=",
        ),
    ),
    # vanity/0x69869
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x6986962fb885f7eec1af5c3dc0cee82bf3712ff1",
            "0x3b48fe546a953a5e59696895f6c41f63d3b0fb26f67a8950bd41a05868d99f8d171407a9f602210951418c0006ebfd3d68f1909408e58bad61fd875ed8fcb192",
            "48ee9fda71dab379eab49f09cdedf2e9f5c667a4d3f9f30eb4106d5a8c8a1252",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x6986962fb885f7eec1af5c3dc0cee82bf3712ff1",
            "BDtI/lRqlTpeWWlolfbEH2PTsPsm9nqJUL1BoFho2Z+NFxQHqfYCIQlRQYwABuv9PWjxkJQI5YutYf2HXtj8sZI=",
            "SO6f2nHas3nqtJ8Jze3y6fXGZ6TT+fMOtBBtWoyKElI=",
        ),
    ),
    # vanity/0x69969
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x69969f425ef2740d11f6ef507aae64e8cf5f80d3",
            "0x881737c0405cb9308658a4cc1931e215aab447f6727566a26eb7227a537f11a620a99b24d8e86346e08e396ee86cfd62e55e10dfc8dc55c7335fa1d010cdc69a",
            "e4a36a4b263f3a6e141230aa6cc87f5c1a47c3da3afa046017e3e4366b39ce16",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x69969f425ef2740d11f6ef507aae64e8cf5f80d3",
            "BIgXN8BAXLkwhlikzBkx4hWqtEf2cnVmom63InpTfxGmIKmbJNjoY0bgjjlu6Gz9YuVeEN/I3FXHM1+h0BDNxpo=",
            "5KNqSyY/Om4UEjCqbMh/XBpHw9o6+gRgF+PkNms5zhY=",
        ),
    ),
    # vanity/0x70070
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x70070b81ddd20008d988c7308f99b57af4f58162",
            "0xa12313fddec908ff91c9875c399078ded22436cd829be5526134f70e098c26893bdf6737a877fe8d1f04a97f1175faa32801ff202a6a640302780a4c955289d6",
            "f2a83354285dac83f2804a0b58ea645f34ec0e112a1515561ff54eca68b31dad",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x70070b81ddd20008d988c7308f99b57af4f58162",
            "BKEjE/3eyQj/kcmHXDmQeN7SJDbNgpvlUmE09w4JjCaJO99nN6h3/o0fBKl/EXX6oygB/yAqamQDAngKTJVSidY=",
            "8qgzVChdrIPygEoLWOpkXzTsDhEqFRVWH/VOymizHa0=",
        ),
    ),
    # vanity/0x70170
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x701709f0d60b71b2567eb0ba0905fc5d437b8435",
            "0xb2c66778940db4555404e55ac445393da82c5f57683d685b7aac8c3a08d7849bb53ba62c548c13f4a6f38f758816aa84fd465383a15e8dda9b9e68491192c0c2",
            "d67f25e5fc4d6c56e457dc2c9dda88c644389bb337ec277744ad99192fd82e31",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x701709f0d60b71b2567eb0ba0905fc5d437b8435",
            "BLLGZ3iUDbRVVATlWsRFOT2oLF9XaD1oW3qsjDoI14SbtTumLFSME/Sm8491iBaqhP1GU4OhXo3am55oSRGSwMI=",
            "1n8l5fxNbFbkV9wsndqIxkQ4m7M37Cd3RK2ZGS/YLjE=",
        ),
    ),
    # vanity/0x70270
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x702704a43ba8704843e2834ce4bb785e88344b26",
            "0xc5106c0acb3600d310acf9c62c72f2a5ed9fb112aae9d34551442ad1a47ec2d31f938af0e645520c346a7edfc307b0016bdab8abdbf898b5679596de57085a32",
            "7fa41dd3d1b952f0044bb61253d396987d2d49f8580451ac891985c3d086fb87",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x702704a43ba8704843e2834ce4bb785e88344b26",
            "BMUQbArLNgDTEKz5xixy8qXtn7ESqunTRVFEKtGkfsLTH5OK8OZFUgw0an7fwwewAWvauKvb+Ji1Z5WW3lcIWjI=",
            "f6Qd09G5UvAES7YSU9OWmH0tSfhYBFGsiRmFw9CG+4c=",
        ),
    ),
    # vanity/0x70370
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x70370ed52e67416fe4016ffad710a10fbfdbb8ac",
            "0xc9a339e4485ad794cc63da51db858f8d9931c803ba4f6b4e2bb699a04365e68bf9d2dcb2a8e6551d7f55662314a05e1f9549a880b993ca25410d3a009b54e744",
            "aa276b79f10034b9df63d277c953ee8077f023179a85532d7f815473256e3309",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x70370ed52e67416fe4016ffad710a10fbfdbb8ac",
            "BMmjOeRIWteUzGPaUduFj42ZMcgDuk9rTiu2maBDZeaL+dLcsqjmVR1/VWYjFKBeH5VJqIC5k8olQQ06AJtU50Q=",
            "qidrefEANLnfY9J3yVPugHfwIxeahVMtf4FUcyVuMwk=",
        ),
    ),
    # vanity/0x70470
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x7047056b4f3e5dbdb5f920a3961583da48d79d6e",
            "0xb44335c5c8705d933434b6820073af45c00db9e3cedb153b9c42a7d68dc213d82e35fa7cb1631def40f749b09e3d7f5b93cbd91d97f41ece0d828605602149e4",
            "a3561f0bddf11995b38854df277ba2e21faab01dedb7b165f86aa6d32079f04e",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x7047056b4f3e5dbdb5f920a3961583da48d79d6e",
            "BLRDNcXIcF2TNDS2ggBzr0XADbnjztsVO5xCp9aNwhPYLjX6fLFjHe9A90mwnj1/W5PL2R2X9B7ODYKGBWAhSeQ=",
            "o1YfC93xGZWziFTfJ3ui4h+qsB3tt7Fl+Gqm0yB58E4=",
        ),
    ),
    # vanity/0x70570
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x70570617b663093db450d062981077583db307a5",
            "0xaf6c193bf5fbcdc3c5734a03406d61d468d66f9c6eb929c2cd4f3f7d617fdbb4afa44b8e6eb16792d7f9b22f52da720616c76f742206ed5e094836e25443e0c1",
            "f87b74e7e222ddad7c83f2a8ddd2a0631b59ed88e50714d95f30c1a95da677a6",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x70570617b663093db450d062981077583db307a5",
            "BK9sGTv1+83DxXNKA0BtYdRo1m+cbrkpws1PP31hf9u0r6RLjm6xZ5LX+bIvUtpyBhbHb3QiBu1eCUg24lRD4ME=",
            "+Ht05+Ii3a18g/Ko3dKgYxtZ7YjlBxTZXzDBqV2md6Y=",
        ),
    ),
    # vanity/0x70670
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x7067057460a1423aa2fc6c82ba5c9daf04511b6e",
            "0x0eb4936d15568693e8e715983ca51ec4925137e769ff9fcacaf9f6872eb49e75de6b37f09d29a9c3cc4ead013af9363faeee476c2326e63020733e5529f263ac",
            "b882563b8fc7035139c38ee1da26a6e61552fe2e7f0a565d03cd1139056b39a1",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x7067057460a1423aa2fc6c82ba5c9daf04511b6e",
            "BA60k20VVoaT6OcVmDylHsSSUTfnaf+fysr59ocutJ513ms38J0pqcPMTq0BOvk2P67uR2wjJuYwIHM+VSnyY6w=",
            "uIJWO4/HA1E5w47h2iam5hVS/i5/ClZdA80ROQVrOaE=",
        ),
    ),
    # vanity/0x70770
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x707701f9f7bfe62b3eb47cbae7e6d438506ab988",
            "0x0129767438c269770f6c28b199bd87fbe18873cb5c97f6e052dfcfec9f08a01f9f30eb4bb5aee6a3ead6e3ad234d2c9846e480e6517a2989b217b3e5e9798dcb",
            "708ca80d8f50ae8dac1b3c57954a4e8fbf8a093d75d5f505ebe800f91cbc043b",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x707701f9f7bfe62b3eb47cbae7e6d438506ab988",
            "BAEpdnQ4wml3D2wosZm9h/vhiHPLXJf24FLfz+yfCKAfnzDrS7Wu5qPq1uOtI00smEbkgOZReimJshez5el5jcs=",
            "cIyoDY9Qro2sGzxXlUpOj7+KCT111fUF6+gA+Ry8BDs=",
        ),
    ),
    # vanity/0x70870
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x7087099eedb739f3784fef486a06288717151f40",
            "0x8ffdba1145c504351056120968ef2f87940212bbe42a56a36c917ce01c5df6dca52c34d8de2fb89ed9a0e27f4be35043dc2ddd51b42c47f241d5b63fe0fa4aff",
            "6a7aebb93c550eec675477a41bcb41eb6767981768aaf99800a6c4575a613ffe",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x7087099eedb739f3784fef486a06288717151f40",
            "BI/9uhFFxQQ1EFYSCWjvL4eUAhK75CpWo2yRfOAcXfbcpSw02N4vuJ7ZoOJ/S+NQQ9wt3VG0LEfyQdW2P+D6Sv8=",
            "anrruTxVDuxnVHekG8tB62dnmBdoqvmYAKbEV1phP/4=",
        ),
    ),
    # vanity/0x70970
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x70970844bdf198b83e6cf63d900a5bdb30e8c6ba",
            "0xdd282e62291d2ebf03ffbc9733b8cafe84f0db3c8696f4a68170dd6646e6f25032dd4c2e7628206d8ed8504a0c11413341d540cceae3b4b56799b81a09ce9313",
            "a0695f5e48073a17c1edb32ce01701780463ae3edfc1952b19163649fc61d943",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x70970844bdf198b83e6cf63d900a5bdb30e8c6ba",
            "BN0oLmIpHS6/A/+8lzO4yv6E8Ns8hpb0poFw3WZG5vJQMt1MLnYoIG2O2FBKDBFBM0HVQMzq47S1Z5m4GgnOkxM=",
            "oGlfXkgHOhfB7bMs4BcBeARjrj7fwZUrGRY2Sfxh2UM=",
        ),
    ),
    # vanity/0x71071
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x71071e826fa5366187a08a64d2af90568a0dfead",
            "0x405a5b7e3d74bedbb516c1eaffbbee3c33b3738196c38319a8c678a51be2961561fc756f2cb0cae53dc72023a4dbda586ce20dde6a5114928e4fe03a3931873a",
            "49f0d0ed4459d7332c9175706f4f7ec87b9689797eebaf6847b8fd1e52e37ef7",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x71071e826fa5366187a08a64d2af90568a0dfead",
            "BEBaW349dL7btRbB6v+77jwzs3OBlsODGajGeKUb4pYVYfx1byywyuU9xyAjpNvaWGziDd5qURSSjk/gOjkxhzo=",
            "SfDQ7URZ1zMskXVwb09+yHuWiXl+669oR7j9HlLjfvc=",
        ),
    ),
    # vanity/0x71171
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x7117183f58461bbc25d361947cac990fb42826fa",
            "0x8455a5ee42ff795e2d9643287c62562f6c629edc0bff994b1b28b5957b0953320c7a8b5303150709bce9dd4327c28b3813443df8c64a9f87e5372f2322938e8c",
            "40d20b2f87bfce95b37994bc84159605d68849d434aa1d1dc78896fc86616a63",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x7117183f58461bbc25d361947cac990fb42826fa",
            "BIRVpe5C/3leLZZDKHxiVi9sYp7cC/+ZSxsotZV7CVMyDHqLUwMVBwm86d1DJ8KLOBNEPfjGSp+H5TcvIyKTjow=",
            "QNILL4e/zpWzeZS8hBWWBdaISdQ0qh0dx4iW/IZhamM=",
        ),
    ),
    # vanity/0x71271
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x712717e583e25162af49fb5334ecb1a89a03ebf6",
            "0xd124d9b9252a3b0df926c56efa4aeb341f9c5549d2d97f3f2c04175e919a4d7eb536a3b37ad1235d535d1de88ae5a3fb2bcb9244ecb40bc25661a5ac44c92be8",
            "350a927ebe948035228fb1a87727e431910209d8f8585534446ecda6734e99c4",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x712717e583e25162af49fb5334ecb1a89a03ebf6",
            "BNEk2bklKjsN+SbFbvpK6zQfnFVJ0tl/PywEF16Rmk1+tTajs3rRI11TXR3oiuWj+yvLkkTstAvCVmGlrETJK+g=",
            "NQqSfr6UgDUij7GodyfkMZECCdj4WFU0RG7NpnNOmcQ=",
        ),
    ),
    # vanity/0x71371
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x7137103cc2a17bf0f1a9b43fbbfb61a95dd0d88f",
            "0x21d4162db4a82e787aa84f75763061287d3ba77cd88d97e89a8cc48736ba94262901375ad190f1fd47760701a9545ad44f5971a39193b4218b1fcac26f3875e1",
            "58c747261a76957b63b4fd3a11bad21a3e6c86a8ac737b76573b4ee251b76d08",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x7137103cc2a17bf0f1a9b43fbbfb61a95dd0d88f",
            "BCHUFi20qC54eqhPdXYwYSh9O6d82I2X6JqMxIc2upQmKQE3WtGQ8f1HdgcBqVRa1E9ZcaORk7Qhix/Kwm84deE=",
            "WMdHJhp2lXtjtP06EbrSGj5shqisc3t2VztO4lG3bQg=",
        ),
    ),
    # vanity/0x71471
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x7147148577118b70acac5f6e9f7cfd1ea984ca10",
            "0x178b2a443a9f37edf54d232fbffe557800d2b4438a81bfec8b3ed7d1d460204c2ac1847e63edf7337b83fc44ed0d2bf09e3287f4112d4ca42a375c5aaf786b1b",
            "23391c85a7a57759e6404e555eafc9f06c52d3b62448cf02a2d83b3f474927dc",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x7147148577118b70acac5f6e9f7cfd1ea984ca10",
            "BBeLKkQ6nzft9U0jL7/+VXgA0rRDioG/7Is+19HUYCBMKsGEfmPt9zN7g/xE7Q0r8J4yh/QRLUykKjdcWq94axs=",
            "Izkchaeld1nmQE5VXq/J8GxS07YkSM8Cotg7P0dJJ9w=",
        ),
    ),
    # vanity/0x71571
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x7157123fdc4351a4ff23e62dc721f2edb8febeb4",
            "0x53b86003aaf8625dd79838b43825cd7d22a0568f0eb7cf7d82a74c73a53591323a97d0ccc9545c9d427cd5b7b9595abd00f4f86d5e8e210509bef58c4d986443",
            "bf03b1a8dc7f093672f09cd29bf69d71461721af77ed9226ba49088b8af5451f",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x7157123fdc4351a4ff23e62dc721f2edb8febeb4",
            "BFO4YAOq+GJd15g4tDglzX0ioFaPDrfPfYKnTHOlNZEyOpfQzMlUXJ1CfNW3uVlavQD0+G1ejiEFCb71jE2YZEM=",
            "vwOxqNx/CTZy8JzSm/adcUYXIa937ZImukkIi4r1RR8=",
        ),
    ),
    # vanity/0x71671
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x716711d5feaa77adc3fac1e967c9d581605e8338",
            "0xa34bef9e504a5ef7493c2c829a9a60b6db7adf22974aa509850ae51e6198855650c388fff665eb94b4a89e85c53279d6cd986fce541c7c49eb37d2d5cd88ab4f",
            "9edb2f6376d66e71946f100f0b8ba15cc4d5cf535511cd8c6910f9c3891e5e3c",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x716711d5feaa77adc3fac1e967c9d581605e8338",
            "BKNL755QSl73STwsgpqaYLbbet8il0qlCYUK5R5hmIVWUMOI//Zl65S0qJ6FxTJ51s2Yb85UHHxJ6zfS1c2Iq08=",
            "ntsvY3bWbnGUbxAPC4uhXMTVz1NVEc2MaRD5w4keXjw=",
        ),
    ),
    # vanity/0x71771
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x71771633a50d4050337c89816377b02044479743",
            "0x699e9b50baaf9d5bd65e602f44760ed9f00394c9b54c13830a28721f9e8d077fef35feb540f89a87199f9790dce071b92a95bf39071cc86bfe108311f6798839",
            "324707d6f850f5e683f822645b64fd7492b1ac3968e005f733ffc91f3dbff59c",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x71771633a50d4050337c89816377b02044479743",
            "BGmem1C6r51b1l5gL0R2DtnwA5TJtUwTgwooch+ejQd/7zX+tUD4mocZn5eQ3OBxuSqVvzkHHMhr/hCDEfZ5iDk=",
            "MkcH1vhQ9eaD+CJkW2T9dJKxrDlo4AX3M//JHz2/9Zw=",
        ),
    ),
    # vanity/0x71871
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x71871821543ca7dbdbd09c36af29bb3cda64a564",
            "0xaa7165afe137dde528aca020becbcb86fd53e2430b38cc6eee9a3fe6a3d13c5814e6c21e4ba67a5ae95fed4d8a9b35c984c3789523a45fd55f547ef7404b9fb8",
            "87e4965bdce5d9ef674d19aa7dc128ed1d74e3192b64ef45ab4b0da92787443e",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x71871821543ca7dbdbd09c36af29bb3cda64a564",
            "BKpxZa/hN93lKKygIL7Ly4b9U+JDCzjMbu6aP+aj0TxYFObCHkumelrpX+1Nips1yYTDeJUjpF/VX1R+90BLn7g=",
            "h+SWW9zl2e9nTRmqfcEo7R104xkrZO9Fq0sNqSeHRD4=",
        ),
    ),
    # vanity/0x71971
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x71971daa3c422b754730ce600a72b2674f20cd1e",
            "0xd6849065354954ac9d32562c161fe8329c0b279bdc7422615c2d52dc25029de8e8d4b7d35de1a3fa2bf3a42ce41f0a6ef1f3e9e57b45dc5194d95097206b9219",
            "4ddd9b7e7667af5a3ca7a82e63c0ba96006e8a0c5877f9ae30559702fd02e949",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x71971daa3c422b754730ce600a72b2674f20cd1e",
            "BNaEkGU1SVSsnTJWLBYf6DKcCyeb3HQiYVwtUtwlAp3o6NS3013ho/or86Qs5B8KbvHz6eV7RdxRlNlQlyBrkhk=",
            "Td2bfnZnr1o8p6guY8C6lgBuigxYd/muMFWXAv0C6Uk=",
        ),
    ),
    # vanity/0x72072
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x7207253c3240bb3376a1d7a9746755506c2675c7",
            "0x000d30ed1efa4dea65866448511ee96eac522e7953c442216cd499da08295d11f276c428d48f81fc876db8646bd9724d6a9b6130516aba27942df3ebfc850a92",
            "6adfe362c00f798f13e58eb6e6b9ae39cd0dc6b1dc5c41156cb8022ab6cb12ed",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x7207253c3240bb3376a1d7a9746755506c2675c7",
            "BAANMO0e+k3qZYZkSFEe6W6sUi55U8RCIWzUmdoIKV0R8nbEKNSPgfyHbbhka9lyTWqbYTBRaronlC3z6/yFCpI=",
            "at/jYsAPeY8T5Y625rmuOc0NxrHcXEEVbLgCKrbLEu0=",
        ),
    ),
    # vanity/0x72172
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x72172f65e8fac9f484764892a703cec4c8d3a4c7",
            "0x70d01c0be6ae17466d8ba43045ecc56b75f5e468a0444a7f96db2bb1f3e58960fa8f1f7d2266336c5361aea4bf7794a701a53de713b1e3888e0a81b43f7111cb",
            "9956138993cc3ce392cf869f9c59ded05e60a28294d4ab01f415aecc68d4e9b1",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x72172f65e8fac9f484764892a703cec4c8d3a4c7",
            "BHDQHAvmrhdGbYukMEXsxWt19eRooERKf5bbK7Hz5Ylg+o8ffSJmM2xTYa6kv3eUpwGlPecTseOIjgqBtD9xEcs=",
            "mVYTiZPMPOOSz4afnFne0F5gooKU1KsB9BWuzGjU6bE=",
        ),
    ),
    # vanity/0x72272
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x722728afc72ba82db3f9b3832d90c9fdaf665008",
            "0x6bb37ffd83037f50361615f22cd945de15e360d3430879a79c834834cb3a38de859c989ee412c9d87ec202b26b6b4d5fa83a5c1d20e7f24ee5a3980331072a51",
            "0df1152ae44e35d94e865ce9436a434630defe49738384d9e2138cae5cfc51a3",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x722728afc72ba82db3f9b3832d90c9fdaf665008",
            "BGuzf/2DA39QNhYV8izZRd4V42DTQwh5p5yDSDTLOjjehZyYnuQSydh+wgKya2tNX6g6XB0g5/JO5aOYAzEHKlE=",
            "DfEVKuRONdlOhlzpQ2pDRjDe/klzg4TZ4hOMrlz8UaM=",
        ),
    ),
    # vanity/0x72372
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x72372fc70e6a79fb2d23b4cae71e2c8c877f7843",
            "0xc50a89d91cc67c4f1ecd96b2fd183caec77cf4530660934735683b25ff6157fddf99396ef184e60ba00ab9326f36f8bacc66e02389272a2399c00b37217913ed",
            "b7fbc6d38adfef757e3011facc92f6e7e669e9feeb2fef039c7bc5e4dcad85ff",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x72372fc70e6a79fb2d23b4cae71e2c8c877f7843",
            "BMUKidkcxnxPHs2Wsv0YPK7HfPRTBmCTRzVoOyX/YVf935k5bvGE5gugCrkybzb4usxm4COJJyojmcALNyF5E+0=",
            "t/vG04rf73V+MBH6zJL25+Zp6f7rL+8DnHvF5Nythf8=",
        ),
    ),
    # vanity/0x72472
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x72472d9c68525296f35ee75e0607cf8a1eae5d7f",
            "0x8006709ec9893f791ab55a457784b42a9b3c4de4150c4528d8a504eb48cbb9ec7e418e84863dda6b8ec88926679965c69fc40ab17f5b340e3d29591fd72d2183",
            "c198a7be171ffa6089f9c35c632cabff86a6e9c40902c4a82a651e0bb7f005b2",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x72472d9c68525296f35ee75e0607cf8a1eae5d7f",
            "BIAGcJ7JiT95GrVaRXeEtCqbPE3kFQxFKNilBOtIy7nsfkGOhIY92muOyIkmZ5llxp/ECrF/WzQOPSlZH9ctIYM=",
            "wZinvhcf+mCJ+cNcYyyr/4am6cQJAsSoKmUeC7fwBbI=",
        ),
    ),
    # vanity/0x72572
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x72572df546e6f5e31f229af016243d7f992e64ab",
            "0x8a2606f8e82d9bde1a1cd6adde3cfba5bee1faabbf3a53deb8aedebf13c9bdef87cfa37d14490a721e9e7687c7b232236c64c09457042fea4f97af7798818dbe",
            "7080997f2154d91b83c7848fce19a42cc98e004b9fbc542280efb13eb3a68fb4",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x72572df546e6f5e31f229af016243d7f992e64ab",
            "BIomBvjoLZveGhzWrd48+6W+4fqrvzpT3riu3r8Tyb3vh8+jfRRJCnIennaHx7IyI2xkwJRXBC/qT5evd5iBjb4=",
            "cICZfyFU2RuDx4SPzhmkLMmOAEufvFQigO+xPrOmj7Q=",
        ),
    ),
    # vanity/0x72672
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x7267290f9c6a0551b963b459703832352648107b",
            "0x6eb9fbea00a01133c6734eb1322e69fc901fdc3bd7ebdaa12fd3dbeeb53c76f21a9ae42d80695796ac31cbef64b6b391151831fa65c87b57f86bbb6a7e6b4dba",
            "6d103b6efe129f3b8fe388c8991dda1a2a03737e75fc0f83d144c2fb05c1db35",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x7267290f9c6a0551b963b459703832352648107b",
            "BG65++oAoBEzxnNOsTIuafyQH9w71+vaoS/T2+61PHbyGprkLYBpV5asMcvvZLazkRUYMfplyHtX+Gu7an5rTbo=",
            "bRA7bv4SnzuP44jImR3aGioDc351/A+D0UTC+wXB2zU=",
        ),
    ),
    # vanity/0x72772
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x7277270af1bcffff7c8f74dce382751cfc0b02e3",
            "0xc5e0bbd80b0b41fcb5872d30d6d6105f70962a789a606bf5ea0d48e6e8a7ece8e742263f570f662d9010981d80cdbb30f1c7d1d6fce9f26508d28787ab3cf467",
            "666943b6a56a0fdcda3f68a5e9d50739482a2ac067efc05bb2bf70bdceb2a63a",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x7277270af1bcffff7c8f74dce382751cfc0b02e3",
            "BMXgu9gLC0H8tYctMNbWEF9wlip4mmBr9eoNSObop+zo50ImP1cPZi2QEJgdgM27MPHH0db86fJlCNKHh6s89Gc=",
            "ZmlDtqVqD9zaP2il6dUHOUgqKsBn78Bbsr9wvc6ypjo=",
        ),
    ),
    # vanity/0x72872
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x72872076774d4c7f6db3be36a259408e6bdf77b8",
            "0x4494e9479aeb16d6462d94858e4fa8b02e7ce70eaa170ba9cfc5403cbbaf26497465a1836d2dd6cd8b72bba7278cf895c4da4ac02511d4336bbbab247d1a6aa2",
            "0de5eda50bd3a3a6991b8d4566c65e13dc817d0648a7e518ba50881dbadce467",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x72872076774d4c7f6db3be36a259408e6bdf77b8",
            "BESU6Uea6xbWRi2UhY5PqLAufOcOqhcLqc/FQDy7ryZJdGWhg20t1s2LcrunJ4z4lcTaSsAlEdQza7urJH0aaqI=",
            "DeXtpQvTo6aZG41FZsZeE9yBfQZIp+UYulCIHbrc5Gc=",
        ),
    ),
    # vanity/0x72972
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x729726e4f5de11ebc2a990fc5f449c8b7bc90238",
            "0x76041af1e3dd203e94f0e7af1383fb60ca71fcaa5aeb33c4d30fd2f332c33fba41aa834d7f42155fe3d31f60ec87bcaf196a160f2e6dd6e0ad33896bad4ac0f3",
            "3b81e3075ab4865235bbdfa2625cd7202d49931859f2ed96c44c37f92a9dbe41",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x729726e4f5de11ebc2a990fc5f449c8b7bc90238",
            "BHYEGvHj3SA+lPDnrxOD+2DKcfyqWuszxNMP0vMywz+6QaqDTX9CFV/j0x9g7Ie8rxlqFg8ubdbgrTOJa61KwPM=",
            "O4HjB1q0hlI1u9+iYlzXIC1JkxhZ8u2WxEw3+SqdvkE=",
        ),
    ),
    # vanity/0x73073
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x7307394bd5e2885fc48e1a4fff228f1cb7d99115",
            "0x6bfa112d79b476eaaa4c1e9b438ab9224c6c3e86167c511635f6e2a951299eacfd33055c090784acd39b22b99d7a6cd7242417f10afbcefe981d933c4fa55879",
            "3740dfa35d99debabc17c4018be55e2242ae09fb9fd12ab2ca62e7d68855f21a",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x7307394bd5e2885fc48e1a4fff228f1cb7d99115",
            "BGv6ES15tHbqqkwem0OKuSJMbD6GFnxRFjX24qlRKZ6s/TMFXAkHhKzTmyK5nXps1yQkF/EK+87+mB2TPE+lWHk=",
            "N0Dfo12Z3rq8F8QBi+VeIkKuCfuf0SqyymLn1ohV8ho=",
        ),
    ),
    # vanity/0x73173
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x731736993985a524b3504cee88f23e157ff8344a",
            "0x6aa4ab0f0ec0a708487ced3bd4cc5404db3099ee259d2aae4b1fd734bc653dc2110d5c41bb328253ef585b6ac6e5a944aee6402741439cfd4bf32ca141530de7",
            "7636bc943c975ce034ab88c0a5b0fd61626f353086a4b3ae413d432bf4603f36",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x731736993985a524b3504cee88f23e157ff8344a",
            "BGqkqw8OwKcISHztO9TMVATbMJnuJZ0qrksf1zS8ZT3CEQ1cQbsyglPvWFtqxuWpRK7mQCdBQ5z9S/MsoUFTDec=",
            "dja8lDyXXOA0q4jApbD9YWJvNTCGpLOuQT1DK/RgPzY=",
        ),
    ),
    # vanity/0x73273
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x7327369fa5f6fb03aa07289dac6e9792b243a127",
            "0xec265fa927f380ce32d6a25aacb760ff790c45b0dcff0ee20145de1f6114f73f04efec8ad6fb029a76473f165a229c27398ac77f72778f0451058f8fc5c9b2db",
            "4bdaa26ab031dcea80767d9031eff7561b6932d56aee47f4b1149627aef6435c",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x7327369fa5f6fb03aa07289dac6e9792b243a127",
            "BOwmX6kn84DOMtaiWqy3YP95DEWw3P8O4gFF3h9hFPc/BO/sitb7App2Rz8WWiKcJzmKx39yd48EUQWPj8XJsts=",
            "S9qiarAx3OqAdn2QMe/3VhtpMtVq7kf0sRSWJ672Q1w=",
        ),
    ),
    # vanity/0x73373
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x73373680a88324119134a4345a2dfe345a502ec6",
            "0xc79dd3e062548748d9e0719c55797b46d4d6afdb5ce4c1b339fb2a0af144764de6235187b4322005c9f559771a915799ea146a9f63ac0e8d4d3bd6d76b20c950",
            "67ecf55d768f552990d1aa1522ba5f23bbff3979e9fa9893d0253b510c09996d",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x73373680a88324119134a4345a2dfe345a502ec6",
            "BMed0+BiVIdI2eBxnFV5e0bU1q/bXOTBszn7KgrxRHZN5iNRh7QyIAXJ9Vl3GpFXmeoUap9jrA6NTTvW12sgyVA=",
            "Z+z1XXaPVSmQ0aoVIrpfI7v/OXnp+piT0CU7UQwJmW0=",
        ),
    ),
    # vanity/0x73473
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x7347385b4a89f05cca6ee4a43ddbf7624b4b8a6c",
            "0xde475922c71e214ccf065861f03621973d45ce4bd73d707dfcad1b9ce2ec98e1d124faa23767968e8393204d0d9cb43f665a06609bd3308fd4fa13c0284ddb5f",
            "c07124c4958f340871acfc2eaeac568486cb20e8624a27f7b804ccc7df0e085f",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x7347385b4a89f05cca6ee4a43ddbf7624b4b8a6c",
            "BN5HWSLHHiFMzwZYYfA2IZc9Rc5L1z1wffytG5zi7Jjh0ST6ojdnlo6DkyBNDZy0P2ZaBmCb0zCP1PoTwChN218=",
            "wHEkxJWPNAhxrPwurqxWhIbLIOhiSif3uATMx98OCF8=",
        ),
    ),
    # vanity/0x73573
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x7357365dd15269b8a18fa8c506a9ac8d92f24b10",
            "0xc334676f0ba04b84a933ecd6737c27c9099304520ae17d1d60b6ec77fca5e78804e76cb4933b8e9faf777b47b99f9c45ae3213f7864592d523d92b52e47259e7",
            "2484a34a410eb1b89e87fa859dbe79541d2c7c34637832276990732ab0e9692e",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x7357365dd15269b8a18fa8c506a9ac8d92f24b10",
            "BMM0Z28LoEuEqTPs1nN8J8kJkwRSCuF9HWC27Hf8peeIBOdstJM7jp+vd3tHuZ+cRa4yE/eGRZLVI9krUuRyWec=",
            "JISjSkEOsbieh/qFnb55VB0sfDRjeDInaZBzKrDpaS4=",
        ),
    ),
    # vanity/0x73673
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x73673f5ac1aae1b7cc960f3ea32391a45c92efaf",
            "0xa32f760c047907f10cbdd727f3a4c264d6b179f057b1a4f1c02c1b7341516afcecb0e5bc96b0ba2f5ac23d3322c9dd5892b870e3d1a99fce66bc03133e62e074",
            "1f92f19af870c7e9e584a6c1063a0155a8aedde4a9deebf09cf685082c626918",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x73673f5ac1aae1b7cc960f3ea32391a45c92efaf",
            "BKMvdgwEeQfxDL3XJ/OkwmTWsXnwV7Gk8cAsG3NBUWr87LDlvJawui9awj0zIsndWJK4cOPRqZ/OZrwDEz5i4HQ=",
            "H5Lxmvhwx+nlhKbBBjoBVaiu3eSp3uvwnPaFCCxiaRg=",
        ),
    ),
    # vanity/0x73773
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x737730d79b9602658e478a9f4c16b4dc0bcedaae",
            "0xacc0c155b91ce0983142c66fb5e17849a2dfeb9526912653cbab6d2a5ae2968cbf27b634b6c43a1b4d17a419a2ba8a8cbde2251cd201ed75816f89e398af759b",
            "d41f7bedd77130b2a14bc136961feceee4b5f6eefe2e8dfc455fbd2c40ecb709",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x737730d79b9602658e478a9f4c16b4dc0bcedaae",
            "BKzAwVW5HOCYMULGb7XheEmi3+uVJpEmU8urbSpa4paMvye2NLbEOhtNF6QZorqKjL3iJRzSAe11gW+J45ivdZs=",
            "1B977ddxMLKhS8E2lh/s7uS19u7+Lo38RV+9LEDstwk=",
        ),
    ),
    # vanity/0x73873
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x73873d1c73007f2726ecbd8339f09662becaae7c",
            "0x5e44b80b233d9aea4cc966ae638eb12796977d0632577a36a5d3e14952791f8dcd672f2094464d98f002c770238f6960a9253a0a37ce62518beb8ace686831c6",
            "7b15c0f4d45724227cdbdc7132986fd39be023ad45481a85321a9b44d58c37e3",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x73873d1c73007f2726ecbd8339f09662becaae7c",
            "BF5EuAsjPZrqTMlmrmOOsSeWl30GMld6NqXT4UlSeR+NzWcvIJRGTZjwAsdwI49pYKklOgo3zmJRi+uKzmhoMcY=",
            "exXA9NRXJCJ829xxMphv05vgI61FSBqFMhqbRNWMN+M=",
        ),
    ),
    # vanity/0x73973
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x739737312a80e9c4851c4ca6bcc9c2d706c656cc",
            "0xd7b183cb00995794393c29adf42996b3a22cf52b714806c9878ce24021d415c2c6d4f8274be52bc1d3ee732b42a23218eb50566b3b3909288995c958f38d44db",
            "015a26ee3617f4d3845b4c635ac7cbaea9d7b7dc791d66eeabaea33927d50356",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x739737312a80e9c4851c4ca6bcc9c2d706c656cc",
            "BNexg8sAmVeUOTwprfQplrOiLPUrcUgGyYeM4kAh1BXCxtT4J0vlK8HT7nMrQqIyGOtQVms7OQkoiZXJWPONRNs=",
            "AVom7jYX9NOEW0xjWsfLrqnXt9x5HWbuq66jOSfVA1Y=",
        ),
    ),
    # vanity/0x74074
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x7407471d0f7bad3c6e13330347b8a2e5f4a6334b",
            "0xe0fd13799bbaa707c50f4fb7453792ffa103caa0df5ce0c2d354889561e3c7b14f81ec96a3bee5f4223e64d5602eb0c5fee1ce4ac5ca71eb7a945166b8e11417",
            "233ff3ccf183049c7bf3cd16c648cd7713a1f9ed486543bfd8b5d07bd5669272",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x7407471d0f7bad3c6e13330347b8a2e5f4a6334b",
            "BOD9E3mbuqcHxQ9Pt0U3kv+hA8qg31zgwtNUiJVh48exT4HslqO+5fQiPmTVYC6wxf7hzkrFynHrepRRZrjhFBc=",
            "Iz/zzPGDBJx7880WxkjNdxOh+e1IZUO/2LXQe9VmknI=",
        ),
    ),
    # vanity/0x74174
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x741747d9f626e9c7b7e8b0ca06f135354fb3482b",
            "0x654c07d6f81260b506584a3bc181b5748ba67415842fee8305f8e61ed0380d8982dc8e36407f17c68baf7b9dba6ace0acb02c32248a0fc4eef3aec343f7da0e7",
            "5531d4b3715229d39fe999be29ee69a0b24626f14e65f4b291eed601040be3b7",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x741747d9f626e9c7b7e8b0ca06f135354fb3482b",
            "BGVMB9b4EmC1BlhKO8GBtXSLpnQVhC/ugwX45h7QOA2JgtyONkB/F8aLr3udumrOCssCwyJIoPxO7zrsND99oOc=",
            "VTHUs3FSKdOf6Zm+Ke5poLJGJvFOZfSyke7WAQQL47c=",
        ),
    ),
    # vanity/0x74274
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x74274cd0ff6187cbed41d71484b42e8039860600",
            "0x03c627d30a9e8bc6c4b89c89739c070e3096e796cabcf7f0350c0767253b36c7bfc4a891b9723735d9f208e24a4c6acb9668cc02118cebf9f96c335f2c9202e1",
            "f27d611e610bf67eeba3a4a1f7249f446245f70af8c7d7e005faa65c2ed98aa9",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x74274cd0ff6187cbed41d71484b42e8039860600",
            "BAPGJ9MKnovGxLiciXOcBw4wlueWyrz38DUMB2clOzbHv8SokblyNzXZ8gjiSkxqy5ZozAIRjOv5+WwzXyySAuE=",
            "8n1hHmEL9n7ro6Sh9ySfRGJF9wr4x9fgBfqmXC7Ziqk=",
        ),
    ),
    # vanity/0x74374
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x74374660d30f3f5ac5cfcc4a69124fb8ee12c96c",
            "0x9e4c3696b805baa5499431a2551e70eb24719100819368fa773d37cfc9be9e0c83ea620b7c35af9dccb37014e5a1fee2844f9bfaecef64ab5e43cc4d31fda4ab",
            "d9cdf1ac08b969cc8cc540801ac6466122e897f4d593948181b3d20a902f69da",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x74374660d30f3f5ac5cfcc4a69124fb8ee12c96c",
            "BJ5MNpa4BbqlSZQxolUecOskcZEAgZNo+nc9N8/Jvp4Mg+piC3w1r53Ms3AU5aH+4oRPm/rs72SrXkPMTTH9pKs=",
            "2c3xrAi5acyMxUCAGsZGYSLol/TVk5SBgbPSCpAvado=",
        ),
    ),
    # vanity/0x74474
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x744747940baa01f2524abb3c0385cc54e58a06d3",
            "0xb08ae8215efe4fc2fb7b8786ba502099120d97bb10ac224f5e52d2f1c6fa5125dcb0102ca17c56a2c99cf8d7f97bbeefc0863b43a9c6cf261afbb518a7a56e01",
            "f496c73e9828c324d177f5ef1a9f2140ece007b93a180e4fa9bd3ca9850aa398",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x744747940baa01f2524abb3c0385cc54e58a06d3",
            "BLCK6CFe/k/C+3uHhrpQIJkSDZe7EKwiT15S0vHG+lEl3LAQLKF8VqLJnPjX+Xu+78CGO0Opxs8mGvu1GKelbgE=",
            "9JbHPpgowyTRd/XvGp8hQOzgB7k6GA5Pqb08qYUKo5g=",
        ),
    ),
    # vanity/0x74574
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x745747e9eb1062864b2412ac5ede4648b1c077dc",
            "0xd9041c226aa9d3748daec6f818123329aaea31735312f757f7033df270161eb850ddc1068dc36556f401368b6f8e34a7d0d15e6ca381eb463ea453152e7c7566",
            "db2f6c2e19ebab7e9d81d72b40332d4ee4fc752dafaabb7b6c511d9e31e5f440",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x745747e9eb1062864b2412ac5ede4648b1c077dc",
            "BNkEHCJqqdN0ja7G+BgSMymq6jFzUxL3V/cDPfJwFh64UN3BBo3DZVb0ATaLb440p9DRXmyjgetGPqRTFS58dWY=",
            "2y9sLhnrq36dgdcrQDMtTuT8dS2vqrt7bFEdnjHl9EA=",
        ),
    ),
    # vanity/0x74674
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x74674d092e25db24eff15d86d621d6401ec794c9",
            "0x4ece8546e72aa8fb1b7a0c7e2d73f2888b66fd6582766f55f07375cd64cb40c802dec1148f0baaa5190a0377da31ff965618df8911be09ac9597489b99cc4990",
            "475a5300ba1d2b4a6f5c8a00a89b25d6a5daea781127eaffebf1caf4c5f460d5",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x74674d092e25db24eff15d86d621d6401ec794c9",
            "BE7OhUbnKqj7G3oMfi1z8oiLZv1lgnZvVfBzdc1ky0DIAt7BFI8LqqUZCgN32jH/llYY34kRvgmslZdIm5nMSZA=",
            "R1pTALodK0pvXIoAqJsl1qXa6ngRJ+r/6/HK9MX0YNU=",
        ),
    ),
    # vanity/0x74774
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x747741cf22d97e74479141a57e59876c312136bc",
            "0xc56790a58db1bd4d03765f3fa9b65c241923c2459500c1cff207989490100dd2f8e7eb07ee6b17bc330ec4f0ba7520ce24b1bad793560858e5760fab4bf79d4a",
            "24bd4499efe38b068151c67b25da57961643c2203470c1cdc4b572dc86b9df9e",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x747741cf22d97e74479141a57e59876c312136bc",
            "BMVnkKWNsb1NA3ZfP6m2XCQZI8JFlQDBz/IHmJSQEA3S+OfrB+5rF7wzDsTwunUgziSxuteTVghY5XYPq0v3nUo=",
            "JL1Eme/jiwaBUcZ7JdpXlhZDwiA0cMHNxLVy3Ia5354=",
        ),
    ),
    # vanity/0x74874
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x74874794bbfcc52108eaa478f263f0eb0a7a7244",
            "0x3346984c05ce6267e46fbbc81a7cd26de2c289862545b65e031cdaaacf9f7b0a694d4e436e67b9e7374ccb6ffe15d1ffbffe04f04adcaa27ecfdcf5a139282af",
            "2d020d54fadf012a4fb6331e708d58c4c931168d46de8f146c4ac45e5ce67997",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x74874794bbfcc52108eaa478f263f0eb0a7a7244",
            "BDNGmEwFzmJn5G+7yBp80m3iwomGJUW2XgMc2qrPn3sKaU1OQ25nuec3TMtv/hXR/7/+BPBK3Kon7P3PWhOSgq8=",
            "LQINVPrfASpPtjMecI1YxMkxFo1G3o8UbErEXlzmeZc=",
        ),
    ),
    # vanity/0x74974
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x74974c95f42301b0821f078ece84af1ac2ce797b",
            "0xc29f6a4c2d20a1f0d4c1af81c23783837a837fc5068c0bee8652c2e2075f4613f0f94390830c0a358fb622e7e14d54dad90253bd2a39fc5a1ed5d27928d62805",
            "2e5eac687f19f7844cb80dc5c53db45f572cb5ed1d07377558afbd1b60f71113",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x74974c95f42301b0821f078ece84af1ac2ce797b",
            "BMKfakwtIKHw1MGvgcI3g4N6g3/FBowL7oZSwuIHX0YT8PlDkIMMCjWPtiLn4U1U2tkCU70qOfxaHtXSeSjWKAU=",
            "Ll6saH8Z94RMuA3FxT20X1cste0dBzd1WK+9G2D3ERM=",
        ),
    ),
    # vanity/0x75075
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x75075b2d8714a93f926f5673a5d71d84fa866c6c",
            "0x33aa6efbb349784a27768b332d4a5e333582e551e684eff8e2beef5e7f1983e35770de0adc68fea7b834c6fd2856b65fe9b88bbe07027135f32bf9e248444697",
            "fee40a259a192b9388806ebe87154c00780584f79fff39f3a228a74f3fc9f58b",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x75075b2d8714a93f926f5673a5d71d84fa866c6c",
            "BDOqbvuzSXhKJ3aLMy1KXjM1guVR5oTv+OK+715/GYPjV3DeCtxo/qe4NMb9KFa2X+m4i74HAnE18yv54khERpc=",
            "/uQKJZoZK5OIgG6+hxVMAHgFhPef/znzoiinTz/J9Ys=",
        ),
    ),
    # vanity/0x75175
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x75175d67b14f9cf4e2e7102423e836af96748e99",
            "0xdc70aa5936551862b21fd366c592494ea877f9cc325699a49dee3c1da4f0d3501f6d4feeb085c2f6975c73a2aa1db5853dc2b8ec28bd5d607d04fba9d850d680",
            "a4416616c76028faea01d65491b21904d18fca84a23f9eb8c3fdf162a9532a30",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x75175d67b14f9cf4e2e7102423e836af96748e99",
            "BNxwqlk2VRhish/TZsWSSU6od/nMMlaZpJ3uPB2k8NNQH21P7rCFwvaXXHOiqh21hT3CuOwovV1gfQT7qdhQ1oA=",
            "pEFmFsdgKPrqAdZUkbIZBNGPyoSiP564w/3xYqlTKjA=",
        ),
    ),
    # vanity/0x75275
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x75275c3f94502f80874adc2b9c3e0e3c02d14200",
            "0x143b6b95f8b077b65fd20b3e7d83c866890a4a244d8a5e0817b1871561742dded20b2b654020eabca6c3c18a1f4bcf2c428b5be1446b221e6a591a018ea63377",
            "f5e2478520c6c5194b9bbe18420107ad1bc29234d53b3d133779b9cbe13368a3",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x75275c3f94502f80874adc2b9c3e0e3c02d14200",
            "BBQ7a5X4sHe2X9ILPn2DyGaJCkokTYpeCBexhxVhdC3e0gsrZUAg6rymw8GKH0vPLEKLW+FEayIealkaAY6mM3c=",
            "9eJHhSDGxRlLm74YQgEHrRvCkjTVOz0TN3m5y+EzaKM=",
        ),
    ),
    # vanity/0x75375
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x75375a076da684bd0f3c40fecffa7939676b35fb",
            "0x01dd65c95a11422f8b766e430f59d349e6b90e44980c61586f00839f912f4191264e1c222c0825b2b9174086a348bd6e2430af5a547ed4aab158adef9b046226",
            "06038bf701c06d5daa692a7cf1b0296dcf52fd8e8b246a3cca408a05bed1ecf2",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x75375a076da684bd0f3c40fecffa7939676b35fb",
            "BAHdZclaEUIvi3ZuQw9Z00nmuQ5EmAxhWG8Ag5+RL0GRJk4cIiwIJbK5F0CGo0i9biQwr1pUftSqsVit75sEYiY=",
            "BgOL9wHAbV2qaSp88bApbc9S/Y6LJGo8ykCKBb7R7PI=",
        ),
    ),
    # vanity/0x75475
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x754758be4b281b2c2fb0d4c2d2d7e037bd270a57",
            "0x2e70c31b2315db3402b9cc7c19782b891a235c61854b1776978616e65d7bc4ba6b63d8c688b34c470d79f69473e0c63aaae128e303d3152e83cdf16fc883ea9e",
            "776f151a4b8f6170f69f139c395d9dd2cd1670bec006c27234ee7b8d8333d6e4",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x754758be4b281b2c2fb0d4c2d2d7e037bd270a57",
            "BC5wwxsjFds0ArnMfBl4K4kaI1xhhUsXdpeGFuZde8S6a2PYxoizTEcNefaUc+DGOqrhKOMD0xUug83xb8iD6p4=",
            "d28VGkuPYXD2nxOcOV2d0s0WcL7ABsJyNO57jYMz1uQ=",
        ),
    ),
    # vanity/0x75575
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x75575dd3964f86c8a29787204e2d702a0bef3dc4",
            "0x4251d7443c27de3d4bd7e223574f816ece935132f0d5caccbadf365efbbb53789efb58d373798af7919ab67452c1f573345fa9b84c2c20de0743ddcf20e8f04e",
            "9d7b662c937bad7a8ee76722c9a808632ad85b31565a9f94a00c25d5d685a3fd",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x75575dd3964f86c8a29787204e2d702a0bef3dc4",
            "BEJR10Q8J949S9fiI1dPgW7Ok1Ey8NXKzLrfNl77u1N4nvtY03N5iveRmrZ0UsH1czRfqbhMLCDeB0PdzyDo8E4=",
            "nXtmLJN7rXqO52ciyagIYyrYWzFWWp+UoAwl1daFo/0=",
        ),
    ),
    # vanity/0x75675
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x75675b5e2c62aa5a808830528b28b0c89122cc98",
            "0x7e6577249590382a9586aef8c0c866fa8faa48cedf90f6a39c9583f677d8eddc82bdbeab9edfab91558af3f4298cdd34a12ec06ef31d12176a77376c7f135a51",
            "025a454cf96109ecea7d88c10edc582ea11e7b6e36e3608fae7c15a999eecbc3",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x75675b5e2c62aa5a808830528b28b0c89122cc98",
            "BH5ldySVkDgqlYau+MDIZvqPqkjO35D2o5yVg/Z32O3cgr2+q57fq5FVivP0KYzdNKEuwG7zHRIXanc3bH8TWlE=",
            "AlpFTPlhCezqfYjBDtxYLqEee24242CPrnwVqZnuy8M=",
        ),
    ),
    # vanity/0x75775
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x757753da6f8b2d2269a329e4a961d3ca2376387d",
            "0x0fc79c44d4008773f5422f36db2d5c735bb87e4403c69bbf691fa402927fa80bff6327abf9829bccb81d543d80ef623a9c9f6989559d81b11df1d2aaa7d6af3e",
            "ddc1dd0119dbac0db4e9050f7887030d58314243d016f7a11a2434545b3551dd",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x757753da6f8b2d2269a329e4a961d3ca2376387d",
            "BA/HnETUAIdz9UIvNtstXHNbuH5EA8abv2kfpAKSf6gL/2Mnq/mCm8y4HVQ9gO9iOpyfaYlVnYGxHfHSqqfWrz4=",
            "3cHdARnbrA206QUPeIcDDVgxQkPQFvehGiQ0VFs1Ud0=",
        ),
    ),
    # vanity/0x75875
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x758759ae1ca1355aedf2e1dcb7f7023d9dec3740",
            "0xcbfb0696bc067bde9e66133b017a60a7b5d0c735bab5dae0550ba1c5f7289946f7249da2d8743288f906a142184f47f0f7aee58032b89b1894ff2a58e660ebdf",
            "7cdb26965fa4fce33d5f28d7adfac23995c22836ddc207a882f79d9a62ae4d0b",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x758759ae1ca1355aedf2e1dcb7f7023d9dec3740",
            "BMv7Bpa8BnvenmYTOwF6YKe10Mc1urXa4FULocX3KJlG9ySdoth0Moj5BqFCGE9H8Peu5YAyuJsYlP8qWOZg698=",
            "fNsmll+k/OM9XyjXrfrCOZXCKDbdwgeogvedmmKuTQs=",
        ),
    ),
    # vanity/0x75975
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x75975a81ae290e3d6472f7e77756fef5f524030e",
            "0xd6e3aa8f4b2d9388d5fbe59f3b53c903886d163b84c2715c10d0bfaa42b2b9e4ba951781c354b0f741d39149c62e9b54bf15e1013f0df76a7825da59d1c2ba60",
            "31d3d12d2575cc4ff68cc83ad9cffc62250951a949c42752cfdfbfec0967e0bd",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x75975a81ae290e3d6472f7e77756fef5f524030e",
            "BNbjqo9LLZOI1fvlnztTyQOIbRY7hMJxXBDQv6pCsrnkupUXgcNUsPdB05FJxi6bVL8V4QE/DfdqeCXaWdHCumA=",
            "MdPRLSV1zE/2jMg62c/8YiUJUalJxCdSz9+/7Aln4L0=",
        ),
    ),
    # vanity/0x76076
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x760760b876f08534df6e2248d836a69293445313",
            "0x1b2c695ab7a89deef83f5b138c9a2d66580350a18d95512e00e87b08843d7215a05f7dbcd0da2ed91115fb1ac824b8f8a227e94645266d41abd077e03f76a5e9",
            "3ce326630e9d57118eb73b460f8509e9b58df2a02c6f1665c4bd47620be7a530",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x760760b876f08534df6e2248d836a69293445313",
            "BBssaVq3qJ3u+D9bE4yaLWZYA1ChjZVRLgDoewiEPXIVoF99vNDaLtkRFfsayCS4+KIn6UZFJm1Bq9B34D92pek=",
            "POMmYw6dVxGOtztGD4UJ6bWN8qAsbxZlxL1HYgvnpTA=",
        ),
    ),
    # vanity/0x76176
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x76176d9c0f0a8d2da979e5acbc67c4926f4d8963",
            "0x08e10c12b1a209173d08b5ca36cfe039cb6925538971b8b91d1d833800132f7d3c0f7b3fc724ab4cddc0e808dc0997f412c747359c8b1cde0dad291da1eb183b",
            "8fc92d9c37d7be6c1b10e3be772ea0e39ee4ab427d5ff2f8ba91d75bbb385e8b",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x76176d9c0f0a8d2da979e5acbc67c4926f4d8963",
            "BAjhDBKxogkXPQi1yjbP4DnLaSVTiXG4uR0dgzgAEy99PA97P8ckq0zdwOgI3AmX9BLHRzWcixzeDa0pHaHrGDs=",
            "j8ktnDfXvmwbEOO+dy6g457kq0J9X/L4upHXW7s4Xos=",
        ),
    ),
    # vanity/0x76276
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x762760eefe6c2e393cc7ee47b5add3ca73e35003",
            "0x1e208ac5c9f0d432e67605d2b28b562dd6173f90ac5748fbbe869a7d2c800e550fefda1714d499370323f26f97d20fdede5fed7ec5a1c8708e3f418e9d88c6ff",
            "b2612e9f51c69211a2df9e05e54de40a155e49d6473b4e736c69008357d132b4",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x762760eefe6c2e393cc7ee47b5add3ca73e35003",
            "BB4gisXJ8NQy5nYF0rKLVi3WFz+QrFdI+76Gmn0sgA5VD+/aFxTUmTcDI/Jvl9IP3t5f7X7Fochwjj9Bjp2Ixv8=",
            "smEun1HGkhGi354F5U3kChVeSdZHO05zbGkAg1fRMrQ=",
        ),
    ),
    # vanity/0x76376
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x7637601e17c3c0429c6c3e0c5cc0228ab0c84b4c",
            "0xb81318ebfa9c65a1cd6814f22ab27b2d0d2d5f730124b0d4ca9103f7e33dc4b44efb230bf6811d31022210ce0f14502e387de63f2876e31c4bc0189103534705",
            "b5bee7ea83dde445c227d84ea6560d8e5502e02fc04c662bbbda359bc0e4b03b",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x7637601e17c3c0429c6c3e0c5cc0228ab0c84b4c",
            "BLgTGOv6nGWhzWgU8iqyey0NLV9zASSw1MqRA/fjPcS0TvsjC/aBHTECIhDODxRQLjh95j8oduMcS8AYkQNTRwU=",
            "tb7n6oPd5EXCJ9hOplYNjlUC4C/ATGYru9o1m8DksDs=",
        ),
    ),
    # vanity/0x76476
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x76476954c4fb8f17d9df3d12fedd243b492f6c8b",
            "0x15337ca2f4978f5a6e935743addc48dd301d216d584b954f776dbf15d7e926845561e4b1e2d147491f3e2e79b1c54460b039c4cd0894f8dd7b72c510df766362",
            "3b97857b1b7d5dc3cfdff5778f93a49917ee4ecf5e4b83687382900db14af808",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x76476954c4fb8f17d9df3d12fedd243b492f6c8b",
            "BBUzfKL0l49abpNXQ63cSN0wHSFtWEuVT3dtvxXX6SaEVWHkseLRR0kfPi55scVEYLA5xM0IlPjde3LFEN92Y2I=",
            "O5eFext9XcPP3/V3j5OkmRfuTs9eS4Noc4KQDbFK+Ag=",
        ),
    ),
    # vanity/0x76576
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x76576db40c5be585c20cd74ae4bd27f97df0028c",
            "0xf5fdf60f3ef44da8858ce377fb36515c24ce625cb25bb074ce2d99c3fd53b0bb2d2d8b279294c86994f52cbc51e9630f6366ecacc4e1047255d5639fa104d12c",
            "a07c67fec31ad9e83a825d80d8751c72fa2e2961d6a0fdf58beef129fda8a7b9",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x76576db40c5be585c20cd74ae4bd27f97df0028c",
            "BPX99g8+9E2ohYzjd/s2UVwkzmJcsluwdM4tmcP9U7C7LS2LJ5KUyGmU9Sy8UeljD2Nm7KzE4QRyVdVjn6EE0Sw=",
            "oHxn/sMa2eg6gl2A2HUccvouKWHWoP31i+7xKf2op7k=",
        ),
    ),
    # vanity/0x76676
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x7667639c4f78419cf134dcbbb3573fc50152e69d",
            "0xbe5dd46f6f16d4bf7846332ff5719b269c538729ae11b8f1f7c41d0357b81716e19aabcd7fc7f263579b5d573baffb3776a99c5e68b074605d8417fde618e59c",
            "a1faa98a63759df7d4442b3ff637130dfecbe4a557970d902078940fc9f704d4",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x7667639c4f78419cf134dcbbb3573fc50152e69d",
            "BL5d1G9vFtS/eEYzL/VxmyacU4cprhG48ffEHQNXuBcW4ZqrzX/H8mNXm11XO6/7N3apnF5osHRgXYQX/eYY5Zw=",
            "ofqpimN1nffURCs/9jcTDf7L5KVXlw2QIHiUD8n3BNQ=",
        ),
    ),
    # vanity/0x76776
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x76776486e3af55ed8f5be21ddc46f4f58c05483e",
            "0xb0145c14b008deed02b0eefa1cea91692ee51c6124a21286dbe5b746d4a4fbc2833c673e11ba368ef708409f2923ead7ede9c6916b31e1612d8ab1d7ccde4628",
            "fb6556bb148b0c73d52d6c0dd12b97a6aafdd775b4b0584c97e499ef2745a520",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x76776486e3af55ed8f5be21ddc46f4f58c05483e",
            "BLAUXBSwCN7tArDu+hzqkWku5RxhJKIShtvlt0bUpPvCgzxnPhG6No73CECfKSPq1+3pxpFrMeFhLYqx18zeRig=",
            "+2VWuxSLDHPVLWwN0SuXpqr913W0sFhMl+SZ7ydFpSA=",
        ),
    ),
    # vanity/0x76876
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x76876ae5be855c9971c5f4c16b1037bcbe63d266",
            "0x236abc75bf44e777bcb3b94a33fb3ba24b6d77138127cf872ebf9f739c3282c7470b2a2be86c8f5e2fb066fe6a90e480371b9e18b30ebbaafbbabdde50804a6f",
            "17b1852559734d8a6e029ee4ae7323695cf78f9f443c440162b6272d4bd1625b",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x76876ae5be855c9971c5f4c16b1037bcbe63d266",
            "BCNqvHW/ROd3vLO5SjP7O6JLbXcTgSfPhy6/n3OcMoLHRwsqK+hsj14vsGb+apDkgDcbnhizDruq+7q93lCASm8=",
            "F7GFJVlzTYpuAp7krnMjaVz3j59EPEQBYrYnLUvRYls=",
        ),
    ),
    # vanity/0x76976
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x769768c94e5afc7e8baba0c6f6974a60b1f6321c",
            "0x8ede5854948872928cdfde5af48b79aafc090a483454c35663978c48cb08c8ae34be6862bf5cdf4ae63f532fe624209ba14ecc0b053dac1567730226e60e2785",
            "72530250c7fd8126bf05c0956b77071c08c2ba4706df22f9d4aef21ae619a3c2",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x769768c94e5afc7e8baba0c6f6974a60b1f6321c",
            "BI7eWFSUiHKSjN/eWvSLear8CQpINFTDVmOXjEjLCMiuNL5oYr9c30rmP1Mv5iQgm6FOzAsFPawVZ3MCJuYOJ4U=",
            "clMCUMf9gSa/BcCVa3cHHAjCukcG3yL51K7yGuYZo8I=",
        ),
    ),
    # vanity/0x77077
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x7707771c011eab5935a5ad14756a2ab954696ca7",
            "0x28a26f4470c2f34e2ab6c6ca7e8a085bc178ebf67f725f9d8d8e6c359e20542f2fbb7105396bf7de6277e5e20618b039a00e1246e6b839596a85de7db2086a36",
            "eacf690d7d7d1e7d77d248d4f9978b08cc053f0cf20ab2c904d82f66372ffbf6",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x7707771c011eab5935a5ad14756a2ab954696ca7",
            "BCiib0RwwvNOKrbGyn6KCFvBeOv2f3JfnY2ObDWeIFQvL7txBTlr995id+XiBhiwOaAOEkbmuDlZaoXefbIIajY=",
            "6s9pDX19Hn130kjU+ZeLCMwFPwzyCrLJBNgvZjcv+/Y=",
        ),
    ),
    # vanity/0x77177
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x77177d5f7652d654779e8b3e079803f542cf46a8",
            "0x17381adb63fb6a209ca20cbef672bdca040ae418fb2984114907ab14aa3712710cf3aff2d0d357847c408a1cebf16b8bc4d93b2eb309015882652fcb9244fcd9",
            "c6c5eb111adcc2d4906e9bcdf8a73c6c6466febb5f67799a3b6f15ee4f848fef",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x77177d5f7652d654779e8b3e079803f542cf46a8",
            "BBc4Gttj+2ognKIMvvZyvcoECuQY+ymEEUkHqxSqNxJxDPOv8tDTV4R8QIoc6/Fri8TZOy6zCQFYgmUvy5JE/Nk=",
            "xsXrERrcwtSQbpvN+Kc8bGRm/rtfZ3maO28V7k+Ej+8=",
        ),
    ),
    # vanity/0x77277
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x77277f2632e4affe43077c9716b69952275b86e1",
            "0xeb429ccab2abec52dcc09827f64e0f4905ed6cb445c6fde7a9e2c4423a26a1003436956212936c12610c7283efee92672f1795b41ac4417f4dcf4e6943e2e4f5",
            "210183f9a400ad0092b56c42c8e6eaffbb08b61f8aa8d253629bc774f78eeddb",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x77277f2632e4affe43077c9716b69952275b86e1",
            "BOtCnMqyq+xS3MCYJ/ZOD0kF7Wy0Rcb956nixEI6JqEANDaVYhKTbBJhDHKD7+6SZy8XlbQaxEF/Tc9OaUPi5PU=",
            "IQGD+aQArQCStWxCyObq/7sIth+KqNJTYpvHdPeO7ds=",
        ),
    ),
    # vanity/0x77377
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x773778b1ebf7c73bcf9ad96985d2e4050e4854fb",
            "0x491b0fcade4e939524169daf4cae81bb39554db6567c2eb907b501506b8f46c43d97e4ba167e04fe26610aafe7448a730d3c46fba5ad3b68a9ab5d331f839acb",
            "7f7dfa586905a05896567c369385ae9972b7c5ca0138ca4dcdaf7818efc90505",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x773778b1ebf7c73bcf9ad96985d2e4050e4854fb",
            "BEkbD8reTpOVJBadr0yugbs5VU22VnwuuQe1AVBrj0bEPZfkuhZ+BP4mYQqv50SKcw08RvulrTtoqatdMx+Dmss=",
            "f336WGkFoFiWVnw2k4WumXK3xcoBOMpNza94GO/JBQU=",
        ),
    ),
    # vanity/0x77477
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x77477fe610e0155a26ff287fe83101278fccc4e7",
            "0xace502793fa4ea5a2420cc21ca0cb14ad8571b24e983b236ac9d6633096a279c3d58362016d899208f745c5fab64f8d47e440d7f9a5331ad765106e1bb489355",
            "1e58c907ee48a80e0ea4936df92d151a729169e84a5979b0d165e40b64a87b9d",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x77477fe610e0155a26ff287fe83101278fccc4e7",
            "BKzlAnk/pOpaJCDMIcoMsUrYVxsk6YOyNqydZjMJaiecPVg2IBbYmSCPdFxfq2T41H5EDX+aUzGtdlEG4btIk1U=",
            "HljJB+5IqA4OpJNt+S0VGnKRaehKWXmw0WXkC2Soe50=",
        ),
    ),
    # vanity/0x77577
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x77577bf4ae63c26feac17c4ab8656ea2a2f30a76",
            "0xa14639d950096e3ff33b7c6ac443ef1b5bb0c53ccccd16794f8fab04a100f22558aca06323f3cac48806e4db9307f9f4ef2c085c03e2d760af9d6fa509d9efc7",
            "0e2151169ba52b0d2e38daa77eb88101f639364ea95b64e62b31f7b0013c8c2c",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x77577bf4ae63c26feac17c4ab8656ea2a2f30a76",
            "BKFGOdlQCW4/8zt8asRD7xtbsMU8zM0WeU+PqwShAPIlWKygYyPzysSIBuTbkwf59O8sCFwD4tdgr51vpQnZ78c=",
            "DiFRFpulKw0uONqnfriBAfY5Nk6pW2TmKzH3sAE8jCw=",
        ),
    ),
    # vanity/0x77677
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x7767723f81b348faa0c09f8b28d89b50e0c90bfd",
            "0x2558815eb8b2f69499d6d0d67935bac008a11616f44ba5ecabdaa456a089f3bcebf52b1bf34051c9a05887f36fa42f147228fcfd6dd2de5cc2c0d126ea43ea31",
            "198257d066d01c9340c0979b311a1e8e01c356fbadcd7706051e98abc91bd2be",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x7767723f81b348faa0c09f8b28d89b50e0c90bfd",
            "BCVYgV64svaUmdbQ1nk1usAIoRYW9Eul7KvapFagifO86/UrG/NAUcmgWIfzb6QvFHIo/P1t0t5cwsDRJupD6jE=",
            "GYJX0GbQHJNAwJebMRoejgHDVvutzXcGBR6Yq8kb0r4=",
        ),
    ),
    # vanity/0x77777
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x77777544be402cb18b5079eb685190ea61df5ef8",
            "0x8e4b98449764f665d6e633bbdec820e01abdbc3f3835f8eab1888621471aa31292cc3767e6768a0bacf0955ae03e61b926cd7d3a5800d067577dcb7c0fc4a849",
            "6c47fb6d82da725e85924e570d06ec37ee32f45989a2d16de8809269376c13a3",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x77777544be402cb18b5079eb685190ea61df5ef8",
            "BI5LmESXZPZl1uYzu97IIOAavbw/ODX46rGIhiFHGqMSksw3Z+Z2igus8JVa4D5huSbNfTpYANBnV33LfA/EqEk=",
            "bEf7bYLacl6Fkk5XDQbsN+4y9FmJotFt6ICSaTdsE6M=",
        ),
    ),
    # vanity/0x77877
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x77877b0a84b74af3128dadf6f309111c98e133da",
            "0xe73c1a70b376c77c8a26377103a9c1c7f41869f255464fce08a66009053562b6ebcced36c4b560e982300a7d2f0e3468445b5d8d5dc64a740d2781efc041837a",
            "ccdef509c8b9af32fbae116d8f1df7e3b3ac7974e85012f7570edbf78637cb39",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x77877b0a84b74af3128dadf6f309111c98e133da",
            "BOc8GnCzdsd8iiY3cQOpwcf0GGnyVUZPzgimYAkFNWK268ztNsS1YOmCMAp9Lw40aERbXY1dxkp0DSeB78BBg3o=",
            "zN71Cci5rzL7rhFtjx3347OseXToUBL3Vw7b94Y3yzk=",
        ),
    ),
    # vanity/0x77977
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x77977f71babb4d616528c2d1f00d35713c743001",
            "0xb9f897c7b660a51ffe77d09494b07b2acec3dddd68415aaeca6955775cb6c736d4ec28543754cbf8c046127ef1c7d3bee49b9365f2aa4ef78166573ecc394a0a",
            "e1da3757d71a242d7065eb1fff0db5d64e95aadd1f826b010ce211d1f49595ed",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x77977f71babb4d616528c2d1f00d35713c743001",
            "BLn4l8e2YKUf/nfQlJSweyrOw93daEFarsppVXdctsc21OwoVDdUy/jARhJ+8cfTvuSbk2Xyqk73gWZXPsw5Sgo=",
            "4do3V9caJC1wZesf/w211k6Vqt0fgmsBDOIR0fSVle0=",
        ),
    ),
    # vanity/0x78078
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x780780311285951fee2980c4bc2592507acabdbc",
            "0x9b0696db32605025a76383bc7699c0274e648535efe61f1d8f3cc1670cfb6cdb0cb1fc7c2902f319a7995565cb9d8a73429117941c0e5bc822cd047b0b4d99e4",
            "bb4c5e84b97713d7252537eb245556f91f67cf96cb2adc972d36fa88554298f2",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x780780311285951fee2980c4bc2592507acabdbc",
            "BJsGltsyYFAlp2ODvHaZwCdOZIU17+YfHY88wWcM+2zbDLH8fCkC8xmnmVVly52Kc0KRF5QcDlvIIs0EewtNmeQ=",
            "u0xehLl3E9clJTfrJFVW+R9nz5bLKtyXLTb6iFVCmPI=",
        ),
    ),
    # vanity/0x78178
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x781789f212868e58d6e4d1ca40f71138882c5182",
            "0x9909bd5919d7e38ada3a593f77c5e331a3038bdb607a8fb635c48465871cf28e9f3badc7807b1ef4d85bad278bc319ee049494f02eefb5255bc436e3ee523f8d",
            "317940265893af9b368e0765dee496503b948ed8200a84fb1cdd73555bb8e78b",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x781789f212868e58d6e4d1ca40f71138882c5182",
            "BJkJvVkZ1+OK2jpZP3fF4zGjA4vbYHqPtjXEhGWHHPKOnzutx4B7HvTYW60ni8MZ7gSUlPAu77UlW8Q24+5SP40=",
            "MXlAJliTr5s2jgdl3uSWUDuUjtggCoT7HN1zVVu454s=",
        ),
    ),
    # vanity/0x78278
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x7827867ca49e33551ceeafe5cafd4b20334692cf",
            "0x1265286036a8658608650646992117a1ad9195dd5af8b6caf1c10ef005b1adf492ce1de745c7f93f07a21112f7e3c01a14a5f0d88c7b374620123f2183394f75",
            "e40acbda2d89e83df8a28f3aefae434d8ad6ab2bdc3d50adc969d2f46b67ea77",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x7827867ca49e33551ceeafe5cafd4b20334692cf",
            "BBJlKGA2qGWGCGUGRpkhF6GtkZXdWvi2yvHBDvAFsa30ks4d50XH+T8HohES9+PAGhSl8NiMezdGIBI/IYM5T3U=",
            "5ArL2i2J6D34oo86765DTYrWqyvcPVCtyWnS9Gtn6nc=",
        ),
    ),
    # vanity/0x78378
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x783784c9c89d42ecacc468867116f4fc5a6b911d",
            "0x0532f937f15980193a8a4c0b7278ca6a2ea35ccf7a3a4878d68f234067790d287157be2b66ae10154116caf856eee7b4893c7118491d35ee01753fc16f23dad2",
            "2e7475e60e4a3c32d0e2f089e76804ef6fc6e5e183e387c48ddeba89af3a1d0f",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x783784c9c89d42ecacc468867116f4fc5a6b911d",
            "BAUy+TfxWYAZOopMC3J4ymouo1zPejpIeNaPI0BneQ0ocVe+K2auEBVBFsr4Vu7ntIk8cRhJHTXuAXU/wW8j2tI=",
            "LnR15g5KPDLQ4vCJ52gE72/G5eGD44fEjd66ia86HQ8=",
        ),
    ),
    # vanity/0x78478
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x78478febeaf0d44490ae31b0fa9424e0bcc199e3",
            "0x1c7ec698cf91478e93c524bf554c3b17f01e30896cfb094adf75f603099c06cb6f7a8598d2a6fb25b7f91d28cf899af257f0e788e216959e197d779fee46ed6e",
            "5049d93cc71fcc971ea8c282cc9e9d0c6df750536232611ba4f26c718f15d6f3",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x78478febeaf0d44490ae31b0fa9424e0bcc199e3",
            "BBx+xpjPkUeOk8Ukv1VMOxfwHjCJbPsJSt919gMJnAbLb3qFmNKm+yW3+R0oz4ma8lfw54jiFpWeGX13n+5G7W4=",
            "UEnZPMcfzJceqMKCzJ6dDG33UFNiMmEbpPJscY8V1vM=",
        ),
    ),
    # vanity/0x78578
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x7857869b005cbe68f8b88cf9ce9feb76b71fc7e0",
            "0x324ff967bf3d8f30f68d917072d401e5ff716dbf4c498a5ede9ad1fbc9073ce0ae88f2b36ae25ac0a4586f9caf54d866240d4a19816aecf39f494e7dfac0830f",
            "7bba3948c770ee228b02dbb0f7d8da587713831b07b9e234cd5146d6aab45c8d",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x7857869b005cbe68f8b88cf9ce9feb76b71fc7e0",
            "BDJP+We/PY8w9o2RcHLUAeX/cW2/TEmKXt6a0fvJBzzgrojys2riWsCkWG+cr1TYZiQNShmBauzzn0lOffrAgw8=",
            "e7o5SMdw7iKLAtuw99jaWHcTgxsHueI0zVFG1qq0XI0=",
        ),
    ),
    # vanity/0x78678
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x78678f8acb3af9a2f01d7353333bf6a76108b610",
            "0xd44c672e6aa41b7b0d814bcd7e22cba229e155a35a3be540ec6cf3c24f02dee9e12c3639cbd5251d445510611fa9d57426dab5d5a18a8711ae3f62541cf302d5",
            "d287fe8e4df301b2a3d0743cfc3eed04e16f91682348108fe38c8fb3bff603c2",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x78678f8acb3af9a2f01d7353333bf6a76108b610",
            "BNRMZy5qpBt7DYFLzX4iy6Ip4VWjWjvlQOxs88JPAt7p4Sw2OcvVJR1EVRBhH6nVdCbatdWhiocRrj9iVBzzAtU=",
            "0of+jk3zAbKj0HQ8/D7tBOFvkWgjSBCP44yPs7/2A8I=",
        ),
    ),
    # vanity/0x78778
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x7877855a7a746ef2b4406a6f0f0ce63aae275c87",
            "0xb1b7c16213fe616d033fa32bf19cca8dedb66bcc8c0fb48328f538a091b415bc472fb7d81e07797ce928c1c03d871246ac72e2fc78ec7903107bb30fce50d6bd",
            "d2890c837cf896b96e975e65bf67f787e17b1d2a74115d3d1dfcc5ee7f1b99e3",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x7877855a7a746ef2b4406a6f0f0ce63aae275c87",
            "BLG3wWIT/mFtAz+jK/Gcyo3ttmvMjA+0gyj1OKCRtBW8Ry+32B4HeXzpKMHAPYcSRqxy4vx47HkDEHuzD85Q1r0=",
            "0okMg3z4lrlul15lv2f3h+F7HSp0EV09HfzF7n8bmeM=",
        ),
    ),
    # vanity/0x78878
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x7887863a467be222547bd663aaea77a66fb7b68a",
            "0xa16cca8515795d7b1d880bcd1f01ec8104b3ab5214d6e0a528aab4f5c7a05fcfa0a97ee0014be146e67d9fb7bd7f4e8b1852240af6ca0992a167f49bee2f6c32",
            "9c1c181d52a884c14f1e5a3562956f43f1f9dee74e592a17f3ddfadb007f14d9",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x7887863a467be222547bd663aaea77a66fb7b68a",
            "BKFsyoUVeV17HYgLzR8B7IEEs6tSFNbgpSiqtPXHoF/PoKl+4AFL4UbmfZ+3vX9OixhSJAr2ygmSoWf0m+4vbDI=",
            "nBwYHVKohMFPHlo1YpVvQ/H53udOWSoX89362wB/FNk=",
        ),
    ),
    # vanity/0x78978
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x789789100926af77e2c2c2bf59508a0cd8e3a039",
            "0x5357fbb330dda133e5b8bc3f172144235ac76a59f3889c2735db70aabe29a3bbd753a0d63c85503046a7602f1fce59f838bc7304f199913c1f95ecf079f7b369",
            "f27771f6bd2e7dcb6995456a7bf018018517ac3ab480eb292844a3d033c93913",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x789789100926af77e2c2c2bf59508a0cd8e3a039",
            "BFNX+7Mw3aEz5bi8PxchRCNax2pZ84icJzXbcKq+KaO711Og1jyFUDBGp2AvH85Z+Di8cwTxmZE8H5Xs8Hn3s2k=",
            "8ndx9r0ufctplUVqe/AYAYUXrDq0gOspKESj0DPJORM=",
        ),
    ),
    # vanity/0x79079
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x79079669af81fbde00af6f3219826f29972cb9da",
            "0xac577e5daea1f9167884faed5d278f45cc1f435fe1e172bc7e43fd7d0773e4b6084da3eedc0211fc46cdcb02d581025fb82292cdca825f12bcfad525845040f6",
            "903d4e207c821931d67ad4557d6df8751d612fd39ab24c8490e7d29d65848612",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x79079669af81fbde00af6f3219826f29972cb9da",
            "BKxXfl2uofkWeIT67V0nj0XMH0Nf4eFyvH5D/X0Hc+S2CE2j7twCEfxGzcsC1YECX7giks3Kgl8SvPrVJYRQQPY=",
            "kD1OIHyCGTHWetRVfW34dR1hL9OaskyEkOfSnWWEhhI=",
        ),
    ),
    # vanity/0x79179
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x791790579a2921d318bc4d5ac505b86c3761fdf7",
            "0x65fe8c12f26b539063763c1532552f9fae26bc09f58f4d3b08c41fec4c38cbe81f6352b94edcd7ae9f89d624e49c78fd735e333a1deadf0f529e6e676a696619",
            "b7bc519460b05a564d4ca62782f93d24c5d37d7df4fe9cd2a2a02e83f75c7583",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x791790579a2921d318bc4d5ac505b86c3761fdf7",
            "BGX+jBLya1OQY3Y8FTJVL5+uJrwJ9Y9NOwjEH+xMOMvoH2NSuU7c166fidYk5Jx4/XNeMzod6t8PUp5uZ2ppZhk=",
            "t7xRlGCwWlZNTKYngvk9JMXTfX30/pzSoqAug/dcdYM=",
        ),
    ),
    # vanity/0x79279
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x792791474c33d16741f0269607d92067daad3006",
            "0x100fb118f5b226f76be204477e7d1804df3beaf21d5a7884cf817156c5b37ca6b4f8007f3a1dc442cab2ae9e0443a56a274e953516cc3ee944513623b8228df5",
            "d2405a2dc37f69a41382c90d8ac5745fcf5775f11dc741390480cdffdb8d9fa8",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x792791474c33d16741f0269607d92067daad3006",
            "BBAPsRj1sib3a+IER359GATfO+ryHVp4hM+BcVbFs3ymtPgAfzodxELKsq6eBEOlaidOlTUWzD7pRFE2I7gijfU=",
            "0kBaLcN/aaQTgskNisV0X89XdfEdx0E5BIDN/9uNn6g=",
        ),
    ),
    # vanity/0x79379
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x79379da028c1fddf786fafa2eaf8c874743c6f1c",
            "0xb862506c4b68ea7d7c60b7370d3c999ef2c658ec07daae2c2d6f4b744942655393b9aba7bc2e00ddc2060dbccb833696a5433567b621b45a0f1dbdd601cf1a71",
            "83cac4fb925057162a9cae89f4a6c85493c83e4221707af2f348e04f97fd011f",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x79379da028c1fddf786fafa2eaf8c874743c6f1c",
            "BLhiUGxLaOp9fGC3Nw08mZ7yxljsB9quLC1vS3RJQmVTk7mrp7wuAN3CBg28y4M2lqVDNWe2IbRaDx291gHPGnE=",
            "g8rE+5JQVxYqnK6J9KbIVJPIPkIhcHry80jgT5f9AR8=",
        ),
    ),
    # vanity/0x79479
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x7947923e8cdd21ef208c6a7c998d8613776d0660",
            "0xfbd5960d45fea7f05317a5be89ac196d585dd25999768bed923ed7b1332de1bd8cc74bdc2eb111fd1cf831ab40b298cdad4b7e0f727c3be83cc9e015a2c1b069",
            "4767c2fe1ea4a69c4274ca7ae3a0bdb86a24c4860a42de2207a9eb99d855fb47",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x7947923e8cdd21ef208c6a7c998d8613776d0660",
            "BPvVlg1F/qfwUxelvomsGW1YXdJZmXaL7ZI+17EzLeG9jMdL3C6xEf0c+DGrQLKYza1Lfg9yfDvoPMngFaLBsGk=",
            "R2fC/h6kppxCdMp646C9uGokxIYKQt4iB6nrmdhV+0c=",
        ),
    ),
    # vanity/0x79579
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x79579ac6f99b996e1cdffa8cf003f41360cde498",
            "0x59044b11bb16dbf1166d55f98e3d515793e112539e6860265c0afb1aab06ea7c92c6681a724fa6f55033a0c2fc258a6c2901864c56de5cca6eac16b8ef49ff1d",
            "a994374faf77517e52dbc47585c199e4baf2781b1148578937e726f351559ccf",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x79579ac6f99b996e1cdffa8cf003f41360cde498",
            "BFkESxG7FtvxFm1V+Y49UVeT4RJTnmhgJlwK+xqrBup8ksZoGnJPpvVQM6DC/CWKbCkBhkxW3lzKbqwWuO9J/x0=",
            "qZQ3T693UX5S28R1hcGZ5LryeBsRSFeJN+cm81FVnM8=",
        ),
    ),
    # vanity/0x79679
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x7967977c8a60810abe0060a40636a76f424ad4e9",
            "0xadf53c7c258a58c0324465b6938f9ee117e564e616cff16e1f253c14f8f0528f86611be71a214bae49c8372a5e6b22bbf5a04318678e62110aaa4466c0810c8c",
            "5cac46efc66d950a019225f007cbac4c33cac623951b46b87dfa7a7e837b07ea",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x7967977c8a60810abe0060a40636a76f424ad4e9",
            "BK31PHwliljAMkRltpOPnuEX5WTmFs/xbh8lPBT48FKPhmEb5xohS65JyDcqXmsiu/WgQxhnjmIRCqpEZsCBDIw=",
            "XKxG78ZtlQoBkiXwB8usTDPKxiOVG0a4ffp6foN7B+o=",
        ),
    ),
    # vanity/0x79779
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x79779acd258c0343e6a747422467472b3e1519b4",
            "0x00647c33ebc6a66fa572fb3541761e9eff572e3b5e0183f587a930659b5f52947717c25cf734043614c2458dd55d70361dc40d06934268c4e9d67f6fc5b8dab5",
            "e6cbbfe0133cbf58444392edb108b5c0ee40f17e65ab64425420e210ff876df6",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x79779acd258c0343e6a747422467472b3e1519b4",
            "BABkfDPrxqZvpXL7NUF2Hp7/Vy47XgGD9YepMGWbX1KUdxfCXPc0BDYUwkWN1V1wNh3EDQaTQmjE6dZ/b8W42rU=",
            "5su/4BM8v1hEQ5LtsQi1wO5A8X5lq2RCVCDiEP+HbfY=",
        ),
    ),
    # vanity/0x79879
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x79879b76a485dbb5ed4b314c4e7e4e87b6a1254f",
            "0xd4daf50f8dbfbcaa5843f91edd52c9ece88f083f0815a367801e2570482e3c28d6333d08fdf6490a9ac47919ea11b05d82cfd53053a56dfe44ea160ce44cd6d8",
            "2de300fe2b15f102f4a7043f94637d578bd153b56ea99e379d6c82adef18c870",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x79879b76a485dbb5ed4b314c4e7e4e87b6a1254f",
            "BNTa9Q+Nv7yqWEP5Ht1Syezojwg/CBWjZ4AeJXBILjwo1jM9CP32SQqaxHkZ6hGwXYLP1TBTpW3+ROoWDORM1tg=",
            "LeMA/isV8QL0pwQ/lGN9V4vRU7VuqZ43nWyCre8YyHA=",
        ),
    ),
    # vanity/0x79979
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x7997969951356d907d5da9493daaacdb81b87f8a",
            "0xcea84a961471b4a33b228405dee498c4bd1841e189dc24ccc3ba5cc19554260bc7c1d5b86c9b216a50003e891da5ea753b200cee1f91f076c271748a49d6acd0",
            "287df33b0c8e0499ccd2d63e6517b386d1218744ed98a5c3225624b0926176cf",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x7997969951356d907d5da9493daaacdb81b87f8a",
            "BM6oSpYUcbSjOyKEBd7kmMS9GEHhidwkzMO6XMGVVCYLx8HVuGybIWpQAD6JHaXqdTsgDO4fkfB2wnF0iknWrNA=",
            "KH3zOwyOBJnM0tY+ZRezhtEhh0TtmKXDIlYksJJhds8=",
        ),
    ),
    # vanity/0x80080
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x800807cae32fbfe8f573f470937115d9334595ad",
            "0xae842f579a23148da863af402d342faf4edc35e51a009faf09f5265b850fdd88632922e67f008a7126a4c9d151aea6c8ce9c8446e05e8fa292b991dcd737eeff",
            "27f689eb02026f2dc89b3b9160f2aff995c59fb71ec00404922769ccfa51820d",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x800807cae32fbfe8f573f470937115d9334595ad",
            "BK6EL1eaIxSNqGOvQC00L69O3DXlGgCfrwn1JluFD92IYyki5n8AinEmpMnRUa6myM6chEbgXo+ikrmR3Nc37v8=",
            "J/aJ6wICby3ImzuRYPKv+ZXFn7cewAQEkidpzPpRgg0=",
        ),
    ),
    # vanity/0x80180
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x80180ec263fb806eb484529f579ff31441323f9a",
            "0x775a78af4f6933750c45445656b1a561a0db69573c7d7adadf6db211c7d6d23d31e18b29dcfacc0c89ee9daaae4c2e9ea7324cad5681d0e614b1e23a43ecbc63",
            "702c91f05bc51f0e6da7111b2c3b2019aae18c4583063641ce088844d892564b",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x80180ec263fb806eb484529f579ff31441323f9a",
            "BHdaeK9PaTN1DEVEVlaxpWGg22lXPH162t9tshHH1tI9MeGLKdz6zAyJ7p2qrkwunqcyTK1WgdDmFLHiOkPsvGM=",
            "cCyR8FvFHw5tpxEbLDsgGarhjEWDBjZBzgiIRNiSVks=",
        ),
    ),
    # vanity/0x80280
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x80280ad7cdf13d870c1f143eb20a8c5e76108c54",
            "0x0f04b9ed83ca8f1f49fffbd10ca825dadedde55fb597429d12250d42b6bbfe45eae79ae40cffa931514ebd101585dd9e101d08c9c6abb1172cd3f6285c99059a",
            "1acadc717b2529fa1166d46e6d42713601f0df2cba6598b7209fead0852c14e0",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x80280ad7cdf13d870c1f143eb20a8c5e76108c54",
            "BA8Eue2Dyo8fSf/70QyoJdre3eVftZdCnRIlDUK2u/5F6uea5Az/qTFRTr0QFYXdnhAdCMnGq7EXLNP2KFyZBZo=",
            "GsrccXslKfoRZtRubUJxNgHw3yy6ZZi3IJ/q0IUsFOA=",
        ),
    ),
    # vanity/0x80380
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x80380a93b0ba151863b28a1cffcfed522e2e311c",
            "0x5aedacc532a5307b6047691b411af8a6fd18771dd3cc44b86c90304cf1a3b741def7106857c923385244dfa0a2c777adabf2c030dc66b0cb616a10c72977fccc",
            "6b4c3d0b0fecae742f3aba0d4bc3fd74aa54771ff9d62b6d69309dd1104dd0f9",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x80380a93b0ba151863b28a1cffcfed522e2e311c",
            "BFrtrMUypTB7YEdpG0Ea+Kb9GHcd08xEuGyQMEzxo7dB3vcQaFfJIzhSRN+gosd3ravywDDcZrDLYWoQxyl3/Mw=",
            "a0w9Cw/srnQvOroNS8P9dKpUdx/51ittaTCd0RBN0Pk=",
        ),
    ),
    # vanity/0x80480
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x804804e1acce0b6eecb5b7de466beb58a1543680",
            "0x7b3771ce94b8b18b626bd0ed4d455c14cc8215b14c61702aa896b288c224fbecb05a6894dd9079e96641f3d94260fded2e907c096faf28a0624d6b35540bb7b0",
            "092cd98a3d5f937037ddf9480d52bfe3ef3ca763bc07069b37103cdd5f21f2da",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x804804e1acce0b6eecb5b7de466beb58a1543680",
            "BHs3cc6UuLGLYmvQ7U1FXBTMghWxTGFwKqiWsojCJPvssFpolN2QeelmQfPZQmD97S6QfAlvryigYk1rNVQLt7A=",
            "CSzZij1fk3A33flIDVK/4+88p2O8BwabNxA83V8h8to=",
        ),
    ),
    # vanity/0x80580
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x80580b43703562d454c975afdedddc0173b45b62",
            "0xe07225a75cde9390f1db2ddf40bb62c77b27da1a2dd49418b6f2a10fca629968209963b156c060de8b37e6bb7be5b46f95e8eba3c680f3c2ebd063ddd1be080b",
            "651142e731f78467cb35b2e74b7100302dd181e24dac1ba4b975cd3950e48134",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x80580b43703562d454c975afdedddc0173b45b62",
            "BOByJadc3pOQ8dst30C7Ysd7J9oaLdSUGLbyoQ/KYploIJljsVbAYN6LN+a7e+W0b5Xo66PGgPPC69Bj3dG+CAs=",
            "ZRFC5zH3hGfLNbLnS3EAMC3RgeJNrBukuXXNOVDkgTQ=",
        ),
    ),
    # vanity/0x80680
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x8068023a69c51b843e376078aa9afdaf1880a748",
            "0x0612be2ee19e4b245b81cdec8fa7edc99b7cb4c359be624fae7b34e3102b1fc860057029aff221756cb444b916ebfdd0ae54db7faf6c1dc45afdfbd198e3ccf3",
            "03fb3ab5a44c84b14bf3f35bcaa0a6339b389213735cb94757d69066c8ec0ba6",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x8068023a69c51b843e376078aa9afdaf1880a748",
            "BAYSvi7hnkskW4HN7I+n7cmbfLTDWb5iT657NOMQKx/IYAVwKa/yIXVstES5Fuv90K5U23+vbB3EWv370ZjjzPM=",
            "A/s6taRMhLFL8/NbyqCmM5s4khNzXLlHV9aQZsjsC6Y=",
        ),
    ),
    # vanity/0x80780
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x80780737ec86f7391a7f648384ab9d0d3e9ef8d6",
            "0xbb98e825c7d5e0a9da147bcd65967c5c98bae1d144a910f49e4d6df77b99a70c25dde869f4cebe49cfef350f9ef12cf69fa5b97eeab1217c70e71d6997aa31b3",
            "a2cebb4be15340d9f3ec7dc2d0436d959e06f4e581d383b526ad100f7efcdcf5",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x80780737ec86f7391a7f648384ab9d0d3e9ef8d6",
            "BLuY6CXH1eCp2hR7zWWWfFyYuuHRRKkQ9J5Nbfd7macMJd3oafTOvknP7zUPnvEs9p+luX7qsSF8cOcdaZeqMbM=",
            "os67S+FTQNnz7H3C0ENtlZ4G9OWB04O1Jq0QD3783PU=",
        ),
    ),
    # vanity/0x80880
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x8088019ac584628e3e84d8940c4476c00eaeb65e",
            "0x9bcfaa0b77f36e3d4babef1b7c678a1db0fa83e112a4591fd63d32ef6e3342de5ec4384578d7eb7d1f781ada410c9a0ebac6adbfeade6f29b4dc29d5a37a296b",
            "5c7a3643cf7dfbfd74adbda9338afdebd31fdd2b5f46aa739a79d370f4a4419a",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x8088019ac584628e3e84d8940c4476c00eaeb65e",
            "BJvPqgt38249S6vvG3xnih2w+oPhEqRZH9Y9Mu9uM0LeXsQ4RXjX630feBraQQyaDrrGrb/q3m8ptNwp1aN6KWs=",
            "XHo2Q899+/10rb2pM4r969Mf3StfRqpzmnnTcPSkQZo=",
        ),
    ),
    # vanity/0x80980
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x809804d4d65bede0196342f5e56e10cb26d99fd9",
            "0xf3ec820493ac42dd275a38cda9bc5626d21e277d5c7bf161940ae04bc9b1389ba50a19b67fefcddf637726142a1d0576fa987cf82dedd2c5b2bede2f4313408e",
            "87358590ac8fc3697daf122ee4b66c56f2d654d21b1f1077c5093dc4f8b6e5a1",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x809804d4d65bede0196342f5e56e10cb26d99fd9",
            "BPPsggSTrELdJ1o4zam8VibSHid9XHvxYZQK4EvJsTibpQoZtn/vzd9jdyYUKh0FdvqYfPgt7dLFsr7eL0MTQI4=",
            "hzWFkKyPw2l9rxIu5LZsVvLWVNIbHxB3xQk9xPi25aE=",
        ),
    ),
    # vanity/0x81081
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x81081f35fbc4c4ddca9b1cf15dc358ee3d66ac21",
            "0x16804ba2e3861ed43ca93ba2b03aa5d0f7bd52c5db6ceb096bdae72bf68859fe2754809cc669fb868e3b274efa60bf4266c09bccceb0e8ac042ad4b80925274d",
            "4e8391a8a1af395f033ba58b0d496fb7e2bbe35b8ae6b04b8e7cc2211dd3b001",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x81081f35fbc4c4ddca9b1cf15dc358ee3d66ac21",
            "BBaAS6Ljhh7UPKk7orA6pdD3vVLF22zrCWva5yv2iFn+J1SAnMZp+4aOOydO+mC/QmbAm8zOsOisBCrUuAklJ00=",
            "ToORqKGvOV8DO6WLDUlvt+K741uK5rBLjnzCIR3TsAE=",
        ),
    ),
    # vanity/0x81181
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x811815b472321dcc34c434044abe021aca85a69d",
            "0xa6d2bd18b82044a19ec870b13a767f3e99685cfd524bf1df1f942a1afe3832d7dea57c6cb2ebe8d586d26db7f61bd4818db7aea7f5ba2e75ed65e2c24d129f37",
            "2aa6381d2d5852c20738f3c116303282667571942ba5e75954b8184214c28ad5",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x811815b472321dcc34c434044abe021aca85a69d",
            "BKbSvRi4IEShnshwsTp2fz6ZaFz9Ukvx3x+UKhr+ODLX3qV8bLLr6NWG0m239hvUgY23rqf1ui517WXiwk0Snzc=",
            "KqY4HS1YUsIHOPPBFjAygmZ1cZQrpedZVLgYQhTCitU=",
        ),
    ),
    # vanity/0x81281
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x812811f99f273054bdf809e5d97baf46ab9207f1",
            "0xc47c032da3ca94b2e9a39c622adf26d7ade5a3c73a051b8d579cf64e0187f051ce92ecdea158a03b505f235df6841027f69d2825efab5415847773e1bc558c40",
            "f9a23c3a5c798ba04243dd06ab794f1db73fb5cf793e34770079bb02a043bf31",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x812811f99f273054bdf809e5d97baf46ab9207f1",
            "BMR8Ay2jypSy6aOcYirfJtet5aPHOgUbjVec9k4Bh/BRzpLs3qFYoDtQXyNd9oQQJ/adKCXvq1QVhHdz4bxVjEA=",
            "+aI8Olx5i6BCQ90Gq3lPHbc/tc95PjR3AHm7AqBDvzE=",
        ),
    ),
    # vanity/0x81381
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x81381ef738b3a48696ecbd189b358cc7230dd585",
            "0xa1ae501d262ff3d6a7f37fee359c634c6b01be69ce29c67ce2bdbe0eca736e440861e142a47d1f3f2dd0f81ea0310c2158447715d854e7a5bec988403c5cadc8",
            "f91738f2bdf8d652e831c7ac45d20535602c50dc697189a1051ede1e09674b16",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x81381ef738b3a48696ecbd189b358cc7230dd585",
            "BKGuUB0mL/PWp/N/7jWcY0xrAb5pzinGfOK9vg7Kc25ECGHhQqR9Hz8t0PgeoDEMIVhEdxXYVOelvsmIQDxcrcg=",
            "+Rc48r341lLoMcesRdIFNWAsUNxpcYmhBR7eHglnSxY=",
        ),
    ),
    # vanity/0x81481
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x814816354cfc54705b0bc588e9658015cc294b7b",
            "0x8ba2f4a92262fb0bfc8e5e59b16ac6b589bf5adf1f2c0677e4a9c0baa565601840a82f0cfa8a0c70fa0d971b7cc4cba596590b382d73bbf6571ebafe1899f348",
            "de0e81ef4092530c23bbc8304d1daa13f2f3f561552625b72714749838e939ea",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x814816354cfc54705b0bc588e9658015cc294b7b",
            "BIui9KkiYvsL/I5eWbFqxrWJv1rfHywGd+SpwLqlZWAYQKgvDPqKDHD6DZcbfMTLpZZZCzgtc7v2Vx66/hiZ80g=",
            "3g6B70CSUwwju8gwTR2qE/Lz9WFVJiW3JxR0mDjpOeo=",
        ),
    ),
    # vanity/0x81581
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x81581e3700d5516f0e84f91a9fde753d85e90270",
            "0x28acc0c8e5f4b33ab65d1966c43d0922362d748941bc9729e388f1a6978020d74dc12e996855ac32de2759bceebf631a8a69610baaa4b8e0cb31ba2147e016fe",
            "30c6d4dee0140d38f882ebb2698e527c99a8fe843db61ddfc0926a1e892391ab",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x81581e3700d5516f0e84f91a9fde753d85e90270",
            "BCiswMjl9LM6tl0ZZsQ9CSI2LXSJQbyXKeOI8aaXgCDXTcEumWhVrDLeJ1m87r9jGoppYQuqpLjgyzG6IUfgFv4=",
            "MMbU3uAUDTj4guuyaY5SfJmo/oQ9th3fwJJqHokjkas=",
        ),
    ),
    # vanity/0x81681
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x81681dc21af88e820671f4dcf9fb28cf21af004b",
            "0xdac5e0088f1f3d1eb1ccd638f36b5784f240f396697535fe2bfaa410b69591e31f3e4ee646291332d9d9fa986b091bcf57b6a9e4376513d3afc116c879a3c2bf",
            "e1acbae30229476a1ae3ddb7f791acb55e7ab83a936e07a48c03f28e85e2f65d",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x81681dc21af88e820671f4dcf9fb28cf21af004b",
            "BNrF4AiPHz0esczWOPNrV4TyQPOWaXU1/iv6pBC2lZHjHz5O5kYpEzLZ2fqYawkbz1e2qeQ3ZRPTr8EWyHmjwr8=",
            "4ay64wIpR2oa492395GstV56uDqTbgekjAPyjoXi9l0=",
        ),
    ),
    # vanity/0x81781
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x817819b8e7c1a90044e82040451969fb94efafbc",
            "0x4762c8c159973d28a088525b6acddf6477eff6e1fc65e6b284578ebb075bd1c06b7833779d2c5421057ca7e60bcf449b283c8b8558846fe45330d1c44c26e27e",
            "eee135117531909cbd71dacb2cebfcb1d258143bdb7d6d96fbcb4e723a0f2620",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x817819b8e7c1a90044e82040451969fb94efafbc",
            "BEdiyMFZlz0ooIhSW2rN32R37/bh/GXmsoRXjrsHW9HAa3gzd50sVCEFfKfmC89Emyg8i4VYhG/kUzDRxEwm4n4=",
            "7uE1EXUxkJy9cdrLLOv8sdJYFDvbfW2W+8tOcjoPJiA=",
        ),
    ),
    # vanity/0x81881
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x81881778abf05bed14d9ba8ebff9469d6797708d",
            "0xb48f9369d2750e02f7cbd98e7b64964b2fe579f3293b33a673e020ec719f36834a14e682db5bf3935e1b6bcd6ea1c444181d86386a82a014218ff81cdcc4095c",
            "cf439ad7b05de4f2d3544ae8478a13535ac8bb0565db75ca29cd3774c1f783fc",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x81881778abf05bed14d9ba8ebff9469d6797708d",
            "BLSPk2nSdQ4C98vZjntklksv5XnzKTszpnPgIOxxnzaDShTmgttb85NeG2vNbqHERBgdhjhqgqAUIY/4HNzECVw=",
            "z0Oa17Bd5PLTVEroR4oTU1rIuwVl23XKKc03dMH3g/w=",
        ),
    ),
    # vanity/0x81981
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x81981e5c04f03f460c6e71f45047925405ffd082",
            "0x7fec7a80fbc0286dfbdc9c3ce370a02903bb078b1be7cf09315384ff6ec11cf815b8f49e2dd4ac9027ebb2b5463dea2c15ae476a95e7d5a2021753d61a8b8891",
            "42baab174e2b3e47293fe843dbd3f19f81a9e02c1f5745fa4f1693fb3d082ddb",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x81981e5c04f03f460c6e71f45047925405ffd082",
            "BH/seoD7wCht+9ycPONwoCkDuweLG+fPCTFThP9uwRz4Fbj0ni3UrJAn67K1Rj3qLBWuR2qV59WiAhdT1hqLiJE=",
            "QrqrF04rPkcpP+hD29Pxn4Gp4CwfV0X6TxaT+z0ILds=",
        ),
    ),
    # vanity/0x82082
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x820826f5fffe3f40c775e04cde0f957edb9691f4",
            "0x9de1b0757c85c532ffad451c76ed537db06db09fcd4a13979c9eea7ff60bd2648e0bd6cbeb38e20e858ffc52496c8a5447a2fb5e63e62fa2351ebfae0e015994",
            "dd4be03e04f53da8a1e48cddd044c0aa556f4fe91c178b89b8c1809c3a1a5009",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x820826f5fffe3f40c775e04cde0f957edb9691f4",
            "BJ3hsHV8hcUy/61FHHbtU32wbbCfzUoTl5ye6n/2C9JkjgvWy+s44g6Fj/xSSWyKVEei+15j5i+iNR6/rg4BWZQ=",
            "3UvgPgT1Paih5Izd0ETAqlVvT+kcF4uJuMGAnDoaUAk=",
        ),
    ),
    # vanity/0x82182
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x821829e1db37680f6802c91d2d7141e27f0c7caf",
            "0xfbd4770ffe9b0462f01ca42b4a75a5c9d3e9a16a43757573de642f08626d3d5b52c8724a1e4848988c55ee01cb75e67bed0570c4f64cab5f14e46e30730947cc",
            "9667892d8d62a6e6dd21efcf9de5f9e85c1a0942f6e686c9aeb22fd73da63fca",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x821829e1db37680f6802c91d2d7141e27f0c7caf",
            "BPvUdw/+mwRi8BykK0p1pcnT6aFqQ3V1c95kLwhibT1bUshySh5ISJiMVe4By3Xme+0FcMT2TKtfFORuMHMJR8w=",
            "lmeJLY1ipubdIe/PneX56FwaCUL25obJrrIv1z2mP8o=",
        ),
    ),
    # vanity/0x82282
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x82282978c9d2476143e63bc66b0ba26bde5ee339",
            "0x7a4ba9d4f143ad1ffbe5980b4eddded58d819617cf5078c2eab1a3c63ae47bd2f6fbcfd1ca5ab00aa7aaf73f9931c9373550d3563bcabd09aff7fc1b0f731f4e",
            "0e00db99fd36295eb148c42d5e37e3b922ade56873413cacf6981ac83ff44d8a",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x82282978c9d2476143e63bc66b0ba26bde5ee339",
            "BHpLqdTxQ60f++WYC07d3tWNgZYXz1B4wuqxo8Y65HvS9vvP0cpasAqnqvc/mTHJNzVQ01Y7yr0Jr/f8Gw9zH04=",
            "DgDbmf02KV6xSMQtXjfjuSKt5WhzQTys9pgayD/0TYo=",
        ),
    ),
    # vanity/0x82382
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x823825920606a7e2654b3e1e9f68da0ea41b01bc",
            "0x635d86dac42b59755668bc1c2ba0ef431b17bb5400044561a8252440e87bf5ca7e8a823a5573b5c2f889228a3ee78819e937240d07ad99f97520201483c8e717",
            "0ae353d1cc5774bb05231671b95655a9f8c43c622f5e9443999da39d4525031d",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x823825920606a7e2654b3e1e9f68da0ea41b01bc",
            "BGNdhtrEK1l1Vmi8HCug70MbF7tUAARFYaglJEDoe/XKfoqCOlVztcL4iSKKPueIGek3JA0HrZn5dSAgFIPI5xc=",
            "CuNT0cxXdLsFIxZxuVZVqfjEPGIvXpRDmZ2jnUUlAx0=",
        ),
    ),
    # vanity/0x82482
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x82482c919b8cab184fbb939b908079106fc03a8d",
            "0x3b60a440f239ec9bdd043e3fcdad991b38abeaeec50daa64206bf2471c09d8b3902cf33be5588419ee513f23bce72e353a1b60ce81c19ddf8890519e6d4d4fdb",
            "74aeee47239a1c0d9ce9d503e03945c919d250ad5f50288cbfb6e09d0543de2f",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x82482c919b8cab184fbb939b908079106fc03a8d",
            "BDtgpEDyOeyb3QQ+P82tmRs4q+ruxQ2qZCBr8kccCdizkCzzO+VYhBnuUT8jvOcuNTobYM6BwZ3fiJBRnm1NT9s=",
            "dK7uRyOaHA2c6dUD4DlFyRnSUK1fUCiMv7bgnQVD3i8=",
        ),
    ),
    # vanity/0x82582
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x82582100c082155f86d9def028bc11213a4483bc",
            "0x31075a6c56553b2d6dd1dad761ab28af233b48abf8e50e53d615f99b525b13563c93e02f30035a9e7786f03e446b1552f2d56b77a0926dcd1463e522d2f7368c",
            "38e5dfe059cbcc379213301c4c2dc2477f25868cd1276c14ae74bb43c8d03999",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x82582100c082155f86d9def028bc11213a4483bc",
            "BDEHWmxWVTstbdHa12GrKK8jO0ir+OUOU9YV+ZtSWxNWPJPgLzADWp53hvA+RGsVUvLVa3egkm3NFGPlItL3Now=",
            "OOXf4FnLzDeSEzAcTC3CR38lhozRJ2wUrnS7Q8jQOZk=",
        ),
    ),
    # vanity/0x82682
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x82682be66646973b905547de0eef0fa29893afd5",
            "0xcf033cd031582f0c9015c293f2773aa31f2812d8092b26994793f24dfeab79eb60c9660690cc2a37a31d79470dc96d5eba59645a29f09434b758f4402f7792e0",
            "723923cc8ce70ffdaf3b3ed524c730440f27fa033338220cedbf14ae754ea68e",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x82682be66646973b905547de0eef0fa29893afd5",
            "BM8DPNAxWC8MkBXCk/J3OqMfKBLYCSsmmUeT8k3+q3nrYMlmBpDMKjejHXlHDcltXrpZZFop8JQ0t1j0QC93kuA=",
            "cjkjzIznD/2vOz7VJMcwRA8n+gMzOCIM7b8UrnVOpo4=",
        ),
    ),
    # vanity/0x82782
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x82782c4aea2e404bd03bdb2e892a2690f778cf56",
            "0xc2c833b91f32bf556ab5473b67ccc89f0156f8bd238a623b6a906721abdeb221f521b8d9458244aad1f9763c8065c3107268989b56a18e59f2dade2e9948d08f",
            "0d9394063f6aac1f83fb041fbfdd5b2b07bcb25443bebb67b644fd313d26b685",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x82782c4aea2e404bd03bdb2e892a2690f778cf56",
            "BMLIM7kfMr9VarVHO2fMyJ8BVvi9I4piO2qQZyGr3rIh9SG42UWCRKrR+XY8gGXDEHJomJtWoY5Z8treLplI0I8=",
            "DZOUBj9qrB+D+wQfv91bKwe8slRDvrtntkT9MT0mtoU=",
        ),
    ),
    # vanity/0x82882
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x82882108f7189e7396d118b1dfa37f46e9a73d89",
            "0x788d4d1008b6f298d8ff51cf7adec1f7020f14cf6b29d1d035196004b703279eed38ac7ad6500bf8567d6d873f39645566cef3d0d07c036bf8f374d577d5704b",
            "203715565fdf4152b004e5485f86ef859e3664e5ecea052e757f2f0c8b34d6f0",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x82882108f7189e7396d118b1dfa37f46e9a73d89",
            "BHiNTRAItvKY2P9Rz3rewfcCDxTPaynR0DUZYAS3Ayee7TisetZQC/hWfW2HPzlkVWbO89DQfANr+PN01XfVcEs=",
            "IDcVVl/fQVKwBOVIX4bvhZ42ZOXs6gUudX8vDIs01vA=",
        ),
    ),
    # vanity/0x82982
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x829823ededce5356c80b963076f071e7e19a6d37",
            "0x8072cab1e672e05cc572da5bedba385ca7064f154c06a545a46a27086beb1ae8760e9e63c4a40be0eb881fd2ab8a5794c69276f421c14d6fa2ea4302839665ca",
            "5afa3c6497bce53289f42a0047734c4385248a21d4261bd5afac804113a65f96",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x829823ededce5356c80b963076f071e7e19a6d37",
            "BIByyrHmcuBcxXLaW+26OFynBk8VTAalRaRqJwhr6xrodg6eY8SkC+DriB/Sq4pXlMaSdvQhwU1voupDAoOWZco=",
            "Wvo8ZJe85TKJ9CoAR3NMQ4UkiiHUJhvVr6yAQROmX5Y=",
        ),
    ),
    # vanity/0x83083
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x83083305329d9a0f042936cf70cdcbd79a168711",
            "0x20d8165068700a95a8b3922e559b9e80d74c8168da8f51e51658b18250306bab7e7ced46a6c58d7a2b70b5d7c229ec71a5434846c7db3df0e67309cadad7e5a3",
            "f14ca55c02a7aadfb8cd6da5a6be0ded187a252d7f7664f885e2a1accc3a026f",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x83083305329d9a0f042936cf70cdcbd79a168711",
            "BCDYFlBocAqVqLOSLlWbnoDXTIFo2o9R5RZYsYJQMGurfnztRqbFjXorcLXXwinscaVDSEbH2z3w5nMJytrX5aM=",
            "8UylXAKnqt+4zW2lpr4N7Rh6JS1/dmT4heKhrMw6Am8=",
        ),
    ),
    # vanity/0x83183
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x83183292c1f48d09fca54f9421e4f2fc71800b70",
            "0x74247a9b8b280805e22d9251dd5949b1141617865da4a9c8b066602bc9c2848c282a31269482864fae4fb9a803268b15ea9145e046dd2820ffebd1624df23239",
            "003e5f87cbc2a6fac9f7efc16b7e773a054a647c3b7ecfdc6bfe9b670b9e29d8",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x83183292c1f48d09fca54f9421e4f2fc71800b70",
            "BHQkepuLKAgF4i2SUd1ZSbEUFheGXaSpyLBmYCvJwoSMKCoxJpSChk+uT7moAyaLFeqRReBG3Sgg/+vRYk3yMjk=",
            "AD5fh8vCpvrJ9+/Ba353OgVKZHw7fs/ca/6bZwueKdg=",
        ),
    ),
    # vanity/0x83283
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x83283d76157418efb3d6862d387f83c8f60ed2ba",
            "0xed9ac29155cf0c96b660694e2c3f38ec217a63df3fcba2ed0947967afb90af8b8081fa0222335b7c6b31429814a9eb4049d4c7a93e9e134facd01ac91b694a6d",
            "8f6678dc73bd89e7a3075ff3fa127a06779120c901651d13a173376ef38ca349",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x83283d76157418efb3d6862d387f83c8f60ed2ba",
            "BO2awpFVzwyWtmBpTiw/OOwhemPfP8ui7QlHlnr7kK+LgIH6AiIzW3xrMUKYFKnrQEnUx6k+nhNPrNAayRtpSm0=",
            "j2Z43HO9ieejB1/z+hJ6BneRIMkBZR0ToXM3bvOMo0k=",
        ),
    ),
    # vanity/0x83383
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x833838da31871620e4125ac15ca0eb46432fa1d3",
            "0xda2d0d7d23200a997e434c26761757b01820bb8188cef476dbe73179fccb89847cc3411514afdc3a28309e0d420b42e1fbed9ab45f739edbe118f2db0c2ca5b2",
            "9d9ad31995c63018c8942613c17d4a42c73c5dffbb25376c58d5822ced14004f",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x833838da31871620e4125ac15ca0eb46432fa1d3",
            "BNotDX0jIAqZfkNMJnYXV7AYILuBiM70dtvnMXn8y4mEfMNBFRSv3DooMJ4NQgtC4fvtmrRfc57b4Rjy2wwspbI=",
            "nZrTGZXGMBjIlCYTwX1KQsc8Xf+7JTdsWNWCLO0UAE8=",
        ),
    ),
    # vanity/0x83483
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x83483b208de3e18a84c0c51104969cfd874b4b00",
            "0x40ab59445d4facce9613a57a08e36cec51dd9fcf07068272fbb2c2c7c5586fe4efee1a3df7c844173aa532539d89a5501518b836505b5fbed5ecc79267401f40",
            "72e9345da28db586d8d524be0fdd6cbc5290245f307615d35b84d1f587dd775a",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x83483b208de3e18a84c0c51104969cfd874b4b00",
            "BECrWURdT6zOlhOlegjjbOxR3Z/PBwaCcvuywsfFWG/k7+4aPffIRBc6pTJTnYmlUBUYuDZQW1++1ezHkmdAH0A=",
            "cuk0XaKNtYbY1SS+D91svFKQJF8wdhXTW4TR9Yfdd1o=",
        ),
    ),
    # vanity/0x83583
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x8358394e56a0d3718d90c0912bba99b5209517f4",
            "0x06ddc7f33b7dfb0498990e96cbbbb1bfcf9e6ce862ac28f947a7cb8281b87959e2a33ffad3a6a9942e823834875bf9f01f024ad052c4b7ad94baf384fda052b3",
            "d4ad102a4e6d497a71a3f409e05b92c2924abfe24ef45483fe6115f91d4078d0",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x8358394e56a0d3718d90c0912bba99b5209517f4",
            "BAbdx/M7ffsEmJkOlsu7sb/PnmzoYqwo+Ueny4KBuHlZ4qM/+tOmqZQugjg0h1v58B8CStBSxLetlLrzhP2gUrM=",
            "1K0QKk5tSXpxo/QJ4FuSwpJKv+JO9FSD/mEV+R1AeNA=",
        ),
    ),
    # vanity/0x83683
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x836830fe5352087af4e4c1ad5d34556eaa87309c",
            "0xc5b42f5bf04d245045ec0ace6e4cd6e713ca2b2f0a526d729bf426ca57a04eee285a7c4ad64576fb364d88173007afec0c29b3b359b61ac4388552694e6976f5",
            "70775383b6fcc1a0873114fec9bb83344ffa86ef88afab9e27f7c95409c14fb1",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x836830fe5352087af4e4c1ad5d34556eaa87309c",
            "BMW0L1vwTSRQRewKzm5M1ucTyisvClJtcpv0JspXoE7uKFp8StZFdvs2TYgXMAev7Awps7NZthrEOIVSaU5pdvU=",
            "cHdTg7b8waCHMRT+ybuDNE/6hu+Ir6ueJ/fJVAnBT7E=",
        ),
    ),
    # vanity/0x83783
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x8378396c983a65d010bec89500e1285c344086fa",
            "0xf4fe15b9edd3bdf3c4c94deb7637fa1caeb41662a657f1d227494cff26247c4a681bd1716e08e426fc3a59452a782d412664809b1729888856c0b5d260855e65",
            "1ee1fca5f1873787a6ab956117dbbd3ef7c27d520a5132fa8d2206b60c0c725a",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x8378396c983a65d010bec89500e1285c344086fa",
            "BPT+Fbnt073zxMlN63Y3+hyutBZiplfx0idJTP8mJHxKaBvRcW4I5Cb8OllFKngtQSZkgJsXKYiIVsC10mCFXmU=",
            "HuH8pfGHN4emq5VhF9u9PvfCfVIKUTL6jSIGtgwMclo=",
        ),
    ),
    # vanity/0x83883
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x83883db341f0e747f632bc8fb48439d710da14df",
            "0xa5e7243638bee3def83acf93a081a2eb21ad4a2aec9e9895ce42787b66b4ec6aabf8a0b3b8391d05ddf08d66c95ab4f809744dc2ba827a6ef2a4e7b86b456355",
            "69576392d00df9135eb363b2097baa48ce1d8de30eb7c0937a239d54843c6e9b",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x83883db341f0e747f632bc8fb48439d710da14df",
            "BKXnJDY4vuPe+DrPk6CBoushrUoq7J6Ylc5CeHtmtOxqq/igs7g5HQXd8I1myVq0+Al0TcK6gnpu8qTnuGtFY1U=",
            "aVdjktAN+RNes2OyCXuqSM4djeMOt8CTeiOdVIQ8bps=",
        ),
    ),
    # vanity/0x83983
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x83983526ed653a9752c80e1b77c1345f88e7c0cb",
            "0x0888adbaffa29be65fa46eef0ea633622989d064b2d7352128b531a70b6405bb59ca646bb0c3819290534b6f9cf3e56e3ffdd80f2e1134edf7fd9d8213b35fcd",
            "3c1f90fc76bfcbfcd71abef7c241b69a2740e6c13383e7bd102e967fd2a75ed2",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x83983526ed653a9752c80e1b77c1345f88e7c0cb",
            "BAiIrbr/opvmX6Ru7w6mM2IpidBkstc1ISi1MacLZAW7Wcpka7DDgZKQU0tvnPPlbj/92A8uETTt9/2dghOzX80=",
            "PB+Q/Ha/y/zXGr73wkG2midA5sEzg+e9EC6Wf9KnXtI=",
        ),
    ),
    # vanity/0x84084
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x84084d65cfe77b568464e7b296c0489ce6124d73",
            "0x76e506bbee951bf7e9441cc35877365436737988b984ed4741192b6418e175314176fd35540ef1d3f17701ba0043cc7a6ee216e11c1a62cb0c9eaa8fd9daed96",
            "48dc8a08f324cef91f04f9b3ef07a7512d718410ea3e0cc36b95b4f686fb7a52",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x84084d65cfe77b568464e7b296c0489ce6124d73",
            "BHblBrvulRv36UQcw1h3NlQ2c3mIuYTtR0EZK2QY4XUxQXb9NVQO8dPxdwG6AEPMem7iFuEcGmLLDJ6qj9na7ZY=",
            "SNyKCPMkzvkfBPmz7wenUS1xhBDqPgzDa5W09ob7elI=",
        ),
    ),
    # vanity/0x84184
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x84184596acdaacc567d9ca10a7e7d9a8f48d6dde",
            "0x1c10f0c3b2f12157fc36be76d20e61c540b59c9706ada13a6a08d8e3e620643c7bff8b192cad0a59d8515708ad9bc24979419404813bf154e6b6bef3caacbb8e",
            "12c96bb7d2097dc46bba4cf57cb162f1b61e193771d9370690e4ba287dea04ef",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x84184596acdaacc567d9ca10a7e7d9a8f48d6dde",
            "BBwQ8MOy8SFX/Da+dtIOYcVAtZyXBq2hOmoI2OPmIGQ8e/+LGSytClnYUVcIrZvCSXlBlASBO/FU5ra+88qsu44=",
            "Eslrt9IJfcRrukz1fLFi8bYeGTdx2TcGkOS6KH3qBO8=",
        ),
    ),
    # vanity/0x84284
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x84284cdf83462c70271196d12ddc1ee836a7c24a",
            "0x448bd97f93a70f5813fff53d7ec246510016b77bde7394b89f58e9897a0204384e92dc415ff2fb094f6892ace22b08240077cc3227491f20dcb5d786189b89ac",
            "673403f98dbb49d9ffa5093013b418fca14c5a7626fc0dd7d75dccb62bbbac6b",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x84284cdf83462c70271196d12ddc1ee836a7c24a",
            "BESL2X+Tpw9YE//1PX7CRlEAFrd73nOUuJ9Y6Yl6AgQ4TpLcQV/y+wlPaJKs4isIJAB3zDInSR8g3LXXhhibiaw=",
            "ZzQD+Y27Sdn/pQkwE7QY/KFMWnYm/A3X113Mtiu7rGs=",
        ),
    ),
    # vanity/0x84384
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x84384922f31599da7cf221af68cb01d2287e1018",
            "0x51443397adae2582de1c6d458a3ba688e048b55811a44a94ce72f88c0259cdac427461d8d7b9c185660f1b2be0a420bc6d2662de04425addacd80b7fc133ee31",
            "24f7c0dedf12da209ec724364a7e9953719c80f12221cfdeccce0b88f3748836",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x84384922f31599da7cf221af68cb01d2287e1018",
            "BFFEM5etriWC3hxtRYo7pojgSLVYEaRKlM5y+IwCWc2sQnRh2Ne5wYVmDxsr4KQgvG0mYt4EQlrdrNgLf8Ez7jE=",
            "JPfA3t8S2iCexyQ2Sn6ZU3GcgPEiIc/ezM4LiPN0iDY=",
        ),
    ),
    # vanity/0x84484
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x844841e0029a4f1152f6ce762ce181152c95c042",
            "0xe2987ac2a102426a0285ba873a93abf8b0c55fa750ce3e15cb65a89a74d909682f58a81c8cb6ec944a4f731d825ad9bbb253510e5694efb056f462b7d9c9d245",
            "e46936c43f4a9783f4ed0f200319c62c7d16ed3e1cf655fffb074accc7ec15d1",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x844841e0029a4f1152f6ce762ce181152c95c042",
            "BOKYesKhAkJqAoW6hzqTq/iwxV+nUM4+FctlqJp02QloL1ioHIy27JRKT3MdglrZu7JTUQ5WlO+wVvRit9nJ0kU=",
            "5Gk2xD9Kl4P07Q8gAxnGLH0W7T4c9lX/+wdKzMfsFdE=",
        ),
    ),
    # vanity/0x84584
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x8458400130cbd48cc0d0faf15c9ec821e095412a",
            "0xd13c796140b73d546c9dc03361aafc21a7f0e822db0e2e31a24bf63720cf1b8dcd0250c3960e5502875d18879657a41465a26ce16afa94d860d5da6760662817",
            "dd3f888288a10494a75ff0412b1df2989e82642300e22aed8d9b5155e7e43a1a",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x8458400130cbd48cc0d0faf15c9ec821e095412a",
            "BNE8eWFAtz1UbJ3AM2Gq/CGn8Ogi2w4uMaJL9jcgzxuNzQJQw5YOVQKHXRiHllekFGWibOFq+pTYYNXaZ2BmKBc=",
            "3T+IgoihBJSnX/BBKx3ymJ6CZCMA4irtjZtRVefkOho=",
        ),
    ),
    # vanity/0x84684
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x84684e010e804e9bac6d1539dd197ab26a6b5f4a",
            "0x4633aa7fe887f8a44b61165a9e488d8e6c73ffbbae75b34fc14a485dfa7d6e1e18957ff4ab4f68879814fea1e84aabcad12dd71c3795ee146a8ca349d1b7f85f",
            "f83966ac49907660d46e32fb1e033ced5ffe902bd4cc4701581a2fd11f75516f",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x84684e010e804e9bac6d1539dd197ab26a6b5f4a",
            "BEYzqn/oh/ikS2EWWp5IjY5sc/+7rnWzT8FKSF36fW4eGJV/9KtPaIeYFP6h6EqrytEt1xw3le4UaoyjSdG3+F8=",
            "+DlmrEmQdmDUbjL7HgM87V/+kCvUzEcBWBov0R91UW8=",
        ),
    ),
    # vanity/0x84784
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x847841515dd65037227114ad24f9dbc52edb8443",
            "0x16380450f8079df9cec93fc36a39d43cfc10c6a98a6f83fe7a4280b8a84696890d6dff58403ceed0854bd35659c3fbd6f5f92440bfe09e4077c679ea66b87298",
            "94c3b1cd7a873697beb6ad51f28f6cc93e8ba3bb40a8f1ccf99de0931387cab0",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x847841515dd65037227114ad24f9dbc52edb8443",
            "BBY4BFD4B535zsk/w2o51Dz8EMapim+D/npCgLioRpaJDW3/WEA87tCFS9NWWcP71vX5JEC/4J5Ad8Z56ma4cpg=",
            "lMOxzXqHNpe+tq1R8o9syT6Lo7tAqPHM+Z3gkxOHyrA=",
        ),
    ),
    # vanity/0x84884
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x84884f0fd387c0d4eacf862f7c8d466dc43bcfd6",
            "0xfbe5a9f2e7c18e76906cf2dfac75d2680442c97ae3cddc3a715d83f3142099fa4f85948d035f5961800e98fe922d804f4f2208504b602310d1b4ea0ae45bf7b0",
            "257763fbb71d8ff183b805033a2ef65eab0340d39e0f8259ab4ec464b8cbea9e",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x84884f0fd387c0d4eacf862f7c8d466dc43bcfd6",
            "BPvlqfLnwY52kGzy36x10mgEQsl6483cOnFdg/MUIJn6T4WUjQNfWWGADpj+ki2AT08iCFBLYCMQ0bTqCuRb97A=",
            "JXdj+7cdj/GDuAUDOi72XqsDQNOeD4JZq07EZLjL6p4=",
        ),
    ),
    # vanity/0x84984
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x84984dfe4e1b135f602fd510ec24f2676cbdc5d1",
            "0x33503a74d0b3add07ba3f77964f13152757489b777e744173697456c03f0939ef8ad597f4a391546f60e8f1385d3b249f7cd9aaadb930cb7cf43254b9c4ef278",
            "259267091c0434712a51e2d0e8db05f46dbc3672da6272ee5f300f35cec6a799",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x84984dfe4e1b135f602fd510ec24f2676cbdc5d1",
            "BDNQOnTQs63Qe6P3eWTxMVJ1dIm3d+dEFzaXRWwD8JOe+K1Zf0o5FUb2Do8ThdOySffNmqrbkwy3z0MlS5xO8ng=",
            "JZJnCRwENHEqUeLQ6NsF9G28NnLaYnLuXzAPNc7Gp5k=",
        ),
    ),
    # vanity/0x85085
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x85085c764cd65541a279e37b7492e91b92805de3",
            "0xf1f7f7640ed862114c227ab5bdbdaeb7087240aa2c65cce72c657d962900c449f027615272bfb85b1d32736d747955b91d124122c014afc77f8e5dd9b6c12e59",
            "2270712de6d704f270e578b05a92eb51952e7e02b2e425319ba0f4aa8dfa891c",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x85085c764cd65541a279e37b7492e91b92805de3",
            "BPH392QO2GIRTCJ6tb29rrcIckCqLGXM5yxlfZYpAMRJ8CdhUnK/uFsdMnNtdHlVuR0SQSLAFK/Hf45d2bbBLlk=",
            "InBxLebXBPJw5XiwWpLrUZUufgKy5CUxm6D0qo36iRw=",
        ),
    ),
    # vanity/0x85185
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x8518573ee6a8cede05af48b03852588f0e8d6ebe",
            "0xf02aa30ed63bd16c2f213d8bbd771c581a97908624f439df9d5a4918f19b3a601fdbf746264b156f955d9140f286b8c79e43639e3cf693c816c32fd499c82c3a",
            "61ce26876e3924b82eea037ee23669191abb1babbeeee4d6e70303ecfcbfe7b5",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x8518573ee6a8cede05af48b03852588f0e8d6ebe",
            "BPAqow7WO9FsLyE9i713HFgal5CGJPQ5351aSRjxmzpgH9v3RiZLFW+VXZFA8oa4x55DY5489pPIFsMv1JnILDo=",
            "Yc4mh245JLgu6gN+4jZpGRq7G6u+7uTW5wMD7Py/57U=",
        ),
    ),
    # vanity/0x85285
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x8528570b22e1d38616aefdde2ee579f31156e629",
            "0x27d61e1eda8a333182d58a84ad2b2b7cfb879ac92e561f42371df11b66da0416f31327a937bdaa43f6fd549d62498bfade91af136bd0db9505c6a54bba119d3d",
            "a9cd7bafa3ce73f0411e875fab599dd3b005460c112d7984700e54e17f68b7d4",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x8528570b22e1d38616aefdde2ee579f31156e629",
            "BCfWHh7aijMxgtWKhK0rK3z7h5rJLlYfQjcd8Rtm2gQW8xMnqTe9qkP2/VSdYkmL+t6RrxNr0NuVBcalS7oRnT0=",
            "qc17r6POc/BBHodfq1md07AFRgwRLXmEcA5U4X9ot9Q=",
        ),
    ),
    # vanity/0x85385
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x85385985006dc66312624958af99a0eb38a6deed",
            "0x10737e5d9ebab23f4378a2f0a097904285b3a981da744aa8284be6ca05d286f352782abb17622a0ad5a5394c72e8df215fdeda2c4b990a0776ff2969cd5db239",
            "55c94e2fce44ecd6e665df0d25d0c56c4f6118034c690e028057d12ff1d12e47",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x85385985006dc66312624958af99a0eb38a6deed",
            "BBBzfl2eurI/Q3ii8KCXkEKFs6mB2nRKqChL5soF0obzUngquxdiKgrVpTlMcujfIV/e2ixLmQoHdv8pac1dsjk=",
            "VclOL85E7NbmZd8NJdDFbE9hGANMaQ4CgFfRL/HRLkc=",
        ),
    ),
    # vanity/0x85485
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x85485290f705c22df6adbe6ac413c42c1e952262",
            "0xc461e60b0d0c080e278386046b6513e18f5c06733d67ea5d357e60ad1119de0176d14452197e8c6a612897b3caa774476e511345815282e35e08319cc92402ba",
            "eeb8683aae685ed68643de76d1d999b80289b2e33df646f216d547f33d443521",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x85485290f705c22df6adbe6ac413c42c1e952262",
            "BMRh5gsNDAgOJ4OGBGtlE+GPXAZzPWfqXTV+YK0RGd4BdtFEUhl+jGphKJezyqd0R25RE0WBUoLjXggxnMkkAro=",
            "7rhoOq5oXtaGQ9520dmZuAKJsuM99kbyFtVH8z1ENSE=",
        ),
    ),
    # vanity/0x85585
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x85585b796afda63bf278b82aa1a508a9116c6e1e",
            "0x8715f8f719f25f1ee410814844d4321dae7bf42dbd2c025162a8001a885c870642528f60a7b26d94793f516e0e9f0c2ad6d4792a7ddb7a02177dbf13ab8b6370",
            "53739c6f692e7e40b4a46416fd37e5c105fefa4b2b23bdaf72619dd929763d6f",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x85585b796afda63bf278b82aa1a508a9116c6e1e",
            "BIcV+PcZ8l8e5BCBSETUMh2ue/QtvSwCUWKoABqIXIcGQlKPYKeybZR5P1FuDp8MKtbUeSp923oCF32/E6uLY3A=",
            "U3Ocb2kufkC0pGQW/TflwQX++ksrI72vcmGd2Sl2PW8=",
        ),
    ),
    # vanity/0x85685
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x85685ba200cd60bcbfef3aae1d8c3cc27e020b17",
            "0x36beab3058f696716eec783ebe98dd55cebff4c440c449c86160b7560c5cb3840c177e4cb335b4443766b212a1f103b56336b889ea9f1f70c3aa7efe6a4281ce",
            "ac455623109655a465e56f92c453ea8b2f2aa2c8549e5c3d50198b2b2c05b551",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x85685ba200cd60bcbfef3aae1d8c3cc27e020b17",
            "BDa+qzBY9pZxbux4Pr6Y3VXOv/TEQMRJyGFgt1YMXLOEDBd+TLM1tEQ3ZrISofEDtWM2uInqnx9ww6p+/mpCgc4=",
            "rEVWIxCWVaRl5W+SxFPqiy8qoshUnlw9UBmLKywFtVE=",
        ),
    ),
    # vanity/0x85785
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x8578525055b0db7d6719264a77e951c71455aa36",
            "0xfbdc1aa75610b68acf583ec30abf87cef1d8244e87d148e867800ee0e5dd8a1bab6f9ab7ec48dd3fb0b9b3d3fbf9c1e9b872671f7832ecdeaa4ca613ff2c639c",
            "1fbd21b3b0365ffcfe19920debb602f71cd67b8fe2b96f9068169286d4f4fefe",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x8578525055b0db7d6719264a77e951c71455aa36",
            "BPvcGqdWELaKz1g+wwq/h87x2CROh9FI6GeADuDl3Yobq2+at+xI3T+wubPT+/nB6bhyZx94MuzeqkymE/8sY5w=",
            "H70hs7A2X/z+GZIN67YC9xzWe4/iuW+QaBaShtT0/v4=",
        ),
    ),
    # vanity/0x85885
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x85885057ca3eca302193092303902b26e976550c",
            "0x8c84f0779c0dafb2220258a098fd921d19bad63fb52b0785d76a4d0e6d45c89d468dd73b0d8c241e60c5e85ddcfb5dd041d69eeb22fbbf7e0e637f2533ecd99f",
            "b7548158bde56a16f721a1c87751db4b82bf5e00e2c722ec482b4335b5c43d1a",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x85885057ca3eca302193092303902b26e976550c",
            "BIyE8HecDa+yIgJYoJj9kh0ZutY/tSsHhddqTQ5tRcidRo3XOw2MJB5gxehd3Ptd0EHWnusi+79+DmN/JTPs2Z8=",
            "t1SBWL3lahb3IaHId1HbS4K/XgDixyLsSCtDNbXEPRo=",
        ),
    ),
    # vanity/0x85985
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x859850e485c710cae2575945e1c22a017c3e9511",
            "0x0c85d13c10ec1888e0d794128de273c2b0c2f51df976d097113f13de838bb88ee4d793e5d889339fd7f67c4c33f3c3e12616e9b1bbd4f5fe5eb3997e51102a97",
            "a845f24e4e45de2b6b2cadb2aacb9f95f9449854bbebf7e9e673f532f0b39365",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x859850e485c710cae2575945e1c22a017c3e9511",
            "BAyF0TwQ7BiI4NeUEo3ic8KwwvUd+XbQlxE/E96Di7iO5NeT5diJM5/X9nxMM/PD4SYW6bG71PX+XrOZflEQKpc=",
            "qEXyTk5F3itrLK2yqsuflflEmFS76/fp5nP1MvCzk2U=",
        ),
    ),
    # vanity/0x86086
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x86086cacff94a608a00681b0b5167ff9d612eba6",
            "0x4fe0b93422172c76f10bdbeff0926060376e5f8791aafa1d9181cc48b215c775093a2ed36ce0d42256c4c9111fc425168b92bfe00249412f964a4967381bb379",
            "72e5b37f13572dc0fa83efc43f6d25b3949d161a3ca6bb2f4542b26190034bab",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x86086cacff94a608a00681b0b5167ff9d612eba6",
            "BE/guTQiFyx28Qvb7/CSYGA3bl+Hkar6HZGBzEiyFcd1CTou02zg1CJWxMkRH8QlFouSv+ACSUEvlkpJZzgbs3k=",
            "cuWzfxNXLcD6g+/EP20ls5SdFho8prsvRUKyYZADS6s=",
        ),
    ),
    # vanity/0x86186
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x86186c1ba6a3e938f7178d64a0b20bd1c55973ac",
            "0x66f0abbb135dcf232f6de00c8fddaa937a5b11e0165d7dee6c04991af1cafc26eb4b67748a36c7bac68be0679957a57e4b497fd21e7e2f12ace52081ae705ddc",
            "43871189a163f9850d477b4dc68327d45bcffd2aac64e3d2c477f866d9a6576c",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x86186c1ba6a3e938f7178d64a0b20bd1c55973ac",
            "BGbwq7sTXc8jL23gDI/dqpN6WxHgFl197mwEmRrxyvwm60tndIo2x7rGi+BnmVelfktJf9Iefi8SrOUgga5wXdw=",
            "Q4cRiaFj+YUNR3tNxoMn1FvP/SqsZOPSxHf4ZtmmV2w=",
        ),
    ),
    # vanity/0x86286
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x862865f46e20a8c509ed43ed3df990cf29ddaf68",
            "0x0b92b7b9aca854c40e4c179ac0f71d328ace0201e90d13d0acd98990225ab8f664e3479ab39112b15ac05caea1e768ef50c955c00c11bec38481d21334e6c31c",
            "bcd66cbadbff6839775c209cdd847173b9af5f0d21336b634fb082b393d91d93",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x862865f46e20a8c509ed43ed3df990cf29ddaf68",
            "BAuSt7msqFTEDkwXmsD3HTKKzgIB6Q0T0KzZiZAiWrj2ZONHmrORErFawFyuoedo71DJVcAMEb7DhIHSEzTmwxw=",
            "vNZsutv/aDl3XCCc3YRxc7mvXw0hM2tjT7CCs5PZHZM=",
        ),
    ),
    # vanity/0x86386
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x86386b06a0f3d3558f866f6b767650854bfab59c",
            "0x6afc35aba7cd44d94e8c747f94537e1c2af9aa7cb81af4ce47345bad6a4415ce3204aaaca595cf23293b098c51d5fd1da6143b8d020724afef26a4eac3577030",
            "894803a65d44f61e53a5baeb3e51103899690cb8649acd69d27d555f7a5b62f4",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x86386b06a0f3d3558f866f6b767650854bfab59c",
            "BGr8NaunzUTZTox0f5RTfhwq+ap8uBr0zkc0W61qRBXOMgSqrKWVzyMpOwmMUdX9HaYUO40CBySv7yak6sNXcDA=",
            "iUgDpl1E9h5TpbrrPlEQOJlpDLhkms1p0n1VX3pbYvQ=",
        ),
    ),
    # vanity/0x86486
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x864860eb974c970c50f7454069f808b70bb2ab8f",
            "0x8507619fa18463a92841a9972e265ff15e4aa3c88fd3504b550e571109bfbd74792663f0633c61edc0506474ae9e2ec9137c94871f7668d11cda4449e7e78c1a",
            "2ff29243069da7b8ba227d3ca8eb44778360a8ca36085c73da08d20aafa8cac1",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x864860eb974c970c50f7454069f808b70bb2ab8f",
            "BIUHYZ+hhGOpKEGply4mX/FeSqPIj9NQS1UOVxEJv710eSZj8GM8Ye3AUGR0rp4uyRN8lIcfdmjRHNpESefnjBo=",
            "L/KSQwadp7i6In08qOtEd4NgqMo2CFxz2gjSCq+oysE=",
        ),
    ),
    # vanity/0x86586
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x86586626d0677427a3feaee18ada7499fb619c2e",
            "0x95254cd7caa24ef1fcb7331f9015f86ce37e1ece465604bb5f4f7e5602427294a9311ad4e188d50bbaf99c03fb1d51b3c677c847a8cf73761b2229c6d2e2eaae",
            "402c3e21a0a26b47feac60d6e8930e3ab300ad16aef7d1ed451023aed1da754c",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x86586626d0677427a3feaee18ada7499fb619c2e",
            "BJUlTNfKok7x/LczH5AV+Gzjfh7ORlYEu19PflYCQnKUqTEa1OGI1Qu6+ZwD+x1Rs8Z3yEeoz3N2GyIpxtLi6q4=",
            "QCw+IaCia0f+rGDW6JMOOrMArRau99HtRRAjrtHadUw=",
        ),
    ),
    # vanity/0x86686
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x866868485f355af2d4ff006ad078159b95d6ba2a",
            "0xfe170c52d4f77acf47bcb16be479babbea9d2aa91832408210f62e23fb63122213641962b2af4fc638ff6b3b920c7cfa6727882ed7ec50b5badd9c0f0adac9a8",
            "cbfbdd5c79e1335017ab6fb0d1b9f8db0a798e3eaa59192a92c4cfb78320fe76",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x866868485f355af2d4ff006ad078159b95d6ba2a",
            "BP4XDFLU93rPR7yxa+R5urvqnSqpGDJAghD2LiP7YxIiE2QZYrKvT8Y4/2s7kgx8+mcniC7X7FC1ut2cDwrayag=",
            "y/vdXHnhM1AXq2+w0bn42wp5jj6qWRkqksTPt4Mg/nY=",
        ),
    ),
    # vanity/0x86786
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x8678688120e23d30b3953e63234931c5b31513af",
            "0x8b9dfdfd35e79125d702d12aca62ac71688a1f42f8515972fcb908214ea988d9850b1ea9c991d47dda8e91af3fb552106a2daa1c2c204da694a464a301228ed0",
            "a4d8e0d1b5b95343b00014d5f49eb823779fd17b7ef4825b4d15a59f9c34aebd",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x8678688120e23d30b3953e63234931c5b31513af",
            "BIud/f0155El1wLRKspirHFoih9C+FFZcvy5CCFOqYjZhQseqcmR1H3ajpGvP7VSEGotqhwsIE2mlKRkowEijtA=",
            "pNjg0bW5U0OwABTV9J64I3ef0Xt+9IJbTRWln5w0rr0=",
        ),
    ),
    # vanity/0x86886
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x86886aad89bb89a83fc82546cb365462e7e29290",
            "0x20b869f68ba6ce32180c61eaf5d33bd7a41bb5686496c4129e0508684680e3eaf21098edc594326a60409c753e8d19edf94bdca1ad2cb2137327698733f85dda",
            "de4460098042d8018adb74991c9448555a9f979e8b80d423e8e779f77ba40595",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x86886aad89bb89a83fc82546cb365462e7e29290",
            "BCC4afaLps4yGAxh6vXTO9ekG7VoZJbEEp4FCGhGgOPq8hCY7cWUMmpgQJx1Po0Z7flL3KGtLLITcydphzP4Xdo=",
            "3kRgCYBC2AGK23SZHJRIVVqfl56LgNQj6Od593ukBZU=",
        ),
    ),
    # vanity/0x86986
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x8698697f2887befb5f8b819715b116b76315d99e",
            "0x1e0848ec95fc864053983011dfbf88ee63383437975c43af59a53e506b4d4884d6b380373ad6bbbb3c9accd8af46cbf2d60e1b0239fa3476a12b75b316fcbe73",
            "230ff2ddb043ade6bed27cb36b17771641716fb49e12c8b11ede02cdc0ffc9a6",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x8698697f2887befb5f8b819715b116b76315d99e",
            "BB4ISOyV/IZAU5gwEd+/iO5jODQ3l1xDr1mlPlBrTUiE1rOANzrWu7s8mszYr0bL8tYOGwI5+jR2oSt1sxb8vnM=",
            "Iw/y3bBDrea+0nyzaxd3FkFxb7SeEsixHt4CzcD/yaY=",
        ),
    ),
    # vanity/0x87087
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x87087917e7c3c30eb1bffde22ba0c07fb9f981ee",
            "0x01225906190af096f1b441284d156544363d4e95e963654d51472e332b6f3a7f1e342b0bf0f0b8d277aff0bc628e887a85e9b99a8d22af13f77d90282c838eb5",
            "20ac83d3b60e8b58bb4d5c3d5a80aa455cf849a8d4232967cb1a37d568506e9a",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x87087917e7c3c30eb1bffde22ba0c07fb9f981ee",
            "BAEiWQYZCvCW8bRBKE0VZUQ2PU6V6WNlTVFHLjMrbzp/HjQrC/DwuNJ3r/C8Yo6IeoXpuZqNIq8T932QKCyDjrU=",
            "IKyD07YOi1i7TVw9WoCqRVz4SajUIylnyxo31WhQbpo=",
        ),
    ),
    # vanity/0x87187
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x87187f25ebb5daa79f38a4770d4a91e40da9de2f",
            "0xa6649b64e9557222d75589225ea32e584d70ff8aff3f4d5379b99ecfb92ee77a78e4eed898221141a9a450fdcb55b13c4f1b420f0cec81b672faca2ec7d35dda",
            "4e4784e61e39c01031ef69ed1e5afc74fd5eb3fe8435e7668883acc24dc3a79f",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x87187f25ebb5daa79f38a4770d4a91e40da9de2f",
            "BKZkm2TpVXIi11WJIl6jLlhNcP+K/z9NU3m5ns+5Lud6eOTu2JgiEUGppFD9y1WxPE8bQg8M7IG2cvrKLsfTXdo=",
            "TkeE5h45wBAx72ntHlr8dP1es/6ENedmiIOswk3Dp58=",
        ),
    ),
    # vanity/0x87287
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x872875f29b5e4f76123c037fa801aa0ba3872dbe",
            "0x2db7436d3cd1627dfe5e67652a96b19cd3d6684680a1a52ebea25a2a7acb6d2fc4d485d6c6bb74bc4b7d11e9992f1aaee5c9e59e70730aebf9ec9bf4e327a57f",
            "a30f31f798c9574a055baac3c974a1a6d571806acaa1f65884a70b5b96e238c9",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x872875f29b5e4f76123c037fa801aa0ba3872dbe",
            "BC23Q2080WJ9/l5nZSqWsZzT1mhGgKGlLr6iWip6y20vxNSF1sa7dLxLfRHpmS8aruXJ5Z5wcwrr+eyb9OMnpX8=",
            "ow8x95jJV0oFW6rDyXShptVxgGrKofZYhKcLW5biOMk=",
        ),
    ),
    # vanity/0x87387
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x8738782dc519937b46c8e3ec6cb74ac61f9b0d41",
            "0xe2424f9e7574a87feab6ec02115a3e69f557be3e13cc8104ad8e6e04fd3837f9dcc6f06b81279d7dce2f7d868a809cb5a0063f8118706d3fec805eac624260b7",
            "6e09c3ace8710f049c0c8583e8e5e7fcb0b779afcae6ac35afbab4278bb0785a",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x8738782dc519937b46c8e3ec6cb74ac61f9b0d41",
            "BOJCT551dKh/6rbsAhFaPmn1V74+E8yBBK2ObgT9ODf53Mbwa4EnnX3OL32GioCctaAGP4EYcG0/7IBerGJCYLc=",
            "bgnDrOhxDwScDIWD6OXn/LC3ea/K5qw1r7q0J4uweFo=",
        ),
    ),
    # vanity/0x87487
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x87487769727dc744f7d541683de9873af40a7bc4",
            "0x53de50c2a91c829b27c66d0d9fb7f1ae8745c61aa45d36d680fca2403925a363f29f1428b1e666ae0ed52ea8f317874e0a93591c4bc82dd5fea9d5117665c319",
            "b740d00c60f624b1d91d85d3968d4e90207441e29d90843d03bb91f11c03b57d",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x87487769727dc744f7d541683de9873af40a7bc4",
            "BFPeUMKpHIKbJ8ZtDZ+38a6HRcYapF021oD8okA5JaNj8p8UKLHmZq4O1S6o8xeHTgqTWRxLyC3V/qnVEXZlwxk=",
            "t0DQDGD2JLHZHYXTlo1OkCB0QeKdkIQ9A7uR8RwDtX0=",
        ),
    ),
    # vanity/0x87587
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x875870aacce34046068632456ff0a4c59a56f355",
            "0x4542f89a0810540c402939c00d0d0f7e139f3d9fcf783f65af0e306215c436dc19b1da296c3aa878decd841d097467ee9371228d37e02ae984caf6c2d23e5321",
            "f8f35b1b0b8ed4d8d45098a901322c2271a5db93361be500d8020ca9e6fa8e09",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x875870aacce34046068632456ff0a4c59a56f355",
            "BEVC+JoIEFQMQCk5wA0ND34Tnz2fz3g/Za8OMGIVxDbcGbHaKWw6qHjezYQdCXRn7pNxIo034CrphMr2wtI+UyE=",
            "+PNbGwuO1NjUUJipATIsInGl25M2G+UA2AIMqeb6jgk=",
        ),
    ),
    # vanity/0x87687
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x876874913320536e5f70491153c1c47e7f7ff3ff",
            "0xb2558a5deaeb387b157e2e1ed406264f659ebd4d74b0ec05703b57b409a80cf4ee97158247d38c58c6316ac15c9eaef7550c146559eee39d51374db00f694a65",
            "8bd2d6a563169e942e13d35daabdfec8f256df77555627a34fbc3eae36c934b7",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x876874913320536e5f70491153c1c47e7f7ff3ff",
            "BLJVil3q6zh7FX4uHtQGJk9lnr1NdLDsBXA7V7QJqAz07pcVgkfTjFjGMWrBXJ6u91UMFGVZ7uOdUTdNsA9pSmU=",
            "i9LWpWMWnpQuE9Ndqr3+yPJW33dVViejT7w+rjbJNLc=",
        ),
    ),
    # vanity/0x87787
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x8778719707a74010eab07f2d8f54cca39bf84fae",
            "0x48651e5a9c970bb0dedfd8874133f3d3db653448713321b34a4bb2e187c8c17d0f3b2e487dff59d714dddf5be410645ebcc571019247e38492ec760a1bb19b92",
            "3384e5b09a1227cc58ddc4765471980d965fb37d659ee6b2296b7b827f8d8a6e",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x8778719707a74010eab07f2d8f54cca39bf84fae",
            "BEhlHlqclwuw3t/Yh0Ez89PbZTRIcTMhs0pLsuGHyMF9DzsuSH3/WdcU3d9b5BBkXrzFcQGSR+OEkux2Chuxm5I=",
            "M4TlsJoSJ8xY3cR2VHGYDZZfs31lnuayKWt7gn+Nim4=",
        ),
    ),
    # vanity/0x87887
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x878870a9884898e99c15db51b5d47fd7f4ace505",
            "0x4684fb740e3e2d3b075ec0cd6d432fe6e73543e82a5f3e7d93fc7a21164018988917dda85ef3807c15200d8b7dff072b7bf914ed925d83040c17dceb2b073dfb",
            "6540dfde4c44b16e96cdb9f1532739ca325656745655bc956e10dd17a3df23f0",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x878870a9884898e99c15db51b5d47fd7f4ace505",
            "BEaE+3QOPi07B17AzW1DL+bnNUPoKl8+fZP8eiEWQBiYiRfdqF7zgHwVIA2Lff8HK3v5FO2SXYMEDBfc6ysHPfs=",
            "ZUDf3kxEsW6WzbnxUyc5yjJWVnRWVbyVbhDdF6PfI/A=",
        ),
    ),
    # vanity/0x87987
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x879871f7763e5ffe7205424baaeebc93471b2fac",
            "0xdaab8530703a4388305c903c5d0b81e3519ee166be66c57d7026981ed874df0b169c800ce0e2ce128af4ec6a826e303373c620f32603ebf090878aa0dbc31981",
            "dbd3c0c9e1e7b11522b79053eca84b78df4c3b48c66744a556c3a4856fb37488",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x879871f7763e5ffe7205424baaeebc93471b2fac",
            "BNqrhTBwOkOIMFyQPF0LgeNRnuFmvmbFfXAmmB7YdN8LFpyADODizhKK9Oxqgm4wM3PGIPMmA+vwkIeKoNvDGYE=",
            "29PAyeHnsRUit5BT7KhLeN9MO0jGZ0SlVsOkhW+zdIg=",
        ),
    ),
    # vanity/0x88088
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x880889307163baa281387dc517aa210d92a15b49",
            "0x490f93589aa5bdad8569db347bc49655f76273774f37ad7626f0180f9b9c42dd24116eb41d1bc16cf90b630cd5f40a824acd3c65440f0d018e420f5897c70fc4",
            "937da6a9c37e4daac44d81a8bedd42ccb43d715ec508412bc2439c890b09c0b9",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x880889307163baa281387dc517aa210d92a15b49",
            "BEkPk1iapb2thWnbNHvEllX3YnN3TzetdibwGA+bnELdJBFutB0bwWz5C2MM1fQKgkrNPGVEDw0BjkIPWJfHD8Q=",
            "k32mqcN+TarETYGovt1CzLQ9cV7FCEErwkOciQsJwLk=",
        ),
    ),
    # vanity/0x88188
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x88188d81349c52e9606050cad449a6ff22baa83c",
            "0x78fc2925b7ec4735dae1271a8b3ba9eddf1414711c5aab7abd9c20511de16d419238983d4468cabda92842b935debc7ab161726d6c383bca9bfb3692e65baf5f",
            "eee568964bc255a819aa94fd258aeccaef9aabe22d1e1c67699f1130aada4658",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x88188d81349c52e9606050cad449a6ff22baa83c",
            "BHj8KSW37Ec12uEnGos7qe3fFBRxHFqrer2cIFEd4W1BkjiYPURoyr2pKEK5Nd68erFhcm1sODvKm/s2kuZbr18=",
            "7uVolkvCVagZqpT9JYrsyu+aq+ItHhxnaZ8RMKraRlg=",
        ),
    ),
    # vanity/0x88288
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x88288a5eb96b1439dbefcd612ccecf01182fdd76",
            "0x6d025b506dfdaf806a05d7f45bfd53bac393ce3469238c96b9a9c7c8a8e21081de3a2204e0bcdda8094384cc6347a0a4d89503f2b159a70c81d3a2a2a4d7c5d7",
            "c97a83fda2e649ec7df14e7790e7df60d47d0cc3f10fd8acf8061608742eacac",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x88288a5eb96b1439dbefcd612ccecf01182fdd76",
            "BG0CW1Bt/a+AagXX9Fv9U7rDk840aSOMlrmpx8io4hCB3joiBOC83agJQ4TMY0egpNiVA/KxWacMgdOioqTXxdc=",
            "yXqD/aLmSex98U53kOffYNR9DMPxD9is+AYWCHQurKw=",
        ),
    ),
    # vanity/0x88388
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x8838823b4a887df339fc29757a1fa3be9c4bd32a",
            "0x0912fb3b6c1650520e5ac3b4a2af2b2bda58bac32b189718c169ce426e77ee6affb44e41e6411b787fb5cf8567c8faf8fd86cc67a86381b9ab49e292b75d21ec",
            "d3c1a957e50e0c292abb80c3474f36ed6e986304c0229f9745cf11c5d60a6247",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x8838823b4a887df339fc29757a1fa3be9c4bd32a",
            "BAkS+ztsFlBSDlrDtKKvKyvaWLrDKxiXGMFpzkJud+5q/7ROQeZBG3h/tc+FZ8j6+P2GzGeoY4G5q0nikrddIew=",
            "08GpV+UODCkqu4DDR0827W6YYwTAIp+XRc8RxdYKYkc=",
        ),
    ),
    # vanity/0x88488
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x884888580e440b7b4bff2e5478b42d70860c00e1",
            "0x6764d4eb5340c755c273d2ba266cba4fc4123ab4c23cae27594c4a6017be4db0be7c92f1358a13157f82147a5c91e98927dd63a1aebe8db4ceceb5666aae18cd",
            "7c7a351782a68a0b415b55bf6f29a6550eff1859ed7bc53ee37921c6a9133b77",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x884888580e440b7b4bff2e5478b42d70860c00e1",
            "BGdk1OtTQMdVwnPSuiZsuk/EEjq0wjyuJ1lMSmAXvk2wvnyS8TWKExV/ghR6XJHpiSfdY6Guvo20zs61ZmquGM0=",
            "fHo1F4KmigtBW1W/bymmVQ7/GFnte8U+43khxqkTO3c=",
        ),
    ),
    # vanity/0x88588
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x885881221a2e909832c089bc809837a96387a42e",
            "0x6ffe796d299a41b50061c2176fe03b136ef3a0fb4c97179c6c015e2525fdbb1b2ff1e5ef97ac48435bf5b50a6b4c83bd0fc83f4caa7f3052b5ec0aa4381e17ca",
            "7f000c6d120bc225981cea9c62e3deee8d7d27b758c097094abab6ff720e1943",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x885881221a2e909832c089bc809837a96387a42e",
            "BG/+eW0pmkG1AGHCF2/gOxNu86D7TJcXnGwBXiUl/bsbL/Hl75esSENb9bUKa0yDvQ/IP0yqfzBStewKpDgeF8o=",
            "fwAMbRILwiWYHOqcYuPe7o19J7dYwJcJSrq2/3IOGUM=",
        ),
    ),
    # vanity/0x88688
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x886881ad6c0ce3171688404424cd34501e32ab17",
            "0xd9cb64e7616901ca8fe898e68d3d3c6cc9069662a9b1338fdd751c4ebdb6c58a42c89ccb131d5b3312d64614a274107f2cdeed0f36e9ee45bf6afca4c68586dd",
            "75cab64b2734e25049c3f00e0d8901dfde2f2d95334d24a1b030ed6caf174241",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x886881ad6c0ce3171688404424cd34501e32ab17",
            "BNnLZOdhaQHKj+iY5o09PGzJBpZiqbEzj911HE69tsWKQsicyxMdWzMS1kYUonQQfyze7Q826e5Fv2r8pMaFht0=",
            "dcq2Syc04lBJw/AODYkB394vLZUzTSShsDDtbK8XQkE=",
        ),
    ),
    # vanity/0x88788
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x887888b1d734b63187776e69eebd55b16ab8f3fc",
            "0xc1948cc3f0cb589f404290d8a606356fe0046d970b41ad1bae692f0d299ce3e31cc5c15dec8bae2b0977cc24eeb491aa227d0f2eff038712fab31388cfc53e77",
            "ce2609b56c60df4171e96046372e0ac91758c966adfcf2fcc50b1c312190d159",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x887888b1d734b63187776e69eebd55b16ab8f3fc",
            "BMGUjMPwy1ifQEKQ2KYGNW/gBG2XC0GtG65pLw0pnOPjHMXBXeyLrisJd8wk7rSRqiJ9Dy7/A4cS+rMTiM/FPnc=",
            "ziYJtWxg30Fx6WBGNy4KyRdYyWat/PL8xQscMSGQ0Vk=",
        ),
    ),
    # vanity/0x88888
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x888882d338cd83b9976b96e9d418061aa1198d23",
            "0xa437bd477b9f9eccda17e61c1b23f3e75e2e3ae00e38a5cec0a3dd59d595b0de2553625275c81f6e578f91d18290eeabe9dfef372e8adaad4a5949097f7df4d5",
            "ff00129f56581d5a0355ef9827e3aed60b608c42a005d283464ff56a5eb4198a",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x888882d338cd83b9976b96e9d418061aa1198d23",
            "BKQ3vUd7n57M2hfmHBsj8+deLjrgDjilzsCj3VnVlbDeJVNiUnXIH25Xj5HRgpDuq+nf7zcuitqtSllJCX999NU=",
            "/wASn1ZYHVoDVe+YJ+Ou1gtgjEKgBdKDRk/1al60GYo=",
        ),
    ),
    # vanity/0x88988
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x88988b81d3c338e6e2102cf4d1683b490278942f",
            "0xc613219426dc483b800f8f00fc03a9dd85bf6cbf31aa56c964b842b948121969354f05cf9af121c2a0a91fd271152fbaa13f71038d8bd82b5aa8109b1ee9ec68",
            "77bc0a6a53efb0b95f7e31276445468809226176f93189436c6806dc858b2b53",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x88988b81d3c338e6e2102cf4d1683b490278942f",
            "BMYTIZQm3Eg7gA+PAPwDqd2Fv2y/MapWyWS4QrlIEhlpNU8Fz5rxIcKgqR/ScRUvuqE/cQONi9grWqgQmx7p7Gg=",
            "d7wKalPvsLlffjEnZEVGiAkiYXb5MYlDbGgG3IWLK1M=",
        ),
    ),
    # vanity/0x89089
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x890898de5dbe2248e5aadd4ea4df766101c9203e",
            "0x96216e32e3e7de6a4c85804fb8b3163b6ea8f9e8d981b43035ced7cff780261b2ebf73e8ae260ff8ca6ec06ea3e33e55cb3ffe037c174f0dfd9341d85336d058",
            "d9bc4c9d500035692b71c02c8aeffa31f2a2ccbf36afaa9c6a9d8fbe8d903239",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x890898de5dbe2248e5aadd4ea4df766101c9203e",
            "BJYhbjLj595qTIWAT7izFjtuqPno2YG0MDXO18/3gCYbLr9z6K4mD/jKbsBuo+M+Vcs//gN8F08N/ZNB2FM20Fg=",
            "2bxMnVAANWkrccAsiu/6MfKizL82r6qcap2Pvo2QMjk=",
        ),
    ),
    # vanity/0x89189
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x89189ef6bc6ba42402e0b8fb1aa6377bfd7b6b48",
            "0x799b6ef27c9589e52125fa3b2adb9a8c96b6356fab95208079404c99db820e8eab0d6b9290b1839e872c1f39fe74cfe65b89fbcab0418b29ad92bd72476b6089",
            "75eafa4a3539ae0ab2a0aadae8c926597ee7c395e9ebba9c8b4fe266d32a2ff2",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x89189ef6bc6ba42402e0b8fb1aa6377bfd7b6b48",
            "BHmbbvJ8lYnlISX6OyrbmoyWtjVvq5UggHlATJnbgg6Oqw1rkpCxg56HLB85/nTP5luJ+8qwQYsprZK9ckdrYIk=",
            "der6SjU5rgqyoKra6MkmWX7nw5Xp67qci0/iZtMqL/I=",
        ),
    ),
    # vanity/0x89289
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x89289d059dd2a11690fdd6a9479d5d1f83cf1b5b",
            "0x98dd99a5b2d9ef0cb627fc8b277a118326f05bc0c6c927c423faeb0fed7db0f669c1d3ad3c97cb4db8a21801d3aca083493b0fa8c7d94f4bbf11e258bf6bb6c5",
            "372980a68aa05febfb8358d15136e880a02a14ae7be7f091e2fa56b9ff2c27ec",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x89289d059dd2a11690fdd6a9479d5d1f83cf1b5b",
            "BJjdmaWy2e8Mtif8iyd6EYMm8FvAxsknxCP66w/tfbD2acHTrTyXy024ohgB06ygg0k7D6jH2U9LvxHiWL9rtsU=",
            "NymApoqgX+v7g1jRUTbogKAqFK575/CR4vpWuf8sJ+w=",
        ),
    ),
    # vanity/0x89389
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x89389c8f48cdb1fd7171acf06fd4172fd228ea7b",
            "0x7eec814adc57e5d2bd102701e685ac97547cc3725fc4700c15f5553b298c02409e59482c832f4ed83193fe7ed78329b9101c46229dd754d04d683acb6c812928",
            "f4a8368b95ae9a98d87fb10e0bbc083d43d79f6d36c15c03d5a41a36e1b2d129",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x89389c8f48cdb1fd7171acf06fd4172fd228ea7b",
            "BH7sgUrcV+XSvRAnAeaFrJdUfMNyX8RwDBX1VTspjAJAnllILIMvTtgxk/5+14MpuRAcRiKd11TQTWg6y2yBKSg=",
            "9Kg2i5WumpjYf7EOC7wIPUPXn202wVwD1aQaNuGy0Sk=",
        ),
    ),
    # vanity/0x89489
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x89489a90e7af7efd904218e7a5aa137d7743626e",
            "0xdc921af8dcf2e22ce394263172b23b29742ac5489135493f34736dcace4d1cca821af09273362cc97d24710425f85774559bc3b69d976836ac24ca78f8403d9b",
            "8df15f610c2043049bd1594c4099e0a8daa0f5f3b5f3726ee12bde739c3732b5",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x89489a90e7af7efd904218e7a5aa137d7743626e",
            "BNySGvjc8uIs45QmMXKyOyl0KsVIkTVJPzRzbcrOTRzKghrwknM2LMl9JHEEJfhXdFWbw7adl2g2rCTKePhAPZs=",
            "jfFfYQwgQwSb0VlMQJngqNqg9fO183Ju4Svec5w3MrU=",
        ),
    ),
    # vanity/0x89589
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x8958925cfcce255b342bcb9b38749a314e1be14c",
            "0xb93b5a143d54905b2052af69442dcc543018d339c4f8421ef622c8245f7200d0664c59e7a23e12c2803b061643ceb641ff133058663c0d298e6b15734d42a81a",
            "fca21b3a4ce1d8e8d9f7c4e84374644efdd1e4f0518ee3b58f2c0f93a9f20c90",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x8958925cfcce255b342bcb9b38749a314e1be14c",
            "BLk7WhQ9VJBbIFKvaUQtzFQwGNM5xPhCHvYiyCRfcgDQZkxZ56I+EsKAOwYWQ862Qf8TMFhmPA0pjmsVc01CqBo=",
            "/KIbOkzh2OjZ98ToQ3RkTv3R5PBRjuO1jywPk6nyDJA=",
        ),
    ),
    # vanity/0x89689
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x89689d71322894fd233bcc085a0a2d8dd52e9bea",
            "0x154c998c9a2d5afb1b9e512ad7dd58d2211c6147a746dc731af8ea5c068b9482a208647a4f6179de8df7c77200786ec4e8df2e884a38eef1789ca905fc78d95b",
            "df59a57296f2af8d5e1195b1b12eb65192ebb957464cb5ce831f4b74c02b652e",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x89689d71322894fd233bcc085a0a2d8dd52e9bea",
            "BBVMmYyaLVr7G55RKtfdWNIhHGFHp0bccxr46lwGi5SCoghkek9hed6N98dyAHhuxOjfLohKOO7xeJypBfx42Vs=",
            "31mlcpbyr41eEZWxsS62UZLruVdGTLXOgx9LdMArZS4=",
        ),
    ),
    # vanity/0x89789
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x897893346b6ecac69516d01c89a75855c35981a1",
            "0x9001bb8c7c8490a1f005de29559b8354e4497dc7b5bc91b9f32d91f5cf947dd85a525ecc2848fc1c7fae445e49c533d79f0349a8e3f9b21778bf3ff1c2a99eb0",
            "6bc58d81a8d4d172fe491ee868dbf67dcf06425ce13292571f54972da35df80d",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x897893346b6ecac69516d01c89a75855c35981a1",
            "BJABu4x8hJCh8AXeKVWbg1TkSX3HtbyRufMtkfXPlH3YWlJezChI/Bx/rkReScUz158DSajj+bIXeL8/8cKpnrA=",
            "a8WNgajU0XL+SR7oaNv2fc8GQlzhMpJXH1SXLaNd+A0=",
        ),
    ),
    # vanity/0x89889
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x89889382e34100fb7bfb1d1502775a65c05c3c9f",
            "0x9016f8ca0e68c51cdfce9ef25a1ec3b10cd561b8cd954d7e57897aef9ab45569aeb6ec49bd01172b68acc996a835a77cdd2f4c4b431aca2a36dd0821663d8997",
            "0454f86754c51eaa4f117656c035c082334fa8eeb3d50f699cd9de303b93f7a1",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x89889382e34100fb7bfb1d1502775a65c05c3c9f",
            "BJAW+MoOaMUc386e8loew7EM1WG4zZVNfleJeu+atFVprrbsSb0BFytorMmWqDWnfN0vTEtDGsoqNt0IIWY9iZc=",
            "BFT4Z1TFHqpPEXZWwDXAgjNPqO6z1Q9pnNneMDuT96E=",
        ),
    ),
    # vanity/0x89989
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x89989d88d2d02e1995bbfc1cbf872484da539884",
            "0x4677ecbf995fda1f6ed0f340bd69755d0eeab40f23e739032ef53be317b9a8cd739833ae88d1b8dca9a753446b1e883b6b2fe1e7efb71c06f8c445f13e6da189",
            "02be8d64214d46dd00d1cec71e88fe4904f80fad6f4cfa1d034f9d7c59143039",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x89989d88d2d02e1995bbfc1cbf872484da539884",
            "BEZ37L+ZX9ofbtDzQL1pdV0O6rQPI+c5Ay71O+MXuajNc5gzrojRuNypp1NEax6IO2sv4efvtxwG+MRF8T5toYk=",
            "Ar6NZCFNRt0A0c7HHoj+SQT4D61vTPodA0+dfFkUMDk=",
        ),
    ),
    # vanity/0x90090
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x900908829f6e493d3f22c8f4e7dfaaf4c7c9e173",
            "0x9ec024d70cc376520a6a11ce7edbe9454c9e4bebd8b99937d48d9b7a2e5c13dde732212e8d788a11ca74675ff76ce234fbced43f367e4e0bb80b839be186aa94",
            "94422ce381cc7c14e0f3fc0faef21797fdfd5f83487c643264d9314c9310071c",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x900908829f6e493d3f22c8f4e7dfaaf4c7c9e173",
            "BJ7AJNcMw3ZSCmoRzn7b6UVMnkvr2LmZN9SNm3ouXBPd5zIhLo14ihHKdGdf92ziNPvO1D82fk4LuAuDm+GGqpQ=",
            "lEIs44HMfBTg8/wPrvIXl/39X4NIfGQyZNkxTJMQBxw=",
        ),
    ),
    # vanity/0x90190
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x901902cf8319248ac3c387073c68c858f90d93c2",
            "0xee28f7d85050c2175b3cdaa0f89b2634fa99301f038e6ab018b1887350aa84f1afe98a5064210280f642c997763da9260148005f6207396552c4207e0327f15b",
            "4739cef5fcbfdc466d0c2080a41e1ed83d3e9378e4d6c33d6ef4b7a49a8eea8c",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x901902cf8319248ac3c387073c68c858f90d93c2",
            "BO4o99hQUMIXWzzaoPibJjT6mTAfA45qsBixiHNQqoTxr+mKUGQhAoD2QsmXdj2pJgFIAF9iBzllUsQgfgMn8Vs=",
            "RznO9fy/3EZtDCCApB4e2D0+k3jk1sM9bvS3pJqO6ow=",
        ),
    ),
    # vanity/0x90290
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x902901ee916d4c53f429ef17838aa702b52d587d",
            "0x4c9a866d474c469677193afdd1dfec1ab4a115998e89da713a41295da6d86de97c8b3a8308118862077958fbf8d5232be23fae22fbec56c649b40cf85c859122",
            "d883ea676d630923098e64f8817598c07e38b90d5b2bb69ab7e3f7ee72bc3985",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x902901ee916d4c53f429ef17838aa702b52d587d",
            "BEyahm1HTEaWdxk6/dHf7Bq0oRWZjonacTpBKV2m2G3pfIs6gwgRiGIHeVj7+NUjK+I/riL77FbGSbQM+FyFkSI=",
            "2IPqZ21jCSMJjmT4gXWYwH44uQ1bK7aat+P37nK8OYU=",
        ),
    ),
    # vanity/0x90390
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x9039058b46d65948f566da48e09e177277653a96",
            "0xdde5238feed98474fbdb4b28aedb81cb6dcc1bf64438f6c2856ad35754ba02812a48c904126b0a74d0b3a3125b70a36f2584fede475bca7daff075718c13720f",
            "15c2154b08667089f7422306353f71677483364b62f9d361a71933e73ba4f5e8",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x9039058b46d65948f566da48e09e177277653a96",
            "BN3lI4/u2YR0+9tLKK7bgcttzBv2RDj2woVq01dUugKBKkjJBBJrCnTQs6MSW3CjbyWE/t5HW8p9r/B1cYwTcg8=",
            "FcIVSwhmcIn3QiMGNT9xZ3SDNkti+dNhpxkz5zuk9eg=",
        ),
    ),
    # vanity/0x90490
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x9049078e3430b0cf3ea01af87d3c63d6db5959ae",
            "0x23d8fbb6b7e6a1eace9fa27c21ed69d0e53ab99189321fc5bd8ef23677d5fd62c2945428d6975d9f389bef12ceee09da00d9f601aa3cba4f223936e13f2be09c",
            "eb94044bc414e9a7ef24c670e4a5a60e669bb207184f9c1e03295abc30466ce9",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x9049078e3430b0cf3ea01af87d3c63d6db5959ae",
            "BCPY+7a35qHqzp+ifCHtadDlOrmRiTIfxb2O8jZ31f1iwpRUKNaXXZ84m+8Szu4J2gDZ9gGqPLpPIjk24T8r4Jw=",
            "65QES8QU6afvJMZw5KWmDmabsgcYT5weAylavDBGbOk=",
        ),
    ),
    # vanity/0x90590
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x90590a0fb5dc7b69156f4a8ea903ff02a3ea9f88",
            "0x144888626336c96e7b8a70c451ff91d78798b464fc99bc112a21b2f59633b37af0fe6441b4dae52a982bbf9d34bfd003417adfd4c1cf64ff0745de781785c7fb",
            "15c42658165ea86008fe5960393e8b7b80ea56eb9601abc759b81d83a86ae55b",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x90590a0fb5dc7b69156f4a8ea903ff02a3ea9f88",
            "BBRIiGJjNslue4pwxFH/kdeHmLRk/Jm8ESohsvWWM7N68P5kQbTa5SqYK7+dNL/QA0F639TBz2T/B0XeeBeFx/s=",
            "FcQmWBZeqGAI/llgOT6Le4DqVuuWAavHWbgdg6hq5Vs=",
        ),
    ),
    # vanity/0x90690
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x90690ec6ec466229b9ba348670ee816abad01f0f",
            "0x274c16680914cca8724aaeceb1aaf4475368472ccab81e83000342d2ea9a8beb06003059c326eee2d89529b4b82ea350944ae7675da027c57b65128f2efdde8e",
            "49d3cce06ec15e835505646a327732616d8adee94e46969d25d7bb74454ca5e9",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x90690ec6ec466229b9ba348670ee816abad01f0f",
            "BCdMFmgJFMyockquzrGq9EdTaEcsyrgegwADQtLqmovrBgAwWcMm7uLYlSm0uC6jUJRK52ddoCfFe2USjy793o4=",
            "SdPM4G7BXoNVBWRqMncyYW2K3ulORpadJde7dEVMpek=",
        ),
    ),
    # vanity/0x90790
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x90790831ab8baa3d44b8ab6d0d3ddf07ce54a130",
            "0x79663a4e0753ddef04f12530585d09120284b764bd50118ebb531db810657f84293f6247152d88a8ab12af69c1c5d270811b249d14aac7e403c48d85d73f2477",
            "66e724de574afe565cdb1221af372dd4770b1fa2690785a0c8b0f66e203af36f",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x90790831ab8baa3d44b8ab6d0d3ddf07ce54a130",
            "BHlmOk4HU93vBPElMFhdCRIChLdkvVARjrtTHbgQZX+EKT9iRxUtiKirEq9pwcXScIEbJJ0UqsfkA8SNhdc/JHc=",
            "Zuck3ldK/lZc2xIhrzct1HcLH6JpB4WgyLD2biA6828=",
        ),
    ),
    # vanity/0x90890
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x908903a81cd051ad84ec6e4a2faf5cacc71d691b",
            "0x6596f0874ce95493f0ce3d35e5afa666eb8f83950ee4d418583e0125e97548c2a4d592911e2a2f23d78be6fca394f692d7903963165dbac35b409bd02cebbf3f",
            "d51dd433d58e8be7491e6ebf047bcf50d3405999873ea8efe5c5ade73667d777",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x908903a81cd051ad84ec6e4a2faf5cacc71d691b",
            "BGWW8IdM6VST8M49NeWvpmbrj4OVDuTUGFg+ASXpdUjCpNWSkR4qLyPXi+b8o5T2kteQOWMWXbrDW0Cb0Czrvz8=",
            "1R3UM9WOi+dJHm6/BHvPUNNAWZmHPqjv5cWt5zZn13c=",
        ),
    ),
    # vanity/0x90990
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x909902f9d556dc948d9472b9c3f486fb1799ef5b",
            "0x1e11f301b78d548dc97b6dccb140f015b8ada8b7bee052e61311360532d3ce9347f9b5c18f98ec11748ea0737938dbf1cf7a8a36f42245590792e5a90dc2ccf3",
            "00606a07958861662c9fbbc4f5a2a9fc4c7ae480af6bdbe4737ffd69058a7666",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x909902f9d556dc948d9472b9c3f486fb1799ef5b",
            "BB4R8wG3jVSNyXttzLFA8BW4rai3vuBS5hMRNgUy086TR/m1wY+Y7BF0jqBzeTjb8c96ijb0IkVZB5LlqQ3CzPM=",
            "AGBqB5WIYWYsn7vE9aKp/Ex65ICva9vkc3/9aQWKdmY=",
        ),
    ),
    # vanity/0x91091
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x91091ff06f1081f06e4a130ddc645f5e8b8e547e",
            "0xc9e6113b80b20a58ca6eb2e2045ebce3a522da088c06a7a3ca7db3d1ac2cdd4327adc23c9919365de91a615dce85c0346123c7009c90918e487a3df751ff1b5d",
            "e6c96f8906a69cd1e74d6cb98d6bb6f3a17e74f3491d8383cc5fa62b59e6b905",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x91091ff06f1081f06e4a130ddc645f5e8b8e547e",
            "BMnmETuAsgpYym6y4gRevOOlItoIjAano8p9s9GsLN1DJ63CPJkZNl3pGmFdzoXANGEjxwCckJGOSHo991H/G10=",
            "5slviQamnNHnTWy5jWu286F+dPNJHYODzF+mK1nmuQU=",
        ),
    ),
    # vanity/0x91191
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x91191dcf281ad1ce6312d007b7b4b3896a4c17bf",
            "0xd3dbb79cd3a86e4eb20ff15b164f3ad2f418434e67c44525bb29c64e4bae74edaa6262e0f7df9c93d55c7598a95327a5355c84bdb2dfd1a6a4b48c91bf90209a",
            "afbfa99c7f75cfd6792c77059a7bb1a6ac600cd7134c886328639cd5b7a8750e",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x91191dcf281ad1ce6312d007b7b4b3896a4c17bf",
            "BNPbt5zTqG5Osg/xWxZPOtL0GENOZ8RFJbspxk5LrnTtqmJi4PffnJPVXHWYqVMnpTVchL2y39GmpLSMkb+QIJo=",
            "r7+pnH91z9Z5LHcFmnuxpqxgDNcTTIhjKGOc1beodQ4=",
        ),
    ),
    # vanity/0x91291
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x912914705c464276893ac7a50af8123b4d08791b",
            "0x83ed4ddb105626f57fba09d7e68826e49fd312b863ab4726fcaceb0886f81cd55b4d6709f49436725ecc0cc9d7b15f013de874fae4411631215fc20669f51d47",
            "94bae0a38b649f64a74ecb5989e8d6eec44ee9e1ec5d4492681f4edfe0a2d455",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x912914705c464276893ac7a50af8123b4d08791b",
            "BIPtTdsQVib1f7oJ1+aIJuSf0xK4Y6tHJvys6wiG+BzVW01nCfSUNnJezAzJ17FfAT3odPrkQRYxIV/CBmn1HUc=",
            "lLrgo4tkn2SnTstZiejW7sRO6eHsXUSSaB9O3+Ci1FU=",
        ),
    ),
    # vanity/0x91391
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x913914c88c576289f7232cd3d67e00529befeebb",
            "0xdf57ede82d2fcc56ff6f090a40de20e4c651b01962fccaa0587208d884d96196ea8dc515f0a6f8df1370e1bffda8bd22ef710aed0431a0167069af9f6d13e36d",
            "b9fec8cadbb6c2e486b4190594a2e55591d266c6dd7616c6811ffe5997c988aa",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x913914c88c576289f7232cd3d67e00529befeebb",
            "BN9X7egtL8xW/28JCkDeIOTGUbAZYvzKoFhyCNiE2WGW6o3FFfCm+N8TcOG//ai9Iu9xCu0EMaAWcGmvn20T420=",
            "uf7Iytu2wuSGtBkFlKLlVZHSZsbddhbGgR/+WZfJiKo=",
        ),
    ),
    # vanity/0x91491
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x91491211407e4d050ce104965504bf9b6e8da63d",
            "0xdac69b00ad075668f85d7eb1b10b0107fd79f85398a23b67ce03cc1933b76e1871a8401a976a01bf474a19e20b0197234739a0727196d38f7d03da88478b122f",
            "38e066a4c67213293b782f38adc95e8be21f615b6238fb0cda5d1fae934ea988",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x91491211407e4d050ce104965504bf9b6e8da63d",
            "BNrGmwCtB1Zo+F1+sbELAQf9efhTmKI7Z84DzBkzt24YcahAGpdqAb9HShniCwGXI0c5oHJxltOPfQPaiEeLEi8=",
            "OOBmpMZyEyk7eC84rclei+IfYVtiOPsM2l0frpNOqYg=",
        ),
    ),
    # vanity/0x91591
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x91591dfba627593b7516b0c98e8f4e7bbbf123da",
            "0xa0fafe1e923b8b7244b70c472ecb40c489b454b7493b364ac9370a5e5cb2fbf9916481a6c5e67c8228deab609f2f11dc995b6c99c58ddbd063440a95e6a47a75",
            "4cd8f4142545d9523dfcbed7ef32da721b02bd5a31b365ebedc962b95f9bc3bf",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x91591dfba627593b7516b0c98e8f4e7bbbf123da",
            "BKD6/h6SO4tyRLcMRy7LQMSJtFS3STs2Ssk3Cl5csvv5kWSBpsXmfIIo3qtgny8R3JlbbJnFjdvQY0QKleakenU=",
            "TNj0FCVF2VI9/L7X7zLachsCvVoxs2Xr7cliuV+bw78=",
        ),
    ),
    # vanity/0x91691
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x91691ca7ba0c0e55edab3aa512a4ccc36a8e2837",
            "0x08fb294f9f71b683fdad0f82f7b262fe83528799f85a2ce8a78e42224870b6042aaca07ed55ff42363e7a29b0fa8543e91e654312c3980c21f55738b65af1f9b",
            "5432deeccfdeb3b9623fcd252d3a9695638df3188cf83ee1f3701e1b5c804194",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x91691ca7ba0c0e55edab3aa512a4ccc36a8e2837",
            "BAj7KU+fcbaD/a0PgveyYv6DUoeZ+Fos6KeOQiJIcLYEKqygftVf9CNj56KbD6hUPpHmVDEsOYDCH1Vzi2WvH5s=",
            "VDLe7M/es7liP80lLTqWlWON8xiM+D7h83AeG1yAQZQ=",
        ),
    ),
    # vanity/0x91791
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x917919696bd4798c814e7e04807d345c3026f85b",
            "0x20c5c71f43a73fb834c64832d4474dfd8f7307226d5aa89e823c6a197f389e710e2d9f85301d2b3dc7359da089cab206cab88b762ce84e50165fc420531dc04e",
            "03521979295005edd004080237d690126b87aa87bb658f3de971de2a99c64fd3",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x917919696bd4798c814e7e04807d345c3026f85b",
            "BCDFxx9Dpz+4NMZIMtRHTf2PcwcibVqonoI8ahl/OJ5xDi2fhTAdKz3HNZ2gicqyBsq4i3Ys6E5QFl/EIFMdwE4=",
            "A1IZeSlQBe3QBAgCN9aQEmuHqoe7ZY896XHeKpnGT9M=",
        ),
    ),
    # vanity/0x91891
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x918917c6938d9a0d2763e1bd0f847d5c3f372da9",
            "0xad2d4626f33c3e3bf838218bdd12155bbb12b57f08a6ae4ca5929e01988c47e4ad0f02dd3645136818be536a5ef6931080c838d3acca463662418fad6a3b6f7d",
            "8e9974372d633d27f3d02d53388059547c9e57f0805e63126c427a23d0056521",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x918917c6938d9a0d2763e1bd0f847d5c3f372da9",
            "BK0tRibzPD47+Dghi90SFVu7ErV/CKauTKWSngGYjEfkrQ8C3TZFE2gYvlNqXvaTEIDIONOsykY2YkGPrWo7b30=",
            "jpl0Ny1jPSfz0C1TOIBZVHyeV/CAXmMSbEJ6I9AFZSE=",
        ),
    ),
    # vanity/0x91991
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x91991663b5d2e2c2476830d6a2ce6a4d4dcf4e0f",
            "0xcc6fad36ea076b71c4668a8d48e0398d9d273cd090d393707d2336bf5af80341173f857264ba39a5330595c02e34e744d972284cb70af1036140f83b8f8d1cb6",
            "6f3a17b3c2e2a76acecb0728180e4260369a439a5dd618ee29676694aed8dbc0",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x91991663b5d2e2c2476830d6a2ce6a4d4dcf4e0f",
            "BMxvrTbqB2txxGaKjUjgOY2dJzzQkNOTcH0jNr9a+ANBFz+FcmS6OaUzBZXALjTnRNlyKEy3CvEDYUD4O4+NHLY=",
            "bzoXs8Lip2rOywcoGA5CYDaaQ5pd1hjuKWdmlK7Y28A=",
        ),
    ),
    # vanity/0x92092
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x9209260bbf1a882f613970cafd7fac4389a900ec",
            "0x6f58789f0775eeb724e8579a99d47f83c76d5ed4b71a205b801d1f0713ec1e88ebe56811282a779a33fe7909a918d91d3a472d7e44ebe4ccf71bd96918e1f419",
            "51ccf0effea3bad576537822d242d11460d2c43073432cab4d49bc96fc9774d1",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x9209260bbf1a882f613970cafd7fac4389a900ec",
            "BG9YeJ8Hde63JOhXmpnUf4PHbV7UtxogW4AdHwcT7B6I6+VoESgqd5oz/nkJqRjZHTpHLX5E6+TM9xvZaRjh9Bk=",
            "Uczw7/6jutV2U3gi0kLRFGDSxDBzQyyrTUm8lvyXdNE=",
        ),
    ),
    # vanity/0x92192
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x921926b66f978360f49b642567654473d041d974",
            "0xca54955e6a3418b1caa7aba3f6bbfb6b4b0c0551253085c35f5e3980e19b2685508035a7b473e36002e6c8b48d5b492e975e5ed47fe1b35c8aae26352389a6ef",
            "5ca28904cde94be0d7c1d0b5902dd703fb63e9a1e462ed0a0c373b3cef83adc6",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x921926b66f978360f49b642567654473d041d974",
            "BMpUlV5qNBixyqero/a7+2tLDAVRJTCFw19eOYDhmyaFUIA1p7Rz42AC5si0jVtJLpdeXtR/4bNciq4mNSOJpu8=",
            "XKKJBM3pS+DXwdC1kC3XA/tj6aHkYu0KDDc7PO+DrcY=",
        ),
    ),
    # vanity/0x92292
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x922925c24e932a3402991e8b6d1692106f2a83b7",
            "0x416fb66c766b7a59bb3da639a67a68fc53dc2c606d541798463d2791c3ee8410dd9d9a9f065143ab8755631527685223100870e57f6da6e70006d8c51ae3ea38",
            "33ee4f0304f60914a44b6fa229ead385850cb8e3ff3fe1c5300a21a03692d5c9",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x922925c24e932a3402991e8b6d1692106f2a83b7",
            "BEFvtmx2a3pZuz2mOaZ6aPxT3CxgbVQXmEY9J5HD7oQQ3Z2anwZRQ6uHVWMVJ2hSIxAIcOV/babnAAbYxRrj6jg=",
            "M+5PAwT2CRSkS2+iKerThYUMuOP/P+HFMAohoDaS1ck=",
        ),
    ),
    # vanity/0x92392
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x92392a1daf67e75ffe020f1dd1b52097e0bb9bbe",
            "0x2c1362f2410893831605fbf6b8bd3d857a6782f91c7b11196047cf624a9005c6b4c7ac1c7c1c577908830bcf371114a69c995d202f1e05c46dd0fbf5a7b06a5d",
            "e62f4c6b669696d999780dc01d7e312b9326479c0e4938b567547948144e6e65",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x92392a1daf67e75ffe020f1dd1b52097e0bb9bbe",
            "BCwTYvJBCJODFgX79ri9PYV6Z4L5HHsRGWBHz2JKkAXGtMesHHwcV3kIgwvPNxEUppyZXSAvHgXEbdD79aewal0=",
            "5i9Ma2aWltmZeA3AHX4xK5MmR5wOSTi1Z1R5SBRObmU=",
        ),
    ),
    # vanity/0x92492
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x9249207915ed06accc0037ab4d2bf9be15bc74cd",
            "0xe8ffbf3b321caa65a569ea389cf96a147483b25c631ac6f3200940103fb25dca3cbaec03e22714aa0fa13bc0fa8e9db1ee474302d6ee92459c76986b420742ff",
            "6a7962bee4760feb40a2dedd0790e601a239e391bb2aac4bed49c3689bbf8d43",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x9249207915ed06accc0037ab4d2bf9be15bc74cd",
            "BOj/vzsyHKplpWnqOJz5ahR0g7JcYxrG8yAJQBA/sl3KPLrsA+InFKoPoTvA+o6dse5HQwLW7pJFnHaYa0IHQv8=",
            "anlivuR2D+tAot7dB5DmAaI545G7KqxL7UnDaJu/jUM=",
        ),
    ),
    # vanity/0x92592
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x92592de1e079b4b4b64e2480f1d03a5b28ac29c6",
            "0x01d9ad8eaaf488a2bd96a5bf4ba5de1cd2eb29aacf53b3647c6b57f4161bfb11d5ab07f9d94636eddc655d106d12d840e3d1f0058916c9d8c1dc5d910fe0311e",
            "e76291fd281146d67c376217d54b145d2c8d1a98827790a0012cabaec5049e4a",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x92592de1e079b4b4b64e2480f1d03a5b28ac29c6",
            "BAHZrY6q9IiivZalv0ul3hzS6ymqz1OzZHxrV/QWG/sR1asH+dlGNu3cZV0QbRLYQOPR8AWJFsnYwdxdkQ/gMR4=",
            "52KR/SgRRtZ8N2IX1UsUXSyNGpiCd5CgASyrrsUEnko=",
        ),
    ),
    # vanity/0x92692
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x926920e3c46e1d8da218be053eaa94ccd62fa25e",
            "0xd6d197aa221abd639c8976ccbcb8fec551389711603218c2ce905fc5978dc938bca874d74b2e86b401ed63f12729a35226ae5892865d7db2aed5328f52a5099b",
            "6f3d2f8e5914bf13df96102bce642c24a2e80db341666eb9c3e483c51d090c3d",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x926920e3c46e1d8da218be053eaa94ccd62fa25e",
            "BNbRl6oiGr1jnIl2zLy4/sVROJcRYDIYws6QX8WXjck4vKh010suhrQB7WPxJymjUiauWJKGXX2yrtUyj1KlCZs=",
            "bz0vjlkUvxPflhArzmQsJKLoDbNBZm65w+SDxR0JDD0=",
        ),
    ),
    # vanity/0x92792
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x92792b70f656121b580461092537de4ffd6dc0f6",
            "0xebd7eee2bda585671ec58194498e72b57d290aeced193a0cc4c0d6fa3b23d53eb762446903d861d7c8faa30335252251ad8371ec41f59a0e2c3af6c14d022130",
            "98900c4c4d64a923a3845907bf82b7049d346b9a2e41e71220f11f64e3641d2d",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x92792b70f656121b580461092537de4ffd6dc0f6",
            "BOvX7uK9pYVnHsWBlEmOcrV9KQrs7Rk6DMTA1vo7I9U+t2JEaQPYYdfI+qMDNSUiUa2DcexB9ZoOLDr2wU0CITA=",
            "mJAMTE1kqSOjhFkHv4K3BJ00a5ouQecSIPEfZONkHS0=",
        ),
    ),
    # vanity/0x92892
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x9289239727afd15b884ec64693085ea7f571ca01",
            "0x710392c3b7447b56b38d2ab3166497d472def52211db35788865f03b837fe850885843f31164f598f594b50b5d9f8f55f9a4c6cf6c1156ca07c794f563e75582",
            "8b5ff8e196075d615a009dae8511b56f0fa8591ee29cfcd33cec47420c5888e3",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x9289239727afd15b884ec64693085ea7f571ca01",
            "BHEDksO3RHtWs40qsxZkl9Ry3vUiEds1eIhl8DuDf+hQiFhD8xFk9Zj1lLULXZ+PVfmkxs9sEVbKB8eU9WPnVYI=",
            "i1/44ZYHXWFaAJ2uhRG1bw+oWR7inPzTPOxHQgxYiOM=",
        ),
    ),
    # vanity/0x92992
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x929920bc58f6ce72a18c45bfc073ee9144b89601",
            "0x915f4c9539339bdd56f4922fb747e773e02fb977d558f3e3828bc5bb7811e2109bb170e87a02e2c51d35d7a277d4b1dbc662df11a00eadb162eaa6e2f03d66c3",
            "90871a31a10338b9ef3d70cb4c9a89b35694f5e596996ef6c244c3695f898f9a",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x929920bc58f6ce72a18c45bfc073ee9144b89601",
            "BJFfTJU5M5vdVvSSL7dH53PgL7l31Vjz44KLxbt4EeIQm7Fw6HoC4sUdNdeid9Sx28Zi3xGgDq2xYuqm4vA9ZsM=",
            "kIcaMaEDOLnvPXDLTJqJs1aU9eWWmW72wkTDaV+Jj5o=",
        ),
    ),
    # vanity/0x93093
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x93093a5dc3f860dee8d0625c243b8f6985903158",
            "0x528cee025a1ddbd1a83fc3873060477a9510eac1ead3e6792664255963eef4416e04c934ef89d91aa3447267cb9af5a87d9f1d4123bd844ca2e00972213e9ec5",
            "e47a19de46f21346966ae9ff9e74f618aab9a58f58e04d83bbbfea941897b191",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x93093a5dc3f860dee8d0625c243b8f6985903158",
            "BFKM7gJaHdvRqD/DhzBgR3qVEOrB6tPmeSZkJVlj7vRBbgTJNO+J2RqjRHJny5r1qH2fHUEjvYRMouAJciE+nsU=",
            "5HoZ3kbyE0aWaun/nnT2GKq5pY9Y4E2Du7/qlBiXsZE=",
        ),
    ),
    # vanity/0x93193
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x93193aacf9cfd5512fdd7de1604a7cfdf9bde698",
            "0x7c84a8fcc5e174aa9a1b3f2cbe0aa18595e035d5d11c79767e3196133f5375993b4428f42c689d9de170eb6b036423ae28f289bb7375da4cd62461c6b71b219a",
            "ebdf14d1730794c569d2474707d1544c5f78b5ee473277945c82e3c1faf55f67",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x93193aacf9cfd5512fdd7de1604a7cfdf9bde698",
            "BHyEqPzF4XSqmhs/LL4KoYWV4DXV0Rx5dn4xlhM/U3WZO0Qo9CxonZ3hcOtrA2QjrijyibtzddpM1iRhxrcbIZo=",
            "698U0XMHlMVp0kdHB9FUTF94te5HMneUXILjwfr1X2c=",
        ),
    ),
    # vanity/0x93293
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x93293b09725bab0f1d549750241df82ea03eb6fe",
            "0x8a55101c7aa36ad80277b10812bd897a10b6a2db39ffa7231b2c9117f3773dcf2766d0dbb0e0caafd75d65006a11cb317672cec37ee99207631299b95a7f4e25",
            "0b8dc789935b04c7349593f91303f85ccdf246eab63105b900fc82622c7f25bd",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x93293b09725bab0f1d549750241df82ea03eb6fe",
            "BIpVEBx6o2rYAnexCBK9iXoQtqLbOf+nIxsskRfzdz3PJ2bQ27Dgyq/XXWUAahHLMXZyzsN+6ZIHYxKZuVp/TiU=",
            "C43HiZNbBMc0lZP5EwP4XM3yRuq2MQW5APyCYix/Jb0=",
        ),
    ),
    # vanity/0x93393
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x933938eaca5aef8085e7a469a93bc03af879d09e",
            "0xf533d48f4d4718552b73cf91c9d5b3f8397c59dc908205d6686e9245551fd12a5ac7600a7e60db85396f02103c5bee74add25638425fe316aa7a124432b5df18",
            "190e5a8dd41a97f97579642923820b58bf2b2bc20fdafa8ba9b99ac4fa028a86",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x933938eaca5aef8085e7a469a93bc03af879d09e",
            "BPUz1I9NRxhVK3PPkcnVs/g5fFnckIIF1mhukkVVH9EqWsdgCn5g24U5bwIQPFvudK3SVjhCX+MWqnoSRDK13xg=",
            "GQ5ajdQal/l1eWQpI4ILWL8rK8IP2vqLqbmaxPoCioY=",
        ),
    ),
    # vanity/0x93493
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x934937f1e83ced217fa55b9e800b8a335cf448c5",
            "0x0757bfd61ae46d81ee321ae6b360b155f43f4299ae32438af6f63e0b2cd7d0887d95daa3e6bbf0bebb83dcdebe531bebba5a1f9f50f3075b21b44e47731e9a20",
            "818d66fffb17a3aa4dcb2ec90797d09fff17bf46b0900e2880c0e15cdbe32231",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x934937f1e83ced217fa55b9e800b8a335cf448c5",
            "BAdXv9Ya5G2B7jIa5rNgsVX0P0KZrjJDivb2Pgss19CIfZXao+a78L67g9zevlMb67paH59Q8wdbIbROR3MemiA=",
            "gY1m//sXo6pNyy7JB5fQn/8Xv0awkA4ogMDhXNvjIjE=",
        ),
    ),
    # vanity/0x93593
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x93593234cde7da173c504f997271b53ed4d26748",
            "0xac9244ce0b9b7838466cda764346b697bd0bb5deb6d1abb2b4193fdc99c964cfc9aef8e56c1592b06139cefea3771998b3a5c9b72c38f8fe53980638d05edbc6",
            "9ed50f8367de4ac9d67fffb5b4b5c79241695e0f2e1ec72310e3ab1db155701f",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x93593234cde7da173c504f997271b53ed4d26748",
            "BKySRM4Lm3g4RmzadkNGtpe9C7XettGrsrQZP9yZyWTPya745WwVkrBhOc7+o3cZmLOlybcsOPj+U5gGONBe28Y=",
            "ntUPg2feSsnWf/+1tLXHkkFpXg8uHscjEOOrHbFVcB8=",
        ),
    ),
    # vanity/0x93693
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x93693da6de48d0bcf8c53c218a9c716630521dfe",
            "0xb9756c407133cf335d1d18ec65f6ec9f59eb8002400d62dd00f6a4de6ca68f2308af2e9c791c72a744aa2f97ea2a76a561885a1be52ec53c8e9360e43b7561bc",
            "02d59fc33494b8e8b673f7c4a4e3c468757469d3cf2870ef71e2f20341a22576",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x93693da6de48d0bcf8c53c218a9c716630521dfe",
            "BLl1bEBxM88zXR0Y7GX27J9Z64ACQA1i3QD2pN5spo8jCK8unHkccqdEqi+X6ip2pWGIWhvlLsU8jpNg5Dt1Ybw=",
            "AtWfwzSUuOi2c/fEpOPEaHV0adPPKHDvceLyA0GiJXY=",
        ),
    ),
    # vanity/0x93793
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x93793e53881feb3426910e9446bfc98db66e005b",
            "0xbc785abbb59b268fb7776bee45007b19d777e47992026de2e7ddaa2ec0afe029c768b3e7326c3003c6ea6bb278da1e426866f81853a32763b3d103d8002074c2",
            "d4fd1a8250ff899594552f104d1039bcc917652c4d3cbe9fb4131b92a7ff5e22",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x93793e53881feb3426910e9446bfc98db66e005b",
            "BLx4Wru1myaPt3dr7kUAexnXd+R5kgJt4ufdqi7Ar+Apx2iz5zJsMAPG6muyeNoeQmhm+BhToydjs9ED2AAgdMI=",
            "1P0aglD/iZWUVS8QTRA5vMkXZSxNPL6ftBMbkqf/XiI=",
        ),
    ),
    # vanity/0x93893
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x938937180e2148b973908b58883a425ad8493852",
            "0xa6c2476bd704564b52bbec075456ac7ea6d9c4ffa046ec4f99a32c0990a0935e83d1a77b2e4f88c95b706f7b0f4613e637ae7712cc5572d86326fb71e7b7e484",
            "b90bd513b5f4c10e5e2d24dad39cb5549a927de86b4a631675bb99d684902e5c",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x938937180e2148b973908b58883a425ad8493852",
            "BKbCR2vXBFZLUrvsB1RWrH6m2cT/oEbsT5mjLAmQoJNeg9Gney5PiMlbcG97D0YT5jeudxLMVXLYYyb7cee35IQ=",
            "uQvVE7X0wQ5eLSTa05y1VJqSfehrSmMWdbuZ1oSQLlw=",
        ),
    ),
    # vanity/0x93993
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x93993bd915de6ee7186fb528d2ddf90945abbfad",
            "0x5f9cffc325c86d78d778aacb6b56273b77edff5a56fc5d76dc7d4daf026976e0b261387dfa214f80444a7863a6b655fb05f55d23d292d1aa8af56865519248c6",
            "960eecfbb503276eacf0129970d99535b26130a663055201eaf556d30f3fdcbc",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x93993bd915de6ee7186fb528d2ddf90945abbfad",
            "BF+c/8MlyG1413iqy2tWJzt37f9aVvxddtx9Ta8CaXbgsmE4ffohT4BESnhjprZV+wX1XSPSktGqivVoZVGSSMY=",
            "lg7s+7UDJ26s8BKZcNmVNbJhMKZjBVIB6vVW0w8/3Lw=",
        ),
    ),
    # vanity/0x94094
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x94094dcb9ec8a8d2c130086d2d4ec697a79a4222",
            "0xb8a3e6587abfbf6847d4ca78033280949f967148394d56ab146605a2e31c93784914369c183356bea76bdc0ef897d04448a115a126f9cfd7a7d2e7efc6dec226",
            "35b919f2138268092d2957a6887505a682a24389d2e975336776c2aec3d788eb",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x94094dcb9ec8a8d2c130086d2d4ec697a79a4222",
            "BLij5lh6v79oR9TKeAMygJSflnFIOU1WqxRmBaLjHJN4SRQ2nBgzVr6na9wO+JfQREihFaEm+c/Xp9Ln78bewiY=",
            "NbkZ8hOCaAktKVemiHUFpoKiQ4nS6XUzZ3bCrsPXiOs=",
        ),
    ),
    # vanity/0x94194
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x941945bd36c9bc584b134fc852b5fd5e9828619a",
            "0x058c712c4f46458f5dff63987d6522a67ac4b850e68b7c5b6574a0ee3ab598946acd4b324a3693ea795c4ee8e7cd21c723957b6c1ab31fa900cad2c9affb66ef",
            "9f54c2fcda8aa319002fe6eca6ef65e075d589b471d3f3727af2373a78bb4de0",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x941945bd36c9bc584b134fc852b5fd5e9828619a",
            "BAWMcSxPRkWPXf9jmH1lIqZ6xLhQ5ot8W2V0oO46tZiUas1LMko2k+p5XE7o580hxyOVe2wasx+pAMrSya/7Zu8=",
            "n1TC/NqKoxkAL+bspu9l4HXVibRx0/NyevI3Oni7TeA=",
        ),
    ),
    # vanity/0x94294
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x94294063541b3ee2d8a8b92448fdf24fa927797a",
            "0x5640653fad1f1540ad1f2875abccf954c57f3cce2d9a960639119a61b6a0d267b9c087731528210ab43eac8c5dc4e30953dcd9edb954c06978019a2346bebf12",
            "7922258c164b7dac5de169d0bba9c8d042e6e14a32c9adf9f30cac730843dd67",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x94294063541b3ee2d8a8b92448fdf24fa927797a",
            "BFZAZT+tHxVArR8odavM+VTFfzzOLZqWBjkRmmG2oNJnucCHcxUoIQq0PqyMXcTjCVPc2e25VMBpeAGaI0a+vxI=",
            "eSIljBZLfaxd4WnQu6nI0ELm4Uoyya358wyscwhD3Wc=",
        ),
    ),
    # vanity/0x94394
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x94394a58fe43b44dd91617327c61bdcd2e33c252",
            "0xf0896c32e1838def1e0de34abc5d9c0793898c25073df54e2b6d0940cc0a2f41dd50bd9f496b12766e44711ce7ef9b3eda31f6056a5472d4810c36aa85655ffa",
            "09232588e028a96b8291ff0992bb063e4b333820c0e3146a44bef4eaa885938e",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x94394a58fe43b44dd91617327c61bdcd2e33c252",
            "BPCJbDLhg43vHg3jSrxdnAeTiYwlBz31TittCUDMCi9B3VC9n0lrEnZuRHEc5++bPtox9gVqVHLUgQw2qoVlX/o=",
            "CSMliOAoqWuCkf8JkrsGPkszOCDA4xRqRL706qiFk44=",
        ),
    ),
    # vanity/0x94494
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x94494e6a95a530d07c7aa664af59e1e3d075fd5b",
            "0x5a50e7721a47a55101ceded8c7f268a50de6ba76479d8460e095d8adbe52e13401e77c3d4dce201fed8e1a62421dea00a2bf7323a145b0dc9a79c228f41709c8",
            "a3051b7d25ea0577ee6fe8fd394c518acf21e4ab3149dd67d93635c5008dd34c",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x94494e6a95a530d07c7aa664af59e1e3d075fd5b",
            "BFpQ53IaR6VRAc7e2MfyaKUN5rp2R52EYOCV2K2+UuE0Aed8PU3OIB/tjhpiQh3qAKK/cyOhRbDcmnnCKPQXCcg=",
            "owUbfSXqBXfub+j9OUxRis8h5KsxSd1n2TY1xQCN00w=",
        ),
    ),
    # vanity/0x94594
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x94594e08f5696c60d1b31b7c1767c1657cc1c281",
            "0x33758864fcfc4a279e72e7fe4ce2bb65e52c88d1bad4ae8bcafbb7bcdae30103029bcc6188606fa24d0f39fde07f7c0487781556403c99a50bc3f9943e7849c0",
            "5930b2e3fbced774daea20aae8610d2b3b80950f86301fca898e1a004146cd21",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x94594e08f5696c60d1b31b7c1767c1657cc1c281",
            "BDN1iGT8/EonnnLn/kziu2XlLIjRutSui8r7t7za4wEDApvMYYhgb6JNDzn94H98BId4FVZAPJmlC8P5lD54ScA=",
            "WTCy4/vO13Ta6iCq6GENKzuAlQ+GMB/KiY4aAEFGzSE=",
        ),
    ),
    # vanity/0x94694
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x94694eb07c7d5755cc84eaf349928e8dd8eb2dc7",
            "0xd083bbdfeaa322a709daac1f7c199533a79a6ca62afa0a9cb263c41e5cb72d464d398cf87d19a0dff3f4dc887bf02fcad66455ec1c20211cd19da2f8907acac3",
            "5b569037bbb6401f855bbbeaee241f7e7d32603400330e6b5364d35cd434e60e",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x94694eb07c7d5755cc84eaf349928e8dd8eb2dc7",
            "BNCDu9/qoyKnCdqsH3wZlTOnmmymKvoKnLJjxB5cty1GTTmM+H0ZoN/z9NyIe/AvytZkVewcICEc0Z2i+JB6ysM=",
            "W1aQN7u2QB+FW7vq7iQffn0yYDQAMw5rU2TTXNQ05g4=",
        ),
    ),
    # vanity/0x94794
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x94794e762261f5f84b19a0a5a1bbc259bb03d77b",
            "0x41627ccf35149aa2adfc40af686ad8a2fbd7a4bdd9af91d51f98e5d4f43c1db933e990dee2f98647ff1afefe85e98179ed6673c26caa3ac0030346eb9348603e",
            "3eb0fdc415f91532d491cadb504c941609ab2ebddf6b448a9e95e2b583d77c90",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x94794e762261f5f84b19a0a5a1bbc259bb03d77b",
            "BEFifM81FJqirfxAr2hq2KL716S92a+R1R+Y5dT0PB25M+mQ3uL5hkf/Gv7+hemBee1mc8JsqjrAAwNG65NIYD4=",
            "PrD9xBX5FTLUkcrbUEyUFgmrLr3fa0SKnpXitYPXfJA=",
        ),
    ),
    # vanity/0x94894
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x94894534d1f3a415131a09e010c124dc7f0fb86a",
            "0xa506ffe8abed0b640a9ad61f69430d2028d91f12584e90b1af7e593e5ea59303cdb2a1923283f103559c15e1f9bc30259082b01b81c924fd704f10b432a7f805",
            "91cd3b0de5b2fcba35479082adee56662902d0d610f6241ae864331fc3902e91",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x94894534d1f3a415131a09e010c124dc7f0fb86a",
            "BKUG/+ir7QtkCprWH2lDDSAo2R8SWE6Qsa9+WT5epZMDzbKhkjKD8QNVnBXh+bwwJZCCsBuByST9cE8QtDKn+AU=",
            "kc07DeWy/Lo1R5CCre5WZikC0NYQ9iQa6GQzH8OQLpE=",
        ),
    ),
    # vanity/0x94994
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x94994737af21d5c9f5a59842e88753ea40ea521b",
            "0x002720da0e272514c86ed1f7498e1ca99b3cf97eae7c29c977e4d6a814351b98a67ad339398093b9cafe02af87bd107c40d9f4c2eb49654b9a9ef6828e8f358f",
            "a3ad3a56e8a4739a4cec592877f3efb210f600766a93f2e9a77665b5ea9eb310",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x94994737af21d5c9f5a59842e88753ea40ea521b",
            "BAAnINoOJyUUyG7R90mOHKmbPPl+rnwpyXfk1qgUNRuYpnrTOTmAk7nK/gKvh70QfEDZ9MLrSWVLmp72go6PNY8=",
            "o606Vuikc5pM7Fkod/PvshD2AHZqk/Lpp3ZlteqesxA=",
        ),
    ),
    # vanity/0x95095
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x95095d6f6eb3d73dbc48ed9d94337718636a06fa",
            "0x828393f59351538e92c1a1f0b475ebf4c822fa2beb38d2bcb03f113aee3975fb299f2ffa212ce46a003cc209be4e65de79caecf3a4acc73ff4f6f470d1ddd8c2",
            "b0cbd45921dfee196feb1100d03818f07d94d22cecc985debcbba0c4bef72f9c",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x95095d6f6eb3d73dbc48ed9d94337718636a06fa",
            "BIKDk/WTUVOOksGh8LR16/TIIvor6zjSvLA/ETruOXX7KZ8v+iEs5GoAPMIJvk5l3nnK7POkrMc/9Pb0cNHd2MI=",
            "sMvUWSHf7hlv6xEA0DgY8H2U0izsyYXevLugxL73L5w=",
        ),
    ),
    # vanity/0x95195
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x95195480757ad37677a46f851d648f0bc9fe3187",
            "0xe29dbc5d92aaa481cd0ef95d44c0a58a16ccd53c0ed0eea7ea1e1f5dffb1bc17f1fd2cff378e78e916c5f1bbf3ce96936eceeac6668c37e1681ff77fd64f6b0e",
            "dec0d24c660f5e4f4691d37a376baa1e3945e26411b3c9813847cd0e3e14f986",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x95195480757ad37677a46f851d648f0bc9fe3187",
            "BOKdvF2SqqSBzQ75XUTApYoWzNU8DtDup+oeH13/sbwX8f0s/zeOeOkWxfG7886Wk27O6sZmjDfhaB/3f9ZPaw4=",
            "3sDSTGYPXk9GkdN6N2uqHjlF4mQRs8mBOEfNDj4U+YY=",
        ),
    ),
    # vanity/0x95295
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x9529535d3cbcf046f7ec8fec6b4a2590ecf94541",
            "0x66a795326438cbafd70e7080b7d51579c99c76b7f1dbf5a79a28d78e4433745acb84bf226a6540728f9dd9d544cc9aaec6f356ad22771b9e4c5ed7bae7fdd402",
            "7a587394db50a9b60860177919972b2990fe54d4bed976c9ac94d4898f905864",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x9529535d3cbcf046f7ec8fec6b4a2590ecf94541",
            "BGanlTJkOMuv1w5wgLfVFXnJnHa38dv1p5oo145EM3Ray4S/ImplQHKPndnVRMyarsbzVq0idxueTF7Xuuf91AI=",
            "elhzlNtQqbYIYBd5GZcrKZD+VNS+2XbJrJTUiY+QWGQ=",
        ),
    ),
    # vanity/0x95395
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x953957b1b1e322370c91f0d6c3ab09e86a635660",
            "0x2f43a75dcca4c8138455fc7c8db0e2266f5e3060df499c7d479daa38e94d5c75cb79643f0dba2e687853899ec77804e50b84d0dbbddc7d2df8e05047a360a237",
            "929703729bb992f3265b5d33304e6958277fa09ffe6a793ee574679dbeb32cd2",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x953957b1b1e322370c91f0d6c3ab09e86a635660",
            "BC9Dp13MpMgThFX8fI2w4iZvXjBg30mcfUedqjjpTVx1y3lkPw26Lmh4U4mex3gE5QuE0Nu93H0t+OBQR6Ngojc=",
            "kpcDcpu5kvMmW10zME5pWCd/oJ/+ank+5XRnnb6zLNI=",
        ),
    ),
    # vanity/0x95495
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x95495c04b4e6e48e7d11284878cc3a4bb11ea821",
            "0x78ec8fbca530303381ee58cd096f87b0becd7751e14675dbb66398140b8da7d7d3010cc2e7f1b5bc601d88b84d1cab43392651feaf2928dd1b8038f4d8dea997",
            "6315739fe8a3bb6a4676c3572f9b7d8b235d9f4d82d633f2606fa8714fad56b0",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x95495c04b4e6e48e7d11284878cc3a4bb11ea821",
            "BHjsj7ylMDAzge5YzQlvh7C+zXdR4UZ127ZjmBQLjafX0wEMwufxtbxgHYi4TRyrQzkmUf6vKSjdG4A49NjeqZc=",
            "YxVzn+iju2pGdsNXL5t9iyNdn02C1jPyYG+ocU+tVrA=",
        ),
    ),
    # vanity/0x95595
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x95595ab9274252dc504ae91d724fa49d3698a03e",
            "0x0c898113407c36af19900b4fca1aaa827713d9438b70d642ead61ebed5d80de852e1d133b28a25038391f03541ea655fce50b2c8a409bcc4155b72f6f99f4e87",
            "0decb8555740ac3cb849ab482c3d0e063fb69162277140497da2e1506c419011",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x95595ab9274252dc504ae91d724fa49d3698a03e",
            "BAyJgRNAfDavGZALT8oaqoJ3E9lDi3DWQurWHr7V2A3oUuHRM7KKJQODkfA1QeplX85QssikCbzEFVty9vmfToc=",
            "Dey4VVdArDy4SatILD0OBj+2kWIncUBJfaLhUGxBkBE=",
        ),
    ),
    # vanity/0x95695
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x9569525daae8c27b9bb621fe87f426ccb1a0ef85",
            "0x604b5290dec16422b68871a086f02f92f17ca0511bbb7718e2de80d13293b66664fa3580c537577f537f6abcf836fdaade9ca3c43cec6f4d4848355700beb143",
            "fdec9ba73ff5f3852977b2c773cff87fe3a2de16a0ca311d49e51a5206e3b570",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x9569525daae8c27b9bb621fe87f426ccb1a0ef85",
            "BGBLUpDewWQitohxoIbwL5LxfKBRG7t3GOLegNEyk7ZmZPo1gMU3V39Tf2q8+Db9qt6co8Q87G9NSEg1VwC+sUM=",
            "/eybpz/184Upd7LHc8/4f+Oi3hagyjEdSeUaUgbjtXA=",
        ),
    ),
    # vanity/0x95795
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x957952382ef1b3402e49841297fdf4bfb1333e34",
            "0x9a272614d20b89e41c254865db3d937bdfe7b42c3db9c96ed00a7ba56c14ad26ddf1f5a5eb3333d19b42232b79d7b6f66fe7e62974ea60c3e1582e36ea023b3e",
            "93408208252be3f930bdc0ac4818562ccfabe9db1b849680b6b3af25c0cc338f",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x957952382ef1b3402e49841297fdf4bfb1333e34",
            "BJonJhTSC4nkHCVIZds9k3vf57QsPbnJbtAKe6VsFK0m3fH1peszM9GbQiMrede29m/n5il06mDD4VguNuoCOz4=",
            "k0CCCCUr4/kwvcCsSBhWLM+r6dsbhJaAtrOvJcDMM48=",
        ),
    ),
    # vanity/0x95895
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x95895e54fb4783f97ea03c9fbca80c63637442b5",
            "0xd01c710829336a5b38267fcefb1db685bff88604d7344e946dea14533c4de25c9c60f22edfe227cf5061f735b364afe43deebe64934a516c1d89891901d3aaf2",
            "db38ae5a8e10b9418475250cc71c207a0c626340ae1c0784cd340078241add2a",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x95895e54fb4783f97ea03c9fbca80c63637442b5",
            "BNAccQgpM2pbOCZ/zvsdtoW/+IYE1zROlG3qFFM8TeJcnGDyLt/iJ89QYfc1s2Sv5D3uvmSTSlFsHYmJGQHTqvI=",
            "2ziuWo4QuUGEdSUMxxwgegxiY0CuHAeEzTQAeCQa3So=",
        ),
    ),
    # vanity/0x95995
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x95995613a31b1db281551e5b9047dbacda87cecc",
            "0x86fc6f05c35de88d092ef11eba18909a7f26f147467dad1d0d2c4f433b3fc5e86c431ef7f6d75306ea22daf5290f1ad23be800530700fa71873b4f735ef51fc5",
            "cd0576ccc99964231070760a891f5ee609e02772b9ff025b5890352f5e947f4d",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x95995613a31b1db281551e5b9047dbacda87cecc",
            "BIb8bwXDXeiNCS7xHroYkJp/JvFHRn2tHQ0sT0M7P8XobEMe9/bXUwbqItr1KQ8a0jvoAFMHAPpxhztPc171H8U=",
            "zQV2zMmZZCMQcHYKiR9e5gngJ3K5/wJbWJA1L16Uf00=",
        ),
    ),
    # vanity/0x96096
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x96096a0bb76e9920166d17cc04811792c4081b81",
            "0x6cb305eaa446eeb8ade8ff04599659847a3b76c53ab80fac4b3c1a13530c38fb9f3986c692f0ca71f489ec3ba9ba3f13466646a98d34c537c2f85d62635c1f41",
            "1937a1ae86837ffdc4456d16c51ddacfa84caf37b7297a79e19ecfcec00430a3",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x96096a0bb76e9920166d17cc04811792c4081b81",
            "BGyzBeqkRu64rej/BFmWWYR6O3bFOrgPrEs8GhNTDDj7nzmGxpLwynH0iew7qbo/E0ZmRqmNNMU3wvhdYmNcH0E=",
            "GTehroaDf/3ERW0WxR3az6hMrze3KXp54Z7PzsAEMKM=",
        ),
    ),
    # vanity/0x96196
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x96196b4b89d71faeaff3f2be057c4c63f47feff4",
            "0xa6006c7112c0b3bccddc3646482c9b618d6b147b7d2d9cc8725327ceca4bed5d4ba5ab7e580f260f25b3b82be307c561b978078b1d63d5b3654986ad11e15bcc",
            "a050e2270ecc3ffa6a1d71eedfdb97928471dc04256404508a7d8d858373420f",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x96196b4b89d71faeaff3f2be057c4c63f47feff4",
            "BKYAbHESwLO8zdw2Rkgsm2GNaxR7fS2cyHJTJ87KS+1dS6WrflgPJg8ls7gr4wfFYbl4B4sdY9WzZUmGrRHhW8w=",
            "oFDiJw7MP/pqHXHu39uXkoRx3AQlZARQin2NhYNzQg8=",
        ),
    ),
    # vanity/0x96296
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x96296031e1cda1d3cf68ce38afb4ec43bc388441",
            "0x716e75a322ae38b75e403fd2062db9f5995fec710c6192086b7934c9e15db2d473db9955a894fa1cf41877caad8f1dbbaf4eb4cc5bfe947e0261df3f845689af",
            "126a21a2d7fe220b1ce414738eeb0661513aaa2afb132e4f5adcfd74ea05d2e3",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x96296031e1cda1d3cf68ce38afb4ec43bc388441",
            "BHFudaMirji3XkA/0gYtufWZX+xxDGGSCGt5NMnhXbLUc9uZVaiU+hz0GHfKrY8du69OtMxb/pR+AmHfP4RWia8=",
            "Emohotf+Igsc5BRzjusGYVE6qir7Ey5PWtz9dOoF0uM=",
        ),
    ),
    # vanity/0x96396
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x9639614460e780e02117d59f37e38570cd0d7174",
            "0x36eafbe8649c667e5c4d96953ea1dbd136c727fe3f343ca941ac85185e89a6f15480038a0ad63dcdce239218c0123d73933e24289a958163acabd012986945fa",
            "a957f36fdea2c52274da131ac084260faa6036fb8ef53b61b6ac0472f2591f28",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x9639614460e780e02117d59f37e38570cd0d7174",
            "BDbq++hknGZ+XE2WlT6h29E2xyf+PzQ8qUGshRheiabxVIADigrWPc3OI5IYwBI9c5M+JCialYFjrKvQEphpRfo=",
            "qVfzb96ixSJ02hMawIQmD6pgNvuO9TthtqwEcvJZHyg=",
        ),
    ),
    # vanity/0x96496
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x96496ba4fa3d2a63590942b53303f810f257b7c0",
            "0x078b8dece37a3aad3af6afaef7ca8504c031b1977d29cb317055d42730c18395f7034778dba9f4a9d1d3c7bde9c923f25511ae42afc564740a0f4c73d3c8b4b3",
            "95b512536daf6b5a62e911f30758cbc46a05b5bd577a49f795335c89e575bfb0",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x96496ba4fa3d2a63590942b53303f810f257b7c0",
            "BAeLjezjejqtOvavrvfKhQTAMbGXfSnLMXBV1CcwwYOV9wNHeNup9KnR08e96ckj8lURrkKvxWR0Cg9Mc9PItLM=",
            "lbUSU22va1pi6RHzB1jLxGoFtb1Xekn3lTNcieV1v7A=",
        ),
    ),
    # vanity/0x96596
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x96596b6cffaccea0179507906f587df73d177cfd",
            "0x8a991588d055eb5c5bad5812810b0f454049d43f2192b83e96958421967c8a585e9d71e0fc69ff35a8c31b6ac4d535c4d6346d61e59223b9169a21c32def6a3b",
            "5b363805cc726141d5d7a2eb9ab4f13bc0011d2d97b9c6e720d75286ef0526fb",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x96596b6cffaccea0179507906f587df73d177cfd",
            "BIqZFYjQVetcW61YEoELD0VASdQ/IZK4PpaVhCGWfIpYXp1x4Pxp/zWowxtqxNU1xNY0bWHlkiO5Fpohwy3vajs=",
            "WzY4BcxyYUHV16LrmrTxO8ABHS2XucbnINdShu8FJvs=",
        ),
    ),
    # vanity/0x96696
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x96696266e5c58c0f4ff4aa8b7b076f0c1f6c42c3",
            "0xea2da8c055a0df0905aca4703aaa26a88bb442c4e42c14776defce85ee0c74db192259f64c277750ec8191a4097bde5da4ec9a328842fb12a9e91ce9d5018fca",
            "233bd4a19b40010d8a3e67f27515c0a01329924b622352f5aa5fb9daf7db6787",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x96696266e5c58c0f4ff4aa8b7b076f0c1f6c42c3",
            "BOotqMBVoN8JBaykcDqqJqiLtELE5CwUd23vzoXuDHTbGSJZ9kwnd1DsgZGkCXveXaTsmjKIQvsSqekc6dUBj8o=",
            "IzvUoZtAAQ2KPmfydRXAoBMpkktiI1L1ql+52vfbZ4c=",
        ),
    ),
    # vanity/0x96796
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x96796d6a2004001e9bb152b74da9d7059ce4781c",
            "0x212d659a6aa835a9adfd86fdb1ec4ba71adc55fbf6640e26adaa3aa6f116af614c26db311c49b9ce0b0a95850c9b4fc89482e79745464e3b973f4cfa0b3aebc4",
            "aa30c793b3d275e5ae254267548142d1288817807523d120a7ed913a9a5c0fc8",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x96796d6a2004001e9bb152b74da9d7059ce4781c",
            "BCEtZZpqqDWprf2G/bHsS6ca3FX79mQOJq2qOqbxFq9hTCbbMRxJuc4LCpWFDJtPyJSC55dFRk47lz9M+gs668Q=",
            "qjDHk7PSdeWuJUJnVIFC0SiIF4B1I9Egp+2ROppcD8g=",
        ),
    ),
    # vanity/0x96896
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x96896422cb1eaee3eeee77a7e0575154f407b536",
            "0x885e20ee1a26b051c1e843d5bc067f26a2eb596d2f3e7f4543ca639d970c7fd28f8c068ee958da65fbe7596d4aaaf9c2aac19b81699c80af63018a995e02aa0b",
            "140ddfe8e59245770ddbf76e019ee56feff9632e0449daba92e2d6493882cce2",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x96896422cb1eaee3eeee77a7e0575154f407b536",
            "BIheIO4aJrBRwehD1bwGfyai61ltLz5/RUPKY52XDH/Sj4wGjulY2mX751ltSqr5wqrBm4FpnICvYwGKmV4Cqgs=",
            "FA3f6OWSRXcN2/duAZ7lb+/5Yy4ESdq6kuLWSTiCzOI=",
        ),
    ),
    # vanity/0x96996
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x96996aca35cb5fa420fbf364e790c4380bb7d20f",
            "0x0c0fa8aa3011f38dca6047d7ed871f504a06945072ccb666ae4fffa49705b7e95f89d3874a01c5da85ef4e75907e8643dfe2dea1b59cbcb870d2de7ea54ed815",
            "2621161d31b7883263d4fb2014e02770c7b95428f4d6f1a04cf2d0e4738c89a3",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x96996aca35cb5fa420fbf364e790c4380bb7d20f",
            "BAwPqKowEfONymBH1+2HH1BKBpRQcsy2Zq5P/6SXBbfpX4nTh0oBxdqF7051kH6GQ9/i3qG1nLy4cNLefqVO2BU=",
            "JiEWHTG3iDJj1PsgFOAncMe5VCj01vGgTPLQ5HOMiaM=",
        ),
    ),
    # vanity/0x97097
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x9709767a25ff23f46af1d260ce693f193c9f3b48",
            "0xf12485b6568d4a95f6dce31c51be6d3bdeab5569dcfbdfac92e6da5f55febd43edfc4126298dc4661638be827ff8f50326fc31d5ea9a2131bbf9b2c681961c76",
            "fb325bc40b5cde20c1548590e1859d6b77ca3a91cb2cde9e91a072ab24cec596",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x9709767a25ff23f46af1d260ce693f193c9f3b48",
            "BPEkhbZWjUqV9tzjHFG+bTveq1Vp3PvfrJLm2l9V/r1D7fxBJimNxGYWOL6Cf/j1Ayb8MdXqmiExu/myxoGWHHY=",
            "+zJbxAtc3iDBVIWQ4YWda3fKOpHLLN6ekaByqyTOxZY=",
        ),
    ),
    # vanity/0x97197
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x97197e99a6ba3bf601499960418f667d5ab153d7",
            "0xff604c630f1193a1821ef8ff5a8ec5521392555b5d5ece0eadea073c560bdb324d5cd4c0c2274fa67b7bc3069e828d0bbc340d154d4cf659f2a4286d604fa2ae",
            "a8678ba3d2ebbb9fe82bf2fa8639355ed2e95b7ef9f8527553ad69aab9828eed",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x97197e99a6ba3bf601499960418f667d5ab153d7",
            "BP9gTGMPEZOhgh74/1qOxVITklVbXV7ODq3qBzxWC9syTVzUwMInT6Z7e8MGnoKNC7w0DRVNTPZZ8qQobWBPoq4=",
            "qGeLo9Lru5/oK/L6hjk1XtLpW375+FJ1U61pqrmCju0=",
        ),
    ),
    # vanity/0x97297
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x972977aa871d2efcfd40a4c96dbabefa121d956e",
            "0x89aa1856bdb2a4a998f909e28cb3b13383bf6ddca8126ed3fcef499bd36bfbbee04afaa9982214d7c4ff6dc897ec62a737faac20c275ae92f2cf5345808d9b5a",
            "b7ab3796102647c855641e39478366efcf4c011a087a717bebbe373e7124288f",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x972977aa871d2efcfd40a4c96dbabefa121d956e",
            "BImqGFa9sqSpmPkJ4oyzsTODv23cqBJu0/zvSZvTa/u+4Er6qZgiFNfE/23Il+xipzf6rCDCda6S8s9TRYCNm1o=",
            "t6s3lhAmR8hVZB45R4Nm789MARoIenF76743PnEkKI8=",
        ),
    ),
    # vanity/0x97397
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x97397f79d3ab2149c8c78830c17b673daad6df48",
            "0x02fcb08bbeb13468cb79d4e6305cfe97c1ffe7a92bedab151090cf88101a74191a68c2ea88fa51309eb05bd7861e2748abed9d374df9d2c1cdf0d130826ad1de",
            "cd7e7f339e32749039cb9a14e7a19d5f0a423804da03eb5c111c284d34e422f1",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x97397f79d3ab2149c8c78830c17b673daad6df48",
            "BAL8sIu+sTRoy3nU5jBc/pfB/+epK+2rFRCQz4gQGnQZGmjC6oj6UTCesFvXhh4nSKvtnTdN+dLBzfDRMIJq0d4=",
            "zX5/M54ydJA5y5oU56GdXwpCOATaA+tcERwoTTTkIvE=",
        ),
    ),
    # vanity/0x97497
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x9749756104e798a864faf823a0171395e54b01cf",
            "0xcbc337ceebca45bb7f4f711fbc90119950afc980110760c057fd65328674873d754103dee2f16ea17209d64399e9c52b85efea297a845b1b71f68786cbf81365",
            "79ae1f0c334b4a010a5fbb27fa6febd757c1b8e33e29d9b45ec697534504c991",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x9749756104e798a864faf823a0171395e54b01cf",
            "BMvDN87rykW7f09xH7yQEZlQr8mAEQdgwFf9ZTKGdIc9dUED3uLxbqFyCdZDmenFK4Xv6il6hFsbcfaHhsv4E2U=",
            "ea4fDDNLSgEKX7sn+m/r11fBuOM+Kdm0XsaXU0UEyZE=",
        ),
    ),
    # vanity/0x97597
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x975978ba8d4bc4171c768a056a1eb8fcf70c5e20",
            "0xa15389cc6875d370118b3bf79ca6d13462f5fffec43b2babe377f64c2cc3036c1ead0a6f3924418f15c9c2c22e4a1a44e9938ecfd7e1309a2d3476c7dcdd8461",
            "de0c05ed1462bb3022097538bf46313a8e6d1128cc5f113c7f862d10e1df492e",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x975978ba8d4bc4171c768a056a1eb8fcf70c5e20",
            "BKFTicxoddNwEYs795ym0TRi9f/+xDsrq+N39kwswwNsHq0KbzkkQY8VycLCLkoaROmTjs/X4TCaLTR2x9zdhGE=",
            "3gwF7RRiuzAiCXU4v0YxOo5tESjMXxE8f4YtEOHfSS4=",
        ),
    ),
    # vanity/0x97697
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x976970a086257c1b96e9813d98f41c1e9ca80d27",
            "0x7abfdd2eb1308834c6f466a7ae83c8031ec0a11f52e484e1bbbfee3357b37c72b6ea19f5ebb89bc58b33123283eb8fbf93902292dbc2f8dc7d16f876cc494e2a",
            "6e0c6b1bf2ee39e56459c7e9ff779d1bcefad83d69734254f1fc86a8028dd479",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x976970a086257c1b96e9813d98f41c1e9ca80d27",
            "BHq/3S6xMIg0xvRmp66DyAMewKEfUuSE4bu/7jNXs3xytuoZ9eu4m8WLMxIyg+uPv5OQIpLbwvjcfRb4dsxJTio=",
            "bgxrG/LuOeVkWcfp/3edG8762D1pc0JU8fyGqAKN1Hk=",
        ),
    ),
    # vanity/0x97797
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x97797f6e69b36eecf345117ec6ad9379f446eafe",
            "0x1776f637af45bbc8003abb795a5e3c6673b104406d501d2b395e33e94fb76a04c1e29e0eb52c4c840d758b30373d96ea2ba6a50c56014a1c040e64b9d828c705",
            "0cca0e41f1426b9129941094187246a8b368e272a6dc6e3e082572fcf6fa6790",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x97797f6e69b36eecf345117ec6ad9379f446eafe",
            "BBd29jevRbvIADq7eVpePGZzsQRAbVAdKzleM+lPt2oEweKeDrUsTIQNdYswNz2W6iumpQxWAUocBA5kudgoxwU=",
            "DMoOQfFCa5EplBCUGHJGqLNo4nKm3G4+CCVy/Pb6Z5A=",
        ),
    ),
    # vanity/0x97897
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x97897c0033f1edabb008f1dac6773a971d7289e3",
            "0x0c5cd5f8e37249305af641dc0287ddc53d335a4d4156f58a9de52c6e00506802cde4fe4167d0576cff5eb938c5967ab06c2e6b1634b1a8c154b74f5bd89891c3",
            "56eec1343982fa16ac37bb5a48f273a9ccbec8332ba8cc22ac237455e6b426cb",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x97897c0033f1edabb008f1dac6773a971d7289e3",
            "BAxc1fjjckkwWvZB3AKH3cU9M1pNQVb1ip3lLG4AUGgCzeT+QWfQV2z/Xrk4xZZ6sGwuaxY0sajBVLdPW9iYkcM=",
            "Vu7BNDmC+hasN7taSPJzqcy+yDMrqMwirCN0Vea0Jss=",
        ),
    ),
    # vanity/0x97997
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x979976833ccdf895a96a5b51a500e294d7cd9b96",
            "0xc2967b078a90293ac91faf84904a76af92df746d6cc63cb607335cbfebed7979cedf34ea8eca8ef7fb73dd0dad981f20e258b4ae00b0e500b05e41f1af1dd484",
            "bc5147d806cda47fedcfd7d95c5492dea030573f2a6f2e53806d4e00020f2e62",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x979976833ccdf895a96a5b51a500e294d7cd9b96",
            "BMKWeweKkCk6yR+vhJBKdq+S33RtbMY8tgczXL/r7Xl5zt806o7Kjvf7c90NrZgfIOJYtK4AsOUAsF5B8a8d1IQ=",
            "vFFH2AbNpH/tz9fZXFSS3qAwVz8qby5TgG1OAAIPLmI=",
        ),
    ),
    # vanity/0x98098
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x980985a8ca7a7094b83c12063088c77eb1151b50",
            "0x196085d61a2a10607448775ce0ddc02dc6bc708e77783eecdd88ffe747ec442ef38107b5ab62e9c8098f07b3a2ffc60f0e8e75f7f6718bf689271025437e5edd",
            "5a0ac5a912ccd32708806b461d2895c3dfea56ebf1f82f90a897ca73eea2da0f",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x980985a8ca7a7094b83c12063088c77eb1151b50",
            "BBlghdYaKhBgdEh3XODdwC3GvHCOd3g+7N2I/+dH7EQu84EHtati6cgJjwezov/GDw6Odff2cYv2iScQJUN+Xt0=",
            "WgrFqRLM0ycIgGtGHSiVw9/qVuvx+C+QqJfKc+6i2g8=",
        ),
    ),
    # vanity/0x98198
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x98198a079565534d6d18cbe2d8e5556c401113f5",
            "0x8b60b91d57452ce4c16466e43493076730920fd775dcfaaab3a3d095c52faa9f959de45aba98a76e7896f2f3aea75c013a0828f55b297dc4225bd6bed399d2de",
            "dc716693601955b4cf4a417d14681fd65aaa36a419210c60bd889552eedcb6f5",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x98198a079565534d6d18cbe2d8e5556c401113f5",
            "BItguR1XRSzkwWRm5DSTB2cwkg/Xddz6qrOj0JXFL6qflZ3kWrqYp254lvLzrqdcAToIKPVbKX3EIlvWvtOZ0t4=",
            "3HFmk2AZVbTPSkF9FGgf1lqqNqQZIQxgvYiVUu7ctvU=",
        ),
    ),
    # vanity/0x98298
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x9829885ee34263dbb5bf925015382be646ad41c1",
            "0x7881c501aa6b42cd54759c5907ddd024515af930b9b782cd098877ab34188d511f2da446ddba689ffdb8af04c8b344a042b2f44af5233a7fbd64425a5065866e",
            "7512d64d2fb53c6a32ed6acaeebbd6907fecae024806c2489cc15b744ffe9710",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x9829885ee34263dbb5bf925015382be646ad41c1",
            "BHiBxQGqa0LNVHWcWQfd0CRRWvkwubeCzQmId6s0GI1RHy2kRt26aJ/9uK8EyLNEoEKy9Er1Izp/vWRCWlBlhm4=",
            "dRLWTS+1PGoy7WrK7rvWkH/srgJIBsJInMFbdE/+lxA=",
        ),
    ),
    # vanity/0x98398
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x98398ad3478869e86dcf2c730977fd50cecf9c9d",
            "0xccc7a7992b2b4086eb4c004f705821465a00593ca3ce477bb5778f6c94df31ce11842b5d9d2a779a5d953d64ddc8b02df1e61704953564ab8956ca0e75cd477c",
            "192caa50701dd969cc8073b97d55b488ffbcd208ed3064aefe2f7202d639115a",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x98398ad3478869e86dcf2c730977fd50cecf9c9d",
            "BMzHp5krK0CG60wAT3BYIUZaAFk8o85He7V3j2yU3zHOEYQrXZ0qd5pdlT1k3ciwLfHmFwSVNWSriVbKDnXNR3w=",
            "GSyqUHAd2WnMgHO5fVW0iP+80gjtMGSu/i9yAtY5EVo=",
        ),
    ),
    # vanity/0x98498
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x98498d9c6ebd30ecddb3bedca829e8ad90783c29",
            "0x04ea1594e7c6b4d8eb63d4ca8ab247f9be623c408a7efbc0946724febeafaf88f3146572973a21f8c3299fb4a0123767fc83a1368ccaa5501c4eee12a2011608",
            "3fc0f3677f0ad78b7063f16bed2a27cbf6669525b54616b3cf1abca8ec0c5469",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x98498d9c6ebd30ecddb3bedca829e8ad90783c29",
            "BATqFZTnxrTY62PUyoqyR/m+YjxAin77wJRnJP6+r6+I8xRlcpc6IfjDKZ+0oBI3Z/yDoTaMyqVQHE7uEqIBFgg=",
            "P8DzZ38K14twY/Fr7Sony/ZmlSW1Rhazzxq8qOwMVGk=",
        ),
    ),
    # vanity/0x98598
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x98598b0c186f91656abf9a342887a6c795a5ce45",
            "0xb415ed347b9a0a29993805fbce8c1d9a8ba4151139aa4c242c1ad082ee9dfd7329c4bb49d8616f2c32293bbc04a9751ba7aeccbf09aebb976edfff04793f4fea",
            "ec9c642cf90af4d00a2341e1b5c4c0a45df6b43b069dec6bf667723d052743a8",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x98598b0c186f91656abf9a342887a6c795a5ce45",
            "BLQV7TR7mgopmTgF+86MHZqLpBUROapMJCwa0ILunf1zKcS7SdhhbywyKTu8BKl1G6euzL8JrruXbt//BHk/T+o=",
            "7JxkLPkK9NAKI0HhtcTApF32tDsGnexr9mdyPQUnQ6g=",
        ),
    ),
    # vanity/0x98698
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x986982918fe4b366772b0d17b3da952cb0059083",
            "0x2364afaea81d5ddaf00ee495097e15c45400ec3f5967e715dea3ab313df257e36e7fac80a493461b0d485cce9f48ed50545e68285aa9598f056c87a9b772a972",
            "23191c4ad12957fefbb00a1e55fa53826f06d6affa55a1a5b9ec85e2a6f1bee6",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x986982918fe4b366772b0d17b3da952cb0059083",
            "BCNkr66oHV3a8A7klQl+FcRUAOw/WWfnFd6jqzE98lfjbn+sgKSTRhsNSFzOn0jtUFReaChaqVmPBWyHqbdyqXI=",
            "IxkcStEpV/77sAoeVfpTgm8G1q/6VaGlueyF4qbxvuY=",
        ),
    ),
    # vanity/0x98798
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x98798ea5b30ee959f8acb93cae52b3b5bbcb084b",
            "0xc64ac9825983573c4e1283f636db65767b3876634fb68c203bfe9f1c8114f9d0b4aa6aaea9d8cc9b8cc6eaaa4bd608e39ed0398fc231d607c3411ba54126bb8c",
            "97dba34035cf8099b1ae31c4f8de509cfb2496296e99b7b878f341adae6be890",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x98798ea5b30ee959f8acb93cae52b3b5bbcb084b",
            "BMZKyYJZg1c8ThKD9jbbZXZ7OHZjT7aMIDv+nxyBFPnQtKpqrqnYzJuMxuqqS9YI457QOY/CMdYHw0EbpUEmu4w=",
            "l9ujQDXPgJmxrjHE+N5QnPsklilumbe4ePNBra5r6JA=",
        ),
    ),
    # vanity/0x98898
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x9889867b73391b826f4ab41b96060114cfcb4808",
            "0x964ad239eed1fa49521976d53d0b527682a92a7557d3eb88279b2131174cf0e1d54a6bb69e77794dd4c9abab2d6eee2267fe2b8827b98df34ba30a8c6cd7598a",
            "0b5aa3530731304cceb7dd3f83d1eaaf93627defa8d9c30573047810fce07fe2",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x9889867b73391b826f4ab41b96060114cfcb4808",
            "BJZK0jnu0fpJUhl21T0LUnaCqSp1V9PriCebITEXTPDh1Uprtp53eU3UyaurLW7uImf+K4gnuY3zS6MKjGzXWYo=",
            "C1qjUwcxMEzOt90/g9Hqr5Nife+o2cMFcwR4EPzgf+I=",
        ),
    ),
    # vanity/0x98998
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x989985760dda6c0517aa32e34d9c0b707254ab1c",
            "0x0ba9fcbd42bb5b46a3c031ba75420efa1894181f38971e61c93be482b31a94cda4f7558b6490d81369024fbbf894e945a5e538601783bb27d3ae96d8d7011d19",
            "98faabe089cd444dd98e3b7e1bd7bb0506045d878dabcdf492e6445e682c27f2",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x989985760dda6c0517aa32e34d9c0b707254ab1c",
            "BAup/L1Cu1tGo8AxunVCDvoYlBgfOJceYck75IKzGpTNpPdVi2SQ2BNpAk+7+JTpRaXlOGAXg7sn066W2NcBHRk=",
            "mPqr4InNRE3Zjjt+G9e7BQYEXYeNq830kuZEXmgsJ/I=",
        ),
    ),
    # vanity/0x99099
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x9909970a89f90c5148c74a94073dcc32c4fa9723",
            "0x2a8346b6572beb42b90e51d7a117749de4bab344877b0c0289d07321bf17bb830e2cc9c1fdcbc764862a69035c1bcc8bb7f972fbb689fd14770c128113ed88da",
            "03796941a25759d5c56e0f58b395c690321556904267aeb4980c3bf4882ca8a7",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x9909970a89f90c5148c74a94073dcc32c4fa9723",
            "BCqDRrZXK+tCuQ5R16EXdJ3kurNEh3sMAonQcyG/F7uDDizJwf3Lx2SGKmkDXBvMi7f5cvu2if0UdwwSgRPtiNo=",
            "A3lpQaJXWdXFbg9Ys5XGkDIVVpBCZ660mAw79IgsqKc=",
        ),
    ),
    # vanity/0x99199
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x99199b71b0cd46a4b720c04ddb9611e31699d63f",
            "0xf946ca8225cbad5e699e83cf00f30615b6c2f2c08341f2d1fe99d6ad00527569f090d7698c95b6a1b24fd8fd2f29968176210af6938cf3ea11df22acea07ac87",
            "cd18cd6f101adc3bca5741610fff7b830d136c240bf662b8054181bbad3cd5ca",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x99199b71b0cd46a4b720c04ddb9611e31699d63f",
            "BPlGyoIly61eaZ6DzwDzBhW2wvLAg0Hy0f6Z1q0AUnVp8JDXaYyVtqGyT9j9LymWgXYhCvaTjPPqEd8irOoHrIc=",
            "zRjNbxAa3DvKV0FhD/97gw0TbCQL9mK4BUGBu6081co=",
        ),
    ),
    # vanity/0x99299
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x99299d9c8c4fe231492482277407f96e988bf393",
            "0x85020b1ae04731f4b159467f224e888f97739c7fa07c78081773c04e90d4fe8beecd426ee7948555146a5400f1083c4dbe035962122566f80a44af22940f282d",
            "59ba98a6db629b936a200a29b74c30b6d2eb2a9abdfe168cb5121801d4f4ef80",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x99299d9c8c4fe231492482277407f96e988bf393",
            "BIUCCxrgRzH0sVlGfyJOiI+Xc5x/oHx4CBdzwE6Q1P6L7s1CbueUhVUUalQA8Qg8Tb4DWWISJWb4CkSvIpQPKC0=",
            "WbqYpttim5NqIAopt0wwttLrKpq9/haMtRIYAdT074A=",
        ),
    ),
    # vanity/0x99399
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x9939933149d4bc7faa8b68e800574e3eccfecf56",
            "0x83a7ac1ba01f2280f21370063d5c84edbb4f29ca8e8dc8c79fb15ad1ba741fe158884fb2228b93a6622596765816183cfe901576b35812bcda8d74d28237a653",
            "88e566330e4fbade55f4e50befe8038133a7e62894fd55f5f6f93eda19087b94",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x9939933149d4bc7faa8b68e800574e3eccfecf56",
            "BIOnrBugHyKA8hNwBj1chO27TynKjo3Ix5+xWtG6dB/hWIhPsiKLk6ZiJZZ2WBYYPP6QFXazWBK82o100oI3plM=",
            "iOVmMw5Put5V9OUL7+gDgTOn5iiU/VX19vk+2hkIe5Q=",
        ),
    ),
    # vanity/0x99499
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x99499717e5f99cb7dc61c80d052a66cad8cc9748",
            "0xf13be29a3c39dfec7ef303ec7e06f33117ce8f4cf228c0e95a0e18a8ba028eda50530f51c965fc3748a9dc2673699642a98d3c77f453162834b3b96fca145280",
            "830fb6715d4b92d9354e0ad2ba6b9196574ded882dc42200a4386db63e45e55b",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x99499717e5f99cb7dc61c80d052a66cad8cc9748",
            "BPE74po8Od/sfvMD7H4G8zEXzo9M8ijA6VoOGKi6Ao7aUFMPUcll/DdIqdwmc2mWQqmNPHf0UxYoNLO5b8oUUoA=",
            "gw+2cV1Lktk1TgrSumuRlldN7YgtxCIApDhttj5F5Vs=",
        ),
    ),
    # vanity/0x99599
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x995990633801c5923097babcc7089b18ff034c00",
            "0xd68edda54f4e4035a6f1751b0521863ca33943b7c17dbeb6c9583c9e183c7404b77236c4099f7b6d555b8dca47ac482e4f4393e4dd95a6aa28b0c6f0f6c416a9",
            "e35aa28528742881434e998bc46ad9e7e7e21868beaa7003ea834d0957658cec",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x995990633801c5923097babcc7089b18ff034c00",
            "BNaO3aVPTkA1pvF1GwUhhjyjOUO3wX2+tslYPJ4YPHQEt3I2xAmfe21VW43KR6xILk9Dk+TdlaaqKLDG8PbEFqk=",
            "41qihSh0KIFDTpmLxGrZ5+fiGGi+qnAD6oNNCVdljOw=",
        ),
    ),
    # vanity/0x99699
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x996991b4bd2f612dc4d49f51082edb4c136260a5",
            "0x3aa6857f7c1b8f5a0672e9e4d598ec063b1233770b496b4a92a71083286af766267249dd0cce2d7707f2e3a29352e7268ae8c2329ff47b6c820a946bc6c8fb45",
            "93f10dafda82b09a35f87fd2ed50d8f4872f1357d9f552597351043f760ed3ba",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x996991b4bd2f612dc4d49f51082edb4c136260a5",
            "BDqmhX98G49aBnLp5NWY7AY7EjN3C0lrSpKnEIMoavdmJnJJ3QzOLXcH8uOik1LnJorowjKf9HtsggqUa8bI+0U=",
            "k/ENr9qCsJo1+H/S7VDY9IcvE1fZ9VJZc1EEP3YO07o=",
        ),
    ),
    # vanity/0x99799
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x99799a851d328731c3865968b87d2da631aa758a",
            "0x855cd440fc5c29290db2ea8a6f9225fd5537108912d8cf65adaadb2081cbc3e338675ff4b4dfd23e12f19ca9ee9eb9291ab29e4ba132c2bc25dcb7b734b83d06",
            "572089757d8300be774b09e810a51f0c837e7691560531f082f2f4e45f8a89d5",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x99799a851d328731c3865968b87d2da631aa758a",
            "BIVc1ED8XCkpDbLqim+SJf1VNxCJEtjPZa2q2yCBy8PjOGdf9LTf0j4S8Zyp7p65KRqynkuhMsK8Jdy3tzS4PQY=",
            "VyCJdX2DAL53SwnoEKUfDIN+dpFWBTHwgvL05F+KidU=",
        ),
    ),
    # vanity/0x99899
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x99899d046040d2806bf61e2d785ce167befd6ec7",
            "0x40d3611a5d7360bcccdfbde8c3f680b8981eb26b6279e5c1ad950c4703c1e2298323992dd4037fa36a769a20dfa6daa47cb796985aaeac9e2da3f8ddcbc44475",
            "afaa2251f2ab785f1cd45424d02811699658acf590fb01fa9a66138240e7caa4",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x99899d046040d2806bf61e2d785ce167befd6ec7",
            "BEDTYRpdc2C8zN+96MP2gLiYHrJrYnnlwa2VDEcDweIpgyOZLdQDf6Nqdpog36bapHy3lpharqyeLaP43cvERHU=",
            "r6oiUfKreF8c1FQk0CgRaZZYrPWQ+wH6mmYTgkDnyqQ=",
        ),
    ),
    # vanity/0x99999
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x999994bdaf3113292a8c48eb9265cf665ddaefe5",
            "0xdd148f570ec8b319589c21de6da4b16a57bb429ac9a77ba329055cb25b7a471a06dedf5ba619dce33dcf8796adaabe7616e17805b743257a6f6b7159293fd6c0",
            "eb24207a4ccf40b80c91b049ad6996e1107958cadfc8ad8961855e468f645d4a",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x999994bdaf3113292a8c48eb9265cf665ddaefe5",
            "BN0Uj1cOyLMZWJwh3m2ksWpXu0Kayad7oykFXLJbekcaBt7fW6YZ3OM9z4eWraq+dhbheAW3QyV6b2txWSk/1sA=",
            "6yQgekzPQLgMkbBJrWmW4RB5WMrfyK2JYYVeRo9kXUo=",
        ),
    ),
    # vanity/0x10001
    account.new_validator(
        # ETH/Tendermint account - used by heimdall validators.
        account.new(
            "0x10001bc5ddb825eaf23f245e1b2e6d040e30d85e",
            "0xff212dc179ca58133e0ea144d2495e07ac30f6c8089ad9ee7dee303d12367cadcc274d66325044bcc030c38969acbd1b5c1aeb58299b7df558ed24651979eadc",
            "962948d2c91cda4a2da0651354d931b210277c566e624cc0fe61d12564be2f68",
        ),
        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.
        account.new(
            "0x10001bc5ddb825eaf23f245e1b2e6d040e30d85e",
            "BP8hLcF5ylgTPg6hRNJJXgesMPbICJrZ7n3uMD0SNnytzCdNZjJQRLzAMMOJaay9G1wa61gpm331WO0kZRl56tw=",
            "lilI0skc2kotoGUTVNkxshAnfFZuYkzA/mHRJWS+L2g=",
        ),
    ),
]
