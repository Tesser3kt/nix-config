{
  config,
  pkgs,
  username,
  ...
}: {
  # Systemd timers
  systemd.user.timers."mailsync" = {
    enable = true;
    description = "Sync mail every 15 minutes";
    wantedBy = ["timers.target"];
    timerConfig = {
      OnBootSec = "1min";
      OnUnitActiveSec = "15min";
      Unit = "mailsync.service";
      Persistent = true;
    };
  };

  # Systemd user services
  systemd.user.services."mailsync" = {
    enable = false;
    Unit = {
      Description = "Sync mail";
    };
    Install = {
      WantedBy = ["default.target"];
    };
    Service = {
      Type = "oneshot";
      ExecStart = "${pkgs.mutt-wizard}/bin/mailsync";
    };
  };
}
