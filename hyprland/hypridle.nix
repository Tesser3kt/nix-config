{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    hypridle
  ];

  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = "pidof hyprlock || hyprlock";
        before_sleep_cmd = "loginctl lock-session";
        after_sleep_cmd = "hyprctl dispatch dpms on";
      };

      listener = [
        # Lock
        {
          timeout = 300;
          on-timeout = "hyprlock";
        }
        # Suspend
        {
          timeout = 900;
          on-timeout = "systemctl suspend-then-hibernate";
          on-resume = "hyprctl dispatch dpms on";
        }
      ];
    };
  };
}
