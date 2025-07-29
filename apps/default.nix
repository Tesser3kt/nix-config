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
    ./browsers.nix
    ./vscode
    ./math.nix
    ./coolercontrol.nix
  ];
}
