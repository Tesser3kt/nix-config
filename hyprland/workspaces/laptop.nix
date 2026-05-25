{
  lib,
  mod,
  ...
}: let
  mklua = lib.generators.mkLuaInline;
in {
  wayland.windowManager.hyprland.settings = {
    # Workspace bindings
    bind = (
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
        8)
    );

    # Bind workspaces to monitors
    workspace_rule = (
      builtins.genList (
        i: let
          ws = i + 1;
        in {
          workspace = "name:${toString ws}";
          monitor = "eDP-1";
          default = ws == 1;
        }
      )
      8
    );
  };

  programs.waybar.settings.main = {
    "hyprland/workspaces" = {
      "persistent-workspaces" = {
        "eDP-1" = [1 2 3 4 5 6 7 8];
      };
    };
  };
}
