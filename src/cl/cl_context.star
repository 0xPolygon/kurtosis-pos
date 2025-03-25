def new_cl_context(
    node_name,
    api_url,
    rpc_url,
    metrics_url,
):
    return struct(
        node_name=node_name,
        api_url=api_url,
        rpc_url=rpc_url,
        metrics_url=metrics_url,
    )
