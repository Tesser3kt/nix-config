{pkgs, ...}: let
  # Python interpreter rebuilt using gcc14 stdenv
  python312_gcc14 =
    pkgs.python312.override {stdenv = pkgs.gcc14Stdenv;};

  # Its package set (sagelib will come from here, using the same stdenv)
  py312_gcc14 = python312_gcc14.pkgs;

  pkgsForSage =
    pkgs
    // {
      stdenv = pkgs.gcc14Stdenv;
      python3 = python312_gcc14;
      python3Packages = py312_gcc14;
    };

  sageWithDoc_py312_gcc14 = pkgs.sage.override {
    pkgs = pkgsForSage;
    withDoc = true; # = sageWithDoc
    requireSageTests = false; # optional but recommended for rebuild stability
  };
in {
  programs.sagemath = {
    enable = true;
    package = sageWithDoc_py312_gcc14;
  };
}
