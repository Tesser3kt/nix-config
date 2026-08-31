{lib, ...}: let
  mklua = lib.generators.mkLuaInline;
in {
  _args = [
    "hyprland.start"
    (mklua "function()\n  hl.exec_cmd(\"sleep 3\")\n  hl.exec_cmd(\"waybar\")\n  hl.exec_cmd(\"nm-applet --indicator\")\n  hl.exec_cmd(\"hypridle\")\n  hl.exec_cmd(\"whatsapp-electron\")\n  hl.exec_cmd(\"element-desktop --hidden\") hl.exec_cmd(\"protonmail-bridge -n\")\nend")
  ];
}
