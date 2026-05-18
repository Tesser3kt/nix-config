{
  config,
  pkgs,
  ...
}: {
  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = "pidof hyprlock || hyprlock";
        before_sleep_cmd = "loginctl lock-session";
        after_sleep_cmd = "sleep 1 && hyprctl dispatch dpms on && sleep 0.5 && (pidof hyprlock || hyprlock)";
      };

      listener = [
        # Lock
        {
          timeout = 300;
          on-timeout = "hyprlock";
        }
        # Suspend
        {
          timeout = 1800;
          on-timeout = "systemctl suspend";
        }
      ];
    };
  };
}
