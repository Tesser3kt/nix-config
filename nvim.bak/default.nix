{pkgs, ...}: {
  imports = [
    ./linters.nix
    ./tools.nix
  ];

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    withRuby = true;
    withPython3 = true;

    plugins = with pkgs.vimPlugins; [
      nvim-treesitter.withAllGrammars
      nvim-treesitter.parsers.svelte
      rustaceanvim
    ];

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
      rustfmt

      claude-code
    ];
  };

  xdg.configFile."nvim".source = pkgs.fetchFromGitHub {
    owner = "Tesser3kt";
    repo = "nvchad-starter";
    rev = "b99469347b8cb7a3487a411242c800a08344c48e";
    hash = "sha256-eSp5TfD6GpG87Zw7aByCyOOU8xGQ0k+D7BF9K+mC2YA=";
  };
}
