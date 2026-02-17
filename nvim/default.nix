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

      claude-code

      vimPlugins.nvim-treesitter
      vimPlugins.nvim-treesitter.withAllGrammars
      vimPlugins.nvim-treesitter-refactor
      vimPlugins.nvim-treesitter-pyfold
    ];
  };

  xdg.configFile."nvim".source = pkgs.fetchFromGitHub {
    owner = "Tesser3kt";
    repo = "nvchad-starter";
    rev = "621547c07f5f3e9f4735a4394c2f00f67caf99dd";
    hash = "sha256-ivpapZomhcuJJ/n0x8LquAzf3vEcg7lo6T1I2fmW1tI=";
  };
}
