{
  config,
  pkgs,
  ...
}: {
  programs.vscode.profiles.default.userSettings = {
    "files.autoSave" = "on";
    "editor.lineNumbers" = "relative";
    "editor.insertSpaces" = false;
    "editor.rulers" = [
      80
      120
    ];
    "editor.formatOnSave" = true;
    "[python]" = {
      "editor.tabSize" = 4;
      "editor.detectIndentation" = false;
      "editor.insertSpaces" = true;
      "editor.rulers" = [
        88
      ];
      "editor.formatOnType" = true;
    };
    "[latex]" = {
      "editor.tabSize" = 1;
      "editor.detectIndentation" = true;
      "editor.insertSpaces" = true;
      "editor.rulers" = [
        79
      ];
      "editor.formatOnType" = true;
    };
    "editor.fontWeight" = 400;
    "spellright.addToSystemDictionary" = true;
    "spellright.language" = [
      "Czech"
      "English"
    ];
    "workbench.statusBar.visible" = true;
    "editor.minimap.enabled" = false;
    "breadcrumbs.enabled" = true;
    "spellright.notificationClass" = "warning";
    "editor.quickSuggestionsDelay" = 0;
    "editor.snippetSuggestions" = "top";
    "git.autofetch" = true;
    "git.enableSmartCommit" = true;
    "spellright.documentTypes" = [
      "markdown"
      "plaintext"
      "latex"
      "typst"
      "typst.markdown"
    ];
    "files.trimTrailingWhitespace" = true;
    "vim.normalModeKeyBindings" = [
      {
        "before" = [
          "<leader>"
          "q"
        ];
        "commands" = [
          ":q"
        ];
      }
    ];
    "vim.leader" = "<space>";
    "vim.smartRelativeLine" = true;
    "workbench.editorAssociations" = {
      "*.ipynb" = "jupyter-notebook";
    };
    "emmet.triggerExpansionOnTab" = true;
    "security.workspace.trust.untrustedFiles" = "open";
    "notebook.cellToolbarLocation" = {
      "default" = "right";
      "jupyter-notebook" = "left";
    };
    "typescript.updateImportsOnFileMove.enabled" = "always";
    "workbench.startupEditor" = "none";
    "editor.guides.indentation" = true;
    "editor.fontLigatures" = "'ss01'";
    "editor.inlineSuggest.enabled" = true;
    "github.copilot.enable" = {
      "*" = true;
      "plaintext" = true;
      "markdown" = false;
      "scminput" = false;
      "yaml" = false;
      "html" = true;
      "python" = true;
      "typst" = false;
      "latex" = false;
    };
    "git.openRepositoryInParentFolders" = "always";
    "jupyter.interactiveWindow.textEditor.executeSelection" = true;
    "javascript.updateImportsOnFileMove.enabled" = "always";
    "terminal.integrated.fontWeightBold" = "bold";
    "keyboard.dispatch" = "keyCode";
    "editor.accessibilitySupport" = "off";
    "[scss]" = {
      "editor.formatOnSave" = true;
      "editor.defaultFormatter" = "esbenp.prettier-vscode";
    };
    "editor.unicodeHighlight.ambiguousCharacters" = false;
    "liveServer.settings.donotShowInfoMsg" = true;
    "terminal.integrated.inheritEnv" = false;
    "liveServer.settings.useLocalIp" = true;
    "editor.indentSize" = "tabSize";
    "[javascript]" = {
      "editor.indentSize" = 2;
      "editor.defaultFormatter" = "esbenp.prettier-vscode";
    };
    "[typescriptreact]" = {
      "editor.indentSize" = 2;
      "editor.defaultFormatter" = "esbenp.prettier-vscode";
    };
    "[vue]" = {
      "editor.defaultFormatter" = "esbenp.prettier-vscode";
    };
    "[css]" = {
      "editor.defaultFormatter" = "esbenp.prettier-vscode";
    };
    "[html]" = {
      "editor.defaultFormatter" = "vscode.html-language-features";
    };
    "liveServer.settings.host" = "localhost";
    "extensions.experimental.affinity" = {
      "asvetliakov.vscode-neovim" = 1;
    };
    "editor.fontFamily" = "'Hurmit Nerd Font', 'monospace', monospace";
    "[jsonc]" = {
      "editor.defaultFormatter" = "esbenp.prettier-vscode";
    };
    "[typescript]" = {
      "editor.indentSize" = 2;
      "editor.defaultFormatter" = "esbenp.prettier-vscode";
    };
    "redhat.telemetry.enabled" = true;
    "git.confirmSync" = false;
    "[javascriptreact]" = {
      "editor.defaultFormatter" = "esbenp.prettier-vscode";
    };
    "window.menuBarVisibility" = "toggle";
    "workbench.colorTheme" = "Nord";
    "[typst]" = {
      "editor.wordWrap" = "wordWrapColumn";
      "editor.wordWrapColumn" = 80;
    };
    "github.copilot.nextEditSuggestions.enabled" = false;
    "python.analysis.typeCheckingMode" = "standard";
    "workbench.editor.empty.hint" = "hidden";
    "[json]" = {
      "editor.defaultFormatter" = "esbenp.prettier-vscode";
    };
  };
}
