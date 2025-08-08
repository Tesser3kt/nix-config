{
  config,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    # SDDM theme
    sddm-astronaut
  ];

  # SDDM config
  services.displayManager.enable = true;
  services.displayManager.autoLogin.enable = false;
  services.displayManager.sddm = {
    enable = true;
    package = pkgs.kdePackages.sddm;
    wayland = {
      enable = true;
    };
    theme = "sddm-astronaut-theme";
    extraPackages = with pkgs; [
      sddm-astronaut
    ];
  };

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
    text = ''
      auth      optional      pam_gnupg.so store-only
      session   optional      pam_gnupg.so
    '';
  };
}
