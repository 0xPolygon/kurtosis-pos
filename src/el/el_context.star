def new_el_context(
    service_name,
    ip_addr,
    rpc_port,
    ws_port,
    metrics_port,
    rpc_http_url,
    ws_url,
    metrics_url,
):
    return struct(
        service_name=service_name,
        ip_addr=ip_addr,
        rpc_port=rpc_port,
        ws_port=ws_port,
        metrics_port=metrics_port,
        rpc_http_url=rpc_http_url,
        ws_url=ws_url,
        metrics_url=metrics_url,
    )
