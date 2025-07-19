{
  config,
  pkgs,
  ...
}: {
  wayland.windowManager.hyprland.settings = {
    "$mod" = "SUPER";
    bind =
      [
        # App bindings
        "$mod, Return, exec, alacritty"
        "$mod SHIFT, w, exec, firefox"

        # Workspace 10
        "$mod, code:19, workspace, 10"
        "$mod SHIFT, code:19, movetoworkspace, 10"

        # Workspaces back and forth
        "$mod, Tab, workspace, previous"

        # Kill window
        "$mod, Q, killactive"
        "$mod SHIFT, Q, forcekillactive"

        # Float & fullscreen toggle
        "$mod, Space, togglefloating"
        "$mod, Space, centerwindow, 1"
        "$mod, Space, resizeactive, exact 75% 75%"
        "$mod, F, fullscreen"
      ]
      ++ (
        # Workspace bindings
        builtins.concatLists (builtins.genList (
            i: let
              ws = i + 1;
            in [
              "$mod, code:1${toString i}, workspace, ${toString ws}"
              "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
            ]
          )
          9)
      )
      ++ (
        # Focus & window movement
        builtins.concatLists (
          builtins.map (
            pair: let
              key = builtins.elemAt pair 0;
              dir = builtins.elemAt pair 1;
            in [
              "$mod, ${key}, movefocus, ${dir}"
              "$mod SHIFT, ${key}, movewindow, ${dir}"
              "$mod CTRL, ${key}, focusmonitor, ${dir}"
              "$mod CTRL SHIFT, ${key}, movecurrentworkspacetomonitor, ${dir}"
            ]
          )
          [
            ["up" "u"]
            ["right" "r"]
            ["down" "d"]
            ["left" "l"]
          ]
        )
      );

    monitor = [
      "DP-1, 1920x1080@143.85Hz, 0x0, 1"
      "DP-2, 2560x1440@170.00Hz, 1920x0, 1.0666666666666666667"
    ];

    # Window rules
    windowrule = [];
  };
}
