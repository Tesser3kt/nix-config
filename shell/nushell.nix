# Zsh shell
{
  config,
  pkgs,
  ...
}: let
  nu_plugin_audio = pkgs.callPackage ../pkgs/nu_plugin_audio.nix {};
in {
  programs.nushell = {
    enable = true;
    settings = {
      show_banner = false;
      completions = {
        case_sensitive = false;
        quick = true;
        partial = true;
        algorithm = "fuzzy";
        external = {
          enable = true;
          max_results = 100;
        };
      };
    };
    plugins = [nu_plugin_audio];
    shellAliases = {
      update = "sudo nixos-rebuild switch";
      lg = "lazygit";
    };
    environmentVariables = {
      EDITOR = "nvim";
      BROWSER = "zen";
      DEFAULT_BROWSER = "zen";
      TERMINAL = "alacritty";
      XDG_CONFIG_HOME = "${config.home.homeDirectory}/.config";
      XDG_CACHE_HOME = "${config.home.homeDirectory}/.cache";
    };
    extraConfig = ''
      # Zoxide integration with custom completions
      # Set up PWD change hook to add directories to zoxide
      $env.config.hooks = ($env.config.hooks? | default {})
      $env.config.hooks.env_change = ($env.config.hooks.env_change? | default {})
      $env.config.hooks.env_change.PWD = ($env.config.hooks.env_change.PWD? | default [] | append {
        code: {|_, dir| zoxide add -- $dir}
      })

      # Define custom completer for zoxide
      def __zoxide_completer [context: string] {
        zoxide query -l
        | lines
        | where {|x| $x != $env.PWD}
        | each {|path|
            {
              value: ($path | path basename)
              description: $path
            }
          }
      }

      # Define z command with completions
      def --env "z" [
        path?: string@__zoxide_completer  # path argument with custom completer
      ] {
        let target = if ($path | is-empty) {
          "~"
        } else if $path == "-" {
          "-"
        } else if ($path | path expand | path type) == "dir" {
          $path
        } else {
          zoxide query --exclude $env.PWD -- $path | str trim -r -c "\n"
        }
        cd $target
      }

      # Define zi command for interactive selection
      def --env "zi" [...rest: string] {
        cd $"(zoxide query --interactive -- ...$rest | str trim -r -c "\n")"
      }

      $env.config.completions.external = {
        enable: true
        max_results: 100
        completer: {|spans|
          # Fallback to carapace for external completions
          carapace $spans.0 nushell ...$spans
          | from json
          | if ($in | default [] | where value =~ '^-.*ERR$' | is-empty) { $in } else { null }
        }
      }
    '';
  };
  programs.carapace = {
    enable = true;
    enableNushellIntegration = true;
  };
  programs.zoxide = {
    enable = true;
    enableNushellIntegration = false;  # Manually integrated with custom completions
  };
}
