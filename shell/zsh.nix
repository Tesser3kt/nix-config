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

      function set_custom_title() {
        local title="%~ - zsh"

        if [[ -n "$_LAST_COMMAND" ]]; then
          title="''${_LAST_COMMAND} - zsh"
        fi

        print -Pn "\e]2;''${title}\a"

        print -Pn "\e]1;''${title}\a"
      }
      precmd_functions+=(set_custom_title)

      _LAST_COMMAND=""
      preexec() {
        _LAST_COMMAND="$1"
      }
      precmd() {
        _LAST_COMMAND=""
      }
    '';
    localVariables = {
      DISABLE_AUTO_TITLE = "true";
    };
    sessionVariables = {
      PLAYWRIGHT_BROWSERS_PATH = "${pkgs.playwright.browsers}";
      PLAYWRIGHT_SKIP_VALIDATE_HOST_REQUIREMENTS = true;
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
