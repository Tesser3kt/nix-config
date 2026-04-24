{
  lib,
  rustPlatform,
  fetchFromGitHub,
}:
rustPlatform.buildRustPackage {
  pname = "nu_plugin_highlight";
  version = "1.4.14+0.112.2";

  src = fetchFromGitHub {
    owner = "cptpiepmatz";
    repo = "nu-plugin-highlight";
    rev = "v1.4.14+0.112.2";
    hash = "sha256-zNvHSUpIMpRWw+1DMG4BukfdpZ3jQ6hQ2WisXFmnHGM=";
    fetchSubmodules = true;
  };

  cargoHash = "sha256-ZOu774x8EhW/QbP6dCIgz0BGjkv42rK0E8+oe/I7uhU=";

  meta = {
    description = "A nushell plugin for syntax highlighting";
    homepage = "https://github.com/cptpiepmatz/nu-plugin-highlight";
    license = lib.licenses.mit;
    mainProgram = "nu_plugin_highlight";
  };
}
