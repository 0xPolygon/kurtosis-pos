---
name: kurtosis-starlark
description: Starlark coding rules for kurtosis-pos. Apply when writing or reviewing .star files — module structure, service launchers, config parsers, artifact handling, shell commands, utilities, and templates.
allowed-tools: Bash, Read, Glob, Grep
compatibility: Requires kurtosis CLI. All patterns derived from the kurtosis-pos codebase.
---

## Related skills

- **kurtosis-pos-intro** — onboarding, repo map, PR checklist
- **kurtosis-pos-quality** — formatting, typos, docs, CI, Docker image rules

## Rule categories

| Priority | Category | Impact | Prefix |
|---|---|---|---|
| 1 | Module structure | CRITICAL | `mod-` |
| 2 | Service configuration | CRITICAL | `svc-` |
| 3 | Artifact handling | HIGH | `art-` |
| 4 | Args parsing | HIGH | `args-` |
| 5 | Error handling | MEDIUM | `err-` |
| 6 | Shell commands | MEDIUM | `sh-` |
| 7 | Starlark utilities | LOW | `util-` |
| 8 | Templates | LOW | `tmpl-` |

---

## 1. Module structure (CRITICAL)

### `mod-import-naming` — Name imports after their filename, prefix to disambiguate

```python
# DON'T
x = import_module("./shared.star")
s = import_module("../el/shared.star")

# DO
cl_shared = import_module("./shared.star")
el_shared = import_module("../el/shared.star")
constants  = import_module("../config/constants.star")
```

### `mod-pin-external` — Store external package URLs in a module-level constant

```python
# DON'T
result = import_module("github.com/ethpandaops/ethereum-package/main.star@6.1.0").run(plan, args)

# DO
ETHEREUM_PACKAGE = "github.com/ethpandaops/ethereum-package/main.star@6.1.0"
result = import_module(ETHEREUM_PACKAGE).run(plan, args)
```

### `mod-enum-structs` — Use struct enums for allowed string values, never raw strings

```python
# DON'T
if el_type == "bor": ...

# DO — constants.star
EL_TYPE = struct(bor="bor", erigon="erigon")
PARTICIPANT_KIND = struct(validator="validator", rpc="rpc", archive="archive")

# consumer
if el_type == constants.EL_TYPE.bor: ...
```

### `mod-images-dict` — All Docker image references live in a single `IMAGES` dict

```python
# DON'T — image strings scattered across launchers
image = "0xpolygon/bor:2.7.1"

# DO — constants.star
IMAGES = {
    "l2_el_bor_image":         "0xpolygon/bor:2.7.1",
    "l2_cl_heimdall_v2_image": "0xpolygon/heimdall-v2:0.6.0",
}

# launcher
image = constants.IMAGES.get("l2_el_bor_image")
```

### `mod-launcher-contract` — Every launcher exports `launch(plan, ...)` and returns a context struct

```python
# DO — launcher.star
def launch(plan, participant, ...):
    service = plan.add_service(name=..., config=ServiceConfig(...))
    return context.new_context(
        service_name=service.name,
        rpc_http_url=service.ports[RPC_PORT_ID].url,
    )

# DO — context.star
def new_context(service_name, rpc_http_url):
    return struct(service_name=service_name, rpc_http_url=rpc_http_url)
```

### `mod-dispatcher` — Use a `LAUNCHERS` dict + `_get_launcher()` for multi-client dispatch

```python
# DON'T
if el_type == "bor":
    bor_launcher.launch(plan, participant)
elif el_type == "erigon":
    erigon_launcher.launch(plan, participant)

# DO
LAUNCHERS = {
    constants.EL_TYPE.bor:    bor_launcher.launch,
    constants.EL_TYPE.erigon: erigon_launcher.launch,
}

def _get_launcher(participant):
    el_type = participant.get("el_type")
    if el_type not in LAUNCHERS:
        fail("Unsupported EL launcher '{}', need one of '{}'".format(
            el_type, ",".join(LAUNCHERS.keys())))
    return LAUNCHERS.get(el_type)
```

### `mod-private-prefix` — Prefix internal functions with `_`; public functions have no prefix

```python
def launch(plan, participant, ...): ...       # Public — called by other modules
def _get_launcher(participant): ...           # Private — only within this file
def _parse_dev_args(plan, args): ...
```

### `mod-generate-name` — Service names come from a `generate_name()` function, never inlined

```python
# DON'T
name = "l2-el-{}-bor-heimdall-v2-validator".format(id)

# DO — el/launcher.star
def generate_name(participant, id):
    return "l2-el-{}-{}-{}-{}".format(
        id,
        participant.get("el_type"),
        participant.get("cl_type"),
        participant.get("kind"),
    )
```

---

## 2. Service configuration (CRITICAL)

### `svc-port-ids-shared` — Port IDs and numbers always come from `shared.star`, never hardcoded

```python
# DON'T
ports={"rpc": PortSpec(number=8545, application_protocol="http")}

# DO — el/shared.star defines RPC_PORT_ID = "rpc", RPC_PORT_NUMBER = 8545
ports={
    shared.RPC_PORT_ID:     PortSpec(number=shared.RPC_PORT_NUMBER, application_protocol="http"),
    shared.METRICS_PORT_ID: PortSpec(number=shared.METRICS_PORT_NUMBER, application_protocol="http"),
}
```

### `svc-portspec-keyword` — Always use `number=` keyword in `PortSpec`, never positional

```python
# DON'T
PortSpec(8545, application_protocol="http")

# DO
PortSpec(number=8545, application_protocol="http")
```

### `svc-serviceconfig-order` — Consistent field order in `ServiceConfig`

```python
plan.add_service(
    name=el_node_name,
    config=ServiceConfig(
        image=...,
        ports={...},
        files={...},
        env_vars={...},     # only if needed
        entrypoint=[...],   # only if needed
        cmd=[...],          # only if needed
        max_cpu=...,
        max_memory=...,
    ),
)
```

### `svc-files-patterns` — Use the right `files=` value type for each case

```python
files={"/data":   Directory(persistent_key="{}-data".format(service_name))}  # volume
files={"/config": config_artifact}                                             # single artifact
files={"/config": Directory(artifact_names=[artifact_a, artifact_b])}         # multiple artifacts
```

### `svc-port-url` — Extract port URLs via `service.ports[PORT_ID].url` after `add_service`

```python
# DON'T
rpc_url = "http://{}:8545".format(service.ip_address)

# DO
rpc_url = service.ports[shared.RPC_PORT_ID].url
```

### `svc-hostname-not-ip` — Use service name as hostname for inter-service URLs, never `service.ip_address`

Within a Kurtosis enclave, every service is reachable by its name as a stable DNS hostname. `service.ip_address` is dynamic and harder to reason about. Use the service name when constructing URLs that one service passes to another. Reserve `service.ports[PORT_ID].url` for the service you just created (it returns the external/mapped URL).

```python
# DON'T — ip_address is dynamic
el_rpc_url = "http://{}:{}".format(service.ip_address, shared.RPC_PORT_NUMBER)

# DO — service name is the stable intra-enclave hostname
el_rpc_url = "http://{}:{}".format(el_node_name, shared.RPC_PORT_NUMBER)
```

### `svc-resource-limits` — Set `max_cpu` and `max_memory` from layer-specific `shared.star` constants

| Layer | `MAX_CPU` (milicores) | `MAX_MEM` (MB) |
|---|---|---|
| L2 EL (bor/erigon) | 4000 | 16384 |
| L2 CL (heimdall-v2) | 2000 | 4096 |
| Additional services | 1000 | 2048 |

```python
config=ServiceConfig(..., max_cpu=shared.MAX_CPU, max_memory=shared.MAX_MEM)
```

### `svc-proc-manager` — Wrap long-running node processes with `container-proc-manager.sh`

Forwards SIGTERM for graceful shutdown; traps SIGTRAP (`kill -5 <pid>`) to stop the process while keeping the container alive.

```python
# Upload once in el_cl_launcher.star
proc_manager = plan.upload_files(
    name="container-proc-manager-script",
    src="static_files/scripts/container-proc-manager.sh",
)
# Mount in every EL/CL service
files={"/usr/local/share": proc_manager}
# Invoke as entrypoint
entrypoint=["sh", "-c"],
cmd=["/usr/local/share/container-proc-manager.sh bor <flags>"],
```

---

## 3. Artifact handling (HIGH)

### `art-run-sh-store` — Use `store=` in `plan.run_sh()` to produce artifacts; validate count immediately

```python
result = plan.run_sh(
    name="{}-keys-generator".format(node_name),
    image=constants.IMAGES.get("toolbox_image"),
    store=[StoreSpec(src="/output/keys", name="{}-keys".format(node_name))],
    run="bash /opt/keys/generate.sh",
)
if len(result.files_artifacts) != 1:
    fail("Expected 1 artifact, got {}.".format(len(result.files_artifacts)))
keys = result.files_artifacts[0]
```

### `art-static-vs-dynamic` — Use `upload_files` for static files, `render_templates` for files with runtime values

```python
# Static — no runtime values
artifact = plan.upload_files(name="proc-manager", src="./static_files/proc-manager.sh")

# Dynamic — values from plan execution
artifact = plan.render_templates(
    name="{}-config".format(node_name),
    config={
        "config.toml": struct(
            template=read_file("./templates/config.toml"),
            data={"rpc_port": 8545, "log_level": participant.get("log_level")},
        ),
    },
)
```

**Exception:** `render_templates` with `data={}` is acceptable when the file *path itself* is a runtime value (e.g. read from parsed args), because `upload_files` requires a literal `src=` path and cannot accept a variable. In that case an empty `data={}` is the correct approach — the template variable substitution is a no-op but the dynamic path lookup is the point.

```python
# Acceptable — path comes from args, upload_files cannot be used
artifact = plan.render_templates(
    name="l2-el-genesis",
    config={
        "genesis.json": struct(
            template=read_file(src=dev_args.get("l2_el_genesis_filepath")),
            data={},
        )
    },
)
```

### `art-upload-arg-order` — `name=` before `src=` in `plan.upload_files()`

```python
# DON'T
plan.upload_files(src="./static_files/script.sh", name="my-script")

# DO
plan.upload_files(name="my-script", src="./static_files/script.sh")
```

### `art-template-path-const` — Store template file paths as module-level constants

```python
HEIMDALL_TEMPLATES_PATH = "../../../static_files/cl/heimdall_v2"
template=read_file("{}/config.toml".format(HEIMDALL_TEMPLATES_PATH))
```

### `art-strip-newline` — Strip trailing newlines from `plan.run_sh()` output

```python
result = plan.run_sh(
    files={"/opt": artifact},
    run="jq -r '.address' /opt/output.json | tr -d '\\n'",
)
address = result.output  # safe to use in string formatting
```

---

## 4. Args parsing (HIGH)

### `args-defensive-copy` — Always copy incoming dicts before mutating; use the one-liner form

```python
# DON'T
args = dict(args)  # verbose two-branch form  |  mutates frozen input dict

# DO
args = dict(args) if args else {}
for k, v in DEFAULTS.items():
    args.setdefault(k, v)
```

### `args-defaults-module-level` — Keep default dicts at module level, never mutate them

```python
PARTICIPANT_DEFAULTS = {
    "kind":    constants.PARTICIPANT_KIND.validator,
    "el_type": constants.EL_TYPE.bor,
    "cl_type": constants.CL_TYPE.heimdall_v2,
    "count":   1,
}
```

### `args-sort-return` — Return a sorted dict for deterministic plan output

```python
def _sort_dict(d):
    return dict(sorted(d.items(), key=lambda x: x[0]))
```

### `args-get-not-index` — Always use `.get()` to read parsed args, never direct index access

```python
el_type = participant.get("el_type")   # DO
el_type = participant["el_type"]        # DON'T
```

---

## 5. Error handling (MEDIUM)

### `err-format-not-percent` — Use `.format()` in all `fail()` calls, never `%`

```python
fail("Invalid service: '{}'.".format(svc))                              # DO
fail("Unsupported EL type '{}', need one of: {}.".format(el_type, ...))  # DO
fail("Invalid service: %s" % svc)                                        # DON'T
```

### `err-warn-print` — Use `plan.print()` for non-fatal warnings, `fail()` only for fatal errors

```python
plan.print('WARN: image tag mismatch between bor ({}) and genesis-builder ({}).'.format(
    bor_tag, builder_tag))    # non-fatal
fail("CL type '{}' is not supported.".format(cl_type))  # fatal
```

### `err-validate-early` — Run all validation in `sanity_check.star` before any plan steps execute

```python
def check(plan, args):
    for p in args.get("participants", []):
        if p.get("el_type") not in VALID_EL_CLIENTS:
            fail("Invalid el_type '{}'. Allowed: {}.".format(p.get("el_type"), VALID_EL_CLIENTS))
```

---

## 6. Shell commands (MEDIUM)

### `sh-join-separator` — Use `" && "` (with spaces) when joining multi-step shell commands

```python
cmd = [" && ".join(steps)]   # DO
cmd = ["&&".join(steps)]     # DON'T
```

### `sh-wait-http` — Use `plan.wait()` with `PostHttpRequestRecipe` for HTTP liveness checks

```python
plan.wait(
    service_name=service_name,
    recipe=PostHttpRequestRecipe(
        port_id=shared.RPC_PORT_ID,
        endpoint="",
        content_type="application/json",
        body='{"method":"eth_blockNumber","params":[],"id":1,"jsonrpc":"2.0"}',
        extract={"block": ".result"},
    ),
    field="extract.block",
    assertion="!=",
    target_value="",
    timeout="1m",
)
```

### `sh-description` — Add `description=` to long-running or non-obvious `plan.run_sh()` calls

```python
plan.run_sh(
    name="l2-contract-deployer",
    description="Deploying Polygon PoS contracts to L1 and L2 (takes ~5 minutes)",
    ...
    wait="10m",
)
```

### `sh-env-vars-not-interpolation` — Pass dynamic/sensitive values via `env_vars=`, never string interpolation in `run=`

```python
# DON'T — private key leaked into plan output, injection risk
run="cast send --private-key {} ...".format(private_key)

# DO
plan.run_sh(
    env_vars={"PRIVATE_KEY": private_key, "RPC_URL": rpc_url},
    run="cast send --private-key $PRIVATE_KEY --rpc-url $RPC_URL ...",
)
```

### `sh-script-logging` — Source `log.sh` in every bash script; write all log output to stderr

`log.sh` lives at `static_files/scripts/log.sh`. Scripts that ship inside containers get it via `upload_files`; scripts that run on the host source it via `$SCRIPT_DIR`.

```bash
#!/bin/bash
set -e
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/log.sh"

log_info "Starting snapshot" "enclave=${enclave_name}"
```

All `log_*` functions write to stderr so stdout stays clean for data capture. Set `LOG_LEVEL=DEBUG` for verbose output.

### `sh-script-enclave-param` — Accept enclave name as `$1` with a default and explicit validation

```bash
enclave_name=${1:-"pos"}
if [[ -z "$enclave_name" ]]; then
  log_error "Enclave name cannot be empty"
  exit 1
fi
```

---

## 7. Starlark utilities (LOW)

### `util-builtins` — Use `hex.star`, `math.star`, and `wallet.star` instead of reimplementing

```python
hex    = import_module("../hex/hex.star")
math   = import_module("../math/math.star")
wallet = import_module("../wallet/wallet.star")

hex_value = hex.int_to_hex(block_number)     # "0x..." — no hex() builtin in Starlark
total     = math.sum([1, 2, 3])              # no sum() builtin
big       = math.pow(10, 18)                 # no ** operator
keypair   = wallet.new(plan)
wallet.fund(plan, address, rpc_url, funder_key, value="500ether")
```

### `util-context-struct` — Pass context structs between modules, never raw service names or URLs

```python
# DON'T
def launch_observer(plan, el_rpc_url, el_service_name): ...

# DO
el_context = el_launcher.launch(plan, participant, ...)
def launch_observer(plan, el_context):
    url = el_context.rpc_http_url
```

### `util-wait-run-sh` — Use `plan.run_sh` + polling loop for complex conditions; `plan.wait()` only for simple HTTP checks

```python
# plan.run_sh() + loop — for arithmetic conditions, non-HTTP APIs, or regex matches
plan.run_sh(
    name="wait-for-checkpoint",
    image=constants.IMAGES.get("toolbox_image"),
    env_vars={"CL_API_URL": cl_context.api_url},
    run="\n".join([
        "while true; do",
        "  count=$(curl -sf $CL_API_URL/checkpoints/count | jq -r '.result.result');",
        "  if [[ \"$count\" -gt \"0\" ]]; then break; fi;",
        "  sleep 5;",
        "done",
    ]),
    wait="5m",
)
```

---

## 8. Templates (LOW)

### `tmpl-syntax` — Use Go `text/template` syntax (`{{.field}}`), not Jinja2

```toml
log_level = "{{.log_level}}"
rpc_port  = {{.rpc_port_number}}
```

### `tmpl-conditionals` — Use `{{if eq .kind "archive"}}` for conditional config sections

```toml
gcmode = {{ if eq .kind "archive" }}"archive"{{ else }}"full"{{ end }}
{{- if and (eq .kind "validator") (not .sync_with_witness) }}
[miner]
  mine = true
{{- end }}
```

### `tmpl-range` — Use `{{range}}` with `$.` to access root context inside loops

```yaml
{{range $label, $url := .rpc_urls}}
- name: "{{$label}}"
  url:  "{{$url}}"
  root_value: "{{$.root_level_field}}"
{{end}}
```

### `tmpl-extension` — Use `.tmpl` extension for template files

```
static_files/config.toml.tmpl  ← clearly a template
static_files/genesis.json       ← clearly static
```

---

## Common anti-patterns

| Anti-pattern | Rule | Fix |
|---|---|---|
| `PortSpec(8545, ...)` positional | `svc-portspec-keyword` | `PortSpec(number=8545, ...)` |
| `fail("msg: %s" % val)` | `err-format-not-percent` | `fail("msg: '{}'.".format(val))` |
| `"&&".join(cmds)` no spaces | `sh-join-separator` | `" && ".join(cmds)` |
| `dict(args)` two-branch copy | `args-defensive-copy` | `dict(args) if args else {}` |
| `render_templates` with `data={}` and a literal path | `art-static-vs-dynamic` | Use `upload_files` for static files (exception: path is a runtime variable) |
| Hardcoded image string in launcher | `mod-images-dict` | `constants.IMAGES.get("key")` |
| Service name built inline with `.format()` | `mod-generate-name` | Dedicated `generate_name(participant, id)` |
| `src=` before `name=` in `upload_files` | `art-upload-arg-order` | `name=` always first |
| Dynamic value interpolated into `run=` string | `sh-env-vars-not-interpolation` | Pass via `env_vars=` |
| Reimplementing `hex()`, `sum()`, or `**` | `util-builtins` | Use `hex.star`, `math.star` |
| `service.ip_address` in inter-service URL | `svc-hostname-not-ip` | Use service name as hostname |
| Passing raw URL strings between launchers | `util-context-struct` | Return and accept context structs |
| `plan.wait()` for non-HTTP or arithmetic conditions | `util-wait-run-sh` | Use `plan.run_sh` + polling loop |
