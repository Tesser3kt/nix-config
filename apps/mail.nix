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
    goobook
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

  # --- goobook configs (independent oauth/cache for each account) ---
  xdg.configFile."goobook-personal.rc".text = ''
    [DEFAULT]
    cache_expiry_hours: 24
    oauth_db_filename:  ~/.config/goobook-personal-oauth.json
    cache_filename:     ~/.cache/goobook-personal-cache
  '';

  xdg.configFile."goobook-work.rc".text = ''
    [DEFAULT]
    cache_expiry_hours: 24
    oauth_db_filename:  ~/.config/goobook-work-oauth.json
    cache_filename:     ~/.cache/goobook-work-cache
  '';

  # --- NeoMutt: per-account lookup using send-hook on From address ---
  # Replace the two emails below with your actual From addresses that mutt-wizard uses.
  xdg.configFile."mutt/local.muttrc".text = ''
    # Common formatting for results
    set query_format = "%e\t%n"
    bind editor <Tab> complete-query

    # Default to personal (used if a hook doesn't match)
    set query_command = "goobook -c ~/.config/goobook-personal.rc query '%s'"

    # When composing from WORK account, switch to work contacts
    send-hook "~f adam.klepac@gevo.cz" \
      "set query_command='goobook -c ~/.config/goobook-work.rc query \"%s\"'"

    # When composing from PERSONAL account, switch to personal contacts
    send-hook "~f djklepy@gmail.com" \
      "set query_command='goobook -c ~/.config/goobook-personal.rc query \"%s\"'"
  '';

  # Ensure mutt-wizard’s main muttrc sources the local include (idempotent)
  home.activation.appendMuttLocal = lib.hm.dag.entryAfter ["writeBoundary"] ''
    file="$HOME/.config/mutt/muttrc"
    mkdir -p "$(dirname "$file")"
    touch "$file"
    grep -q 'source "~/.config/mutt/local.muttrc"' "$file" || \
      printf '\n# Local overrides (Home Manager)\nsource "~/.config/mutt/local.muttrc"\n' >> "$file"
  '';
}
