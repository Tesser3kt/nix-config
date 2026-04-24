{
  lib,
  stdenv,
  fetchFromGitHub,
}:
stdenv.mkDerivation {
  pname = "ranger-archives";
  version = "unstable-2024-05-22";

  src = fetchFromGitHub {
    owner = "maximtrp";
    repo = "ranger-archives";
    rev = "0b1cfa9a77412c3b51da5b1b213c672227f9fbb4";
    hash = "sha256-HEJ+8KlG++PK0vVpEYptbyuPZAKllX5PeyaTBKcf+8M=";
  };

  installPhase = ''
    mkdir -p $out
    cp -r . $out/
  '';

  meta = {
    description = "Ranger plugin for compressing and extracting archives";
    homepage = "https://github.com/maximtrp/ranger-archives";
    license = lib.licenses.mit;
  };
}
