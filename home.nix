{
  config,
  pkgs,
  inputs,
  username,
  ...
}: {
  imports = [
    ./fonts
    ./systemd.nix
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
    ./quickshell
  ];

  home.username = username;
  home.homeDirectory = "/home/${username}";

  # Link wallpaper file
  home.file."Pictures/wallpaper.png".source = ./wallpaper.png;

  # Link notification sound
  home.file."Music/notification.wav".source = ./notification.wav;

  # Set default apps
  xdg.mimeApps.defaultApplications = {
    "text/html" = ["zen.desktop"];
    "application/xhtml+xml" = ["zen.desktop"];
    "x-scheme-handler/http" = ["zen.desktop"];
    "x-scheme-handler/https" = ["zen.desktop"];
    "x-scheme-handler/about" = ["zen.desktop"];
    "x-scheme-handler/unknown" = ["zen.desktop"];
    "application/pdf" = ["zathura.desktop"];
    "application/x-shellscript" = ["alacritty.desktop"];
    "text/plain" = ["nvim.desktop"];
    "image/png" = ["gwenview.desktop"];
    "image/jpeg" = ["gwenview.desktop"];
    "image/gif" = ["gwenview.desktop"];
    "video/mp4" = ["vlc.desktop"];
    "video/mkv" = ["vlc.desktop"];
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

  home.stateVersion = "25.05";
}
