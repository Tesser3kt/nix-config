#!/bin/sh

# Check if 'dnd' is in the list of active modes
if makoctl list-modes | grep -q "dnd"; then
    # If it is, restore the default mode
    makoctl restore-mode
else
    # If it is not, set the dnd mode
    makoctl set-mode dnd
fi
