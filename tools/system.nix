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

    # Volume control
    pwvucontrol
    wireplumber

    # Media control
    playerctl
  ];
}
