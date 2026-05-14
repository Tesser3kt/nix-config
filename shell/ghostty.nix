{pkgs, ...}: {
  programs.ghostty = {
    enable = true;
    settings = {
      background-opacity = "0.9";
      theme = "Onenord";
      font-family = "CaskaydiaCove Nerd Font";
      font-size = "12.5";
      window-padding-x = "12";
      window-padding-y = "3";
      window-padding-balance = "true";
      window-vsync = "true";
      copy-on-select = "true";
    };
  };
}
