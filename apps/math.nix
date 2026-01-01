{
  config,
  pkgs,
  ...
}: let
  pkgsForSage =
    pkgs
    // {
      python3 = pkgs.python312;
      python3Packages = pkgs.python312Packages;
    };

  mySageWithDoc = pkgs.sage.override {
    pkgs = pkgsForSage;

    withDoc = true;

    # optional but often helpful to avoid long/brittle sage test runs during rebuilds
    requireSageTests = false;
  };
in {
  programs.sagemath = {
    enable = true;
    package = mySageWithDoc;
  };
}
