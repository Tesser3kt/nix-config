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
    enable = true;
    profiles.default = {
      enableUpdateCheck = true;
      enableExtensionUpdateCheck = true;
    };
  };
}
