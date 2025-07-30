{
  config,
  pkgs,
  inputs,
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

  home.packages = with pkgs; [
    hyprpicker
    hyprcursor
    # Dev version of hyprutils
    inputs.hyprutils.packages.${pkgs.stdenv.hostPlatform.system}.hyprutils
  ];

  # Cursor
  home.file.".local/share/icons/BreezeX-Dark".source = ./hyprcursors/BreezeX-Dark;

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
    HYPRCURSOR_THEME = "BreezeX-Dark";
    HYPRCURSOR_SIZE = "28";
  };
}
