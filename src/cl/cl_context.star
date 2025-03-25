def new_cl_context(
    service_name,
    ip_addr,
    api_port,
    rpc_port,
    metrics_port,
    api_url,
    rpc_url,
    metrics_url,
):
    return struct(
        service_name=service_name,
        ip_addr=ip_addr,
        api_port=api_port,
        rpc_port=rpc_port,
        metrics_port=metrics_port,
        api_url=api_url,
        rpc_url=rpc_url,
        metrics_url=metrics_url,
    )
