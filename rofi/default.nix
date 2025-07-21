{
  config,
  pkgs,
  ...
}: let
  colors = {
    selected-active-bg = "#2e3440";
    selected-normal-bg = "#434c5e";
    selected-urgent-bg = "#d08770";
    background = "#242933";
    launcher-bg = "#2e344080";
    foreground = "#bbc3d4";
  };
in {
  home.packages = with pkgs; [
    rofi-wayland
  ];

  xdg.configFile."rofi/themes/default.rasi".text = ''
    * {
      background-alt: ${colors.selected-active-bg};
      selected: ${colors.selected-normal-bg};
      active: ${colors.selected-urgent-bg};
      urgent: ${colors.selected-normal-bg};

      text-selected: ${colors.background};
      text: ${colors.foreground};

      shade-shadow: white / 12%;
      shade-bg: white / 24%;
      shade-border: white / 36%;
    }

    window {
      fullscreen: false;
      transparency: "real";
      cursor: "default";
      background-color: black / 12%;
      border: 0px;
      border-color: @selected;
    }

    element normal.normal,
    element alternate.normal {
      background-color: transparent;
      text-color: @text;
    }

    element selected.normal {
      background-color: @shade-bg;
      text-color: white;
      border: 1px solid;
      border-color: @selected;
    }

    element-text {
      background-color: transparent;
      text-color: inherit;
      highlight: inherit;
      cursor: inherit;
      vertical-align: 0.5;
      horizontal-align: 0.5;
    }

    listview {
      border: 0px;
    }

    scrollbar {
      margin: 0px 4px;
      handle-width: 8px;
      handle-color: white;
      background-color: @shade-shadow;
      border-radius: 4px;
    }

    message {
      background-color: @shade-bg;
      border: 1px solid;
      border-color: transparent;
      border-radius: 12px;
      padding: 24px;
    }

    error-message {
      padding: 100px;
      border: 0px solid;
      border-radius: 0px;
      background-color: black / 10%;
      text-color: @text;
    }

    textbox {
      background-color: transparent;
      text-color: @text;
      vertical-align: 0.5;
      horizontal-align: 0.5;
      highlight: none;
    }
  '';

  xdg.configFile."rofi/themes/launcher.rasi".text = ''
    configuration {
      modi: "drun,calc";
      show-icons: true;
      display-calc: " ";
      display-drun: " ";
      drun-display-format: "{name}";
      font: "Hurmit Nerd Font 12";
    }

    @import "default.rasi"

    window {
      width: 100%;
      height: 100%;
      margin: 0px;
      padding: 0px;
    }

    mainbox {
      children: [ "inputbar", "message", "listview", "mode-switcher" ];
      background-color: transparent;

      spacing: 24px;
      margin: 0px;
      padding: 100px 226px;
    }

    inputbar {
      children: [ "prompt", "entry" ];

      border-radius: 12px;
      background-color: @shade-bg;
      text-color: @text;

      spacing: 12px;
      margin: 0% 28%;
      padding: 14px;
    }

    prompt {
      background-color: transparent;
      text-color: inherit;
    }

    textbox-prompt-colon {
      expand: false;
      str: "::";
      background-color: transparent;
      text-color: inherit;
    }

    entry {
      background-color: transparent;
      text-color: inherit;
      cursor: inherit;
      placeholder: " ";
      placeholder-color: inherit;
    }

    listview {
      cursor: "default";
      columns: 6;
      lines: 4;
      cycle: true;
      dynamic: true;
      scrollbar: false;
      layout: vertical;
      reverse: false;
      fixed-height: true;
      fixed-columns: true;

      background-color: ${colors.launcher-bg};
      text-color: @text;

      spacing: 0px;
      margin: 0px;
      padding: 24px;

      border-radius: 12px;
    }

    mode-switcher {
      background-color: transparent;
      border: 0px;

      margin: 0px;
      padding: 0px;
      spacing: 12px;
    }
    button {
      padding: 12px 0;
      border-radius: 12px;
      background-color: @shade-shadow;
      text-color: @text;
      cursor: pointer;
    }
    button selected {
      background-color: @shade-bg;
      border: 1px solid;
      border-color: @selected;
      text-color: white;
    }

    element {
      cursor: pointer;
      border-radius: 24px;
      background-color: transparent;
      text-color: @text;
      orientation: vertical;

      spacing: 16px;
      margin: 0px;
      padding: 36px 0px;
    }

    element-icon {
      background-color: transparent;
      text-color: inherit;
      size: 72px;
      cursor: inherit;
    }
  '';

  xdg.configFile."rofi/themes/clipboard.rasi".text = ''
    configuration {
      modi: "drun";
      show-icons: false;
      drun-display-format: "{name}";
      font: "Hurmit Nerd Font 14";
    }

    @import "default.rasi"

    window {
      width: 100%;
      height: 100%;
      margin: 0px;
      padding: 0px;
    }

    mainbox {
      children: [ "inputbar", "textbox-help", "message", "listview" ];
      background-color: transparent;

      spacing: 16px;
      margin: 0px;
      padding: 64px;
    }

    inputbar {
      children: [ "dummy", "entry", "dummy" ];

      border-radius: 24px;

      spacing: 0px;
      padding: 128px 64px;
      orientation: horizontal;
      background-image: url("~/Pictures/wallpaper.png", width);
    }

    dummy {
      background-color: transparent;
    }

    textbox-help {
      expand: false;
      content: " [CTRL DEL] Delete \n [ALT DEL] Wipe";

      border-radius: 12px;
      background-color: @shade-bg;
      text-color: white;

      margin: 0px;
      padding: 6px;
    }

    textbox-icon {
      expand: true;
      background-color: transparent;
      text-color: inherit;
      margin: 0px 0px 0px 25px;
      content: "  ";
    }

    entry {
      cursor: inherit;
      placeholder: "Search";
      placeholder-color: inherit;

      border-radius: 12px;
      background-color: black / 48%;
      text-color: @text;

      padding: 16px;
      margin: 0px;
    }

    listview {
      cursor: "default";
      columns: 2;
      cycle: true;
      dynamic: true;
      scrollbar: false;
      layout: vertical;
      reverse: false;
      fixed-height: true;
      fixed-columns: true;

      background-color: transparent;
      text-color: @foreground;

      spacing: 12px;
      margin: 0px;
      padding: 0px;
    }

    element {
      cursor: pointer;
      border-radius: 10px;
      background-color: transparent;
      text-color: @foreground;

      spacing: 0px;
      margin: 0px;
      padding: 6px;
    }

    element-icon {
      background-color: transparent;
      text-color: inherit;
      size: 36px;
      cursor: inherit;
    }

    element-text {
      horizontal-align: 0.0;
    }

    @media(max-aspect-ratio: 1.8) {
      element {
        orientation: vertical;
      }
    }
  '';

  xdg.configFile."rofi/config.rasi".text = ''
    @theme "~/.config/rofi/themes/launcher.rasi"
  '';
}
