{
  config,
  pkgs,
  username,
  ...
}: {
  # Systemd timers
  systemd.user.timers."mailsync" = {
    Unit = {
      Description = "Mail sync timer";
    };
    Install = {
      # WantedBy = ["timers.target"];
      WantedBy = [];
    };
    Timer = {
      OnBootSec = "1min";
      OnUnitActiveSec = "15min";
      Unit = "mailsync.service";
    };
  };

  # Systemd user services
  systemd.user.services."mailsync" = {
    Unit = {
      Description = "Sync mail";
    };
    Install = {
      # WantedBy = ["default.target"];
      WantedBy = [];
    };
    Service = {
      Type = "oneshot";
      ExecStart = "${pkgs.mutt-wizard}/bin/mailsync";
    };
  };
}
