{
  config,
  pkgs,
  ...
}: let
  single_border_active = "rgba(81A1C1D2) rgba(88C0D0D2) 90deg";
  single_border_inactive = "rgba(2E344096)";
  group_border_active = "rgba(81A1C1D2)";
  groupbar_active = "rgba(81A1C1D2)";
  drop_shadow = "rgba(242933A6)";
in {
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

    # Animations
    animations = {
      enabled = "yes";
      bezier = [
        "shot, 0.2, 1.0, 0.2, 1.0"
        "swipe, 0.6, 0.0, 0.2, 1.05"
        "linear, 0.0, 0.0, 1.0, 1.0"
        "progressive, 1.0, 0.0, 0.6, 1.0"
      ];
      animation = [
        "windows, 1, 6, shot, slide"
        "workspaces, 1, 6, swipe, slide"
        "fade, 1, 4, progressive"
        "border, 1, 6, linear"
        "borderangle, 1, 180, linear, loop"
      ];
    };

    # General settings
    dwindle = {
      pseudotile = "yes";
      preserve_split = "yes";
      special_scale_factor = 0.8;
    };

    master = {
      new_on_top = 1;
      mfact = 0.5;
    };

    general = {
      sensitivity = 1.00;
      apply_sens_to_raw = 1;
      gaps_in = 8;
      gaps_out = 8;
      border_size = 1;
      resize_on_border = true;

      col = {
        active_border = single_border_active;
        inactive_border = single_border_inactive;
      };

      layout = "dwindle";
    };

    group = {
      col = {
        border_active = group_border_active;
      };

      groupbar = {
        col = {
          active = groupbar_active;
        };
      };
    };

    decoration = {
      rounding = 24;

      active_opacity = 1.0;
      inactive_opacity = 0.9;
      fullscreen_opacity = 1.0;

      dim_inactive = true;
      dim_strength = 0.35;

      shadow = {
        enabled = true;
        range = 16;
        render_power = 2;
        offset = [2 2];
        color = drop_shadow;
      };

      blur = {
        enabled = true;
        size = 5;
        passes = 3;
        ignore_opacity = true;
        new_optimizations = true;
      };
    };
  };
}
