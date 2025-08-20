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
      "1, monitor:DP-2, default:true"
      "2, monitor:DP-2"
      "3, monitor:DP-2"
      "4, monitor:DP-2"
      "5, monitor:DP-2"
      "6, monitor:DP-1, default:true"
      "7, monitor:DP-1"
      "8, monitor:DP-1"
      "9, monitor:DP-1"
      "10, monitor:DP-1"
    ];
  };

  programs.waybar.settings.main = {
    "hyprland/workspaces" = {
      "persistent-workspaces" = {
        "1" = ["DP-2"];
        "2" = ["DP-2"];
        "3" = ["DP-2"];
        "4" = ["DP-2"];
        "5" = ["DP-2"];
        "6" = ["DP-1"];
        "7" = ["DP-1"];
        "8" = ["DP-1"];
        "9" = ["DP-1"];
        "10" = ["DP-1"];
      };
    };
  };
}
