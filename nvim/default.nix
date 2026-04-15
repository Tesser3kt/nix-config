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
      svelte-language-server
      svelte-check

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
      vimPlugins.nvim-treesitter.parsers.svelte
    ];
  };

  xdg.configFile."nvim".source = pkgs.fetchFromGitHub {
    owner = "Tesser3kt";
    repo = "nvchad-starter";
    rev = "d6c9d37eb4d6eb76109d9be0f3cc5b352a7167bd";
    hash = "sha256-mGv4XruV+F6Pvmf3C/qeyvZrUOdNGepZiXXoThsNJ48=";
  };
}
