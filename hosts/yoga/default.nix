{ pkgs, ... }:
{
  imports = [  ./hardware-configuration.nix ];

  time.timeZone = "Asia/Shanghai";

  # services.dnsmasq 可了解方案：本地 DNS 缓存 + 上游 DNS
  networking.hostName = "yoga";
  networking.networkmanager = {
    enable = true;
    dns = "none";
  };
  networking.nameservers = ["223.5.5.5" "1.1.1.1" ];
  services.resolved.enable = false;

  # add users
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

  programs.xwayland.enable = true;
  services.gvfs.enable = true;
  services.upower.enable = true;
  myModules.kanata.enable = true;

  environment.sessionVariables = {
    XMODIFIERS = "@im=fcitx";
    # GTK_IM_MODULE = "fcitx";
    QT_IM_MODULE = "fcitx";
    GLFW_IM_MODULE = "fcitx";
    SDL_IM_MODULE = "fcitx";
    INPUT_METHOD = "fcitx";

    # XDG_DATA_DIRS = [
    #   "${pkgs.gsettings-desktop-schemas}/share/gsettings-schemas/${pkgs.gsettings-desktop-schemas.name}"
    #   "${pkgs.adwaita-icon-theme}/share"
    # ];
  };

  system.stateVersion = "26.05";
  
}
