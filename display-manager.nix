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
  security.pam.services.login.gnupg.enable = true;
  security.pam.services.sddm = {
    enable = true;
    enableGnomeKeyring = true;
    gnupg = {
      enable = true;
      storeOnly = true;
    };
  };
  home.file.".pam-gnupg".text = "73316C31F6A0A76C6B72A23C87C254BEEA04C2CB";
  services.gpg-agent = {
    enable = true;
    extraConfig = ''
      allow-preset-passphrase
    '';
  };
}
