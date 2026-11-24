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

      output = {
        "eDP-1" = {
          mode = "2880x1800@90.0";
          scale = 1.75;
          transform = "normal";
          position = [ 0 0 ];
        };

        "DP-3" = {
          mode = "3840x2160@60";
          scale = 1.5;
          transform = "normal";
          position = [ 1646 0 ];
          focus_at_startup = true;
        };
      };

      events = {
        lid_close = "umbriel msg output-disable eDP-1";
        lid_open = "umbriel msg output-enable eDP-1";
      };

      input.cursor = {
        theme = "Bibata-Modern-Classic";
        size = 16;
      };

      layout = {
        mode = "scrolling";
        gap = 8;

        extent_presets = [
          0.333
          0.5
          0.667
        ];

        client_maximize = "column";

        scrolling = {
          default_extent_fraction = 0.5;
          center_underfull_strip = true;
          center_focused = "on_overflow";
          center_on_overview_select = false;
        };

        dwindle = {
          preserve_split = false;
          new_toward_cursor = false;
        };

        master = {
          position = "left";
          default_width_fraction = 0.55;
          new_on_top = true;
          new_becomes_master = false;
        };

        tabs = {
          default_display = "normal";
          new_tab_position = "end";
          wrap_focus = true;
          scroll_switches_tabs = true;
          middle_click_closes = false;
        };
      };

      keybinds = {
        # Applications and session
        "Mod+Return" = { action = "spawn foot"; repeat = false; };
        "Mod+Q" = "window-close";
        "Mod+A" = "spawn noctalia msg panel-toggle launcher";
        "Mod+Escape" = "session-quit";
        "Mod+Shift+Escape" = { action = "shortcuts-inhibit-toggle"; allow_when_inhibited = true; repeat = false; };
        
        # Media, volume and brightness keys from any input device
        "XF86AudioRaiseVolume" = { action = "spawn noctalia msg volume-up"; allow_when_locked = true; };
        "XF86AudioLowerVolume" = { action = "spawn noctalia msg volume-down"; allow_when_locked = true; };
        "XF86AudioMute" = { action = "spawn noctalia msg volume-mute"; allow_when_locked = true; repeat = false; };
        "XF86AudioPlay" = { action = "spawn noctalia msg media toggle"; allow_when_locked = true; repeat = false; };
        "XF86AudioNext" = { action = "spawn noctalia msg media next"; allow_when_locked = true; };
        "XF86AudioPrev" = { action = "spawn noctalia msg media previous"; allow_when_locked = true; };
        "XF86MonBrightnessUp" = { action = "spawn noctalia msg brightness-up"; allow_when_locked = true; };
        "XF86MonBrightnessDown" = { action = "spawn noctalia msg brightness-down"; allow_when_locked = true; };

      };
    };
  };
}
