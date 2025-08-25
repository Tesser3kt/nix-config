{
  config,
  pkgs,
  ...
}: {
  wayland.windowManager.hyprland.settings = {
    # Workspace bindings
    bind = (
      builtins.concatLists (builtins.genList (
          i: let
            ws = i + 1;
          in [
            "$mod, code:1${toString i}, workspace, ${toString ws}"
            "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
          ]
        )
        8)
    );

    # Bind workspaces to monitors
    workspace = [
      "name:1, monitor:eDP-1, default:true"
      "name:2, monitor:eDP-1"
      "name:3, monitor:eDP-1"
      "name:4, monitor:eDP-1"
      "name:5, monitor:eDP-1"
      "name:6, monitor:eDP-1"
      "name:7, monitor:eDP-1"
      "name:8, monitor:eDP-1"
    ];
  };

  programs.waybar.settings.main = {
    "hyprland/workspaces" = {
      "persistent-workspaces" = {
        "eDP-1" = [1 2 3 4 5 6 7 8];
      };
    };
  };
}
