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
