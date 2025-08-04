self: super: {
  sioyek = super.sioyek.overrideAttrs (old: {
    buildInputs = old.buildInputs ++ [super.makeWrapper];
    postFixup = ''
      wrapProgram "$out/bin/sioyek" \
        --set QT_QPA_PLATFORM "xcb"
    '';
  });
}
