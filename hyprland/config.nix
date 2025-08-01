{
  config,
  pkgs,
  displayConfig,
  startupConfig,
  deviceConfig,
  ...
}: let
  terminal = "alacritty";
  browser = "firefox-beta";
  files = "thunar";
  single_border_active = "rgba(81A1C1D2) rgba(8FBCBBD2) 90deg";
  single_border_inactive = "rgba(2E344096)";
  group_border_active = "rgba(81A1C1D2)";
  groupbar_active = "rgba(81A1C1D2)";
  drop_shadow = "rgba(242933A6)";
  output = {
    "pc" = import ./output/pc.nix;
    "laptop" = import ./output/laptop.nix;
  };
  startup = {
    "common" = import ./startup/common.nix;
    "pc" = import ./startup/pc.nix;
  };
  devices = {
    "pc" = import ./tablet/pc.nix;
  };
in {
  wayland.windowManager.hyprland.settings = {
    "$mod" = "SUPER";
    bind =
      [
        # App bindings
        "$mod, Return, exec, ${terminal}"
        "$mod SHIFT, w, exec, ${browser}"
        "$mod, e, exec, ${files}"

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

        # Scroll through existing workspaces
        "$mod, period, workspace, e+1"
        "$mod, comma, workspace, e-1"

        # Screenshots
        "$mod SHIFT, S, exec, hyprshot -m output"
        "$mod, S, exec, hyprshot -m region"
        "$mod ALT, S, exec, hyprshot -m window"

        # Rofi
        "$mod, D, exec, pkill rofi || rofi -show drun -modi drun,filebrowser,run,window"
        "$mod ALT, V, exec, $HOME/.config/hypr/scripts/clip_manager.sh"

        # Logout menu
        "$mod, X, exec, wlogout -b 5 -B 400 -T 400"

        # Sway notification center panel
        "$mod SHIFT, N, exec, swaync-client -t -sw"

        # Exit hyprland
        "CTRL ALT, Delete, exec, hyprctl dispatch exit 0"
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

    # Mouse binds
    bindm = [
      # Move/resize windows with mouse
      "$mod, mouse:272, movewindow"
      "$mod, mouse:273, resizewindow"
    ];

    # Repeat/hold binds
    binde = [
      "$mod ALT, left, resizeactive, -50 0"
      "$mod ALT, right, resizeactive, 50 0"
      "$mod ALT, up, resizeactive, 0 -50"
      "$mod ALT, down, resizeactive, 0 50"

      # Volume control
      ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
      ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
      ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"

      # Playback control
      ", XF86AudioPlay, exec, playerctl play-pause"
      ", XF86AudioStop, exec, playerctl stop"
      ", XF86AudioNext, exec, playerctl next"
      ", XF86AudioPrev, exec, playerctl previous"

      # Brightness control
      ", XF86MonBrightnessUp, exec, brightnessctl set +5%"
      ", XF86MonBrightnessDown, exec, brightnessctl set 5%-"
    ];

    # Output configuration
    monitor = output.${displayConfig} or [];

    # Window rules
    windowrule = [
      # Discord on workspace 9
      "workspace 9, class:^(WebCord)$"

      # Spotify on workspace 8
      "workspace 8, class: ^(spotify)$"
    ];

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
        "windows, 1, 4, shot, slide"
        "workspaces, 1, 4, swipe, slide"
        "fade, 1, 3, progressive"
        "border, 1, 4, linear"
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
      gaps_in = 8;
      gaps_out = 12;
      border_size = 1;
      resize_on_border = true;

      "col.active_border" = single_border_active;
      "col.inactive_border" = single_border_inactive;

      layout = "dwindle";
    };

    group = {
      "col.border_active" = group_border_active;

      groupbar = {
        "col.active" = groupbar_active;
      };
    };

    decoration = {
      rounding = 10;

      active_opacity = 1.0;
      inactive_opacity = 0.9;
      fullscreen_opacity = 1.0;

      dim_inactive = true;
      dim_strength = 0.25;

      shadow = {
        enabled = true;
        range = 16;
        render_power = 2;
        offset = "2 2";
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

    # Input settings
    input = {
      kb_layout = "us,cz";
      kb_variant = ",qwerty";
      kb_options = "caps:escape,grp:switch,grp:alt_shift_toggle";
      numlock_by_default = true;
      follow_mouse = true;

      touchpad = {
        disable_while_typing = true;
        natural_scroll = true;
        tap-to-click = true;
        clickfinger_behavior = false;
        drag_lock = 2;
      };
    };

    # Gestures
    gestures = {
      workspace_swipe = true;
    };

    # Miscellaneous
    misc = {
      disable_hyprland_logo = true;
      disable_splash_rendering = true;
      mouse_move_enables_dpms = true;
      vrr = 2;
      enable_swallow = true;
      swallow_regex = "^(Alacritty)$";
      focus_on_activate = false;
    };

    # Render settings
    render = {
      direct_scanout = 2;
    };

    # Binds
    binds = {
      workspace_back_and_forth = true;
      allow_workspace_cycles = false;
      workspace_center_on = 1;
      pass_mouse_when_bound = false;
    };

    # XWayland
    xwayland = {
      enabled = true;
      force_zero_scaling = true;
    };

    # Startup apps
    exec-once =
      startup.common
      ++ startup.${startupConfig} or [];

    # Per-device config
    device = devices.${deviceConfig} or [];
  };
}
