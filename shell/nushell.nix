# Zsh shell
{
  config,
  pkgs,
  ...
}: {
  programs.nushell = {
    enable = true;
    settings = {
      show_banner = false;
      completions = {
        case_sensitive = false;
        quick = true;
        partial = true;
        algorithm = "fuzzy";
        external = {
          enable = true;
          max_results = 100;
        };
      };
    };
    shellAliases = {
      update = "sudo nixos-rebuild switch";
      lg = "lazygit";
    };
    environmentVariables = {
      EDITOR = "nvim";
      BROWSER = "zen";
      DEFAULT_BROWSER = "zen";
      TERMINAL = "alacritty";
      XDG_CONFIG_HOME = "${config.home.homeDirectory}/.config";
      XDG_CACHE_HOME = "${config.home.homeDirectory}/.cache";
    };
  };
  programs.carapace = {
    enable = true;
    enableNushellIntegration = true;
  };
  programs.zoxide = {
    enable = true;
    enableNushellIntegration = true;
  };
}
