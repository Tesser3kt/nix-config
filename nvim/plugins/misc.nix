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
            prompt = ' '
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
    flash-nvim
    nvim-treesitter-textobjects
    emmet-vim
    neoscroll-nvim
    {
      plugin = stay-centered-nvim;
      type = "lua";
      config = ''
        require('stay-centered').setup({
          -- The filetype is determined by the vim filetype, not the file extension. In order to get the filetype, open a file and run the command:
          -- :lua print(vim.bo.filetype)
          skip_filetypes = {},
          -- Set to false to disable by default
          enabled = true,
          -- allows scrolling to move the cursor without centering, default recommended
          allow_scroll_move = true,
          -- temporarily disables plugin on left-mouse down, allows natural mouse selection
          -- try disabling if plugin causes lag, function uses vim.on_key
          disable_on_mouse = true,
        })
      '';
    }
  ];
}
