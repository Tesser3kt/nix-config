{
  lib,
  rustPlatform,
  fetchFromGitHub,
}:
rustPlatform.buildRustPackage {
  pname = "nu_plugin_highlight";
  version = "1.4.15+0.113.1";

  src = fetchFromGitHub {
    owner = "cptpiepmatz";
    repo = "nu-plugin-highlight";
    rev = "v1.4.15+0.113.1";
    hash = "sha256-zJYbtGpQU0CrAu7sEQWv06hJj/PCD/iYCLOLrNmsL5U=";
    fetchSubmodules = true;
  };

  cargoHash = "sha256-oJtmmKRylOZQjBBifvWBx7ikwK2inGg8rGb/rPZ/t/s=";

  meta = {
    description = "A nushell plugin for syntax highlighting";
    homepage = "https://github.com/cptpiepmatz/nu-plugin-highlight";
    license = lib.licenses.mit;
    mainProgram = "nu_plugin_highlight";
  };
}
