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
    wantedBy = ["default.target"];
    script = "/etc/profiles/per-user/tesserekt/bin/mailsync";
    serviceConfig = {
      Type = "oneshot";
      User = "tesserekt";
    };
  };
}
