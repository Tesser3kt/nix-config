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
    rev = "af09945e306c104c53c830977d62d93417fd9890";
    hash = "sha256-MmpZZUuZlOUQyoGNN38AWUPeaznR7TlJy+KORHNpMcA=";
  };

  cargoHash = "sha256-DRyT6z7P2d7cY5+4rXX7TUnxvRGKmAbSrMCoUVfxluM=";

  meta = {
    description = "A nushell plugin for compression and decompression, supporting zstd, gzip, bzip2, and xz";
    homepage = "https://github.com/yybit/nu_plugin_compress";
    license = lib.licenses.asl20;
    mainProgram = "nu_plugin_compress";
  };
}
