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
    openldap
    gawk
    (pkgs.writeShellScriptBin "work-ldap-query" ''
      set -euo pipefail
      q="''${1:-}"
      # Workspace Secure LDAP certs (put your real files here)
      export LDAPTLS_CERT="${config.home.homeDirectory}/.config/ldap/google/client.crt"
      export LDAPTLS_KEY="${config.home.homeDirectory}/.config/ldap/google/client.key"

      BASE_DN="dc=gevo,dc=cz"   # <-- CHANGE THIS to your org's base DN

      # Ask for common name/e-mail fields; -LLL gives clean LDIF, -Y EXTERNAL uses client cert auth
      ${pkgs.openldap}/bin/ldapsearch -LLL -H ldaps://ldap.google.com:636 -Y EXTERNAL \
        -b "$BASE_DN" "(|(mail=*''${q}*)(cn=*''${q}*)(givenName=*''${q}*)(sn=*''${q}*))" mail cn givenName sn 2>/dev/null \
        | awk '
            BEGIN{ FS=": "; email=""; cn=""; gn=""; sn="" }
            /^mail: /{ email=$2; next }
            /^cn: /  { cn=$2; next }
            /^givenName: /{ gn=$2; next }
            /^sn: /  { sn=$2; next }
            /^$/{
              if (email!="") {
                name = (cn!=""?cn: ( (gn!=""||sn!="") ? (gn " " sn) : "" ))
                print email "\t" name
              }
              email=""; cn=""; gn=""; sn=""
            }
            END{
              # flush last entry if no trailing blank line
              if (email!="") {
                name = (cn!=""?cn: ( (gn!=""||sn!="") ? (gn " " sn) : "" ))
                print email "\t" name
              }
            }' \
        | ${pkgs.gawk}/bin/awk -F'\t' '!seen[tolower($1)]++'    # dedupe by e-mail
    '')
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

  # --- neomutt: query via khard (works with mutt-wizard) ---
  # --- NeoMutt: per-account query switching ---
  xdg.configFile."mutt/local.muttrc".text = ''
    set query_format = "%e\t%n"
    bind editor <Tab> complete-query

    # Default to PERSONAL contacts via khard
    set query_command = "khard -c ${config.home.homeDirectory}/.config/khard/personal.conf email --parsable '%s' 2>/dev/null"

    # When composing from WORK identity, switch to LDAP
    # (replace with your actual From address used by mutt-wizard)
    send-hook "~f adam.klepac@gevo.cz" \
      "set query_command='work-ldap-query \"%s\"'"

    # When composing from PERSONAL, ensure personal contacts
    send-hook "~f djklepy@gmail.com" \
      "set query_command='khard -c ${config.home.homeDirectory}/.config/khard/personal.conf email --parsable \"%s\" 2>/dev/null'"
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

    [pair work_contacts]
    a = "work_local"
    b = "work_google"
    collections = [ "from b" ]
    metadata = [ "displayname" ]

    [storage work_local]
    type = "filesystem"
    path = "${config.home.homeDirectory}/.local/share/contacts/work/"
    fileext = ".vcf"

    [storage work_google]
    type = "google_contacts"
    token_file = "${config.home.homeDirectory}/.config/vdirsyncer/google-work.token"
    client_id = "__CID_W__"
    client_secret = "__SEC_W__"
    CFG

          # Substitute secrets safely
          sed -i \
            -e "s|__CID_P__|$cid_p|g" \
            -e "s|__SEC_P__|$sec_p|g" \
            -e "s|__CID_W__|$cid_w|g" \
            -e "s|__SEC_W__|$sec_w|g" \
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
