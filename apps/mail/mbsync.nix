{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.mbsync = {
    enable = true;
    extraConfig = ''
      # Global settings
      Create Both
      Expunge Both
      SyncState *

      # Account definition
      IMAPAccount personal
      Host 127.0.0.1
      Port 1143
      User djklepy@pm.me
      PassCmd "pass email/djklepy@pm.me"
      TLSType STARTTLS

      # Remote store
      IMAPStore personal-remote
      Account personal

      # Local store
      MaildirStore personal-local
      SubFolders Verbatim
      Path ~/.mail/personal/
      Inbox ~/.mail/personal/INBOX

      # Channel (sync definition)
      Channel personal
      Far :personal-remote:
      Near :personal-local:
      Patterns *
    '';
  };
  services.mbsync = {
    enable = true;
    frequency = "*:0/5";
  };
}
