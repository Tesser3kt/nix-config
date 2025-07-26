{
  boot.loader = {
    efi.canTouchEfiVariables = true;

    systemd-boot = {
      enable = true;

      edk2-uefi-shell.enable = true;
      edk2-uefi-shell.sortKey = "z_edk2";
    };
  };
}
