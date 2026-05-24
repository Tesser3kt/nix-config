{
  config,
  pkgs,
  ...
}: let
  kvantumTheme = pkgs.catppuccin-kvantum.override {
    variant = "macchiato";
    accent = "mauve";
  };
in {
  home.packages = [kvantumTheme];

  xdg.configFile."Kvantum/kvantum.kvconfig".text = ''
    [General]
    theme=catppuccin-macchiato-mauve
  '';

  qt = {
    enable = true;
    platformTheme = {
      name = "qt6ct";
    };
    style.package = pkgs.catppuccin-qt5ct;
    qt6ctSettings = {
      Appearance = {
        custom_palette = true;
        color_scheme_path = "${pkgs.catppuccin-qt5ct}/share/qt6ct/colors/catppuccin-macchiato-mauve.conf";
        icon_theme = "Papirus-Dark";
        standard_dialogs = "xdgdesktopportal";
        style = "kvantum-dark";
      };
      Interface = {
        activate_item_on_single_click = "1";
        buttonbox_layout = "0";
        cursor_flash_time = "1000";
        dialog_buttons_have_icons = "1";
        double_click_interval = "400";
        gui_effects = "@Invalid()";
        keyboard_scheme = "2";
        menus_have_icons = true;
        show_shortcuts_in_context_menus = true;
        stylesheets = "@Invalid()";
        toolbutton_style = "4";
        underline_shortcut = "1";
        wheel_scroll_lines = "3";
      };
      Troubleshooting = {
        force_raster_widgets = "1";
        ignored_applications = "@Invalid()";
      };
    };
  };
}
