{
  config,
  pkgs,
  ...
}: {
  programs.neovim.initLua = ''
    -- General vimtex options
    vim.g.vimtex_view_method = "zathura"
    vim.g.vimtex_view_general_viewer = "zathura"
    vim.g.vimtex_fold_enabled = 1
    vim.g.vimtex_format_enabled = 1
    vim.g.tex_conceal = "abdgm"
    vim.g.conceallevel = 2
    vim.g.tex_conceal_frac = 1
    vim.g.tex_superscripts = 1
    vim.g.tex_subscripts = 1

    -- TeX local settings
    vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
      pattern = { "*.tex", "*.bib" },
      callback = function()
        vim.opt_local.shiftwidth = 2
        vim.opt_local.spell = true
        vim.opt_local.spelllang = "csa"
        vim.opt_local.textwidth = 80
        vim.opt_local.wrapmargin = 2
        vim.opt_local.formatoptions = "tcq"
        vim.opt_local.colorcolumn = "81"

        -- add item on Enter in itemize/enumerate/description
        vim.cmd [[
          function! AddItem()
            let [end_lnum, end_col] = searchpairpos('\\begin{", "", '\\end{', 'nW')
            if match(getline(end_lnum), '\(itemize\|enumerate\|description\)') != -1
              return "\\item "
            else
              return ""
            endif
          endfunction
          inoremap <expr><buffer> <CR> getline('.') =~ '\item $'
            \ ? '<c-w><c-w>'
            \ : (col(".") < col("$") ? '<CR>' : '<CR>'.AddItem() )
          nnoremap <expr><buffer> o "o".AddItem()
          nnoremap <expr><buffer> O "O".AddItem()
        ]]
      end,
    })
  '';
}
