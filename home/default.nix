# home/default.nix
{ config, pkgs, inputs, ... }:
{
  imports = [
    inputs.noctalia.homeModules.default
  ];
  
  home.packages = with pkgs; [
    tldr
    bat
    eza
    lazygit
    fastfetch
    zellij

    foot
    # alacritty

    # vim
    # helix
    neovim
    zed-editor
    vscode
    # sublime4-dev

    chromium
    inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default

    obsidian
    telegram-desktop
    gimp
    kdePackages.gwenview
    kdePackages.okular

    nemo
    libnotify # Nemo 的文件操作（复制、移动）需要一个通知服务来显示进度条。
    # adwaita-icon-theme
  ];

  programs.noctalia = {
    enable = true;
    package = inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default;
    settings = {};
  };

  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    settings."*" = {
    };
  };

  home.sessionVariables = {
    EDITOR = "hx";
    VISUAL = "hx";
    SUDO_EDITOR = "hx";

    QS_ICON_THEME = config.gtk.iconTheme.name;
    XCURSOR_THEME = "Bibata-Modern-Classic";
    XCURSOR_SIZE = "16";
  };

  gtk = {
    enable = true;

    iconTheme = {
      package = pkgs.papirus-icon-theme;
      name = "Papirus";
    };

  };

  home.pointerCursor = {
    enable = true;
    
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 16;

    dotIcons.enable = true;
    # gtk.enable = true;
    x11 = {
      enable = true;
      defaultCursor = "default";
    };
  };

}
