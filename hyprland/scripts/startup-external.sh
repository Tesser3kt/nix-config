#!/bin/bash

# Check if the correct number of arguments are provided
if [ "$#" -lt 2 ]; then
    echo "Usage: $0 MONITOR_NAME \"APP_COMMAND [app_args...]\""
    exit 1
fi

MONITOR_NAME="$1"
# All arguments from the second one onwards are treated as the command to execute
APP_COMMAND="${@:2}"

# Poll for the external monitor to be connected
# We add a timeout to prevent an infinite loop if the monitor is never connected
timeout=30 # seconds
while ! hyprctl monitors | grep -q "$MONITOR_NAME"; do
  sleep 1
  timeout=$((timeout - 1))
  if [ "$timeout" -eq 0 ]; then
    echo "Error: Monitor '$MONITOR_NAME' not found after 30 seconds."
    exit 1
  fi
done

# Launch the application
eval "$APP_COMMAND" &
