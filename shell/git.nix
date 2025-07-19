{ pkgs, lib, ... }:
{
  # Git config
  programs.git = {
    enable = true;
    userName = "Adam Klepac";
    userEmail = "djklepy@gmail.com";

    extraConfig = {
      credential = {
	helper = lib.mkDefault "store";
      };
    };
  };

  # Enable git credential oauth
  programs.git-credential-oauth = {
    enable = true;
  };
}
