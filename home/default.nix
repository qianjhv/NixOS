# home/default.nix
{ pkgs, inputs, ... }:
{
  # imports = [
  #   inputs.noctalia.homeModules.default
  # ];
  
  home.packages = with pkgs; [
    sops
    
    tldr
    yazi
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
    inputs.nixpkgs-unstable.legacyPackages.${pkgs.stdenv.hostPlatform.system}.noctalia
    # inputs.nixpkgs-unstable.legacyPackages.${pkgs.stdenv.hostPlatform.system}.clash-verge-rev

    obsidian
    telegram-desktop
    gimp
    kdePackages.gwenview
    kdePackages.okular

    # nemo
    # nemo-fileroller
    # libnotify # Nemo 的文件操作（复制、移动）需要一个通知服务来显示进度条。
    nautilus
    # adwaita-icon-theme

    # lsp
    tree-sitter
    clang-tools
    lldb
    rust-analyzer
    nixd
    lua-language-server
    marksman
    bash-language-server
    taplo
    jdt-language-server

    #
    cargo
    rustc

  ];

  # programs.noctalia = {
  #   enable = true;
  #   package = inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default;
  #   settings = {};
  # };

  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5 = {
      waylandFrontend = true;
      addons = with pkgs; [
        fcitx5-gtk              # GTK 应用输入法支持
        (fcitx5-rime.override {
          rimeDataPkgs = [
            rime-ice
          ];
        })
      ];
    };
  };

  # 声明式管理 Rime 配置
  home.file = {
    ".local/share/fcitx5/rime/default.custom.yaml".text = ''
      patch:
        __include: rime_ice_suggestion:/
        __patch:
          schema_list:
            - schema: double_pinyin_flypy

          ascii_composer:
            good_old_caps_lock: true
            switch_key:
              Shift_L: noop
              Shift_R: noop

          menu:
            page_size: 8

          speller/auto_select: true
          engine/translator/enable_user_dict: false
    '';
  };

  # programs.clash-verge = {
  #   enable = true;
  #   package = inputs.nixpkgs-unstable.legacyPackages.${pkgs.stdenv.hostPlatform.system}.clash-verge-rev;

  #   serviceMode = true;
  #   tunMode = true;
  #   # group = "networkmanager";
  # };
  
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    settings."*" = {
    };
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
