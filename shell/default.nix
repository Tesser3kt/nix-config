{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./zsh.nix
    ./alacritty.nix
    ./starship.nix
    ./git.nix
  ];

  home.sessionVariables = {
    # default apps
    EDITOR = "nvim";
    BROWSER = "firefox-beta";
    DEFAULT_BROWSER = "firefox-beta";
    TERMINAL = "alacritty";
    XDG_CONFIG_HOME = "${config.home.homeDirectory}/.config";
    XDG_CACHE_HOME = "${config.home.homeDirectory}/.cache";
  };

  home.shellAliases = {
    update = "sudo nixos-rebuild switch";
  };

  home.packages = with pkgs; [
    nix-index

    # Bash language checking
    shellcheck
    bash-language-server
  ];
}
