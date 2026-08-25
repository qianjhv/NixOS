# modules/core.nix
{ pkgs, ... }:
{
  ####################
  # Boot / bootloader
  ####################
  boot.loader.systemd-boot = {
    enable = true;
    configurationLimit = 5;   # 只在 bootloader 菜单里保留最近 5 代
  };
  boot.loader.efi.canTouchEfiVariables = true;


  ####################
  # Nix daemon settings
  ####################
  nix.gc = {
    automatic = true;
    dates = "biweekly";
    options = "--delete-older-than 7d";
  };

  # nix.settings.auto-optimise-store = true;

  # nix-daemon 走代理下载
  # systemd.services.nix-daemon.environment = {
  #   # http_proxy = "http://127.0.0.1:xxxx";
  #   # https_proxy = "http://127.0.0.1:xxxx";
  #   # all_proxy   = "socks5://127.0.0.1:7897";
  # };

  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    substituters = [
      "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
      "https://mirrors.ustc.edu.cn/nix-channels/store"
      "https://cache.nixos.org/"
    ];
    # trusted-users = [ "jeff" ];
  };
  nixpkgs.config.allowUnfree = true;

  ####################
  # System packages
  ####################
  environment.systemPackages = with pkgs; [
    # --- 版本控制 / 网络 ---
    git
    curl
    wget

    # --- 命令行核心工具 ---
    zsh
    ripgrep
    fd
    fzf
    jq
    tree

    # --- 压缩/归档 ---
    unzip
    zip

    # --- 系统诊断 ---
    btop
    lsof
    pciutils     # lspci
    usbutils     # lsusb
    dnsutils     # dig, nslookup
    iproute2
    nmap

    # --- 磁盘/文件系统 ---
    ntfs3g
    exfatprogs

    # --- Nix 生态 ---
    nix-tree     # 可视化依赖树,排查 store 膨胀很有用
    nix-du       # 分析 store 占用

    # --- 编辑器 fallback ---
    vim
    helix
  ];
}
