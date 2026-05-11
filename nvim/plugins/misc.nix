{
  config,
  pkgs,
  inputs,
  ...
}: {
  programs.neovim.plugins = with pkgs.vimPlugins; [
    vim-sleuth
    vim-fugitive
    vim-rhubarb
    which-key-nvim
    todo-comments-nvim
    {
      plugin = nvim-colorizer-lua;
      type = "lua";
      config = ''
        require('colorizer').setup()
      '';
    }
    {
      plugin = fine-cmdline-nvim;
      type = "lua";
      config = ''
        require('fine-cmdline').setup({
          cmdline = {
            enable_keymaps = true,
            smart_history = true,
            prompt = ': '
          },
          popup = {
            position = {
              row = '50%',
              col = '50%',
            },
            size = {
              width = '60%',
            },
            border = {
              style = 'rounded',
            },
            win_options = {
              winhighlight = 'Normal:Normal,FloatBorder:Normal',
            },
          },
          hooks = {
            before_mount = function(input)
              -- code
            end,
            after_mount = function(input)
              -- code
            end,
            set_keymaps = function(imap, feedkeys)
              -- code
            end
          }
        })
      '';
    }
    nui-nvim
    {
      plugin = pkgs.vimUtils.buildVimPlugin {
        name = "bg-nvim";
        src = inputs.bg-nvim;
      };
      type = "lua";
    }
    nvim-numbertoggle
  ];
}
