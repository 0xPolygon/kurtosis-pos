def l1_rpcs(l1_context):
    return (
        {
            p.el_context.service_name: p.el_context.rpc_http_url
            for p in l1_context.all_participants
        }
        if l1_context.all_participants
        else {"external-l1": l1_context.rpc_url}
    )


def l2_el_rpc_urls(l2_context):
    # Stateless-sync nodes (syncmode "stateless") run with the txpool
    # disabled and can't serve eth_sendRawTransaction, so keep them out of
    # the load-balancer upstream pools (nginx and erpc are the only
    # consumers). Never empty: the sanity check requires at least one
    # non-stateless validator.
    return {
        p.el_context.service_name: p.el_context.rpc_http_url
        for p in l2_context.all_participants
        if not p.el_stateless
    }


def l2_el_rpc_hosts(l2_context):
    # host:port form (no scheme) for proxies like nginx whose upstream
    # `server` directives reject full URLs.
    return {
        name: url.replace("http://", "")
        for name, url in l2_el_rpc_urls(l2_context).items()
    }


def l2_urls(l2_context):
    return {
        p.el_context.service_name: {
            "rpc": p.el_context.rpc_http_url,
            "heimdall": p.cl_context.api_url,
            "tendermint": p.cl_context.rpc_url,
        }
        for p in l2_context.all_participants
    }
