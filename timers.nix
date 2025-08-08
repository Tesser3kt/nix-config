{
  config,
  pkgs,
  ...
}: {
  # Systemd timers
  systemd.timers."mailsync" = {
    description = "Sync mail every 15 minutes";
    wantedBy = ["timers.target"];
    timerConfig = {
      OnBootSec = "1min";
      OnUnitActiveSec = "15min";
      Unit = "mailsync.service";
    };
  };
  systemd.services."mailsync" = {
    description = "Sync mail";
    after = ["network.target"];
    wantedBy = ["default.target"];
    script = "mailsync";
    serviceConfig = {
      Type = "oneshot";
    };
  };
}
