{
  config,
  lib,
  pkgs,
  displayConfig,
  startupConfig,
  deviceConfig,
  ...
}: let
  mod = "SUPER";
  mklua = lib.generators.mkLuaInline;
  terminal = "ghostty";
  browser = "zen";
  files = "ghostty -e nu -c 'yazi'";
  calculator = "ghostty -e nu -c 'sage'";
  mail = "ghostty -e nu -c 'neomutt'";
  ai = "zen --new-window 'gemini.google.com'";
  chat = "element-desktop";
  drawing = "zen --new-window 'https://excalidraw.com'";
  single_border_active = mklua "{ colors = { \"rgba(81A1C1D2)\", \"rgba(8FBCBBD2)\" }, angle = 90 }";
  single_border_inactive = "rgba(2E344096)";
  group_border_active = "rgba(81A1C1D2)";
  groupbar_active = "rgba(81A1C1D2)";
  drop_shadow = "rgba(242933A6)";
  output = {
    "pc" = import ./output/pc.nix;
    "laptop" = import ./output/laptop.nix;
    "nvidia" = import ./output/nvidia.nix;
  };
  startup = {
    "common" = import ./startup/common.nix {inherit lib;};
    "pc" = import ./startup/pc.nix {inherit lib;};
    "nvidia" = import ./startup/nvidia.nix {inherit lib;};
    "laptop" = import ./startup/laptop.nix {inherit lib;};
  };
  devices = {
    "pc" = import ./tablet/pc.nix;
    "nvidia" = import ./tablet/nvidia.nix;
    "raider" = import ./tablet/raider.nix;
  };
  workspaceSettings = {
    "pc" = [(import ./workspaces/pc.nix {inherit lib mod;})];
    "laptop" = [(import ./workspaces/laptop.nix {inherit lib mod;})];
    "nvidia" = [(import ./workspaces/nvidia.nix {inherit lib mod;})];
  };
in {
  imports = (
    workspaceSettings.${displayConfig} or []
  );

  wayland.windowManager.hyprland.settings = {
    env = [
      {
        _args = [
          "GTK_IM_MODULE"
          "simple"
        ];
      }
    ];
    bind =
      [
        # App bindings
        {
          _args = [
            "${mod} + Return"
            (mklua "hl.dsp.exec_cmd(\"${terminal}\")")
          ];
        }
        {
          _args = [
            "${mod} + SHIFT + w"
            (mklua "hl.dsp.exec_cmd(\"${browser}\")")
          ];
        }
        {
          _args = [
            "${mod} + e"
            (mklua "hl.dsp.exec_cmd(\"${files}\")")
          ];
        }
        {
          _args = [
            "${mod} + c"
            (mklua "hl.dsp.exec_cmd(\"${calculator}\")")
          ];
        }
        {
          _args = [
            "${mod} + m"
            (mklua "hl.dsp.exec_cmd(\"${mail}\")")
          ];
        }
        {
          _args = [
            "${mod} + a"
            (mklua "hl.dsp.exec_cmd(\"${ai}\")")
          ];
        }
        {
          _args = [
            "${mod} + v"
            (mklua "hl.dsp.exec_cmd(\"${chat}\")")
          ];
        }
        {
          _args = [
            "${mod} + SHIFT + d"
            (mklua "hl.dsp.exec_cmd(\"${drawing}\")")
          ];
        }

        # Workspaces back and forth
        {
          _args = [
            "${mod} + Tab"
            (mklua "hl.dsp.focus({ workspace = \"previous\" })")
          ];
        }

        # Kill window
        {
          _args = [
            "${mod} + q"
            (mklua "hl.dsp.window.close()")
          ];
        }
        {
          _args = [
            "${mod} + SHIFT + q"
            (mklua "hl.dsp.window.kill()")
          ];
        }

        # Float & fullscreen toggle
        {
          _args = [
            "${mod} + Space"
            (mklua
              ''
                function()
                  local m = hl.get_active_monitor()
                  hl.dispatch(hl.dsp.window.float({ action = "toggle" }))
                  hl.dispatch(hl.dsp.window.resize({
                    x = math.floor(m.width / m.scale * 0.75),
                    y = math.floor(m.height / m.scale * 0.75),
                  }))
                  hl.dispatch(hl.dsp.window.center())
                end
              '')
          ];
        }
        {
          _args = [
            "${mod} + f"
            (mklua "hl.dsp.window.fullscreen{ action = \"toggle\" }")
          ];
        }

        # Scroll through existing workspaces
        {
          _args = [
            "${mod} + period"
            (mklua "hl.dsp.focus({ workspace = \"e+1\" })")
          ];
        }
        {
          _args = [
            "${mod} + comma"
            (mklua "hl.dsp.focus({ workspace = \"e-1\" })")
          ];
        }

        # Screenshots
        {
          _args = [
            "${mod} + SHIFT + s"
            (mklua "hl.dsp.exec_cmd(\"hyprshot -m output\")")
          ];
        }
        {
          _args = [
            "${mod} + s"
            (mklua "hl.dsp.exec_cmd(\"hyprshot -m region\")")
          ];
        }
        {
          _args = [
            "${mod} + ALT + s"
            (mklua "hl.dsp.exec_cmd(\"hyprshot -m window\")")
          ];
        }

        # Rofi
        {
          _args = [
            "${mod} + d"
            (mklua "hl.dsp.exec_cmd(\"pkill rofi || rofi -show drun -modi drun,filebrowser,run,window\")")
          ];
        }
        {
          _args = [
            "${mod} + ALT + v"
            (mklua "hl.dsp.exec_cmd(\"$HOME/.config/hypr/scripts/clip_manager.sh\")")
          ];
        }

        # Logout menu
        {
          _args = [
            "${mod} + x"
            (mklua "hl.dsp.exec_cmd(\"wlogout -b 5 -B 400 -T 400\")")
          ];
        }

        # Enable DND mode
        {
          _args = [
            "${mod} + p"
            (mklua "hl.dsp.exec_cmd(\"makoctl mode -t dnd\")")
          ];
        }

        # Exit hyprland
        {
          _args = [
            "CTRL + ALT + Delete"
            (mklua "hl.dsp.exec_cmd(\"hyprctl dispatch exit 0\")")
          ];
        }
        # Mouse binds
        {
          _args = [
            "${mod} + mouse:272"
            (mklua "hl.dsp.window.drag()")
            {mouse = true;}
          ];
        }
        {
          _args = [
            "${mod} + mouse:273"
            (mklua "hl.dsp.window.resize()")
            {mouse = true;}
          ];
        }
        # Repeat/hold binds
        {
          _args = [
            "${mod} + ALT + left"
            (mklua "hl.dsp.window.resize({ x = -50, y = 0, relative = true })")
            {repeating = true;}
          ];
        }
        {
          _args = [
            "${mod} + ALT + right"
            (mklua "hl.dsp.window.resize({ x = 50, y = 0, relative = true })")
            {repeating = true;}
          ];
        }
        {
          _args = [
            "${mod} + ALT + up"
            (mklua "hl.dsp.window.resize({ x = 0, y = -50, relative = true })")
            {repeating = true;}
          ];
        }
        {
          _args = [
            "${mod} + ALT + down"
            (mklua "hl.dsp.window.resize({ x = 0, y = 50, relative = true })")
            {repeating = true;}
          ];
        }
        # Volume control
        {
          _args = [
            "XF86AudioRaiseVolume"
            (mklua "hl.dsp.exec_cmd(\"wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+\")")
            {
              repeating = true;
              locked = true;
            }
          ];
        }
        {
          _args = [
            "XF86AudioLowerVolume"
            (mklua "hl.dsp.exec_cmd(\"wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-\")")
            {
              repeating = true;
              locked = true;
            }
          ];
        }
        {
          _args = [
            "XF86AudioMute"
            (mklua "hl.dsp.exec_cmd(\"wpctl set-volume @DEFAULT_AUDIO_SINK@ toggle\")")
            {locked = true;}
          ];
        }
        # Brightness control
        {
          _args = [
            "XF86MonBrightnessUp"
            (mklua "hl.dsp.exec_cmd(\"brightnessctl set +5%\")")
            {locked = true;}
          ];
        }
        {
          _args = [
            "XF86MonBrightnessDown"
            (mklua "hl.dsp.exec_cmd(\"brightnessctl set -5%\")")
            {locked = true;}
          ];
        }
      ]
      ++
      # Playback control
      builtins.map (
        pair: let
          key = builtins.elemAt pair 0;
          cmd = builtins.elemAt pair 1;
        in {
          _args = [
            key
            (mklua "hl.dsp.exec_cmd(\"playerctl ${cmd}\")")
            {locked = true;}
          ];
        }
      )
      [
        ["XF86AudioPlay" "play-pause"]
        ["XF86AudioStop" "stop"]
        ["XF86AudioNext" "next"]
        ["XF86AudioPrev" "previous"]
      ]
      ++
      # Focus & window movement
      builtins.concatLists (
        builtins.map (
          pair: let
            key = builtins.elemAt pair 0;
            dir = builtins.elemAt pair 1;
          in [
            {
              _args = [
                "${mod} + ${key}"
                (mklua "hl.dsp.focus({ direction = \"${dir}\" })")
              ];
            }
            {
              _args = [
                "${mod} + SHIFT + ${key}"
                (mklua "hl.dsp.window.move({ direction = \"${dir}\" })")
              ];
            }
            {
              _args = [
                "${mod} + CTRL + ${key}"
                (mklua "hl.dsp.focus({ monitor = \"${dir}\" })")
              ];
            }
            {
              _args = [
                "${mod} + CTRL + SHIFT + ${key}"
                (mklua "hl.dsp.workspace.move({ monitor = \"${dir}\" })")
              ];
            }
          ]
        )
        [
          ["up" "u"]
          ["right" "r"]
          ["down" "d"]
          ["left" "l"]
        ]
      );

    # Output configuration
    monitor = output.${displayConfig} or [];

    # Window rules
    window_rule = [
      {
        match.fullscreen = true;
        idle_inhibit = "fullscreen";
      }
      {
        match.class = "sioyek";
        tile = true;
      }
    ];

    # Curves
    curve = [
      {
        _args = [
          "shot"
          {
            type = "bezier";
            points = [
              [0.2 1.0]
              [0.2 1.0]
            ];
          }
        ];
      }
      {
        _args = [
          "swipe"
          {
            type = "bezier";
            points = [
              [0.6 0.0]
              [0.2 1.05]
            ];
          }
        ];
      }
      {
        _args = [
          "linear"
          {
            type = "bezier";
            points = [
              [0.0 0.0]
              [1.0 1.0]
            ];
          }
        ];
      }
      {
        _args = [
          "progressive"
          {
            type = "bezier";
            points = [
              [1.0 0.0]
              [0.6 1.0]
            ];
          }
        ];
      }
    ];

    # Animations
    animation = [
      {
        leaf = "windows";
        enabled = true;
        speed = 4;
        bezier = "shot";
        style = "slide";
      }
      {
        leaf = "workspaces";
        enabled = true;
        speed = 4;
        bezier = "swipe";
        style = "slide";
      }
      {
        leaf = "fade";
        enabled = true;
        speed = 3;
        bezier = "progressive";
      }
      {
        leaf = "border";
        enabled = true;
        speed = 4;
        bezier = "linear";
      }
    ];

    config = {
      # General settings
      general = {
        gaps_in = 8;
        gaps_out = 12;
        border_size = 1;
        resize_on_border = true;

        "col.active_border" = single_border_active;
        "col.inactive_border" = single_border_inactive;

        layout = "dwindle";
      };

      # Group settings
      group = {
        "col.border_active" = group_border_active;
        groupbar = {
          "col.active" = groupbar_active;
        };
      };

      # Layout settings
      dwindle = {
        preserve_split = true;
        special_scale_factor = 0.8;
      };
      master = {
        new_on_top = true;
        mfact = 0.5;
      };

      # Decorations
      decoration = {
        rounding = 10;

        active_opacity = 1.0;
        inactive_opacity = 0.9;
        fullscreen_opacity = 1.0;

        dim_inactive = true;
        dim_strength = 0.25;

        blur = {
          enabled = true;
          size = 5;
          passes = 3;
          ignore_opacity = true;
          new_optimizations = true;
        };

        shadow = {
          enabled = true;
          range = 16;
          render_power = 2;
          offset = [2 2];
          color = drop_shadow;
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
          tap_to_click = true;
          clickfinger_behavior = true;
          drag_lock = 2;
        };
      };

      # Miscellaneous
      misc = {
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
        mouse_move_enables_dpms = true;
        vrr = 1;
        focus_on_activate = false;
      };

      render = {
        direct_scanout = 2;
      };

      # Binds
      binds = {
        workspace_back_and_forth = true;
        allow_workspace_cycles = true;
        workspace_center_on = 1;
        pass_mouse_when_bound = false;
      };

      # XWayland
      xwayland = {
        enabled = true;
        force_zero_scaling = true;
      };

      # Cursor
      cursor = {
        no_hardware_cursors = 1;
      };
    };

    # Startup
    on = [
      startup.common
      startup.${startupConfig} or {}
    ];

    # Per-device config
    device = devices.${deviceConfig} or [];
  };
}
