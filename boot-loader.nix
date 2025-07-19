{
  boot.loader = {
    efi.canTouchEfiVariables = true;

    systemd-boot = {
      enable = true;

      windows = {
        "windows" = 
	  let 
	    boot-drive = "FS1";
	  in 
	  {
	    title = "Windows";
	    efiDeviceHandle = boot-drive;
	    sortKey = "y_windows";
	  };
      };

      edk2-uefi-shell.enable = true;
      edk2-uefi-shell.sortKey = "z_edk2";
    };
  };
}
