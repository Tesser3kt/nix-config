{
  config,
  pkgs,
  ...
}: let
  colors = import ../nordic.nix;
in {
  services.mako.settings = {
    sort = "-time";
    background-color = colors.gray1;
    text-color = colors.white0;
    progress-color = "over ${colors.cyan}";
    layer = "overlay";
    width = 400;
    height = 150;
    border-size = 2;
    border-color = colors.gray3;
    border-radius = 10;
    max-visible = 3;
    max-history = 5;
    on-button-left = "invoke-default-action";
    on-button-middle = "dismiss-group";
    on-button-right = "dismiss";
    on-notify = "exec mpv $HOME/Music/notification.wav";
    padding = 10;
    font = "Hurmit Nerd Font 12";
    max-icon-size = 64;
    margin = 5;
    icons = 1;
    icon-location = "left";
    actions = 1;
    text-alignment = "left";
    default-timeout = 5000;
    ignore-timeout = 0;
    anchor = "top-right";
  };
  services.mako.extraConfig = ''
    [urgency=low]
    border-color=${colors.blue0}

    [urgency=normal]
    border-color=${colors.yellow}

    [urgency=high]
    border-color=${colors.red}
  '';
}
