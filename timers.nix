{
  config,
  pkgs,
  username,
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
}
