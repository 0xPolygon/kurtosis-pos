def new_el_context(
    node_name,
    rpc_http_url,
    ws_url,
):
    return struct(
        node_name=node_name,
        rpc_http_url=rpc_http_url,
        ws_url=ws_url,
    )
