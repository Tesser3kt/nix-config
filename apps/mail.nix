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

  # Neomutt config for goobook
  xdg.configFile."mutt/local-djklepy.muttrc".text = ''
    set query_command = "goobook -c ~/.config/goobook-personal.rc query '%s'"
    set query_format  = "%e\t%n"
    bind editor <Tab> complete-query
  '';
  xdg.configFile."mutt/local-gevo.muttrc".text = ''
    set query_command = "goobook -c ~/.config/goobook-work.rc query '%s'"
    set query_format  = "%e\t%n"
    bind editor <Tab> complete-query
  '';

  # Append a source line to mutt-wizard's muttrc, idempotently
  home.activation.appendMuttLocal = lib.hm.dag.entryAfter ["writeBoundary"] ''
    file="$HOME/.config/mutt/accounts/djklepy@gmail.com.muttrc"
    mkdir -p "$(dirname "$file")"
    touch "$file"
    if ! grep -q 'source "~/.config/mutt/local-djklepy.muttrc"' "$file"; then
      printf '\n# HM include: local overrides\nsource "~/.config/mutt/local-djklepy.muttrc"\n' >> "$file"
    fi

    file="$HOME/.config/mutt/accounts/adam.klepac@gevo.cz.muttrc"
    mkdir -p "$(dirname "$file")"
    touch "$file"
    if ! grep -q 'source "~/.config/mutt/local-gevo.muttrc"' "$file"; then
      printf '\n# HM include: local overrides\nsource "~/.config/mutt/local-gevo.muttrc"\n' >> "$file"
    fi
  '';
}
