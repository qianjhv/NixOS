{ pkgs, ... }:
{
  imports = [  ./hardware-configuration.nix ];

  networking.hostName = "yoga";
  networking.networkmanager = {
    enable = true;
    dns = "none";
  };
  networking.nameservers = ["223.5.5.5" "1.1.1.1" ];
  services.resolved.enable = false;

  programs.zsh.enable = true;
  users.users.jeff = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [ "wheel" "networkmanager" "uinput" ]; # Enable ‘sudo’ for the user.
    # initialPassword = "foobar";
    packages = with pkgs; [
      # tree
    ];
  };

  myModules.kanata.enable = true;
  services.gvfs.enable = true;
  services.upower.enable = true;


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

  environment.sessionVariables = {
    XMODIFIERS = "@im=fcitx";
    GTK_IM_MODULE = "fcitx";
    QT_IM_MODULE = "fcitx";
    SDL_IM_MODULE = "fcitx";
    GLFW_IM_MODULE = "ibus";  # 注意：GLFW 官方文档里这个变量吃的是 "ibus"，不是应用名，是协议名，fcitx 通过 ibus 兼容层生效，写 "fcitx" 大概率不识别
    INPUT_METHOD = "fcitx";

    # XDG_DATA_DIRS = [
    #   "${pkgs.gsettings-desktop-schemas}/share/gsettings-schemas/${pkgs.gsettings-desktop-schemas.name}"
    #   "${pkgs.adwaita-icon-theme}/share"
    # ];
  };


  system.stateVersion = "26.05";
  
}
