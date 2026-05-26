{
  config,
  pkgs,
  lib,
  ...
}: let
  colors = import ../catppuccin.nix;
  removeHash = lib.strings.removePrefix "#";
in {
  programs.hyprlock = {
    enable = true;
    settings = {
      background = [
        {
          monitor = "";
          path = "$HOME/Pictures/wallpaper.jpg";
          blur_size = 4;
          blur_passes = 3;
          nose = 0.0117;
          contrast = 1.3;
          brightness = 0.8;
          vibrancy = 0.21;
          vibrancy_darkness = 0.0;
        }
      ];
      label = [
        {
          monitor = "";
          text = "cmd[update:1000] echo \"<b><big> $(date +\"%H\") </big></b>\"";
          color = "rgb(${removeHash colors.macchiato.sky})";
          font_size = 112;
          font_family = "CaskaydiaCove Nerd Font";
          shadow_passes = 3;
          shadow_size = 4;

          position = "0, 300";
          halign = "center";
          valign = "center";
        }
        {
          monitor = "";
          text = "cmd[update:1000] echo \"<b><big> $(date +\"%M\") </big></b>\"";
          color = "rgb(${removeHash colors.macchiato.mauve})";
          font_size = 112;
          font_family = "CaskaydiaCove Nerd Font";
          shadow_passes = 3;
          shadow_size = 4;

          position = "0, 160";
          halign = "center";
          valign = "center";
        }
        {
          monitor = "";
          text = "cmd[update:18000000] echo \"<b><big> \"$(date +'%A')\" </big></b>\"";
          color = "rgb(${removeHash colors.macchiato.text})";
          font_size = 22;
          font_family = "CaskaydiaCove Nerd Font";

          position = "0, 30";
          halign = "center";
          valign = "center";
        }
        {
          monitor = "";
          text = "cmd[update:18000000] echo \"<b> \"$(date +'%d %b')\" </b>\"";
          color = "rgb(${removeHash colors.macchiato.text})";
          font_size = 18;
          font_family = "CaskaydiaCove Nerd Font";

          position = "0, 0";
          halign = "center";
          valign = "center";
        }
      ];
      input-field = [
        {
          monitor = "";
          size = "250, 50";
          outline_thickness = 3;

          dots_size = 0.26;
          dots_spacing = 0.64;
          dots_center = true;

          rounding = 22;
          outer_color = "rgb(${removeHash colors.macchiato.lavender})";
          inner_color = "rgb(${removeHash colors.macchiato.base})";
          font_color = "rgb(${removeHash colors.macchiato.text})";
          fade_on_empty = true;
          placeholder_text = "<i>Password...</i>";

          position = "0, 120";
          halign = "center";
          valign = "bottom";
        }
      ];
    };
  };
}
