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

  # --- khard (reads local vCards) ---
  xdg.configFile."khard/khard.conf".text = ''
    [addressbooks]
      [[personal]]
        path = ${config.home.homeDirectory}/.local/share/contacts/personal/default/
      [[work]]
        path = ${config.home.homeDirectory}/.local/share/contacts/work/default/

    [general]
      editor = nvim
      merge_editor = nvim
  '';

  # --- neomutt: query via khard (works with mutt-wizard) ---
  xdg.configFile."mutt/local.muttrc".text = ''
    set query_command = "khard email --parsable '%s'"
    set query_format  = "%e\t%n"
    bind editor <Tab> complete-query
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
  #   google/work/client_id
  #   google/work/client_secret
  home.activation.writeVdirsyncerConfig = lib.hm.dag.entryAfter ["writeBoundary"] ''
          set -euo pipefail
          umask 077

          cfg="${config.home.homeDirectory}/.config/vdirsyncer/config"
          mkdir -p "$(dirname "$cfg")" \
             "${config.home.homeDirectory}/.local/share/contacts/personal" \
             "${config.home.homeDirectory}/.local/share/contacts/work"

          # Read secrets from pass
          cid_p="$(${pkgs.pass}/bin/pass show google/personal/client_id)"
          sec_p="$(${pkgs.pass}/bin/pass show google/personal/client_secret)"
          cid_w="$(${pkgs.pass}/bin/pass show google/work/client_id)"
          sec_w="$(${pkgs.pass}/bin/pass show google/work/client_secret)"

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
