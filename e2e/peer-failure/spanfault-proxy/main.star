# A Heimdall reverse-proxy that forwards everything to the real Heimdall EXCEPT span
# queries (/bor/spans/*), which it fails with 503. This puts bor in the one state that
# reproduces the self-eclipse bug: Heimdall answers /status as synced (so bor's sync-gate
# opens) but GetSpan fails (so span verification errors -> peers dropped as invalid-chain).
#
# The nginx config is written by the container's cmd (not a file artifact) so the package
# is idempotent and re-runnable within an enclave (kurtosis has no artifact-remove).
def run(plan, target_heimdall):
    nginx_conf = "events {} http { access_log /dev/stdout; server { listen 1317; location /bor/spans/ { return 503; } location / { proxy_pass http://" + target_heimdall + ":1317; } } }"
    return plan.add_service(
        name="heimdall-spanfault-proxy",
        config=ServiceConfig(
            image="nginx:1.27-alpine",
            ports={"http": PortSpec(number=1317, application_protocol="http")},
            env_vars={"NGINX_CONF": nginx_conf},
            entrypoint=["sh", "-c"],
            cmd=["printf '%s' \"$NGINX_CONF\" > /etc/nginx/nginx.conf && exec nginx -g 'daemon off;'"],
        ),
    )
