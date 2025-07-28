{
  config,
  pkgs,
  startupConfig,
  ...
}: let
  startupApps = {
    "pc" = [
      (
        import ./pc.nix {
          inherit config pkgs;
        }
      )
    ];
  };
in {
  wayland.windowManager.hyprland.settings = {
    # Startup
    exec-once =
      [
        "waybar &"
        "nm-applet --indicator &"
        "swaync &"
        "hypridle &"
        "spotify &"
        "webcord &"
      ]
      ++ startupApps.${startupConfig} or [];
  };
}
