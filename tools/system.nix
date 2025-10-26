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

    # Logitech stuff
    solaar

    # HID devices control
    hidapi

    # Dbus explorer
    d-spy

    # Notification library
    libnotify

    # Partition management
    parted
    tparted

    # Raspberry Pi
    (pkgs.callPackage ./pkgs/rpi-imager-appimage.nix {})

    # Crypto
    libsecret

    # Mounting NTFS drives
    ntfs3g
    fuse
  ];

  services.blueman-applet.enable = false;

  # Enable USB automount
  services.udiskie = {
    enable = true;
    settings = {
      program_options = {
        file_manager = "${pkgs.xfce.thunar}/bin/thunar";
      };
    };
  };
}
