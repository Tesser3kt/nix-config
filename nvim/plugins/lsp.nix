{
  config,
  pkgs,
  ...
}: {
  programs.neovim.plugins = with pkgs; [
    {
      plugin = vimPlugins.nvim-lspconfig;
      type = "lua";
      config = ''
          local function lsp_on_attach(client, bufnr)
            local map = function(keys, func, desc, mode)
              mode = mode or 'n'
              vim.keymap.set(mode, keys, func, { buffer = bufnr, desc = 'LSP: ' .. desc })
            end

            map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
            map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
            map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
            map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
            map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
            map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
            map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
            map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction', { 'n', 'x' })
            map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

            if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
              local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
              vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
                buffer = bufnr,
                group = highlight_augroup,
                callback = vim.lsp.buf.document_highlight,
              })
              vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
                buffer = bufnr,
                group = highlight_augroup,
                callback = vim.lsp.buf.clear_references,
              })
              vim.api.nvim_create_autocmd('LspDetach', {
                group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
                callback = function(event2)
                  vim.lsp.buf.clear_references()
                  vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
                end,
              })
            end

            if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
              map('<leader>th', function()
                vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = bufnr })
              end, '[T]oggle Inlay [H]ints')
            end
          end

          _G._lsp_on_attach = lsp_on_attach

          vim.api.nvim_create_autocmd('LspAttach', {
            group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
            callback = function(event)
              lsp_on_attach(vim.lsp.get_client_by_id(event.data.client_id), event.buf)
            end,
          })

        -- LSP servers and clients are able to communicate to each other what features they support.
        -- By default, Neovim doesn't support everything that is in the LSP specification.
        -- When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
        -- So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

        local function find_venv_python(start_path)
          for _, name in ipairs({ '.venv', 'venv', '.virtualenv', 'env' }) do
            local found = vim.fs.find(name, {
              path = start_path,
              upward = true,
              type = 'directory',
            })[1]
            if found then
              for _, py in ipairs({ 'python3', 'python' }) do
                if vim.fn.executable(found .. '/bin/' .. py) == 1 then
                  return found .. '/bin/' .. py
                end
              end
            end
          end
          return nil
        end

        -- Enable the following language servers
        --
        -- Add any additional override configuration in the following tables. Available keys are:
        -- - cmd (table): Override the default command used to start the server
        -- - filetypes (table): Override the default list of associated filetypes for the server
        -- - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
        -- - settings (table): Override the default settings passed when initializing the server.
        local servers = {
          bashls = {
            cmd = { 'bash-language-server', 'start' },
            filetypes = { 'bash', 'sh' }
          },
          ts_ls = {},
          basedpyright = {
            cmd = { 'basedpyright-langserver', '--stdio' },
            filetypes = { 'python' },
            on_attach = function(client, bufnr) _G._lsp_on_attach(client, bufnr) end,
            settings = {
              python = {
                analysis = {
                  autoSearchPaths = true,
                  useLibraryCodeForTypes = true,
                  diagnosticMode = 'openFilesOnly',
                  typeCheckingMode = 'standard',
                },
              },
            },
          },
          html = { filetypes = { 'html', 'twig', 'hbs' } },
          cssls = {
            cmd = { 'vscode-css-language-server', '--stdio' },
          },
          tailwindcss = {},
          dockerls = {},
          sqls = {},
          jsonls = {},
          yamlls = {},
          lua_ls = {
            settings = {
              Lua = {
                completion = {
                  callSnippet = 'Replace',
                },
                runtime = { version = 'LuaJIT' },
                workspace = {
                  checkThirdParty = false,
                  library = vim.api.nvim_get_runtime_file("", true),
                },
                diagnostics = {
                  globals = { 'vim' },
                  disable = { 'missing-fields' },
                },
                format = {
                  enable = false,
                },
              },
            },
          },
          marksman = {},
          clangd = {},
          eslint = {},
          nil_ls = {},
          texlab = {},
          svelte = {},
          tinymist = {},
          qmlls = {},
          hls = {}
        }

        vim.api.nvim_create_autocmd('FileType', {
          pattern = 'python',
          callback = function(args)
            if #vim.lsp.get_clients({ name = 'basedpyright' }) > 0 then
              return
            end
            local bufname = vim.api.nvim_buf_get_name(args.buf)
            local start = bufname ~= "" and vim.fs.dirname(bufname) or vim.fn.getcwd()
            local python_path = find_venv_python(start)
            if python_path then
              servers.basedpyright.settings.python.pythonPath = python_path
            end
            servers.basedpyright.capabilities = vim.tbl_deep_extend('force', {}, capabilities, servers.basedpyright.capabilities or {})
            vim.lsp.config('basedpyright', servers.basedpyright)
            vim.lsp.enable('basedpyright')
          end,
        })

        for server, cfg in pairs(servers) do
          if server ~= 'basedpyright' then
            -- For each LSP server (cfg), we merge:
            -- 1. A fresh empty table (to avoid mutating capabilities globally)
            -- 2. Your capabilities object with Neovim + cmp features
            -- 3. Any server-specific cfg.capabilities if defined in `servers`
            cfg.capabilities = vim.tbl_deep_extend('force', {}, capabilities, cfg.capabilities or {})

            vim.lsp.config(server, cfg)
            vim.lsp.enable(server)
          end
        end;
      '';
    }
    {
      plugin = vimPlugins.fidget-nvim;
      type = "lua";
      config = ''
        require('fidget').setup {
            notification = {
                window = {
                    winblend = 0,
                },
            },
        }
      '';
    }
    vimPlugins.cmp-nvim-lsp
    vimPlugins.mason-nvim
    vimPlugins.mason-lspconfig-nvim

    vscode-langservers-extracted
    bash-language-server
    marksman
    nil
    docker-language-server
    emmet-language-server
    lua-language-server
    basedpyright
    sqls
    tailwindcss-language-server
    texlab
    typescript-language-server
    tinymist
    arduino-language-server
    clang-tools
    haskell-language-server
    svelte-language-server
    yaml-language-server
  ];
}
