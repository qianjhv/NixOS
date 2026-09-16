{ ... }:
{
  home.file = {
    ".config/helix/config.toml".text = ''
      theme = "catppuccin_mocha"

      [editor]
      line-number = "relative"
      bufferline = "multiple"
      cursorline = true
      color-modes = true

      [editor.cursor-shape]
      insert = "bar"
      normal = "underline"
      select = "block"

      [editor.indent-guides]
      render = true

      [editor.file-picker]
      hidden = false

      [keys.insert]
      "C-[" = "normal_mode"

      [keys.normal.space]
      f = "file_picker_in_current_directory"
      F = "file_picker"
      q = ":bc"
    '';

    ".config/helix/languages.toml".text = ''
      [[language]]
      name = "rust"
      auto-format = true

      [[language]]
      name = "c"
      auto-format = false

      [language.indent]
      tab-width = 4
      unit = "    "

      [[language]]
      name = "cpp"
      auto-format = true

      [language.indent]
      tab-width = 2
      unit = "  "


      [language-server.rust-analyzer.config]
      check.command = "clippy"
      diagnostics.enable = true
    '';
  };
}
