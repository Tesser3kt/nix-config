{
  config,
  pkgs,
  ...
}: {
  programs.neovim.plugins = with pkgs.vimPlugins; [
    {
      plugin = bufferline-nvim;
      type = "lua";
      config = ''
        require("bufferline").setup({
          options = {
            mode = "buffers",
            themable = true,
            numbers = "none",
            close_command = "Bdelete! %d",
            buffer_close_icon = "",
            close_icon = "",
            path_components = 1, -- Show only the file name without the directory
            modified_icon = "",
            left_trunc_marker = "",
            right_trunc_marker = "",
            max_name_length = 30,
            show_duplicate_prefix = true,
            max_prefix_length = 30, -- prefix used when a buffer is de-duplicated
            tab_size = 21,
            diagnostics = "nvim_lsp",
            diagnostics_indicator = function(count, level, diagnostics_dict, context)
              local icon = level:match("error") and " " or " "
              return " " .. icon .. count
            end,
            diagnostics_update_in_insert = true,
            color_icons = true,
            show_buffer_icons = true,
            show_buffer_close_icons = true,
            show_close_icon = true,
            persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
            separator_style = "thin", -- | "thick" | "thin" | { 'any', 'any' },
            enforce_regular_tabs = false,
            always_show_bufferline = true,
            show_tab_indicators = false,
            indicator = {
              -- icon = "▎", -- this should be omitted if indicator style is not 'icon'
              style = "none", -- Options: 'icon', 'underline', 'none'
            },
            icon_pinned = "󰐃",
            minimum_padding = 1,
            maximum_padding = 5,
            maximum_length = 15,
            sort_by = "insert_at_end",
            custom_filter = function(buf_number, buf_numbers)
                -- filter out by buffer name
                local buf_name = vim.fn.bufname(buf_number)
                return not buf_name:match("term://")
            end,
            offsets = {
                {
                    filetype = "neo-tree",
                }
            },
          },
          highlights = highlights
        })
      '';
    }
    {
      plugin = vim-bbye;
    }
    {
      plugin = nvim-web-devicons;
      type = "lua";
    }
  ];
}
