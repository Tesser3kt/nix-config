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
    description = "Sync mail";
    wantedBy = ["default.target"];
    script = "${pkgs.mutt-wizard}/bin/mailsync";
    serviceConfig = {
      Type = "oneshot";
      User = username;
    };
  };
}
