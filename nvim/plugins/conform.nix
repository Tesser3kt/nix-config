{
  config,
  pkgs,
  ...
}: {
  programs.neovim.plugins = with pkgs; [
    {
      plugin = vimPlugins.conform-nvim;
      type = "lua";
      config = ''
        require("conform").setup({
          formatters_by_ft = {
            lua = { "stylua" },
            css = { "prettierd" },
            python = { "ruff_fix", "ruff_format" },
            html = { "djlint" },
            javascript = { "prettierd" },
            typescript = { "prettierd" },
            javascriptreact = { "prettierd" },
            typescriptreact = { "prettierd" },
            svelte = { "prettierd" },
            nix = { "alejandra" },
            tex = { "tex-fmt" },
            typst = { "typstyle" },
            arduino = { "clang-format" },
            c = { "clang-format" },
            cpp = { "clang-format" },
            haskell = { "ormolu" },
            rust = { "rustfmt" },
            toml = { "tombi" }
          },
          format_on_save = {
            timeout_ms = 500,
            lsp_format = "fallback", -- use LSP if no conform formatter matches
          },
        })

        vim.keymap.set({ "n", "v" }, "<leader>f", function()
          require("conform").format({ async = true })
        end, { desc = "Format buffer" })
      '';
    }
    stylua
    prettierd
    alejandra
    tex-fmt
    haskellPackages.ormolu
    rustfmt
    djlint
    ruff
    tombi
  ];
}
