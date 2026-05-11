{
  config,
  pkgs,
  ...
}: {
  programs.neovim.plugins = with pkgs.vimPlugins; [
    {
      plugin = nvim-autopairs;
      type = "lua";
      config = ''
        require('nvim-autopairs').setup {
            disable_filetype = { "TelescopePrompt", "spectre_panel", "snacks_picker_input", "tex", "latex" }
        }

        local cmp_autopairs = require('nvim-autopairs.completion.cmp')
        local cmp = require('cmp')

        cmp.event:on(
            'confirm_done',
            cmp_autopairs.on_confirm_done()
        )
      '';
    }
  ];
}
