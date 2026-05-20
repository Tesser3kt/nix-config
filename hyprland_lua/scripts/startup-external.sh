#!/bin/sh

# Check if at least two arguments are provided (monitor name and a command).
if [ "$#" -lt 2 ]; then
    printf 'Usage: %s MONITOR_NAME "APP_COMMAND [app_args...]"\\n' "$0"
    exit 1
fi

MONITOR_NAME="$1"
shift # Removes the first argument, so the rest ($@) become the command.
APP_COMMAND="$@" # Assign all remaining arguments to APP_COMMAND.

# Poll for the external monitor for up to 30 seconds.
timeout=30
while [ "$timeout" -gt 0 ]; do
  # Check if the monitor is listed by hyprctl.
  if hyprctl monitors | grep -q "$MONITOR_NAME"; then
    # Monitor found, launch the application in the background and exit successfully.
    eval "$APP_COMMAND" &
    exit 0
  fi
  
  sleep 1
  timeout=$((timeout - 1))
done

# If the loop finishes, the monitor was not found in time.
# Print error to stderr (>%2) and exit with a failure code.
echo "Error: Monitor '$MONITOR_NAME' not found after 30 seconds." >&2
exit 1
