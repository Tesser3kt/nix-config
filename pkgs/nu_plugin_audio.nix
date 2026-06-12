{
  lib,
  rustPlatform,
  fetchFromGitHub,
  alsa-lib,
  pkg-config,
}:
rustPlatform.buildRustPackage {
  pname = "nu_plugin_audio";
  version = "0.2.7+0.113.1";

  src = fetchFromGitHub {
    owner = "SuaveIV";
    repo = "nu_plugin_audio";
    rev = "v0.2.7";
    hash = "sha256-3JVvPzL+jSqB3HJpLkdnQI+bsZQZhWAK/iBWbLquUoQ=";
  };

  patches = [./nu_plugin_audio_cargo.patch ./nu_plugin_audio_Cargo.lock.patch];
  cargoLock = {lockFile = ./nu_plugin_audio_Cargo.lock;};

  nativeBuildInputs = [pkg-config];
  buildInputs = [alsa-lib];

  meta = {
    description = "A nushell plugin to make and play sounds";
    homepage = "https://github.com/SuaveIV/nu_plugin_audio";
    license = lib.licenses.mit;
    mainProgram = "nu_plugin_audio";
  };
}
