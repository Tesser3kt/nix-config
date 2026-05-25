{lib, ...}: let
  mklua = lib.generators.mkLuaInline;
in {
  _args = [
    "hyprland.start"
    (mklua "function()\n  hl.exec_cmd(\"solaar -w hide\")\nend")
  ];
}
