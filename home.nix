{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./fonts.nix
    ./shell
    ./hyprland
    ./tools
    ./apps
    ./nvim
    ./languages
    ./rofi
    ./waybar
    ./swaync
    ./gtk
    ./qt
  ];

  home.username = "tesserekt";
  home.homeDirectory = "/home/tesserekt";

  # Link wallpaper file
  home.file."Pictures/wallpaper.png".source = ./wallpaper.png;

  # Set default apps
  xdg.mimeApps.defaultApplications = {
    "text/html" = ["firefox.desktop"];
    "application/xhtml+xml" = ["firefox.desktop"];
    "x-scheme-handler/http" = ["firefox.desktop"];
    "x-scheme-handler/https" = ["firefox.desktop"];
    "x-scheme-handler/about" = ["firefox.desktop"];
    "x-scheme-handler/unknown" = ["firefox.desktop"];
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

  home.stateVersion = "25.05";
}
