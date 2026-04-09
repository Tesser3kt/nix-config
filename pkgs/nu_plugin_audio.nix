{
  lib,
  rustPlatform,
  fetchFromGitHub,
  alsa-lib,
  pkg-config,
}:
rustPlatform.buildRustPackage {
  pname = "nu_plugin_audio";
  version = "0.2.3";

  src = fetchFromGitHub {
    owner = "SuaveIV";
    repo = "nu_plugin_audio";
    rev = "187da08880bfccd95ec1d336e841077c8b678685";
    hash = "sha256-hfgRItZq38UakUI0jFsxz52CIcLf63SvQ4lI4PzAEIE=";
  };

  cargoHash = "sha256-rPOROAeCbLmlt2LtMLk6gM8ywt/wz0HN8HM5kZFJbdg=";

  nativeBuildInputs = [pkg-config];
  buildInputs = [alsa-lib];

  meta = {
    description = "A nushell plugin to make and play sounds";
    homepage = "https://github.com/SuaveIV/nu_plugin_audio";
    license = lib.licenses.mit;
    mainProgram = "nu_plugin_audio";
  };
}
