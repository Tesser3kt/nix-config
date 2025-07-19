{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    mesa
  ];
}
