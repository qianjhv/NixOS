# modules/clash-verge.nix（系统层，需要 root 权限的部分）
{ config, pkgs, inputs, ... }:
{
  programs.clash-verge = {
    enable = true;
    package = inputs.nixpkgs-unstable.legacyPackages.${pkgs.stdenv.hostPlatform.system}.clash-verge-rev;

    serviceMode = true;
    tunMode = true;
    # group = "networkmanager";
  };

  networking.firewall = {
    trustedInterfaces = [ "Mihomo" ];  # TUN 接口名，具体看你的配置里设的什么名字
    extraReversePathFilterRules = ''iifname { "Mihomo" } accept comment "trusted interface"'';
  };
}
