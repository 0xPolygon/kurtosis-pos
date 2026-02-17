#!/bin/sh

# Process manager for containerized applications that ensures proper signal handling.
# Forward SIGTERM to child processes for graceful shutdown and supports debugging by keeping containers alive after process termination.

# Usage: ./container-proc-manager.sh <command> [args...]
# Examples:
# - ./container-proc-manager.sh bor server --config /etc/bor/config.toml
# - ./container-proc-manager.sh heimdalld start --all --bridge --home /etc/heimdall

# Signals:
#   - SIGTERM: Forward to child process, waits for graceful exit (docker stop, kurtosis enclave stop).
#   - SIGTRAP: Stop child process, starts dummy process to keep container alive, useful for debugging or manual intervention.

# Exit codes:
#   - Exits with the child process exit code on natural termination.
#   - Runs indefinitely (via tail -f /dev/null) if SIGTRAP was received.


# Assign the command passed as arguments to a variable.
# The "$*" captures all command-line arguments as a single string.
# For example, running `./container-proc-manager.sh sleep 100` will store "sleep 100" in child_cmd.
child_cmd="$*"

echo "Starting process. Running command: $child_cmd" >&2

# Start the specified command in the background, keep stdout/stderr connected and store its process ID (PID).
# The "$!" variable holds the PID of the most recently executed background process.
$child_cmd 2>&1 &
child_pid="$!"
echo "PID $$ has started child process $child_pid" >&2

# SIGTERM handler
# Forward signal to child process for graceful shutdown.
# Triggered by docker stop and kurtosis enclave stop.
# Without this, the shell exits immediately without notifying the child.
trap 'echo "Forwarding TERM to child process $child_pid" >&2; kill -TERM $child_pid; wait $child_pid' TERM

# SIGTRAP handler
# Stop child process and keep container alive for debugging.
# Triggered by: kill -s TRAP <pid> or kill -5 <pid> where <pid> is the process ID of this script.
# Sends SIGTERM to child, then starts dummy process.
trapped=false
trap 'echo "Sending TERM to child process $child_pid"; kill -TERM $child_pid; trapped=true; echo "Starting dummy process"; tail -f /dev/null' TRAP

# The wait command pauses the script and waits for the child process to
# finish. If a signal is caught, the handler will run instead.
# We wait on the specific PID so we can re-wait after signal interruption.
wait $child_pid

# Only start dummy process if we were manually trapped
if [ "$trapped" = "false" ]; then
  echo "Child process exited naturally, container-proc-manager exiting" >&2
  exit $?
fi
