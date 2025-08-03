{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    # system tools
    sysstat
    lm_sensors
    ethtool
    pciutils
    usbutils

    # system call monitors
    strace
    ltrace
    lsof

    # system monitors
    btop
    iotop
    iftop
    nvtopPackages.full

    # Volume control
    pwvucontrol
    wireplumber
    alsa-utils

    # Media control
    playerctl
    mpd
    waybar-mpris

    # Brightness control
    brightnessctl

    # Network
    networkmanagerapplet

    # Bluetooth
    blueman

    # GTK theme editor
    nwg-look

    # MSI Control Center
    mcontrolcenter

    # Logitech stuff
    solaar
  ];

  services.blueman-applet.enable = false;
}
