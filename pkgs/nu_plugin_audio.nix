{
  lib,
  rustPlatform,
  fetchFromGitHub,
  alsa-lib,
  pkg-config,
}:
rustPlatform.buildRustPackage {
  pname = "nu_plugin_audio";
  version = "0.2.7";

  src = fetchFromGitHub {
    owner = "SuaveIV";
    repo = "nu_plugin_audio";
    rev = "v0.2.7";
    hash = "sha256-3JVvPzL+jSqB3HJpLkdnQI+bsZQZhWAK/iBWbLquUoQ=";
  };

  cargoHash = "sha256-wKwaLE5mRuJ4PkuSv80+ATMi2bJh2FARzU+5o1KRM4k=";

  nativeBuildInputs = [pkg-config];
  buildInputs = [alsa-lib];

  meta = {
    description = "A nushell plugin to make and play sounds";
    homepage = "https://github.com/SuaveIV/nu_plugin_audio";
    license = lib.licenses.mit;
    mainProgram = "nu_plugin_audio";
  };
}
