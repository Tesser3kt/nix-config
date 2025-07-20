{
  pkgs,
  lib,
  ...
}: {
  # Git config
  programs.git = {
    enable = true;
    userName = "Adam Klepac";
    userEmail = "djklepy@gmail.com";

    extraConfig = {
      credential = {
        helper = ["cache --timeout=21600" "oauth"];
      };
    };
  };

  # Enable git credential oauth
  programs.git-credential-oauth = {
    enable = true;
  };
}
