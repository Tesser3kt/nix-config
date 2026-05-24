{pkgs, ...}: {
  programs.ghostty = {
    enable = true;
    settings = {
      theme = "Catppuccin Macchiato";
      font-family = "CaskaydiaCove Nerd Font";
      font-size = "12.5";
      window-padding-x = "12";
      window-padding-y = "3";
      window-padding-balance = "true";
      window-vsync = "true";
      copy-on-select = "true";
      mouse-scroll-multiplier = "2";
    };
  };
}
