{
  config,
  pkgs,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
    font-awesome
    nerd-fonts._0xproto
    nerd-fonts.adwaita-mono
    nerd-fonts.anonymice
    nerd-fonts.caskaydia-cove
    nerd-fonts.caskaydia-mono
    nerd-fonts.droid-sans-mono
    nerd-fonts.fira-code
    nerd-fonts.fira-mono
    nerd-fonts.hurmit
    nerd-fonts.inconsolata
    nerd-fonts.iosevka
    nerd-fonts.jetbrains-mono
    nerd-fonts.martian-mono
    nerd-fonts.monaspace
    nerd-fonts.roboto-mono
    nerd-fonts.space-mono
    nerd-fonts.ubuntu-mono
    nerd-fonts.victor-mono
    nerd-fonts.zed-mono
    source-code-pro
    source-sans-pro
    palatino-font
    eb-garamond
  ];
  fonts.fontconfig.enable = true;

  # Copy Garamond Math to ~/.local/share/fonts
  home.file.".local/share/fonts/Garamond-Math.otf".source = ./Garamond-Math.otf;

  # Copy Prenton to ~/.local/share/fonts
  home.file.".local/share/fonts/Prenton-Regular.otf".source = ./Prenton-Regular.otf;
  home.file.".local/share/fonts/Prenton-Italic.otf".source = ./Prenton-Italic.otf;
}
