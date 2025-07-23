{
  config,
  pkgs,
  ...
}: let
  colors = {
    # Black/Gray tones
    black0 = "#191D24";
    black1 = "#1E222A";
    black2 = "#222630";
    gray0 = "#242933";
    gray1 = "#2E3440";
    gray2 = "#3B4252";
    gray3 = "#434C5E";

    # White/Light tones
    white_alt = "#C0C8D8";
    white0 = "#BBC3D4";
    white1 = "#D8DEE9";
    white2 = "#E5E9F0";
    white3 = "#ECEFF4";
    gray5 = "#60728A";
    gray4 = "#4C566A";

    # Accent colors (Main)
    blue0 = "#5E81AC";
    cyan = "#8FBCBB";
    red = "#BF616A";
    orange = "#D08770";
    yellow = "#EBCB8B";
    green = "#A3BE8C";
    magenta = "#B48EAD";

    # Accent colors (Bright)
    blue1 = "#81A1C1";
    cyan_b = "#9FC6C5";
    red_b = "#C5727A";
    orange_b = "#D79784";
    yellow_b = "#EFD49F";
    green_b = "#B1C89D";
    magenta_b = "#BE9DB8";

    # Accent colors (Dark)
    blue2 = "#88C0D0";
    cyan_d = "#80B3B2";
    red_d = "#B74E58";
    orange_d = "#CB775D";
    yellow_d = "#E7C173";
    green_d = "#97B67C";
    magenta_d = "#A97EA1";
  };
in {
  programs.waybar = {
    style = ''
      *{
      	font-family: "Hurmit Nerd Font";
      	font-weight: bold;
        font-size: 12px;
      	min-height: 0;
      	/* set font-size to 100% if font scaling is set to 1.00 using nwg-look */
      	font-feature-settings: '"zero", "ss01", "ss02", "ss03", "ss04", "ss05", "cv31"';
      	padding: 1px;
      }

      window#waybar {
      	background: transparent;
      	border-radius: 1px;
      	color: whitesmoke;
      }

      window#waybar.hidden {
      	opacity: 0.5;
      }
      window#waybar.empty {
      	background-color: transparent;
      }

      window#waybar.empty #window {
         padding: 0px;
         border: 0px;
         background-color: transparent;
      }

      tooltip {
      	background: ${colors.black1};
      	border-radius: 10px;
      	border-width: 2px;
      	border-style: solid;
      	border-color: ${colors.black0};
      	color: ${colors.magenta_b};
      }

      /*-----module groups----*/
      .modules-right {

      }

      .modules-center {

      }

      .modules-left {

      }

      #workspaces button {
      	color: ${colors.gray5};
        box-shadow: none;
      	text-shadow: none;
        padding: 0px;
        border-radius: 9px;
        padding-left: 4px;
        padding-right: 4px;
        transition: all 0.3s;
      }

      #workspaces button.active {
      	color: whitesmoke;
        transition: all 0.3s;
      }

      #workspaces button.focused {
      	color: ${colors.white1};
      }

      #workspaces button.urgent {
      	color: ${colors.orange};
      }

      #workspaces button:hover {
      	color: whitesmoke;
        border-radius: 15px;
        transition: all 0.3s;
      }

      #backlight,
      #battery,
      #bluetooth,
      #clock,
      #cpu,
      #disk,
      #idle_inhibitor,
      #keyboard-state,
      #memory,
      #mode,
      #mpris,
      #network,
      #pulseaudio,
      #taskbar,
      #temperature,
      #tray,
      #window,
      #wireplumber,
      #workspaces,
      #custom-cycle_wall,
      #custom-keybinds,
      #custom-keyboard,
      #custom-light_dark,
      #custom-lock,
      #custom-menu,
      #custom-power_vertical,
      #custom-power,
      #custom-swaync,
      #custom-spotify,
      #custom-updater,
      #custom-weather,
      #custom-weather.clearNight,
      #custom-weather.cloudyFoggyDay,
      #custom-weather.cloudyFoggyNight,
      #custom-weather.default
      #custom-weather.rainyDay,
      #custom-weather.rainyNight,
      #custom-weather.severe,
      #custom-weather.showyIcyDay,
      #custom-weather.snowyIcyNight,
      #custom-weather.sunnyDay {
      	padding-top: 3px;
      	padding-bottom: 3px;
      	padding-right: 6px;
      	padding-left: 6px;
      }

      #clock {
        color: ${colors.cyan};
      }

      #temperature.critical {
      	background-color: ${colors.red};
      }

      @keyframes blink {
      	to {
          color: black;
      	}
      }
      #taskbar button:hover {
          padding-left: 3px;
          padding-right: 3px;
          animation: gradient_f 20s ease-in infinite;
          transition: all 0.3s cubic-bezier(.55,-0.68,.48,1.682);
      }

      #taskbar button.active {
      	background-color: ${colors.gray5};
          padding-left: 12px;
          padding-right: 12px;
          animation: gradient_f 20s ease-in infinite;
          transition: all 0.3s cubic-bezier(.55,-0.68,.48,1.682);
      }

      #battery.critical:not(.charging) {
      	color: ${colors.red};
      	animation-name: blink;
      	animation-duration: 0.5s;
      	animation-timing-function: linear;
      	animation-iteration-count: infinite;
      	animation-direction: alternate;
      }

      #pulseaudio-slider slider {
      	min-width: 0px;
      	min-height: 0px;
      	opacity: 0;
      	background-image: none;
      	border: none;
      	box-shadow: none;
      }

      #pulseaudio-slider trough {
      	min-width: 80px;
      	min-height: 10px;
      	border-radius: 5px;
      	background-color: black;
      }

      #pulseaudio-slider highlight {
      	min-height: 10px;
      	border-radius: 5px;
      	background-color: ${colors.yellow_b};
      }

      #backlight-slider slider {
      	min-width: 0px;
      	min-height: 0px;
      	opacity: 0;
      	background-image: none;
      	border: none;
      	box-shadow: none;
      }

      #backlight-slider trough {
      	min-width: 80px;
      	min-height: 10px;
      	border-radius: 5px;
      	background-color: black;
      }

      #backlight-slider highlight {
      	min-width: 10px;
      	border-radius: 5px;
      	background-color: ${colors.yellow_b};
      }
    '';
  };
}
