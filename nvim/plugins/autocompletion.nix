{
  config,
  pkgs,
  ...
}: {
  programs.neovim.plugins = with pkgs; [
    {
      plugin = vimPlugins.nvim-cmp;
      type = "lua";
      config = ''
        -- See `:help cmp`
            local cmp = require 'cmp'
            local luasnip = require 'luasnip'
            luasnip.config.setup {}

            local kind_icons = {
              Text = '󰉿',
              Method = 'm',
              Function = '󰊕',
              Constructor = '',
              Field = '',
              Variable = '󰆧',
              Class = '󰌗',
              Interface = '',
              Module = '',
              Property = '',
              Unit = '',
              Value = '󰎠',
              Enum = '',
              Keyword = '󰌋',
              Snippet = '',
              Color = '󰏘',
              File = '󰈙',
              Reference = '',
              Folder = '󰉋',
              EnumMember = '',
              Constant = '󰇽',
              Struct = '',
              Event = '',
              Operator = '󰆕',
              TypeParameter = '󰊄',
            }
            cmp.setup {
              snippet = {
                expand = function(args)
                  luasnip.lsp_expand(args.body)
                end,
              },
              completion = { completeopt = 'menu,menuone,noinsert' },

              -- For an understanding of why these mappings were
              -- chosen, you will need to read `:help ins-completion`
              --
              -- No, but seriously. Please read `:help ins-completion`, it is really good!
              mapping = cmp.mapping.preset.insert {
                -- Select the [n]ext item
                --['<C-n>'] = cmp.mapping.select_next_item(),
                -- Select the [p]revious item
                --['<C-p>'] = cmp.mapping.select_prev_item(),

                -- Scroll the documentation window [b]ack / [f]orward
                ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                ['<C-f>'] = cmp.mapping.scroll_docs(4),

                -- Accept ([y]es) the completion.
                --  This will auto-import if your LSP supports it.
                --  This will expand snippets if the LSP sent a snippet.
                --['<C-y>'] = cmp.mapping.confirm { select = true },

                -- If you prefer more traditional completion keymaps,
                -- you can uncomment the following lines
                ['<CR>'] = cmp.mapping.confirm { select = true },
                ['<Tab>'] = cmp.mapping.select_next_item(),
                ['<S-Tab>'] = cmp.mapping.select_prev_item(),

                -- Manually trigger a completion from nvim-cmp.
                --  Generally you don't need this, because nvim-cmp will display
                --  completions whenever it has completion options available.
                ['<C-Space>'] = cmp.mapping.complete {},

                -- Think of <c-l> as moving to the right of your snippet expansion.
                --  So if you have a snippet that's like:
                --  function $name($args)
                --    $body
                --  end
                --
                -- <c-l> will move you to the right of each of the expansion locations.
                -- <c-h> is similar, except moving you backwards.
                ['<C-l>'] = cmp.mapping(function()
                  if luasnip.expand_or_locally_jumpable() then
                    luasnip.expand_or_jump()
                  end
                end, { 'i', 's' }),
                ['<C-h>'] = cmp.mapping(function()
                  if luasnip.locally_jumpable(-1) then
                    luasnip.jump(-1)
                  end
                end, { 'i', 's' }),

                -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
                --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
                -- Select next/previous item with Tab / Shift + Tab
                ['<Tab>'] = cmp.mapping(function(fallback)
                  if cmp.visible() then
                    cmp.select_next_item()
                  elseif luasnip.expand_or_locally_jumpable() then
                    luasnip.expand_or_jump()
                  else
                    fallback()
                  end
                end, { 'i', 's' }),
                ['<S-Tab>'] = cmp.mapping(function(fallback)
                  if cmp.visible() then
                    cmp.select_prev_item()
                  elseif luasnip.locally_jumpable(-1) then
                    luasnip.jump(-1)
                  else
                    fallback()
                  end
                end, { 'i', 's' }),
              },
              sources = {
                { name = 'luasnip' },
                {
                  name = 'lazydev',
                  -- set group index to 0 to skip loading LuaLS completions as lazydev recommends it
                  group_index = 0,
                },
                { name = 'nvim_lsp' },
                { name = 'buffer' },
                { name = 'path' },
              },
              formatting = {
                fields = { 'kind', 'abbr', 'menu' },
                format = function(entry, vim_item)
                  vim_item.kind = string.format('%s', kind_icons[vim_item.kind])
                  vim_item.menu = ({
                    nvim_lsp = '[LSP]',
                    luasnip = '[Snippet]',
                    buffer = '[Buffer]',
                    path = '[Path]',
                  })[entry.source.name]
                  return vim_item
                end,
              },
            }

            -- Disable cmp for LaTeX
            cmp.setup.filetype({ 'tex', 'plaintex' }, {
              enabled = false,
            })

            -- Buffer-local luasnip keymaps for tex (cmp is disabled there)
            vim.api.nvim_create_autocmd('FileType', {
              pattern = { 'tex', 'plaintex' },
              callback = function()
                local tab = vim.api.nvim_replace_termcodes('<Tab>', true, false, true)
                local stab = vim.api.nvim_replace_termcodes('<S-Tab>', true, false, true)
                vim.keymap.set({ 'i', 's' }, '<Tab>', function()
                  if luasnip.expand_or_locally_jumpable() then
                    luasnip.expand_or_jump()
                  else
                    vim.api.nvim_feedkeys(tab, 'n', false)
                  end
                end, { buffer = true })
                vim.keymap.set({ 'i', 's' }, '<S-Tab>', function()
                  if luasnip.locally_jumpable(-1) then
                    luasnip.jump(-1)
                  else
                    vim.api.nvim_feedkeys(stab, 'n', false)
                  end
                end, { buffer = true })
              end,
            })
      '';
    }
    {
      plugin = vimPlugins.luasnip;
      type = "lua";
      config = ''
        require('luasnip.loaders.from_lua').lazy_load({ paths = { '~/.config/nvim/snippets' } })
        require('luasnip').config.set_config {
          enable_autosnippets = true,
          store_selection_keys = '<Tab>'
        }
      '';
    }
    luaPackages.jsregexp
    {
      plugin = vimPlugins.friendly-snippets;
      type = "lua";
      config = ''
        require('luasnip.loaders.from_vscode').lazy_load()
      '';
    }
    vimPlugins.cmp_luasnip
    vimPlugins.cmp-buffer
    vimPlugins.cmp-path
  ];
}
