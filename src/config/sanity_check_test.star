defaults = import_module("defaults.star")
sanity_check = import_module("sanity_check.star")
enums = import_module("../enums.star")


def test_sanity_check_polygon_args_valid_config(plan):
    valid_args = [
        defaults.POLYGON_POS_PACKAGE_ARGS,
    ]
    for args in valid_args:
        sanity_check.sanity_check_polygon_args(plan, args)

    invalid_args = [
        ({}, "Input arguments cannot be empty"),
        (
            {
                "invalid_param": "test",
            },
            'Invalid parameter: "invalid_param"',
        ),
        (
            {
                "participants": [
                    {
                        "invalid_param": "test",
                    }
                ],
            },
            'Invalid key: "invalid_param" in "participants" list of dict',
        ),
        (
            {
                "network_params": {},
            },
            'Missing "participants" field in the input arguments',
        ),
        (
            {
                "participants": [
                    {
                        "kind": "invalid_kind",
                    }
                ]
            },
            'Invalid "kind" attribute: "invalid_kind"',
        ),
        (
            {
                "participants": [
                    {
                        "kind": "validator",
                        "cl_type": "heimdall",
                        "el_type": "bor",
                    },
                    {
                        "kind": "validator",
                        "cl_type": "heimdall-v2",
                        "el_type": "bor",
                    },
                ],
            },
            "aaa",
        ),
    ]
    for args, expected_error in invalid_args:
        expect.fails(
            lambda: sanity_check.sanity_check_polygon_args(plan, args),
            expected_error,
        )


# def test_sanity_check_polygon_args_invalid_client_combination(plan):
#     # Test with invalid client combination (if any restrictions exist)
#     invalid_args = {
#         "participants": [
#             {
#                 "kind": enums.PARTICIPANT_KIND.validator,
#                 "cl_type": enums.CL_TYPE.heimdall,
#                 "el_type": enums.EL_TYPE.bor,  # Valid combination
#                 "cl_log_level": enums.LOG_LEVEL.info,
#                 "el_log_level": enums.LOG_LEVEL.info,
#                 "count": 1,
#             }
#         ],
#         "setup_images": {},
#         "network_params": {
#             "cl_chain_id": "heimdall-4927",
#             "el_chain_id": "4927",
#         },
#         "additional_services": [],
#         "test_runner_params": {},
#     }

#     # This should pass with valid combination
#     sanity_check.sanity_check_polygon_args(plan, invalid_args)


# def test_sanity_check_polygon_args_mixed_cl_types(plan):
#     # Test with mixed CL types (should fail)
#     invalid_args = {
#         "participants": [
#             {
#                 "kind": enums.PARTICIPANT_KIND.validator,
#                 "cl_type": enums.CL_TYPE.heimdall,
#                 "el_type": enums.EL_TYPE.bor,
#                 "count": 1,
#             },
#             {
#                 "kind": enums.PARTICIPANT_KIND.validator,
#                 "cl_type": enums.CL_TYPE.heimdall_v2,  # Different CL type
#                 "el_type": enums.EL_TYPE.bor,
#                 "count": 1,
#             },
#         ],
#         "setup_images": {},
#         "network_params": {
#             "cl_chain_id": "heimdall-4927",
#             "el_chain_id": "4927",
#         },
#         "additional_services": [],
#         "test_runner_params": {},
#     }

#     try:
#         sanity_check.sanity_check_polygon_args(plan, invalid_args)
#         expect.eq(True, False)  # Should not reach here
#     except:
#         pass  # Expected to fail


# def test_sanity_check_polygon_args_test_runner_params_without_service(plan):
#     # Test test_runner_params without test_runner service
#     invalid_args = {
#         "participants": [
#             {
#                 "kind": enums.PARTICIPANT_KIND.validator,
#                 "cl_type": enums.CL_TYPE.heimdall,
#                 "el_type": enums.EL_TYPE.bor,
#                 "count": 1,
#             }
#         ],
#         "setup_images": {},
#         "network_params": {
#             "cl_chain_id": "heimdall-4927",
#             "el_chain_id": "4927",
#         },
#         "additional_services": [],  # No test_runner
#         "test_runner_params": {"image": "test-image"},  # But params provided
#     }

#     try:
#         sanity_check.sanity_check_polygon_args(plan, invalid_args)
#         expect.eq(True, False)  # Should not reach here
#     except:
#         pass  # Expected to fail


# def test_sanity_check_dev_args_valid_config(plan):
#     # Test with valid dev configuration
#     valid_args = {
#         "should_deploy_l1": True,
#         "should_deploy_matic_contracts": True,
#     }

#     # This should not fail
#     sanity_check.sanity_check_dev_args(plan, valid_args)


# def test_sanity_check_dev_args_no_l1_without_rpc_url(plan):
#     # Test should_deploy_l1=False without l1_rpc_url
#     invalid_args = {
#         "should_deploy_l1": False,
#         # Missing l1_rpc_url
#     }

#     try:
#         sanity_check.sanity_check_dev_args(plan, invalid_args)
#         expect.eq(True, False)  # Should not reach here
#     except:
#         pass  # Expected to fail


# def test_sanity_check_dev_args_no_l1_with_rpc_url(plan):
#     # Test should_deploy_l1=False with l1_rpc_url
#     valid_args = {
#         "should_deploy_l1": False,
#         "l1_rpc_url": "http://localhost:8545",
#     }

#     # This should not fail
#     sanity_check.sanity_check_dev_args(plan, valid_args)


# def test_sanity_check_dev_args_no_matic_contracts_without_required_files(plan):
#     # Test should_deploy_matic_contracts=False without required files
#     invalid_args = {
#         "should_deploy_matic_contracts": False,
#         # Missing required file paths
#     }

#     try:
#         sanity_check.sanity_check_dev_args(plan, invalid_args)
#         expect.eq(True, False)  # Should not reach here
#     except:
#         pass  # Expected to fail


# def test_sanity_check_dev_args_no_matic_contracts_with_required_files(plan):
#     # Test should_deploy_matic_contracts=False with all required files
#     valid_args = {
#         "should_deploy_matic_contracts": False,
#         "l2_el_genesis_filepath": "/path/to/el_genesis.json",
#         "l2_cl_genesis_filepath": "/path/to/cl_genesis.json",
#         "matic_contract_addresses_filepath": "/path/to/addresses.json",
#     }

#     # This should not fail
#     sanity_check.sanity_check_dev_args(plan, valid_args)


# def test_validate_chain_ids_valid(plan):
#     # Test valid chain ID combination
#     sanity_check.validate_chain_ids("heimdall-4927", "4927")  # Should not fail


# def test_validate_chain_ids_invalid(plan):
#     # Test invalid chain ID combination
#     try:
#         sanity_check.validate_chain_ids("wrong-id", "4927")
#         expect.eq(True, False)  # Should not reach here
#     except:
#         pass  # Expected to fail


# def test_validate_chain_ids_empty(plan):
#     # Test with empty chain IDs (should not fail)
#     sanity_check.validate_chain_ids("", "")  # Should not fail
#     sanity_check.validate_chain_ids(None, None)  # Should not fail


# def test_validate_cl_environment_valid_heimdall(plan):
#     # Test valid CL environment for Heimdall
#     participants = [
#         {
#             "cl_type": enums.CL_TYPE.heimdall,
#         }
#     ]

#     # Should not fail
#     sanity_check.validate_cl_environment(enums.CL_ENVIRONMENT.local, participants)


# def test_validate_cl_environment_invalid_for_heimdall_v2(plan):
#     # Test CL environment for Heimdall v2 (should fail)
#     participants = [
#         {
#             "cl_type": enums.CL_TYPE.heimdall_v2,
#         }
#     ]

#     try:
#         sanity_check.validate_cl_environment(enums.CL_ENVIRONMENT.local, participants)
#         expect.eq(True, False)  # Should not reach here
#     except:
#         pass  # Expected to fail


# def test_validate_cl_environment_invalid_environment(plan):
#     # Test invalid CL environment
#     participants = [
#         {
#             "cl_type": enums.CL_TYPE.heimdall,
#         }
#     ]

#     try:
#         sanity_check.validate_cl_environment("invalid_env", participants)
#         expect.eq(True, False)  # Should not reach here
#     except:
#         pass  # Expected to fail


# def test_validate_cl_environment_empty(plan):
#     # Test with empty CL environment (should not fail)
#     participants = [
#         {
#             "cl_type": enums.CL_TYPE.heimdall,
#         }
#     ]

#     # Should not fail
#     sanity_check.validate_cl_environment("", participants)
#     sanity_check.validate_cl_environment(None, participants)
