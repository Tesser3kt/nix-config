# Zsh shell
{ config, pkgs, ... }:
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    history.size = 10000;
    initContent = ''
      # Enable starship
      eval "$(starship init zsh)"
      
      # Path
      export PATH="$HOME/bin:$HOME/.local/bin:$HOME/.cargo/bin:$PATH"

      # Pay respects
      eval "$(pay-respects zsh --alias)"
    '';

    # Oh My Zsh disabled. Starship enabled.
    oh-my-zsh = {
      enable = false;
      plugins = [
        "git"
        "npm"
        "node"
        "history-substring-search"
        "docker"
        "virtualenv"
        "web-search"
        "extract"
        "docker-compose"
        "z"
        "fzf"
        "colored-man-pages"
      ];
    };
  };
}
