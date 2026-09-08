{
  lib,
  rustPlatform,
  fetchFromGitHub,
}:
rustPlatform.buildRustPackage {
  pname = "nu_plugin_highlight";
  version = "1.4.17+0.115.1";

  src = fetchFromGitHub {
    owner = "cptpiepmatz";
    repo = "nu-plugin-highlight";
    rev = "v1.4.17+0.115.1";
    hash = "sha256-8yXDP3VKIGjqKPKhQJvDlYBLyl4pplqXqFgL58q4oJg=";
    fetchSubmodules = true;
  };

  cargoHash = "sha256-56PVP1pw6cJVmfd3O3so6YmFro1jvN1R++nnanItBUQ=";

  meta = {
    description = "A nushell plugin for syntax highlighting";
    homepage = "https://github.com/cptpiepmatz/nu-plugin-highlight";
    license = lib.licenses.mit;
    mainProgram = "nu_plugin_highlight";
  };
}
