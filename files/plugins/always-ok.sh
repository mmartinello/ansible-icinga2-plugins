#!/usr/bin/env bash

# Execute a Nagios/Icinga check plugin and returns a forced OK status if the
# plugin exits with OK, WARNING or CRITICAL, and exit with UNKNOWN if the
# plugin exits with UNKNOWN

PLUGIN_COMMAND=$1

# Execute function
# Execute the plugin command and get the exit code
# Function arguments:
#   - $1: the command to be executed
cmd_exec() {
    ($@)
    status=$?

    return $status
}

# Execute the check plugin with the given arguments and get exit code
cmd_exec "$@"
status=$?

#echo "Exit code: $status"

# If the plugin exited with 1 or 2, exit with 0, else exit with the real
# status code
if [ "$status" -eq "1" ] || [ "$status" -eq "2" ]
then
    exit 0
else
    exit $status
fi
