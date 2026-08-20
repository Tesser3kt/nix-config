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
        local macchiato = require("catppuccin.palettes").get_palette "macchiato"
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
            color_icons = true,
            show_buffer_icons = true,
            show_buffer_close_icons = true,
            show_close_icon = true,
            persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
            separator_style = { "", "" }, -- | "thick" | "thin" | { 'any', 'any' },
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
                return not (buf_name:match("term://") or buf_name:match("No Name"))
            end,
            offsets = {
                {
                    filetype = "neo-tree",
                }
            },
          },
          highlights = require("catppuccin.special.bufferline").get_theme {
            custom = {
              all = {
                fill = { bg = macchiato.mantle },
                buffer_visible = { bg = macchiato.base },
                buffer_selected = { bg = macchiato.surface0 },
                close_button_visible = { bg = macchiato.base },
                close_button_selected = { bg = macchiato.surface0 },
                diagnostic_visible = { bg = macchiato.base },
                diagnostic_selected = { bg = macchiato.surface0 },
                hint_visible = { bg = macchiato.base },
                hint_selected = { bg = macchiato.surface0 },
                hint_diagnostic_visible = { bg = macchiato.base },
                hint_diagnostic_selected = { bg = macchiato.surface0 },
                info_visible = { bg = macchiato.base },
                info_selected = { bg = macchiato.surface0 },
                info_diagnostic_visible = { bg = macchiato.base },
                info_diagnostic_selected = { bg = macchiato.surface0 },
                warning_visible = { bg = macchiato.base },
                warning_selected = { bg = macchiato.surface0 },
                warning_diagnostic_visible = { bg = macchiato.base },
                warning_diagnostic_selected = { bg = macchiato.surface0 },
                error_visible = { bg = macchiato.base },
                error_selected = { bg = macchiato.surface0 },
                error_diagnostic_visible = { bg = macchiato.base },
                error_diagnostic_selected = { bg = macchiato.surface0 },
                modified_visible = { bg = macchiato.base },
                modified_selected = { bg = macchiato.surface0 },
                duplicate_visible = { bg = macchiato.base },
                duplicate_selected = { bg = macchiato.surface0 },
                separator_visible = { bg = macchiato.base },
                separator_selected = { bg = macchiato.surface0 },
                indicator_visible = { bg = macchiato.base },
                indicator_selected = { bg = macchiato.surface0 },
                pick_visible = { bg = macchiato.base },
                pick_selected = { bg = macchiato.surface0 },
              },
            },
          }
        })

        vim.diagnostic.config {
          update_in_insert = true
        }
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
