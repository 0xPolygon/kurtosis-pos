input_parser = import_module("./input_parser.star")
sanity_check = import_module("./sanity_check.star")


def test_sanity_check_valid_config(plan):
    sanity_check.sanity_check_polygon_args(
        plan, input_parser.DEFAULT_POLYGON_POS_PACKAGE_ARGS
    )
