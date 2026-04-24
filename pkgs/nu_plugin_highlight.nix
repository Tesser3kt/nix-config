{
  lib,
  rustPlatform,
  fetchFromGitHub,
}:
rustPlatform.buildRustPackage {
  pname = "nu_plugin_highlight";
  version = "1.4.13+0.111.0";

  src = fetchFromGitHub {
    owner = "cptpiepmatz";
    repo = "nu-plugin-highlight";
    rev = "9f3bb51a92413e1296fff7d3a301c99f4f8e0bc2";
    hash = "sha256-vPQgg5A7e+S9SzgscicmcwLhvusWT9+5GoTImiW0pQ4=";
    fetchSubmodules = true;
  };

  cargoHash = "sha256-56u6Yaz5YZNJTXYlb3xZiaGYB5Lte2pPIHX7TmhXPrU=";

  meta = {
    description = "A nushell plugin for syntax highlighting";
    homepage = "https://github.com/cptpiepmatz/nu-plugin-highlight";
    license = lib.licenses.mit;
    mainProgram = "nu_plugin_highlight";
  };
}
