{
  config,
  pkgs,
  ...
}: {
  wayland.windowManager.hyprland.settings = {
    # Workspace bindings
    bind =
      (
        builtins.concatLists (builtins.genList (
            i: let
              ws = i + 1;
            in [
              "$mod, code:1${toString i}, workspace, ${toString ws}"
              "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
            ]
          )
          5)
      )
      ++ (
        builtins.concatLists (builtins.genList (
            i: let
              ws = i + 6;
            in [
              "CTRL, code:1${toString i}, workspace, ${toString ws}"
              "CTRL SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
            ]
          )
          5)
      );

    # Bind workspaces to monitors
    workspace = [
      "name:1, monitor:DP-2, default:true"
      "name:2, monitor:DP-2"
      "name:3, monitor:DP-2"
      "name:4, monitor:DP-2"
      "name:5, monitor:DP-2"
      "name:6, monitor:DP-1, default:true"
      "name:7, monitor:DP-1"
      "name:8, monitor:DP-1"
      "name:9, monitor:DP-1"
      "name:10, monitor:DP-1"
    ];
  };

  programs.waybar.settings.main = {
    "hyprland/workspaces" = {
      "persistent-workspaces" = {
        "DP-2" = [1 2 3 4 5];
        "DP-1" = [6 7 8 9 10];
      };
    };
  };
}
