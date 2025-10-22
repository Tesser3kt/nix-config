{
  pkgs,
  lib,
  ...
}: {
  # Git config
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Adam Klepáč";
        email = "djklepy@gmail.com";
      };
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
