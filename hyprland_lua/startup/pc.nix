{lib, ...}: let
  mklua = lib.generators.mkLuaInline;
in {
  _args = [
    "hyprland.start"
    (mklua ''
      function()
        hl.exec_cmd("solaar -w hide")
        hl.exec_cmd("openrgb --startminimized")
      end
    '')
  ];
}
