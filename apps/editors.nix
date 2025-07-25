{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    sioyek
  ];

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
      font = "Hurmit Nerd Font";
      guioptions = "none";
    };
  };
}
