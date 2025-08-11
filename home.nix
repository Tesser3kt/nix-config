{
  config,
  pkgs,
  inputs,
  username,
  ...
}: {
  imports = [
    ./fonts.nix
    ./timers.nix
    ./shell
    ./hyprland
    ./tools
    ./apps
    ./nvim
    ./languages
    ./rofi
    ./waybar
    # ./swaync
    ./mako
    ./gtk
    ./qt
  ];

  home.username = username;
  home.homeDirectory = "/home/${username}";

  # Link wallpaper file
  home.file."Pictures/wallpaper.png".source = ./wallpaper.png;

  # Link notification sound
  home.file."Music/notification.wav".source = ./notification.wav;

  # Set default apps
  xdg.mimeApps.defaultApplications = {
    "text/html" = ["firefox-beta.desktop"];
    "application/xhtml+xml" = ["firefox-beta.desktop"];
    "x-scheme-handler/http" = ["firefox-beta.desktop"];
    "x-scheme-handler/https" = ["firefox-beta.desktop"];
    "x-scheme-handler/about" = ["firefox-beta.desktop"];
    "x-scheme-handler/unknown" = ["firefox-beta.desktop"];
    "application/pdf" = ["zathura.desktop"];
    "application/x-shellscript" = ["alacritty.desktop"];
    "text/plain" = ["nvim.desktop"];
    "image/png" = ["gwenview.desktop"];
    "image/jpeg" = ["gwenview.desktop"];
    "image/gif" = ["gwenview.desktop"];
    "video/mp4" = ["vlc.desktop"];
    "video/x-matroska" = ["vlc.desktop"];
    "video/x-msvideo" = ["vlc.desktop"];
  };

  home.packages = with pkgs; [
    # terminal stuff
    neofetch
    ranger

    # archives
    zip
    unzip
    xz
    p7zip

    # utils
    ripgrep
    jq
    yq-go
    eza
    fzf
    matugen
    lazygit
    gdu
    bottom

    # networking
    mtr
    iperf3
    dnsutils
    ldns
    aria2
    socat
    nmap
    ipcalc

    # nix related
    nix-output-monitor

    # tools
    hugo

    # text
    glow

    # random
    cowsay
    file
    which
    tree
    gnused
    gnutar
    gawk
    zstd
    gnupg

    # Python packages
    pay-respects
  ];

  # Systemd user services
  systemd.${username}.services."mailsync" = {
    description = "Sync mail";
    wantedBy = ["default.target"];
    script = "${pkgs.mutt-wizard}/bin/mailsync";
    serviceConfig = {
      Type = "oneshot";
      User = username;
    };
  };

  home.stateVersion = "25.05";
}
