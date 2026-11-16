{ inputs, ... }:

{
  imports = [
    inputs.umbriel.homeModules.default
  ];

  programs.umbriel = {
    enable = true;

    settings = {
      general.autostart = [ 
        "noctalia"
        "fcitx5 -d"
      ];

      outputs = {
        "eDP-1" = {
          mode = "2880x1800@90.0";
          scale = 1.75;
          transform = "normal";
          position = {
            x = 0;
            y = 0;
          };
        };

        "DP-3" = {
          mode = "3840x2160@60";
          scale = 1.5;
          transform = "normal";
          position = {
            x = 1646;
            y = 0;
          };
        };
      };

      layout.gap = 4;

      keybinds = {
        "Mod+T" = "spawn foot";
        "Mod+Q" = "window-close";
        "Mod" = "spawn noctalia msg panel-toggle launcher";
      };
    };
  };
}
