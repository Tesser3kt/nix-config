{
  config,
  pkgs,
  ...
}: {
  # SDDM config
  services.displayManager.sddm = {
    enable = true;
    wayland = {
      enable = true;
    };
    theme = "catppuccin-macchiato-mauve";
  };
  environment.systemPackages = with pkgs; [
    (catppuccin-sddm.override {
      flavor = "macchiato";
      accent = "mauve";
      font = "CaskaydiaCove Nerd Font";
      fontSize = "12";
    })
  ];
  # Enable GPG keyring on SDDM login
  security.pam.services.login.gnupg = {
    enable = true;
    noAutostart = true;
  };
  security.pam.services.sddm = {
    enable = true;
    enableGnomeKeyring = true;
    gnupg = {
      enable = true;
      storeOnly = true;
    };
  };
}
