{
  config,
  pkgs,
  ...
}: {
  programs.claude-code = {
    enable = true;
    lspServers = {
      nix = {
        args = [
          "--stdio"
        ];
        command = "nil";
        extensionToLanguage = {
          ".nix" = "nix";
        };
      };
      typescript = {
        args = [
          "--stdio"
        ];
        command = "typescript-language-server";
        extensionToLanguage = {
          extensionToLanguage = {
            ".js" = "javascript";
            ".jsx" = "javascriptreact";
            ".ts" = "typescript";
            ".tsx" = "typescriptreact";
          };
        };
      };
      rust = {
        command = "rust-analyzer";
        extensionToLanguage = {
          ".rs" = "rust";
        };
      };
      python = {
        command = "basedpyright";
        extensionToLanguage = {
          ".py" = "python";
        };
      };
    };
    settings = {
      enabledPlugins = {
        "frontend-design@claude-plugins-official" = true;
        "superpowers@claude-plugins-official" = true;
        "code-review@claude-plugins-official" = true;
        "code-simplifier@claude-plugins-official" = true;
        "playwright@claude-plugins-official" = true;
        "security-guidance@claude-plugins-official" = true;
        "typescript-lsp@claude-plugins-official" = true;
        "pyright-lsp@claude-plugins-official" = true;
        "rust-analyzer-lsp@claude-plugins-official" = true;
      };
    };
  };
}
