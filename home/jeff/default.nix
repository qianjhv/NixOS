# home/jeff/default.nix
{ pkgs, config, flakes, ... }:
{
  imports = [
    ../default.nix    # 几乎每个用户都需要的用户配置
    ./foot.nix
    ./zsh.nix
    ./starship.nix
  ];

  home.username = "jeff";
  # home.homeDirectory = "/home/jeff";
  home.stateVersion = "26.05";    # 按你实际 HM 版本

  home.packages = with pkgs; [
    tukai
  ];

  home.sessionVariables = {
    EDITOR = "hx";
    VISUAL = "hx";
    SUDO_EDITOR = "hx";

    QS_ICON_THEME = config.gtk.iconTheme.name;
    XCURSOR_THEME = "Bibata-Modern-Classic";
    XCURSOR_SIZE = "16";
  };

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;

    nix-direnv = {
      enable = true;
      # 可选：指定 nix-direnv 的包，通常默认即可
      # package = pkgs.nix-direnv;
    };

    #  (可选) 静默模式，减少 direnv 的输出信息
    # silent = true;
  };
}
