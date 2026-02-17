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
# For example, running `./container-proc-manager.sh sleep 100` will store "sleep 100" in command_to_run.
command_to_run="$*"

echo "Starting process. Running command: $command_to_run" >&2

# Start the specified command in the background, keep stdout/stderr connected and store its process ID (PID).
# The "$!" variable holds the PID of the most recently executed background process.
$command_to_run 2>&1 &
command_pid="$!"

echo "PID $$ has started child process $command_pid" >&2

# Forward SIGTERM to the child process so that `docker stop` triggers a clean shutdown.
# Without this, the shell exits on SIGTERM without notifying the child, causing an unclean shutdown.
trap 'echo "Forwarding TERM to child process $command_pid" >&2; kill -TERM $command_pid; wait $command_pid' TERM

# Define a signal handler for SIGTRAP
# When this signal is received, the script will:
# 1. Gracefully terminate the child process by sending the SIGTERM signal.
# 2. Start a dummy process (in this case, `tail -f /dev/null`) to keep the container running.
# This is useful in containerized environments where stopping the main process would otherwise cause the container to exit.
# Example: To trigger this behavior, run `kill -s TRAP <PID>` or `kill -5 <PID>` where `<PID>` is the process ID of this script.
trapped=false
trap 'echo "Sending TERM to child process $command_pid"; kill -TERM $command_pid; trapped=true; echo "Starting dummy process"; tail -f /dev/null' TRAP

# The wait command pauses the script and waits for the child process to
# finish. If a signal is caught, the handler will run instead.
# We wait on the specific PID so we can re-wait after signal interruption.
wait $command_pid

# Only start dummy process if we were manually trapped
if [ "$trapped" = "false" ]; then
  echo "Child process exited naturally, container-proc-manager exiting" >&2
  exit $?
fi
