{ config, inputs, ... }:

{
  imports = [ inputs.umbriel.homeModules.default ];

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
        gap = 16;

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

      appearance.tab_bar = {
        style = "indicator";
        position = "left";

        height = 4;
        tab_gap = 3;
        gap = 4;
        corner_radius = 2;

        visible = true;
        hide_when_single = false;
      };

      keybinds = {
        # Applications and session
        "Mod+Shift+Slash" = { action = "cheatsheet-toggle"; repeat = false; };
        "Mod+A" = "spawn noctalia msg panel-toggle launcher";
        "Mod+Return" = { action = "spawn foot"; repeat = false; };
        "Mod+S" = { action = "spawn nautilus"; repeat = false; };
        "Mod+Alt+L" = { action = "spawn noctalia msg session lock"; repeat = false; }; # Lock Screen
        "Mod+Alt+B" = { action = "spawn noctalia msg bar-toggle"; repeat = false; }; # Toggle Noctalia Bar
        "Mod+Q" = "window-close";
        "Mod+Escape" = "session-quit";
        "Ctrl+Alt+Delete" = { action = "session-quit"; repeat = false; };
        "Mod+Shift+Escape" = { action = "shortcuts-inhibit-toggle"; allow_when_inhibited = true; repeat = false; };
        
        # Focus and movement
        "Mod+Left" = "window-focus-left";
        "Mod+Down" = "window-focus-down";
        "Mod+Up" = "window-focus-up";
        "Mod+Right" = "window-focus-right";
        "Mod+H" = "window-focus-left";
        "Mod+N" = "window-focus-down";
        "Mod+E" = "window-focus-up";
        "Mod+I" = "window-focus-right";
        "Mod+Ctrl+H" = "column-move-left";
        "Mod+Ctrl+N" = "window-move-down";
        "Mod+Ctrl+E" = "window-move-up";
        "Mod+Ctrl+I" = "column-move-right";
        "Alt+Tab" = "window-focus-next";
        # "Alt+Tab" = "spawn noctalia msg window-switcher hold";
        "Alt+Shift+Tab" = "spawn noctalia msg window-switcher hold reverse";

        # Window state and layout
        "Mod+F" = { action = "window-toggle-maximize"; repeat = false; };
        "Mod+Ctrl+F" = { action = "window-toggle-fullscreen"; repeat = false; };

        "Mod+T" = { action = "window-toggle-floating"; repeat = false; };
        "Mod+Ctrl+T" = { action = "window-focus-switch-floating"; repeat = false; };
        "Mod+O" = { action = "overview-toggle"; repeat = false; };
        "Mod+W" = { action = "column-toggle-tabbed"; repeat = false; };
        "Mod+Shift+N" = "column-focus-tab-next";
        "Mod+Shift+E" = "column-focus-tab-previous";

        "Mod+P" = { action = "window-toggle-pinned"; repeat = false; };
        "Mod+R" = "window-cycle-primary-extent";
        "Mod+Ctrl+R" = "window-cycle-primary-extent-back";

        "Mod+Comma" = "window-consume-left";
        "Mod+Period" = "window-consume-right";
        "Mod+Ctrl+Comma" = "window-consume-from-left";
        "Mod+Ctrl+Period" = "window-consume-from-right";
        "Mod+BracketLeft" = { action = "window-consume-or-expel-left"; repeat = false; };
        "Mod+BracketRight" = { action = "window-consume-or-expel-right"; repeat = false; };

        "Mod+Home" = "column-focus-first";
        "Mod+End" = "column-focus-last";
        "Mod+Ctrl+Home" = "column-move-to-first";
        "Mod+Ctrl+End" = "column-move-to-last";

        # Workspaces
        "Mod+1" = "workspace-switch 1";
        "Mod+2" = "workspace-switch 2";
        "Mod+3" = "workspace-switch 3";
        "Mod+4" = "workspace-switch 4";
        "Mod+5" = "workspace-switch 5";
        "Mod+6" = "workspace-switch 6";
        "Mod+7" = "workspace-switch 7";
        "Mod+8" = "workspace-switch 8";
        "Mod+9" = "workspace-switch 9";
        "Mod+Shift+1" = "window-move-to-workspace 1";
        "Mod+Shift+2" = "window-move-to-workspace 2";
        "Mod+Shift+3" = "window-move-to-workspace 3";
        "Mod+Shift+4" = "window-move-to-workspace 4";
        "Mod+Shift+5" = "window-move-to-workspace 5";
        "Mod+Shift+6" = "window-move-to-workspace 6";
        "Mod+Shift+7" = "window-move-to-workspace 7";
        "Mod+Shift+8" = "window-move-to-workspace 8";
        "Mod+Shift+9" = "window-move-to-workspace 9";

        # Scratchpad
        "Mod+Z" = "scratchpad-toggle";
        "Mod+Ctrl+Z" = { action = "window-restore-from-scratchpad"; repeat = false; };
        "Mod+Shift+Z" = { action = "window-move-to-scratchpad"; repeat = false; };
        "Mod+Tab" = "scratchpad-focus-next";  

        # Media, volume and brightness keys from any input device
        "XF86AudioRaiseVolume" = { action = "spawn noctalia msg volume-up"; allow_when_locked = true; };
        "XF86AudioLowerVolume" = { action = "spawn noctalia msg volume-down"; allow_when_locked = true; };
        "XF86AudioMute" = { action = "spawn noctalia msg volume-mute"; allow_when_locked = true; repeat = false; };
        "XF86AudioPlay" = { action = "spawn noctalia msg media toggle"; allow_when_locked = true; repeat = false; };
        "XF86AudioNext" = { action = "spawn noctalia msg media next"; allow_when_locked = true; };
        "XF86AudioPrev" = { action = "spawn noctalia msg media previous"; allow_when_locked = true; };
        "XF86MonBrightnessUp" = { action = "spawn noctalia msg brightness-up"; allow_when_locked = true; };
        "XF86MonBrightnessDown" = { action = "spawn noctalia msg brightness-down"; allow_when_locked = true; };

        # 
        "Print" = { action = "spawn noctalia msg screenshot-region"; repeat = false; };
        "Ctrl+Print" = { action = "spawn noctalia msg screenshot-fullscreen"; repeat = false; };
        "Alt+Print" = { action = "spawn noctalia msg screenshot-window"; repeat = false; };
      };

      include.files = [
        "${config.programs.umbriel.package}/share/umbriel/effects/border/pulse/effect.toml"
        "${config.programs.umbriel.package}/share/umbriel/effects/animation/reveal/effect.toml"
        "${config.programs.umbriel.package}/share/umbriel/effects/animation/squash/effect.toml"
        "${config.programs.umbriel.package}/share/umbriel/effects/animation/workspace_wipe/effect.toml"
        # "${config.programs.umbriel.package}/share/umbriel/effects/cursor/trail/effect.toml"
      ];

      effects = {
        border = "pulse";
        # cursor = "trail";
      };
      
      animation = {
        windows_in.effect = "reveal";
        windows_out.effect = "reveal";
        windows_move.effect = "squash";
        workspaces = {
          enabled = true;
          style = "reveal";
          effect = "workspace_wipe";
          duration_ms = 300;
          curve = "easeout";
        };
      };
    };
  };
}
