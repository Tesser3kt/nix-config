{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    emmet-language-server
    tailwindcss-language-server
    typescript-language-server
    vscode-langservers-extracted
    marksman
    prettierd
    eslint_d
    djlint

    pnpm
  ];
}
