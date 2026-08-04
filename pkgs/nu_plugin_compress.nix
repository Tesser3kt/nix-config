{
  lib,
  rustPlatform,
  fetchFromGitHub,
}:
rustPlatform.buildRustPackage {
  pname = "nu_plugin_compress";
  version = "0.2.10+0.114.1";

  src = fetchFromGitHub {
    owner = "yybit";
    repo = "nu_plugin_compress";
    rev = "81699f5eca4ff4d64d6702771c3fd6c2a74e707c";
    hash = "sha256-MpVHZFMBfDLfY2ulCmsb+ePohSRqC2VkC2om9AB0Yrg=";
  };

  patches = [./nu_plugin_compress_cargo.patch ./nu_plugin_compress_Cargo.lock.patch];
  cargoLock = {lockFile = ./nu_plugin_compress_Cargo.lock;};

  meta = {
    description = "A nushell plugin for compression and decompression, supporting zstd, gzip, bzip2, and xz";
    homepage = "https://github.com/yybit/nu_plugin_compress";
    license = lib.licenses.asl20;
    mainProgram = "nu_plugin_compress";
  };
}
