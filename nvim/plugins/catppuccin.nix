{
  config,
  pkgs,
  inputs,
  ...
}: {
  programs.neovim.plugins = with pkgs.vimPlugins; [
    {
      plugin = catppuccin-nvim;
      type = "lua";
      config = ''
        require("catppuccin").setup({
            flavour = "macchiato",
            background = {
                light = "latte",
                dark = "macchiato"
            },
        })

        vim.cmd.colorscheme "catppuccin-nvim"
      '';
    }
  ];
}
