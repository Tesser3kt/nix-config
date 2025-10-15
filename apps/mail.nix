{
  config,
  pkgs,
  lib,
  gpgKeygrip,
  ...
}: {
  home.packages = with pkgs; [
    neomutt
    mutt-wizard
    isync
    msmtp
    pass
    gettext
    lynx
    notmuch
    abook
    urlscan
    cronie
    mpop
    goimapnotify
    khard
    vdirsyncer
  ];

  # GPG agent configuration
  home.file.".pam-gnupg".text = gpgKeygrip;
  services.gpg-agent = {
    enable = true;
    extraConfig = ''
      allow-preset-passphrase
      max-cache-ttl 86400
    '';
  };

  # Enable IMAP notify
  services.imapnotify = {
    enable = true;
    path = with pkgs; [
      notmuch
      libnotify
      isync
    ];
  };

  # --- vdirsyncer config (two Google accounts) ---
  xdg.configFile."vdirsyncer/config".text = ''
    [general]
    status_path = "~/.local/share/vdirsyncer/status/"

    ############# PERSONAL #############
    [pair personal-contacts]
    a = "personal-local"
    b = "personal-google"
    collections = [ "from b" ]
    metadata = [ "displayname" ]

    [storage personal-local]
    type = "filesystem"
    path = "~/.local/share/contacts/personal/"
    fileext = ".vcf"

    [storage personal-google]
    type = "carddav"
    url = "https://www.googleapis.com/carddav/v1/principals/djklepy@gmail.com/lists/default/"
    username = "djklepy@gmail.com"
    # Use an App Password; vdirsyncer 0.22+ syntax:
    passwordeval = "pass show google/app-password-personal"

    ############# WORK #############
    [pair work-contacts]
    a = "work-local"
    b = "work-google"
    collections = [ "from b" ]
    metadata = [ "displayname" ]

    [storage work-local]
    type = "filesystem"
    path = "~/.local/share/contacts/work/"
    fileext = ".vcf"

    [storage work-google]
    type = "carddav"
    url = "https://www.googleapis.com/carddav/v1/principals/adam.klepac@gevo.cz/lists/default/"
    username = "adam.klepac@gevo.cz"
    passwordeval = "pass show google/app-password-work"
  '';

  # --- khard reads both addressbooks ---
 # --- khard: write the INI directly (don’t use programs.khard.settings) ---
  xdg.configFile."khard/khard.conf".text = ''
    # khard >= 0.13 config
    [addressbooks]
      [[personal]]
        path = ~/.local/share/contacts/personal/
      [[work]]
        path = ~/.local/share/contacts/work/

    [general]
      editor = nvim
      merge_editor = nvim

    [display]
      # khard email --parsable prints "email<TAB>name"
      # (no extra tuning needed for neomutt)
  '';

  # --- NeoMutt: local query via khard (works with mutt-wizard) ---
  xdg.configFile."mutt/local.muttrc".text = ''
    set query_command = "khard email --parsable '%s'"
    set query_format  = "%e\t%n"
    bind editor <Tab> complete-query
  '';

  # Ensure mutt-wizard loads our local include exactly once
  home.activation.appendMuttLocal = lib.hm.dag.entryAfter ["writeBoundary"] ''
    file="$HOME/.config/mutt/muttrc"
    mkdir -p "$(dirname "$file")"
    touch "$file"
    grep -q 'source "~/.config/mutt/local.muttrc"' "$file" || \
      printf '\n# Local overrides (Home Manager)\nsource "~/.config/mutt/local.muttrc"\n' >> "$file"
  '';

  # --- Optional: run vdirsyncer periodically (hourly) ---
  systemd.user.timers.vdirsyncer-hourly = {
    Unit.Description = "vdirsyncer contacts sync (daily)";
    Timer = {
      OnCalendar = "daily";
      Persistent = true;
    };
    Install.WantedBy = ["timers.target"];
  };
  systemd.user.services.vdirsyncer-hourly = {
    Unit.Description = "vdirsyncer contacts sync";
    Service = {
      Type = "oneshot";
      ExecStart = "${pkgs.vdirsyncer}/bin/vdirsyncer sync";
    };
    Install.WantedBy = ["default.target"];
  };
}
