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

  # --- PERSONAL: khard (local vCards) ---
  # Point to your *personal* vdirsyncer location (absolute paths; khard doesn't recurse)
  xdg.configFile."khard/personal.conf".text = ''
    [addressbooks]
      [[personal]]
        path = ${config.home.homeDirectory}/.local/share/contacts/personal/default/

    [general]
      editor = nvim
      merge_editor = nvim
  '';

  # WORK: khard reading your manually-maintained vCards
  xdg.configFile."khard/work.conf".text = ''
    [addressbooks]
      [[work_directory]]
        path = ${config.home.homeDirectory}/.local/share/contacts/work/default/

    [general]
      editor = nvim
      merge_editor = nvim
  '';

  xdg.configFile."mutt/personal-addressbook.muttrc".text = ''
    set query_format = "%e\t%n"
    set query_command = "khard -c ${config.home.homeDirectory}/.config/khard/personal.conf email --parsable '%s' 2>/dev/null"
    bind editor <Tab> complete-query
  '';
  xdg.configFile."mutt/work-addressbook.muttrc".text = ''
    set query_format = "%e\t%n"
    set query_command = "khard -c ${config.home.homeDirectory}/.config/khard/work.conf email --parsable '%s' 2>/dev/null"
  '';

  xdg.configFile."mutt/local.muttrc".text = ''
    set query_format = "%e\t%n"
    bind editor <Tab> complete-query
    # no global set query_command here
  '';

  # Append a source line to each account file exactly once
  home.activation.muttWizardPerAccountIncludes = lib.hm.dag.entryAfter ["writeBoundary"] ''
    set -euo pipefail
    acct_personal="${config.home.homeDirectory}/.config/mutt/accounts/djklepy@gmail.com.muttrc"   # e.g. personal.muttrc
    acct_work="${config.home.homeDirectory}/.config/mutt/accounts/adam.klepac@gevo.cz.muttrc"     # e.g. work.muttrc

    add_source () {
      file="$1"; include="$2"
      mkdir -p "$(dirname "$file")"
      touch "$file"
      grep -Fq "source \"$include\"" "$file" || printf '\nsource "%s"\n' "$include" >> "$file"
    }

    add_source "$acct_personal" "${config.home.homeDirectory}/.config/mutt/personal-addressbook.muttrc"
    add_source "$acct_work"     "${config.home.homeDirectory}/.config/mutt/work-addressbook.muttrc"
  '';

  home.activation.appendMuttLocal = lib.hm.dag.entryAfter ["writeBoundary"] ''
    file="${config.home.homeDirectory}/.config/mutt/muttrc"
    mkdir -p "$(dirname "$file")"
    touch "$file"
    grep -q 'source "${config.home.homeDirectory}/.config/mutt/local.muttrc"' "$file" || \
      printf '\n# Local overrides (Home Manager)\nsource "${config.home.homeDirectory}/.config/mutt/local.muttrc"\n' >> "$file"
  '';

  # --- vdirsyncer config from pass (NO secrets in Nix store) ---
  # pass entries you will create:
  #   google/personal/client_id
  #   google/personal/client_secret
  home.activation.writeVdirsyncerConfig = lib.hm.dag.entryAfter ["writeBoundary"] ''
          set -euo pipefail
          umask 077

          cfg="${config.home.homeDirectory}/.config/vdirsyncer/config"
          mkdir -p "$(dirname "$cfg")" \
             "${config.home.homeDirectory}/.local/share/contacts/personal" \

          # Read secrets from pass
          cid_p="$(${pkgs.pass}/bin/pass show google/personal/client_id)"
          sec_p="$(${pkgs.pass}/bin/pass show google/personal/client_secret)"

          cat > "$cfg" <<'CFG'
    [general]
    status_path = "${config.home.homeDirectory}/.local/share/vdirsyncer/status/"

    [pair personal_contacts]
    a = "personal_local"
    b = "personal_google"
    collections = [ "from b" ]
    metadata = [ "displayname" ]

    [storage personal_local]
    type = "filesystem"
    path = "${config.home.homeDirectory}/.local/share/contacts/personal/"
    fileext = ".vcf"

    [storage personal_google]
    type = "google_contacts"
    token_file = "${config.home.homeDirectory}/.config/vdirsyncer/google-personal.token"
    client_id = "__CID_P__"
    client_secret = "__SEC_P__"

    CFG

          # Substitute secrets safely
          sed -i \
            -e "s|__CID_P__|$cid_p|g" \
            -e "s|__SEC_P__|$sec_p|g" \
            "$cfg"
  '';

  # Optional: hourly sync
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
  };
}
