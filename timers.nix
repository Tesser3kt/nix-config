{
  config,
  pkgs,
  ...
}: {
  # Systemd timers
  # systemd.timers."mailsync" = {
  #   description = "Sync mail every 15 minutes";
  #   wantedBy = ["timers.target"];
  #   timerConfig = {
  #     OnBootSec = "1min";
  #     OnUnitActiveSec = "15min";
  #     Unit = "mailsync.service";
  #   };
  # };
  systemd.services."mailsync" = {
    description = "Sync mail";
    wantedBy = ["default.target"];
    script = "/home/tesserekt/mailsync";
    serviceConfig = {
      Type = "oneshot";
      User = "tesserekt";
    };
  };

  # Disable cron service
  services.cron = {
    enable = false;
  };
}
