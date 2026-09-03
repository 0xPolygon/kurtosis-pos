constants = import_module("./config/constants.star")


def new_participant(
    kind,
    el_type,
    cl_type,
    el_context,
    cl_context,
    el_stateless,
):
    return struct(
        kind=kind,
        el_type=el_type,
        cl_type=cl_type,
        el_context=el_context,
        cl_context=cl_context,
        el_stateless=el_stateless,
    )
