{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./communication.nix
    ./music.nix
    ./images.nix
    ./editors.nix
    ./file-manager.nix
    ./openrgb.nix
  ];
}
