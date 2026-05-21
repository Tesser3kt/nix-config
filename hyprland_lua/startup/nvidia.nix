{lib, ...}: let
  mklua = lib.generators.mkLuaInline;
in {
  _args = [
    "hyprland.start"
    (mklua "function()\n  hl.exec_cmd(\"solaar -w hide\")\n  hl.exec_cmd(\"sleep 0.5 && hyprctl --batch 'dispatch focusmonitor HDMI-A-1; dispatch workspace 1; dispatch focusmonitor DP-1; dispatch workspace 6'\")\nend")
  ];
}
