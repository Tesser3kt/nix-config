{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: {
  imports = [
    inputs.nix4nvchad.homeManagerModule
    ./linters.nix
    ./tools.nix
  ];

  # Disabling neovim for nvchad
  programs.neovim = {
    enable = false;
  };

  programs.nvchad = {
    enable = true;
    hm-activation = true;
    backup = true;

    # Add extra packages
    extraPackages = with pkgs; [
      # Language servers
      vscode-langservers-extracted
      bash-language-server
      marksman
      ccls
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

      # Linters & Formatters
      stylua
      prettierd
      eslint_d
      djlint
      typstyle
      tex-fmt
      alejandra
    ];
  };

  extraConfig = ''
    config = function()
      require("luasnip").config.set_config {
        -- Autotriggered snippets
        enable_autosnippets = true,

        -- Tab to trigger visual selection
        store_selection_keys = "<Tab>",
      }
    end,
  '';

  # Linking snippets folder
  xdg.configFile."nvim/snippets".source = ./snippets;

  # Linking spell folder
  xdg.configFile."nvim/spell".source = ./spell;
}
