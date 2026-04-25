{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    rustc
    cargo
    rustfmt
    rust-analyzer
    lldb
    glibc
    gcc
    vscode-extensions.vadimcn.vscode-lldb
  ];
}
