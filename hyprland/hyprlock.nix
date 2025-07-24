{
  config,
  pkgs,
  ...
}: let
  colors = import ../nordic.nix;
in {
  home.packages = with pkgs; [
    hyprlock
  ];

  programs.hyprlock = {
    enable = true;
    settings = {
      background = [
        {
          path = "$HOME/Pictures/wallpaper.png";
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
          text = "text = cmd[update:1000] echo \"<b><big> $(date +\"%H\") </big></b>\"";
          color = colors.cyan;
          font_size = 112;
          font_family = "GeistMono Nerd Font 10";
          shadow_passes = 3;
          shadow_size = 4;

          position = "0, 220";
          halign = "center";
          valign = "center";
        }
        {
          text = "cmd[update:1000] echo \"<b><big> $(date +\"%M\") </big></b>\"";
          color = colors.cyan;
          font_size = 112;
          font_family = "Geist Mono 10";
          shadow_passes = 3;
          shadow_size = 4;

          position = "0, 80";
          halign = "center";
          valign = "center";
        }
        {
          text = "cmd[update:18000000] echo \"<b><big> \"$(date +'%A')\" </big></b>\"";
          color = colors.blue0;
          font_size = 22;
          font_family = "Hurmit Nerd Font 10";

          position = "0, 30";
          halign = "center";
          valign = "center";
        }
        {
          text = "cmd[update:18000000] echo \"<b> \"$(date +'%d %b')\" </b>\"";
          color = colors.blue0;
          font_size = 18;
          font_family = "Hurmit Nerd Font 10";

          position = "0, 6";
          halign = "center";
          valign = "center";
        }
      ];
      input_field = [
        {
          size = "250, 50";
          outline_thickness = 3;

          dots_size = 0.26;
          dots_spacing = 0.64;
          dots_center = true;
          dots_rounding = -1;

          rounding = 22;
          outer_color = colors.white0;
          inner_color = colors.white0;
          font_color = colors.cyan;
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
