{lib, ...}: let
  mklua = lib.generators.mkLuaInline;
in {
  _args = [
    "hyprland.start"
    (mklua "function()\n  hl.exec_cmd(\"sleep 0.5 && hyprctl --batch 'dispatch focusmonitor eDP-1; dispatch workspace 1'\")\nend")
  ];
}
