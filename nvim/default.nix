{pkgs, ...}: {
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
      (python3.withPackages (p:
        with p; [
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
    repo = "nvchad-starter";

    rev = "7c8f35650f2e8095cdd0943ab11d10c3e14c689c";

    hash = "sha256-O3NGFeCNtMus1r3yVDLg1i1/xyNjD5v/jjKQ2KyDJeU=";
  };
}
