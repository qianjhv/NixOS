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
}
