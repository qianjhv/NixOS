# NixOS Configurations

## 

```txt
.
├── flake.lock
├── flake.nix
├── home
│   ├── default.nix
│   └── jeff
│       ├── default.nix
│       ├── foot.nix
│       ├── fzf.nix
│       ├── starship.nix
│       └── zsh.nix
├── hosts
│   └── yoga
│       ├── default.nix
│       └── hardware-configuration.nix
├── lib
├── modules
│   ├── core.nix
│   ├── dae.nix
│   ├── default.nix
│   ├── fonts.nix
│   ├── kanata.nix
│   ├── niri.nix
│   └── noctalia-greeter.nix
├── overlays
├── pkgs
├── README.md
└── secrets
    └── secrets.yaml
```

## Application Settings

### dae

```zsh
sudo mkdir -p /etc/sops/age
sudo cp ~/.config/sops/age/keys.txt /etc/sops/age/keys.txt
sudo chmod 600 /etc/sops/age/keys.txt
sudo chown root:root /etc/sops/age/keys.txt
```

### fastfetch

```zsh
fastfetch --list-presets
fastfetch --list-logos

# use presets
fastfetch -c all
fastfetch -c neofetch
```

### fcitx5
