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
    ./hyprland_lua
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
  xdg.mimeApps.enable = true;
  xdg.mimeApps.defaultApplications = {
    "text/html" = ["zen.desktop"];
    "application/xhtml+xml" = ["zen.desktop"];
    "x-scheme-handler/http" = ["zen.desktop"];
    "x-scheme-handler/https" = ["zen.desktop"];
    "x-scheme-handler/about" = ["zen.desktop"];
    "x-scheme-handler/unknown" = ["zen.desktop"];
    "application/pdf" = ["org.pwmt.zathura.desktop"];
    "application/x-shellscript" = ["com.mitchellh.ghostty.desktop"];
    "text/plain" = ["nvim.desktop"];
    "image/png" = ["org.kde.gwenview.desktop"];
    "image/jpeg" = ["org.kde.gwenview.desktop"];
    "image/gif" = ["org.kde.gwenview.desktop"];
    "video/mp4" = ["vlc.desktop"];
    "video/mkv" = ["vlc.desktop"];
    "video/x-matroska" = ["vlc.desktop"];
    "video/x-msvideo" = ["vlc.desktop"];
    "x-scheme-handler/discord" = ["vesktop.desktop"];
    "x-scheme-handler/claude-cli" = ["claude-code-url-handler.desktop"];
  };

  home.packages = with pkgs; [
    # terminal stuff

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
