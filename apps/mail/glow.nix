{config, ...}: {
  xdg.configFile."glow/glow.yml".text = ''
    # style name or JSON path (default "auto")

    style: "${config.home.homeDirectory}/.config/glow/catppuccin-mocha.json"
    # show local files only; no network (TUI-mode only)
    local: false
    # mouse support (TUI-mode only)
    mouse: false
    # use pager to display markdown
    pager: false
    # word-wrap at width
    width: 80
  '';

  xdg.configFile."glow/catppuccin-mocha.json" = {
    source = ./glow/catppuccin-mocha.json;
    force = true;
  };
}
