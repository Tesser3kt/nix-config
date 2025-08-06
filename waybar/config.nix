{
  config,
  pkgs,
  waybarConfig,
  ...
}: {
  programs.waybar = {
    settings = {
      main = {
        layer = "top";
        position = "top";
        height = 15;
        margin-left = 10;
        margin-right = 10;
        margin-top = 2;

        modules-left = [
          "clock"
          "custom/separator#blank"
          "hyprland/language"
          "custom/separator#blank"
          "idle_inhibitor"
          "custom/separator#blank"
          "hyprland/window"
        ];

        modules-center = [
          "hyprland/workspaces"
        ];

        modules-right =
          [
            "tray"
            "custom/separator#blank"
            "mpris"
            "custom/separator#blank"
            "bluetooth"
            "custom/separator#blank"
            "group/motherboard"
            "custom/separator#blank"
          ]
          ++ (
            if waybarConfig == "laptop"
            then [
              "group/laptop"
              "custom/separator#blank"
            ]
            else []
          )
          ++ [
            "group/audio"
            "custom/separator#blank"
            "custom/power"
          ];
        # HYPRLAND WORKSPACES. CHOOSE as desired and place on waybar configs
        # CIRCLES Style
        "hyprland/workspaces" = {
          "active-only" = false;
          "all-outputs" = true;
          format = "{icon}";
          "show-special" = false;
          "on-click" = "activate";
          "on-scroll-up" = "hyprctl dispatch workspace e+1";
          "on-scroll-down" = "hyprctl dispatch workspace e-1";
          "persistent-workspaces" = {
            "1" = [];
            "2" = [];
            "3" = [];
            "4" = [];
            "5" = [];
          };
          "format-icons" = {
            active = "<span font='13'></span>";
            default = "<span font='13'></span>";
          };
        };

        # GROUP
        "group/motherboard" = {
          orientation = "horizontal";
          modules = [
            "cpu"
            "memory"
            "temperature"
            "disk"
          ];
        };

        "group/laptop" = {
          orientation = "horizontal";
          modules = [
            "backlight"
            "battery"
          ];
        };

        "group/audio" = {
          orientation = "horizontal";
          modules = [
            "wireplumber"
          ];
        };

        backlight = {
          interval = 2;
          align = 0;
          rotate = 0;
          "format-icons" = ["" "" "" "󰃝" "󰃞" "󰃟" "󰃠"];
          format = "<span font='13'>{icon}</span> {percent}%";
          "tooltip-format" = "backlight {percent}%";
          "icon-size" = 10;
          "on-click" = "";
          "on-click-middle" = "";
          "on-click-right" = "";
          "on-update" = "";
          "on-scroll-up" = "brightnessctl set +5%";
          "on-scroll-down" = "brightnessctl set 5%-";
          "smooth-scrolling-threshold" = 1;
        };

        battery = {
          align = 0;
          rotate = 0;
          "full-at" = 99;
          "design-capacity" = false;
          states = {
            good = 95;
            warning = 30;
            critical = 15;
          };
          format = "{icon} {capacity}%";
          "format-charging" = "<span font='13'></span> {capacity}%";
          "format-plugged" = "<span font='13'>󱘖</span> {capacity}%";
          "format-alt-click" = "click";
          "format-full" = "<span font='13'>{icon}</span> Full";
          "format-alt" = "<span font='13'>{icon}</span> {time}";
          "format-icons" = ["󰂎" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
          "format-time" = "{H}h {M}min";
          tooltip = true;
          "tooltip-format" = "{timeTo} {power}W";
        };

        bluetooth = {
          format = "<span font='13'></span>";
          "format-disabled" = "<span font='13'>󰂳</span>";
          "format-connected" = "<span font='13'>󰂱</span> {num_connections}";
          "tooltip-format" = " {device_alias}";
          "tooltip-format-connected" = "{device_enumerate}";
          "tooltip-format-enumerate-connected" = " {device_alias} <span font='13'>󰂄</span>{device_battery_percentage}%";
          tooltip = true;
          "on-click" = "blueman-manager";
        };

        clock = {
          interval = 1;
          format = "<span font='13'> </span>{:%H:%M}";
          "format-alt" = "<span font='13'> </span>{:%H:%M  <span font='13'> </span>%Y, %d %B, %A}";
          "tooltip-format" = "<tt><small>{calendar}</small></tt>";
          calendar = {
            mode = "year";
            "mode-mon-col" = 3;
            "weeks-pos" = "right";
            "on-scroll" = 1;
            format = {
              months = "<span color='#d79784'><b>{}</b></span>";
              days = "<span color='#b48ead'><b>{}</b></span>";
              weeks = "<span color='#8fbcbb'><b>W{}</b></span>";
              weekdays = "<span color='#ebcb8b'><b>{}</b></span>";
              today = "<span color='#be9db8'><b><u>{}</u></b></span>";
            };
          };
          actions = {
            "on-click-right" = "mode";
            "on-click-forward" = "tz_up";
            "on-click-backward" = "tz_down";
            "on-scroll-up" = "shift_up";
            "on-scroll-down" = "shift_down";
          };
        };

        cpu = {
          format = "<span font='13'>󰍛 </span>{usage}%";
          interval = 1;
          "format-alt-click" = "click";
          "format-alt" = "<span font='13'>{icon0}{icon1}{icon2}{icon3}</span> {usage:>2}%";
          "format-icons" = [" " "▂" "▃" "▄" "▅" "▆" "▇" "█"];
          "on-click" = "gnome-system-monitor";
        };

        disk = {
          interval = 30;
          path = "/";
          format = "<span font='13'>󰋊</span> {percentage_used}%";
          "tooltip-format" = "{used} used out of {total} on {path} ({percentage_used}%)";
        };

        "hyprland/language" = {
          format = "<span font='13'>󰌌 </span>{}";
          "format-en" = "US";
          "format-cs" = "CZ";
        };

        "hyprland/submap" = {
          format = "<span style=\"italic\">󱄅  {}</span>";
          tooltip = false;
        };

        "hyprland/window" = {
          format = "{}";
          "max-length" = 40;
          "separate-outputs" = true;
          "offscreen-css" = true;
          "offscreen-css-text" = "(inactive)";
          rewrite = {
            "(.*) — Mozilla Firefox" = "<span font='13'> </span>$1";
            "(.*) - Google Chrome" = "<span font='13'> </span>$1";
            "(.*) - fish" = "<span font='12'> </span>[$1]";
            "(.*) - zsh" = "<span font='12'> </span>[$1]";
            "(.*) - kitty" = "<span font='12'> </span>[$1]";
            "(.*) - Alacritty" = "<span font='12'> </span>[$1]";
            "WebCord - (.*)" = "<span font='13'> </span>$1";
            "*WebCord - (.*)" = "<span font='13'> </span>$1";
          };
        };

        idle_inhibitor = {
          format = "{icon}";
          "format-icons" = {
            activated = " ";
            deactivated = " ";
          };
        };

        "keyboard-state" = {
          capslock = true;
          format = {
            numlock = "N {icon}";
            capslock = "󰪛 {icon}";
          };
          "format-icons" = {
            locked = "";
            unlocked = "";
          };
        };

        memory = {
          interval = 10;
          format = "<span font='13'>󰾆 </span>{used:0.1f}G";
          "format-alt" = "<span font='13'>󰾆 </span>{percentage}%";
          "format-alt-click" = "click";
          tooltip = true;
          "tooltip-format" = "{used:0.1f}GB/{total:0.1f}G";
          "on-click" = "alacritty --title btop sh -c 'btop'";
        };

        mpris = {
          interval = 10;
          format = "<span font='13'>{player_icon}</span> <i>{dynamic}</i>";
          "format-paused" = "<span font='13'>{status_icon}</span> <i>{dynamic}</i>";
          "on-click-middle" = "playerctl play-pause";
          "on-click" = "playerctl previous";
          "on-click-right" = "playerctl next";
          "scroll-step" = 5.0;
          "on-scroll-up" = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+";
          "on-scroll-down" = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-";
          "smooth-scrolling-threshold" = 1;
          "player-icons" = {
            chromium = "";
            default = "";
            firefox = "";
            kdeconnect = "";
            mopidy = "";
            mpv = "󰐹";
            spotify = "";
            vlc = "󰕼";
          };
          "status-icons" = {
            paused = "󰐎";
            playing = "";
            stopped = "";
          };
          "max-length" = 30;
        };

        network = {
          format = "{ifname}";
          "format-wifi" = "{icon}";
          "format-ethernet" = "󰌘";
          "format-disconnected" = "󰌙";
          "tooltip-format" = "{ipaddr}  {bandwidthUpBytes}  {bandwidthDownBytes}";
          "format-linked" = "󰈁 {ifname} (No IP)";
          "tooltip-format-wifi" = "{essid} {icon} {signalStrength}%";
          "tooltip-format-ethernet" = "{ifname} 󰌘";
          "tooltip-format-disconnected" = "󰌙 Disconnected";
          "max-length" = 50;
          "format-icons" = ["󰤯" "󰤟" "󰤢" "󰤥" "󰤨"];
        };

        "network#speed" = {
          interval = 1;
          format = "{ifname}";
          "format-wifi" = "{icon}  {bandwidthUpBytes}  {bandwidthDownBytes}";
          "format-ethernet" = "󰌘   {bandwidthUpBytes}  {bandwidthDownBytes}";
          "format-disconnected" = "󰌙";
          "tooltip-format" = "{ipaddr}";
          "format-linked" = "󰈁 {ifname} (No IP)";
          "tooltip-format-wifi" = "{essid} {icon} {signalStrength}%";
          "tooltip-format-ethernet" = "{ifname} 󰌘";
          "tooltip-format-disconnected" = "󰌙 Disconnected";
          "max-length" = 50;
          "format-icons" = ["󰤯" "󰤟" "󰤢" "󰤥" "󰤨"];
        };

        pulseaudio = {
          format = "{icon} {volume}%";
          "format-bluetooth" = "{icon} 󰂰 {volume}%";
          "format-muted" = "󰖁";
          "format-icons" = {
            headphone = "";
            "hands-free" = "";
            headset = "";
            phone = "";
            portable = "";
            car = "";
            default = ["" "" "󰕾" ""];
            "ignored-sinks" = ["Easy Effects Sink"];
          };
          "scroll-step" = 5.0;
          "on-click-right" = "~/.config/hypr/scripts/volume_control.sh --toggle";
          "on-click" = "pavucontrol -t 3";
          "on-scroll-up" = "~/.config/hypr/scripts/volume_control.sh --inc";
          "on-scroll-down" = "~/.config/hypr/scripts/volume_control.sh --dec";
          "tooltip-format" = "{icon} {desc} | {volume}%";
          "smooth-scrolling-threshold" = 1;
        };

        "pulseaudio#microphone" = {
          format = "{format_source}";
          "format-source" = " {volume}%";
          "format-source-muted" = "";
          "on-click-right" = "~/.config/hypr/scripts/volume_control.sh --toggle-mic";
          "on-click" = "pavucontrol -t 4";
          "on-scroll-up" = "~/.config/hypr/scripts/volume_control.sh --mic-inc";
          "on-scroll-down" = "~/.config/hypr/scripts/volume_control.sh --mic-dec";
          "tooltip-format" = "{source_desc} | {source_volume}%";
          "scroll-step" = 5;
        };

        temperature = {
          interval = 10;
          tooltip = true;
          "hwmon-path" = [
            "/sys/class/hwmon/hwmon3/temp1_input"
            "/sys/class/thermal/thermal_zone0/temp"
          ];
          "critical-threshold" = 85;
          "format-critical" = "<span font='13'>{icon}</span> {temperatureC}°C";
          format = "<span font='13'>{icon}</span> {temperatureC}°C";
          "format-icons" = ["󰈸"];
          "on-click" = "alacritty --title nvtop -e 'nvtop'";
        };

        tray = {
          "icon-size" = 18;
          spacing = 8;
        };

        wireplumber = {
          format = "<span font='13'>{icon} </span>{volume}%";
          "format-muted" = "<span font='13'> </span>Mute";
          "on-click-right" = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
          "on-click" = "pwvucontrol";
          "on-scroll-up" = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+";
          "on-scroll-down" = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-";
          "format-icons" = ["" "" "󰕾" ""];
        };

        "wlr/taskbar" = {
          format = "{icon} {name} ";
          "icon-size" = 15;
          "all-outputs" = false;
          "tooltip-format" = "{title}";
          "on-click" = "activate";
          "on-click-middle" = "close";
          "ignore-list" = [
            "wofi"
            "rofi"
          ];
        };

        "custom/menu" = {
          format = "{}";
          exec = "echo ; echo 󱓟 app launcher";
          interval = 86400; # once every day
          tooltip = true;
          "on-click" = "pkill rofi || rofi -show drun -modi run,drun,filebrowser,window";
        };

        "custom/playerctl" = {
          format = "<span>{}</span>";
          "return-type" = "json";
          "max-length" = 35;
          exec = "playerctl -a metadata --format '{\"text\": \"{{artist}} ~ {{markup_escape(title)}}\", \"tooltip\": \"{{playerName}} : {{markup_escape(title)}}\", \"alt\": \"{{status}}\", \"class\": \"{{status}}\"}' -F";
          "on-click-middle" = "playerctl play-pause";
          "on-click" = "playerctl previous";
          "on-click-right" = "playerctl next";
          "scroll-step" = 5.0;
          "on-scroll-up" = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+";
          "on-scroll-down" = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-";
          "smooth-scrolling-threshold" = 1;
        };

        "custom/swaync" = {
          tooltip = true;
          format = "{icon} {}";
          "format-icons" = {
            notification = "<span foreground='red'><sup></sup></span>";
            none = "";
            "dnd-notification" = "<span foreground='red'><sup></sup></span>";
            "dnd-none" = "";
            "inhibited-notification" = "<span foreground='red'><sup></sup></span>";
            "inhibited-none" = "";
            "dnd-inhibited-notification" = "<span foreground='red'><sup></sup></span>";
            "dnd-inhibited-none" = "";
          };
          "return-type" = "json";
          "exec-if" = "which swaync-client";
          exec = "swaync-client -swb";
          "on-click" = "sleep 0.1 && swaync-client -t -sw";
          "on-click-right" = "swaync-client -d -sw";
          escape = true;
        };

        # Separators
        "custom/separator#dot" = {
          format = "";
          interval = "once";
          tooltip = false;
        };

        "custom/separator#dot-line" = {
          format = "";
          interval = "once";
          tooltip = false;
        };

        "custom/separator#line" = {
          format = "|";
          interval = "once";
          tooltip = false;
        };

        "custom/separator#blank" = {
          format = "";
          interval = "once";
          tooltip = false;
        };

        "custom/separator#blank_2" = {
          format = "  "; # Two spaces
          interval = "once";
          tooltip = false;
        };

        "custom/separator#blank_3" = {
          format = "   "; # Three spaces
          interval = "once";
          tooltip = false;
        };

        "custom/power" = {
          format = "<span font='13'></span> ";
          icon-size = 20;
          on-click = "wlogout -b 5 -B 400 -T 400";
          tooltip = false;
        };
      };
    };
  };
}
