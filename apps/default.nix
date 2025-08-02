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
    ./vscode
    ./math.nix
    ./mail.nix
  ];
}
