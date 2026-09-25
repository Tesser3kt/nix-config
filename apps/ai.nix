{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: let
  # A Team plugin.
  aTeamPlugin = pkgs.runCommand "a-team" {} ''
    mkdir -p "$out"
    cp -r ${inputs.a-team}/. "$out/"
    chmod -R u+w $out

    # Fix malformed skill metadata.
    ${pkgs.gnused}/bin/sed -i \
      '/^name: skill-duplication-audit$/a description: Audit multiple skills for duplicated or overlapping scope and recommend whether to merge, document boundaries, or keep them separate.' \
      "$out/skills/skill-duplication-audit/SKILL.md"

    # Force Codex to treat this patched plugin as a new version.
    ${pkgs.jq}/bin/jq \
      '.version = "1.4.0+codex.nix1"' \
      "$out/.codex-plugin/plugin.json" \
      > "$out/.codex-plugin/plugin.json.tmp"

    mv \
      "$out/.codex-plugin/plugin.json.tmp" \
      "$out/.codex-plugin/plugin.json"
  '';

  # A team project initialised.
  aTeamInit = pkgs.writeShellApplication {
    name = "a-team-init";

    runtimeInputs = [
      pkgs.coreutils
    ];

    text = ''
      set -euo pipefail

      target="''${1:-$PWD}"
      src="${aTeamPlugin}"

      mkdir -p "$target"

      cp -rn \
        "$src/.claude" \
        "$src/skills" \
        "$src/hooks" \
        "$src/templates" \
        "$src/scripts" \
        "$target/"

      if [[ ! -e "$target/INIT.md" ]]; then
        cp "$src/INIT_TEMPLATE.md" "$target/INIT.md"
      fi

      echo "A Team initialized in: $target"
      echo "Next: edit $target/INIT.md"
    '';
  };

  # Aegis plugin.
  aegisPlugin = pkgs.runCommand "aegis" {} ''
    mkdir -p "$out"
    cp -r ${inputs.aegis}/. "$out/"
  '';

  # Remove this override once nixos-chatgpt pins the updated upstream artifact.
  chatgpt =
    inputs.chatgpt.packages.${pkgs.stdenv.hostPlatform.system}.default.overrideAttrs
    (oldAttrs: {
      version = "26.924.20706";

      src = oldAttrs.src.overrideAttrs (_: {
        outputHash = "sha256-dgoKmNzAWkDL2KNv7B3Xsycz5qHypShThq5/r5pqsDM=";
      });

      installPhase =
        builtins.replaceStrings
        ["resources/plugins/openai-bundled/plugins/latex/bin/tectonic"]
        ["resources/tectonic/tectonic"]
        oldAttrs.installPhase;
    });
in {
  # Enable writable .codex/config.toml.
  home.file.".codex/config.toml".force = true;
  home.activation.makeCodexConfigWritable = lib.hm.dag.entryAfter ["linkGeneration"] ''
    configFile="$HOME/.codex/config.toml"

    if [ -L "$configFile" ]; then
      tmp="$(${pkgs.coreutils}/bin/mktemp)"

      # Dereference HM's /nix/store symlink.
      ${pkgs.coreutils}/bin/cp -L "$configFile" "$tmp"

      ${pkgs.coreutils}/bin/rm "$configFile"
      ${pkgs.coreutils}/bin/install -m 600 "$tmp" "$configFile"
      ${pkgs.coreutils}/bin/rm "$tmp"
    fi
  '';

  home.packages = [
    # Initialises A Team project.
    aTeamInit
    # ChatGPT desktop app
    chatgpt
  ];

  # Prepares Aegis config.
  xdg.configFile."aegis/config.toml".text = ''
    activation_mode = "auto"
    tdd_mode = "off"
    method_pack_root = "${aegisPlugin}"
    workspace_helper = "${aegisPlugin}/scripts/aegis-workspace.py"
  '';

  programs.codex = {
    enable = true;
    enableMcpIntegration = true;
    settings = {
      model = "gpt-5.6-sol";
      model_reasoning_effort = "high";

      approval_policy = "on-request";
      sandbox_mode = "workspace-write";

      features = {
        multi_agent = true;
      };
    };

    plugins = [
      # aTeamPlugin
      aegisPlugin
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
        model = "gpt-6-astra";
        model_reasoning_effort = "xhigh";
        approval_policy = "on-request";
        sandbox_mode = "workspace-write";
      };
      normal = {
        model = "gpt-5.6-terra";
        model_reasoning_effort = "medium";
        approval_policy = "on-request";
        sandbox_mode = "workspace-write";
      };
      shallow = {
        model = "gpt-5.6-luna";
        model_reasoning_effort = "low";
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
