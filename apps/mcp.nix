# MCP servers
{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.mcp = {
    enable = true;

    servers = {
      python-lsp = {
        command = lib.getExe pkgs.mcp-language-server;

        args = [
          "--workspace"
          "."
          "--lsp"
          (lib.getExe' pkgs.basedpyright "basedpyright-langserver")
          "--"
          "--stdio"
        ];
      };

      rust-lsp = {
        command = lib.getExe pkgs.mcp-language-server;

        args = [
          "--workspace"
          "."
          "--lsp"
          (lib.getExe pkgs.rust-analyzer)
        ];
      };

      typescript-lsp = {
        command = lib.getExe pkgs.mcp-language-server;

        args = [
          "--workspace"
          "."
          "--lsp"
          (lib.getExe pkgs.typescript-language-server)
          "--"
          "--stdio"
        ];

        env.PATH = lib.makeBinPath [
          pkgs.nodejs
          pkgs.typescript
          pkgs.typescript-language-server
        ];
      };

      git = {
        command = lib.getExe pkgs.mcp-server-git;
      };
    };
  };
}
