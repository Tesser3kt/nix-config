{
  config,
  pkgs,
  ...
}: {
  programs.neovim.extraConfig = ''
    let g:mapleader = "\<Space>"
    let g:maplocalleader = "\<Space>"
  '';

  programs.neovim.initLua = ''
    vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true }) -- Disable default space behavior

    -- File management
    vim.keymap.set("n", "<leader>w", ":w<CR>", { desc = "Save current buffer.", noremap = true, silent = true })
    vim.keymap.set("n", "<C-s>", ":w<CR>", { desc = "Save current buffer.", noremap = true, silent = true })
    vim.keymap.set("n", "<leader>sn", ":noautocmd w<CR>", { desc = "Save file without formatting.", noremap = true, silent = true })

    -- Clipboard mappings
    vim.keymap.set({ "n", "v" }, "<leader>y", '"+y', { desc = "Yank to system clipboard", noremap = true, silent = true })
    vim.keymap.set("n", "<leader>Y", '"+Y', { desc = "Yank line to system clipboard", noremap = true, silent = true })
    vim.keymap.set({ "n", "v" }, "<leader>p", '"+p', { desc = "Paste from system clipboard", noremap = true, silent = true })
    vim.keymap.set({ "n", "v" }, "<leader>P", '"+P', { desc = "Paste before from system clipboard", noremap = true, silent = true })

    vim.keymap.set("n", "x", '"_x', { desc = "Delete single character without copying", noremap = true, silent = true })

    -- Vertical scroll and center
    vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Keep cursor centered when scrolling down", noremap = true, silent = true })
    vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Keep cursor centered when scrolling up", noremap = true, silent = true })

    -- Find and center
    vim.keymap.set("n", "n", "nzzzv", { desc = "Keep cursor center when searching down", noremap = true, silent = true })
    vim.keymap.set("n", "N", "Nzzzv", { desc = "Keep cursor center when searching up", noremap = true, silent = true })

    -- Resize with arrows
    vim.keymap.set("n", "<Up>", ":resize -2<CR>", { desc = "Horizontal resize -", noremap = true, silent = true })
    vim.keymap.set("n", "<Down>", ":resize +2<CR>", { desc = "Horizontal resize +", noremap = true, silent = true })
    vim.keymap.set("n", "<Left>", ":vertical resize -2<CR>", { desc = "Vertical resize -", noremap = true, silent = true })
    vim.keymap.set("n", "<Right>", ":vertical resize +2<CR>", { desc = "Vertical resize +", noremap = true, silent = true })

    -- Buffer mappings
    vim.keymap.set("n", "<Tab>", ":bnext<CR>", { desc = "Next buffer", noremap = true, silent = true })
    vim.keymap.set("n", "<S-Tab>", ":bprevious<CR>", { desc = "Previous buffer", noremap = true, silent = true })
    vim.keymap.set("n", "<leader>x", ":Bdelete!<CR>", { desc = "Close buffer", noremap = true, silent = true })
    vim.keymap.set("n", "<leader>b", ":enew<CR>", { desc = "New buffer", noremap = true, silent = true })

    -- Window management
    vim.keymap.set("n", "<leader>v", "<C-w>v", { desc = "Vertical split", noremap = true, silent = true })
    vim.keymap.set("n", "<leader>h", "<C-w>s", { desc = "Horizontal split", noremap = true, silent = true })
    vim.keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make split windows the same size", noremap = true, silent = true })
    vim.keymap.set("n", "<leader>q", ":close<CR>", { desc = "Close window", noremap = true, silent = true })

    -- Window navigation
    vim.keymap.set("n", "<C-k>", ":wincmd k<CR>", { desc = "Focus window to the top", noremap = true, silent = true })
    vim.keymap.set("n", "<C-j>", ":wincmd j<CR>", { desc = "Focus window to the bottom", noremap = true, silent = true })
    vim.keymap.set("n", "<C-h>", ":wincmd h<CR>", { desc = "Focus window to the left", noremap = true, silent = true })
    vim.keymap.set("n", "<C-l>", ":wincmd l<CR>", { desc = "Focus window to the right", noremap = true, silent = true })

    -- Tabs
    vim.keymap.set("n", "<leader>to", ":tabnew<CR>", { desc = "Open new tab", noremap = true, silent = true })
    vim.keymap.set("n", "<leader>tx", ":tabclose<CR>", { desc = "Close current tab", noremap = true, silent = true })
    vim.keymap.set("n", "<leader>tn", ":tabn<CR>", { desc = "Go to next tab", noremap = true, silent = true })
    vim.keymap.set("n", "<leader>tp", ":tabp<CR>", { desc = "Go to previous tab", noremap = true, silent = true })

    -- Toggle line wrapping
    vim.keymap.set("n", "<leader>lw", ":set wrap!<CR>", { desc = "Toggle line wrapping", noremap = true, silent = true })

    -- Stay in indent mode
    vim.keymap.set("v", "<", "<gv", { desc = "Stay in indent mode", noremap = true, silent = true })
    vim.keymap.set("v", ">", ">gv", { desc = "Stay in indent mode", noremap = true, silent = true })

    -- Keep last yanked when pasting
    vim.keymap.set("v", "p", '"_dP', { desc = "Keep last yanked when pasting", noremap = true, silent = true })

    -- Diagnostic keymaps
    vim.keymap.set("n", "[d", function()
      vim.diagnostic.jump { count = -1, float = true }
    end, { desc = "Go to previous diagnostic message" })

    vim.keymap.set("n", "]d", function()
      vim.diagnostic.jump { count = 1, float = true }
    end, { desc = "Go to next diagnostic message" })

    vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
    vim.keymap.set("n", "<leader>dl", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })

    -- Terminal
    vim.keymap.set("n", "<leader>\\", ":sp | resize 20 | terminal<CR>", { desc = "New horizontal terminal", noremap = true, silent = true })
    vim.keymap.set("n", "<leader>|", ":vsp | terminal<CR>", { desc = "New vertical terminal", noremap = true, silent = true })
    vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit terminal", noremap = true, silent = true })
    vim.keymap.set("t", "<C-k>", "<C-\\><C-n><C-w>k", { desc = "Focus window to the top", noremap = true, silent = true })
    vim.keymap.set("t", "<C-j>", "<C-\\><C-n><C-w>j", { desc = "Focus window to the bottom", noremap = true, silent = true })
    vim.keymap.set("t", "<C-h>", "<C-\\><C-n><C-w>h", { desc = "Focus window to the left", noremap = true, silent = true })
    vim.keymap.set("t", "<C-l>", "<C-\\><C-n><C-w>l", { desc = "Focus window to the right", noremap = true, silent = true })

    -- Spelling
    vim.keymap.set("i", "<C-l>", "<c-g>u<Esc>[s1z=`]a<c-g>u", { desc = "Correct last spelling mistake.", noremap = true, silent = true })

    -- Command line
    vim.keymap.set("n", ":", ":FineCmdline<CR>", { desc = "Remap : to fine command line", noremap = true, silent = true })
  '';
}
