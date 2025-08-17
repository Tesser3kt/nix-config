[
  "mcontrolcenter &"
  "solaar -w hide &"

  # Start two terminals on workspace 1
  "[workspace 1 silent] ~/.config/hypr/scripts/startup-external.sh DP-2 alacritty &"
  "[workspace 1 silent] ~/.config/hypr/scripts/startup-external.sh DP-2 alacritty &"

  # Start firefox on workspace 2
  "[workspace 2 silent] firefox-beta &"
]
