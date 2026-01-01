{pkgs, ...}: let
  pkgsForSage =
    pkgs
    // {
      # pin toolchain used inside Sage build
      stdenv = pkgs.gcc14Stdenv;

      # pin Python used inside Sage build
      python3 = pkgs.python312;
      python3Packages = pkgs.python312Packages;
    };

  mySageWithDoc = pkgs.sage.override {
    pkgs = pkgsForSage;

    # equivalent of pkgs.sageWithDoc
    withDoc = true;

    # strongly recommended for rebuild stability/CI-like environments
    requireSageTests = false;
  };
in {
  programs.sagemath = {
    enable = true;
    package = mySageWithDoc;
  };
}
