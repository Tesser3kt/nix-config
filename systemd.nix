{
  config,
  pkgs,
  username,
  ...
}: {
  # Systemd timers
  systemd.user.timers."mailsync" = {
    enable = true;
    Unit = {
      Description = "Mail sync timer";
      After = ["network.target"];
      Requires = ["network.target"];
    };
    Install = {
      WantedBy = ["timers.target"];
    };
    Timer = {
      OnBootSec = "1min";
      OnUnitActiveSec = "15min";
      Unit = "mailsync.service";
      Persistent = true;
    };
  };

  # Systemd user services
  systemd.user.services."mailsync" = {
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
