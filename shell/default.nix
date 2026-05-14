{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./nushell.nix
    ./alacritty.nix
    ./ghostty.nix
    ./starship.nix
    ./fastfetch.nix
    ./git.nix
  ];

  home.sessionVariables = {
    # default apps
    EDITOR = "nvim";
    BROWSER = "zen";
    DEFAULT_BROWSER = "zen";
    TERMINAL = "ghostty";
    XDG_CONFIG_HOME = "${config.home.homeDirectory}/.config";
    XDG_CACHE_HOME = "${config.home.homeDirectory}/.cache";
  };

  home.shellAliases = {
    update = "sudo nixos-rebuild switch";
    lg = "lazygit";
  };

  home.packages = with pkgs; [
    nix-index

    # Bash language checking
    shellcheck
    bash-language-server
  ];
}
