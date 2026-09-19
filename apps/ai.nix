{
  config,
  pkgs,
  inputs,
  ...
}: let
  aTeamPlugin = pkgs.runCommand "a-team" {} ''
    mkdir -p "$out"
    cp -r ${inputs.a-team}/. "$out/"
  '';
in {
  programs.codex = {
    enable = true;
    enableMcpIntegration = true;
    settings = {
      model = "gpt-5.6";

      approval_policy = "on-request";
      sandbox_mode = "workspace-write";
    };

    plugins = [
      aTeamPlugin
    ];

    context = ''
      # Global Codex instructions

      - Prefer concise explanations.
      - Do not modify unrelated files.
      - Run relevant tests after making changes.
      - When working with Nix, prefer declarative configuration.
    '';

    profiles = {
      deep = {
        model = "gpt-5.6";
        model_reasoning_effort = "high";
        approval_policy = "on-request";
        sandbox_mode = "workspace-write";
      };
    };

    rules = {
      default = ''
        prefix_rule(pattern = ["nix", "build"], decision = "allow")
        prefix_rule(pattern = ["nix", "flake", "check"], decision = "allow")
      '';
    };
  };

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
