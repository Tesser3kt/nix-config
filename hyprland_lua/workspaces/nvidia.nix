{
  config,
  lib,
  pkgs,
  mod,
  ...
}: let
  mklua = lib.generators.mkLuaInline;
in {
  wayland.windowManager.hyprland.settings = {
    # Workspace bindings
    bind =
      (
        builtins.concatLists (builtins.genList (
            i: let
              ws = i + 1;
            in [
              {
                _args = [
                  "${mod} + code:1${toString i}"
                  (mklua "hl.dsp.focus({ workspace = ${toString ws} })")
                  {bypass = true;}
                ];
              }
              {
                _args = [
                  "${mod} + SHIFT + code:1${toString i}"
                  (mklua "hl.dsp.window.move({ workspace = ${toString ws}, follow = true })")
                  {bypass = true;}
                ];
              }
            ]
          )
          5)
      )
      ++ (
        builtins.concatLists (builtins.genList (
            i: let
              ws = i + 6;
            in [
              {
                _args = [
                  "CTRL + code:1${toString i}"
                  (mklua "hl.dsp.focus({ workspace = ${toString ws} })")
                  {bypass = true;}
                ];
              }
              {
                _args = [
                  "CTRL + SHIFT + code:1${toString i}"
                  (mklua "hl.dsp.window.move({ workspace = ${toString ws}, follow = true })")
                  {bypass = true;}
                ];
              }
            ]
          )
          5)
      );

    # Bind workspaces to monitors
    workspace_rule =
      (
        builtins.genList (
          i: let
            ws = i + 1;
          in {
            workspace = "name:${toString ws}";
            monitor = "HDMI-A-1";
            default = ws == 1;
          }
        )
        5
      )
      ++ (
        builtins.genList (
          i: let
            ws = i + 6;
          in {
            workspace = "name:${toString ws}";
            monitor = "DP-1";
            default = ws == 6;
          }
        )
        5
      );
  };

  programs.waybar.settings.main = {
    "hyprland/workspaces" = {
      "persistent-workspaces" = {
        "HDMI-A-1" = [1 2 3 4 5];
        "DP-1" = [6 7 8 9 10];
      };
    };
  };
}
