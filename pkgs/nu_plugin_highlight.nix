{
  lib,
  rustPlatform,
  fetchFromGitHub,
}:
rustPlatform.buildRustPackage {
  pname = "nu_plugin_highlight";
  version = "1.4.16+0.114.1";

  src = fetchFromGitHub {
    owner = "cptpiepmatz";
    repo = "nu-plugin-highlight";
    rev = "v1.4.16+0.114.1";
    hash = "sha256-0nwz32ECOWzrhq0Uu+Qq4G53RX1AcjpkCdkin581ICY=";
    fetchSubmodules = true;
  };

  cargoHash = "sha256-bJBiCouZ4tY/Sbnrxk04MOG2sQCR876PtumjkpsK5cU=";

  meta = {
    description = "A nushell plugin for syntax highlighting";
    homepage = "https://github.com/cptpiepmatz/nu-plugin-highlight";
    license = lib.licenses.mit;
    mainProgram = "nu_plugin_highlight";
  };
}
