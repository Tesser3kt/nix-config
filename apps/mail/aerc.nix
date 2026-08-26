{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.aerc = {
    enable = true;
    extraConfig = {
      general = {
        unsafe-accounts-conf = true;
      };
    };
    extraAccounts = {
      Personal = {
        source = "maildir://~/.mail/personal";
        outgoing = "smtp://djklepy%40pm.me@127.0.0.1:1025";
        outgoing-cred-cmd = "pass email/djklepy@pm.me";
        default = "Inbox";
        from = "Adam Klepáč <djklepy@pm.me>";
        copy-to = "Sent";
      };
    };
  };
}
