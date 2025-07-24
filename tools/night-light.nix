{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    gammastep
  ];

  services.gammastep = {
    enable = true;
    provider = "manual";
    latitude = 50.088;
    longitude = 14.42076;
    temperature = {
      day = 6500;
      night = 3500;
    };
  };
}
