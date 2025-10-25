{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./settings.nix
    ./extensions.nix
  ];

  programs.vscode = {
    enable = false;
    profiles.default = {
      enableUpdateCheck = true;
      enableExtensionUpdateCheck = true;
    };
  };
}
