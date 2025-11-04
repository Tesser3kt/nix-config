{
  config,
  pkgs,
  graphics,
  ...
}: let
  sioyekPackage = {
    "nvidia" = pkgs.symlinkJoin {
      name = "sioyek";
      paths = [pkgs.sioyek];
      buildInputs = [pkgs.makeWrapper];
      postBuild = ''
        wrapProgram $out/bin/sioyek \
          --set QT_QPA_PLATFORM xcb
      '';
    };
  };
in {
  home.packages = with pkgs; [
    # Arduino
    arduino-ide
    arduino-cli

    # Note-taking
    rnote
    pympress
  ];

  # Zathura configuration
  programs.zathura = {
    enable = true;
    options = {
      # Notification colors
      notification-error-bg = "#2A303C";
      notification-error-fg = "#BF616A";
      notification-warning-bg = "#2A303C";
      notification-warning-fg = "#D08770";
      notification-bg = "#2A303C";
      notification-fg = "#D8DEE9";

      # Completion colors
      completion-bg = "#2A303C";
      completion-fg = "#D8DEE9";
      completion-group-bg = "#3B4252";
      completion-group-fg = "#D8DEE9";
      completion-highlight-bg = "#88C0D0";
      completion-highlight-fg = "#3B4252";

      # Index colors
      index-bg = "#2A303C";
      index-fg = "#8FBCBB";
      index-active-bg = "#8FBCBB";
      index-active-fg = "#2A303C";

      # Input bar colors
      inputbar-bg = "#2A303C";
      inputbar-fg = "#E5E9F0";

      # Status bar colors
      statusbar-bg = "#2A303C";
      statusbar-fg = "#E5E9F0";

      # Highlight colors
      highlight-color = "#D08770";
      highlight-active-color = "#BF616A";

      # Default colors and rendering options
      default-bg = "#2A303C";
      default-fg = "#D8DEE9";
      render-loading = true;
      render-loading-bg = "#2A303C";
      render-loading-fg = "#434C5E";

      # Recolor options
      recolor-lightcolor = "#2A303C";
      recolor-darkcolor = "#ECEFF4";
      recolor = true;

      # Font and GUI options
      font = "Hurmit Nerd Font 12";
      guioptions = "none";

      # Inverse search
      synctex = true;

      # Copy to clipboard
      selection-clipboard = "clipboard";
    };
  };

  # Sioyek configuration
  programs.sioyek = {
    enable = true;
    package = sioyekPackage.${graphics} or pkgs.sioyek;
    config = {
      "startup_commands" = "toggle_custom_color";

      # Color values as space-separated strings
      "background_color" = "0.925490 0.937255 0.956863";
      "dark_mode_background_color" = "0.180392 0.203922 0.250980";
      "default_dark_mode" = "1";

      "text_highlight_color" = "0.368627 0.505882 0.674510";
      "visual_mark_color" = "0.298039 0.337255 0.415686 0.95";

      "search_highlight_color" = "0.368627 0.505882 0.674510";
      "link_highlight_color" = "0.505882 0.631373 0.756863";
      "synctex_highlight_color" = "0.533333 0.752941 0.815686";

      "highlight_color_a" = "0.368627 0.505882 0.674510";
      "highlight_color_b" = "0.505882 0.631373 0.756863";
      "highlight_color_c" = "0.74902 0.380392 0.415686";
      "highlight_color_d" = "0.815686 0.529412 0.439216";
      "highlight_color_e" = "0.921569 0.796078 0.545098";
      "highlight_color_f" = "0.639216 0.745098 0.549020";
      "highlight_color_g" = "0.705882 0.556863 0.678431";

      "font_size" = "14";
      "ui_font" = "Hurmit Nerd Font";

      "custom_background_color" = "0.180392 0.203922 0.250980";
      "custom_text_color" = "0.925490 0.937255 0.956863";

      "ui_text_color" = "0.925490 0.937255 0.956863";
      "ui_background_color" = "0.298039 0.337255 0.415686";
      "ui_selected_text_color" = "0.298039 0.337255 0.415686";

      "status_bar_font_size" = "14";
    };
  };
}
