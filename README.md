# NixOS Configurations

## 

```txt
.
├── flake.nix
├── flake.lock
├── hosts/                      # 每台机器一个目录
│   ├── laptop/
│   │   ├── default.nix         # 该主机的顶层配置(imports + host 特有设置)
│   │   ├── hardware-configuration.nix
│   │   └── disko.nix           # 如果用 disko 声明式分区
│   └── other-host/
│       └── ...
├── modules/
│   ├── nixos/                  # 系统级模块(跨主机复用)
│   │   ├── default.nix         # 汇总 imports
│   │   ├── networking/
│   │   │   ├── dae.nix
│   │   │   └── dns.nix
│   │   ├── desktop/
│   │   │   ├── niri.nix
│   │   │   └── fonts.nix
│   │   ├── boot.nix
│   │   └── nix-settings.nix    # nix.conf、gc、mirror 之类
│   └── home/                   # home-manager 模块
│       ├── default.nix
│       ├── shell/
│       │   ├── foot.nix
│       │   ├── zellij.nix
│       │   └── helix.nix
│       ├── desktop/
│       │   ├── niri.nix
│       │   └── cursor.nix
│       └── fcitx5.nix
├── users/
│   ├── Alice/
│   │    ├── default.nix         # 该用户在系统层的定义(passwd、group)
│   │    └── home.nix            # imports modules/home/*, 该用户的 home-manager 入口
│   └── other-users/
│        └── ...
├── overlays/
│   ├── default.nix
│   └── unstable-packages.nix   # 引入 nixpkgs-unstable 的特定包(比如 dae 2.0)
├── pkgs/                       # 自定义/打包尚未进 nixpkgs 的软件
│   └── some-package/
│       └── default.nix
├── lib/                        # 自定义辅助函数
│   └── default.nix
└── secrets/                    # sops-nix / agenix 加密文件
    ├── secrets.yaml
    └── secrets.nix
```

🧩 设计原则与职责分工：



