constants = import_module("./constants.star")
input_parser = import_module("./input_parser.star")
sanity_check = import_module("./sanity_check.star")


def test_sanity_check_with_status_checker_missing_image(plan):
    args = input_parser.DEFAULT_POLYGON_POS_PACKAGE_ARGS | {
        "additional_services": [
            constants.ADDITIONAL_SERVICES.status_checker,
            constants.ADDITIONAL_SERVICES.test_runner, # test_runner_params is defined in the default args so we have to include it here to avoid failing on that first
        ],
        "status_checker_params": {},
    }
    expect.fails(
        lambda: sanity_check.sanity_check_polygon_args(plan, args),
        "`status_checker_params` must include the \"image\" field when the status checker is deployed",
    )


def test_sanity_check_with_status_checker(plan):
    args = input_parser.DEFAULT_POLYGON_POS_PACKAGE_ARGS | {
        "additional_services": [
            constants.ADDITIONAL_SERVICES.status_checker,
            constants.ADDITIONAL_SERVICES.test_runner,
        ],
        "status_checker_params": {
            "image": constants.DEFAULT_IMAGES.get("status_checker_image"),
        },
    }


def test_sanity_check_with_test_runner_missing_image(plan):
    args = input_parser.DEFAULT_POLYGON_POS_PACKAGE_ARGS | {
        "additional_services": [constants.ADDITIONAL_SERVICES.test_runner],
        "test_runner_params": {},
    }
    expect.fails(
        lambda: sanity_check.sanity_check_polygon_args(plan, args),
        "`test_runner_params` must include the \"image\" field when the test runner is deployed",
    )


def test_sanity_check_with_test_runner(plan):
    args = input_parser.DEFAULT_POLYGON_POS_PACKAGE_ARGS | {
        "additional_services": [constants.ADDITIONAL_SERVICES.test_runner],
        "test_runner_params": {
            "image": constants.DEFAULT_IMAGES.get("test_runner_image"),
        },
    }
