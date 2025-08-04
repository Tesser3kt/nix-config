{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./communication.nix
    ./media.nix
    ./editors.nix
    ./file-manager.nix
    ./vscode
    ./math.nix
    ./mail.nix
  ];
}
