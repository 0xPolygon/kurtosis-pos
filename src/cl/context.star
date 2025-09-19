def new_context(
    service_name,
    api_url,
    rpc_url,
    ws_rpc_url,
    metrics_url,
    cl_rpc_url,
):
    return struct(
        service_name=service_name,
        api_url=api_url,
        rpc_url=rpc_url,
        ws_rpc_url=ws_rpc_url,
        metrics_url=metrics_url,
        cl_rpc_url=cl_rpc_url,
    )
