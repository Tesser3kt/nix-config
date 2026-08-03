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
    ./mail
    ./office.nix
    ./emulation.nix
    ./ai.nix
    ./remote-desktop.nix
  ];
}
