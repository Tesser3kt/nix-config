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
    package = pkgs.vscode.overrideAttrs (old: {
      buildInputs = (old.buildInputs or []) ++ [pkgs.cairo pkgs.pango];
    });
    profiles.default = {
      enableUpdateCheck = true;
      enableExtensionUpdateCheck = true;
    };
  };
}
