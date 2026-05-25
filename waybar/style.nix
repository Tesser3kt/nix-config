{
  config,
  pkgs,
  ...
}: let
  colors = import ../catppuccin.nix;
in {
  programs.waybar = {
    style = ''
      *{
      	font-family: "CaskaydiaCove Nerd Font";
      	font-weight: bold;
        font-size: 16px;
      	min-height: 0;
      	/* set font-size to 100% if font scaling is set to 1.00 using nwg-look */
      	font-feature-settings: '"zero", "ss01", "ss02", "ss03", "ss04", "ss05", "cv31"';
      	padding: 1px;
      }

      window#waybar {
      	background-color: transparent;
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
      	background: ${colors.macchiato.mantle};
      	border-radius: 10px;
      	border-width: 2px;
      	border-style: solid;
      	border-color: ${colors.macchiato.base};
      	color: ${colors.macchiato.lavender};
      }

      /*-----module groups----*/
      .modules-right {

      }

      .modules-center {

      }

      .modules-left {

      }

      #workspaces button {
      	color: ${colors.macchiato.surface2};
        box-shadow: none;
      	text-shadow: none;
        padding: 0px;
        border-radius: 9px;
        padding-left: 4px;
        padding-right: 4px;
        transition: all 0.3s;
      }

      #workspaces button.active {
      	color: ${colors.macchiato.mauve};
        transition: all 0.3s;
      }

      #workspaces button.focused {
      	color: ${colors.macchiato.teal};
      }

      #workspaces button.urgent {
      	color: ${colors.macchiato.red};
      }

      #workspaces button:hover {
      	color: ${colors.macchiato.text};
        border-radius: 15px;
        transition: all 0.3s;
      }

      #backlight,
      #battery,
      #bluetooth,
      #clock,
      #language,
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
        color: ${colors.macchiato.blue};
      }

      #language {
        color: ${colors.macchiato.sapphire};
      }

      #idle_inhibitor{
        color: ${colors.macchiato.sky};
      }

      #bluetooth {
        color: ${colors.macchiato.teal};
      }

      #cpu {
        color: ${colors.macchiato.mauve};
      }

      #memory {
        color: ${colors.macchiato.pink};
      }

      #temperature {
        color: ${colors.macchiato.lavender};
      }

      #temperature.critical {
      	color: ${colors.macchiato.maroon};
      }

      #disk {
        color: ${colors.macchiato.yellow};
      }

      #backlight {
        color: ${colors.macchiato.peach};
      }

      #battery {
        color: ${colors.macchiato.flamingo};
      }

      #wireplumber {
        color: ${colors.macchiato.green};
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
      	background-color: ${colors.macchiato.base};
          padding-left: 12px;
          padding-right: 12px;
          animation: gradient_f 20s ease-in infinite;
          transition: all 0.3s cubic-bezier(.55,-0.68,.48,1.682);
      }

      #battery.critical:not(.charging) {
      	color: ${colors.macchiato.red};
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
      	background-color: ${colors.macchiato.yellow};
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
      	background-color: ${colors.macchiato.yellow};
      }
    '';
  };
}
