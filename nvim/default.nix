{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: {
  imports = [
    ./linters.nix
    ./tools.nix
  ];

  programs.neovim = {
    enable = true;
    defaultEditor = true;

    extraPackages = with pkgs; [
      vscode-langservers-extracted
      bash-language-server
      marksman
      nil
      docker-language-server
      emmet-language-server
      lua-language-server
      (python3.withPackages (p: with p; [
        python-lsp-server
        python-lsp-black
        pyls-isort
        pyls-flake8
        pylint
        black
        flake8
        rope
        pyflakes
        mccabe
        pycodestyle
        pydocstyle
        autopep8
        yapf
        isort
      ]))
      sqls
      tailwindcss-language-server
      texlab
      typescript-language-server
      tinymist
      arduino-language-server
      arduino-cli
      clang-tools
      haskell-language-server

      stylua
      prettierd
      eslint_d
      djlint
      typstyle
      tex-fmt
      alejandra
      hlint
      ormolu
    ];
  };

xdg.configFile."nvim".source = pkgs.fetchFromGitHub {
  owner = "Tesser3kt";
  repo  = "nvchad-starter";

  rev = "12a9358a7cfdd3a124333d97682543d06972daab";

  hash = "sha256-gpFWiqEezEZPQZRU6FDjXfAhSfWVQ4VgQOmPEV7h9PM=";
};

}
