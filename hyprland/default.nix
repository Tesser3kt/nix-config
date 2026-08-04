{
  config,
  pkgs,
  lib,
  deviceConfig,
  graphics,
  ...
}: let
  envVariables = {
    "nvidia" = [(import ./nvidia-envs.nix {inherit config pkgs;})];
  };
  idleConfig = {
    "raider" = [(import ./hypridle/raider.nix {inherit config pkgs;})];
    "laptop" = [(import ./hypridle/laptop.nix {inherit config pkgs;})];
    "pc" = [(import ./hypridle/pc.nix {inherit config pkgs;})];
    "nvidia" = [(import ./hypridle/nvidia.nix {inherit config pkgs;})];
  };
in {
  imports =
    [
      ./config.nix
      ./hyprpaper.nix
      ./hyprlock.nix
      ./scripts
    ]
    ++ (envVariables.${graphics} or [])
    ++ (idleConfig.${deviceConfig} or []);

  wayland.windowManager.hyprland = {
    enable = true;
    package = pkgs.hyprland;
    configType = "lua";
  };

  home.packages = with pkgs; [
    hyprpicker
    hyprcursor
    wlinhibit
  ];

  # Cursor
  home.file.".local/share/icons/BreezeX-Dark".source = ./hyprcursors/BreezeX-Dark;
  home.file.".local/share/icons/CatppuccinMacchiatoMauve".source = ./hyprcursors/CatppuccinMacchiatoMauve;

  # Environment
  home.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    CLUTTER_BACKEND = "wayland";
    GDK_BACKEND = "wayland,x11";
    QT_QPA_PLATFORM = "wayland;xcb";
    QT_QPA_PLATFORMTHEME = "qt6ct";
    GTK_THEME = "catppuccin-macchiato-mauve-standard";
    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_DESKTOP = "Hyprland";
    XDG_SESSION_TYPE = "wayland";
  };
}
