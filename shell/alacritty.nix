{pkgs, ...}: let
  font_name = "Hurmit Nerd Font";
in {
  # Alacritty -- GPU-accelerated terminal emulator
  programs.alacritty = {
    enable = true;
    settings = {
      env.TERM = "xterm-256color";
      font = {
        size = 12;
        normal = {
          family = font_name;
          style = "Regular";
        };
        bold = {
          family = font_name;
          style = "Bold";
        };
      };
      scrolling.multiplier = 5;
      selection.save_to_clipboard = true;
      window.padding = {
        x = 15;
        y = 15;
      };
      colors = {
        # Nordic palette to match neovim
        primary = {
          background = "#2a303c";
          foreground = "#BBC3D4";
        };
        normal = {
          black = "#1E222A";
          red = "#BF616A";
          green = "#A3BE8C";
          yellow = "#EBCB8B";
          blue = "#5E81AC";
          magenta = "#B48EAD";
          cyan = "#8FBCBB";
          white = "#C0C8D8";
        };
        bright = {
          black = "#2E3440";
          red = "#C5727A";
          green = "#B1C89D";
          yellow = "#EFD49F";
          blue = "#81A1C1";
          magenta = "#BE9DB8";
          cyan = "#9FC6C5";
          white = "#D8DEE9";
        };
      };
    };
  };
}
