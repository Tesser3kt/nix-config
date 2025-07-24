{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./config.nix
    ./hyprpaper.nix
    ./hyprlock.nix
    ./hypridle.nix
    ./scripts
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    package = pkgs.hyprland;
  };

  # Fonts
  home.packages = with pkgs; [
    hyprpicker
    font-awesome
    nerd-fonts._0xproto
    nerd-fonts.adwaita-mono
    nerd-fonts.anonymice
    nerd-fonts.caskaydia-cove
    nerd-fonts.caskaydia-mono
    nerd-fonts.droid-sans-mono
    nerd-fonts.fira-code
    nerd-fonts.fira-mono
    nerd-fonts.hurmit
    nerd-fonts.inconsolata
    nerd-fonts.iosevka
    nerd-fonts.jetbrains-mono
    nerd-fonts.martian-mono
    nerd-fonts.monaspace
    nerd-fonts.roboto-mono
    nerd-fonts.space-mono
    nerd-fonts.ubuntu-mono
    nerd-fonts.victor-mono
    nerd-fonts.zed-mono
  ];
  fonts.fontconfig.enable = true;

  # Environment
  home.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    CLUTTER_BACKEND = "wayland";
    GDK_BACKEND = "wayland,x11";
    QT_AUTO_SCREEN_SCALE_FACTOR = "1";
    QT_QPA_PLATFORM = "wayland;xcb";
    QT_QPA_PLATFORMTHEME = "qt5ct";
    QT_SCALE_FACTOR = "1";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_DESKTOP = "Hyprland";
    XDG_SESSION_TYPE = "wayland";
  };
}
