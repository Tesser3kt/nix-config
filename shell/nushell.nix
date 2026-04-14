# Zsh shell
{
  config,
  pkgs,
  ...
}: let
  nu_plugin_audio = pkgs.callPackage ../pkgs/nu_plugin_audio.nix {};
  nu_plugin_compress = pkgs.callPackage ../pkgs/nu_plugin_compress.nix {};
  nu_plugin_highlight = pkgs.callPackage ../pkgs/nu_plugin_highlight.nix {};
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
    plugins = [nu_plugin_audio nu_plugin_compress nu_plugin_highlight];
    shellAliases = {
      update = "sudo nixos-rebuild switch";
      lg = "lazygit";

      # Git aliases
      g = "git";
      gst = "git status";
      gl = "git pull";
      gup = "git pull --rebase";
      gp = "git push";
      gd = "git diff";
      gdc = "git diff --cached";
      gdv = "git diff -w '$@' | view -";
      gc = "git commit -v";
      "gc!" = "git commit -v --amend";
      "gca!" = "git commit -a --amend";
      gca = "git commit -v -a";
      gcmsg = "git commit -m";
      gco = "git checkout";
      gcm = "git checkout main";
      gr = "git remote";
      grv = "git remote -v";
      grmv = "git remote rename";
      grrm = "git remote remove";
      gsetr = "git remote set-url";
      grup = "git remote update";
      grbi = "git rebase -i";
      grbc = "git rebase --continue";
      grba = "git rebase --abort";
      gb = "git branch";
      gba = "git branch -a";
      gcount = "git shortlog -sn";
      gcl = "git config --list";
      gcp = "git cherry-pick";
      glg = "git log --stat --max-count=10";
      glgg = "git log --graph --max-count=10";
      glgga = "git log --graph --decorate --all";
      glo = "git log --oneline --decorate --color";
      glog = "git log --oneline --decorate --color --graph";
      gss = "git status -s";
      ga = "git add";
      gaa = "git add --all";
      gm = "git merge";
      grh = "git reset HEAD";
      grhh = "git reset HEAD --hard";
      gwc = "git whatchanged -p --abbrev-commit --pretty=medium";
      gsts = "git stash show --text";
      gsta = "git stash";
      gstp = "git stash pop";
      gstd = "git stash drop";
      ggpull = "git pull";
      ggl = "git pull";
      ggpur = "git pull --rebase";
      ggpush = "git push";
      gpv = "git push -v";
      glp = "_git_log_prettily";
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
      def gclean [] { git reset --hard; git clean -dfx }
      def ggsync [] { git pull; git push }

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
