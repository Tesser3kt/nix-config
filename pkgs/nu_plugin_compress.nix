{
  lib,
  rustPlatform,
  fetchFromGitHub,
}:
rustPlatform.buildRustPackage {
  pname = "nu_plugin_compress";
  version = "0.2.10";

  src = fetchFromGitHub {
    owner = "yybit";
    repo = "nu_plugin_compress";
    rev = "a5498f4b41e7e5f57a862bfa485e91b98a197b74";
    hash = "sha256-ACvobJwRT6revFX9AG/uOo4ZwI70Up++Gfk/cp7kyoA=";
  };

  cargoHash = "sha256-cuMbnefdgljjSR0CU+yCH4MYFNMmIyjmuu7f9eVPQJc=";

  meta = {
    description = "A nushell plugin for compression and decompression, supporting zstd, gzip, bzip2, and xz";
    homepage = "https://github.com/yybit/nu_plugin_compress";
    license = lib.licenses.asl20;
    mainProgram = "nu_plugin_compress";
  };
}
