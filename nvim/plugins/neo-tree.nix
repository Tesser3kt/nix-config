{ config, pkgs, ...}:
{
  programs.neovim.plugins = with pkgs.vimPlugins; [
    {
      plugin = nvim-lsp-file-operations;
      type = "lua";
      config = ''
	require("lsp-file-operations").setup({})
      '';
    }
    {
      plugin = nvim-window-picker;
      type = "lua";
      config = ''
	require("window-picker").setup({
	  filter_rules = {
	    include_current_win = false,
	    autoselect_one = true,
	    bo = {
	      filetype = { "neo-tree", "neo-tree-popup", "notify" },
	      buftype = { "terminal", "quickfix" },
	    },
	  },
	})
      '';
    }
    {
      plugin = neo-tree-nvim;
      type = "lua";
      config = ''
	require("neo-tree").setup({
	  clipboard = {
	    sync = "universal",
	  },
	  popup_border_style = "",
	  sort_case_insensitive = true,
	})
      '';
    }
  ];
}
