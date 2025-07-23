# Zsh shell
{
  config,
  pkgs,
  ...
}: {
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
    localVariables = {
        DISABLE_AUTO_TITLE = true;
    };

    # Oh My Zsh
    oh-my-zsh = {
      enable = true;
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
