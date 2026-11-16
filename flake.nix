{
  description = "Jeff's NixOS configuration";

  inputs = {
    # nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    # nixpkgs.url = "git+https://mirrors.tuna.tsinghua.edu.cn/git/nixpkgs.git?ref=nixos-26.05&shallow=1";
    nixpkgs.url = "git+https://mirrors.nju.edu.cn/git/nixpkgs.git?ref=nixos-26.05&shallow=1";

    # nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    # nixpkgs-unstable.url = "git+https://mirrors.tuna.tsinghua.edu.cn/git/nixpkgs.git?ref=nixos-unstable&shallow=1";
    nixpkgs-unstable.url = "git+https://mirrors.nju.edu.cn/git/nixpkgs.git?ref=nixos-unstable&shallow=1";

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";  # 确保 home-manager 用同一份 nixpkgs，避免版本冲突
    };

    umbriel = {
      url = "github:noctalia-dev/umbriel";
    };

    noctalia-greeter = {
      url = "github:noctalia-dev/noctalia-greeter";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
  let
    system = "x86_64-linux";

    pkgs = import nixpkgs {
      inherit system;
    };

    mkHost = hostname: extraModules:
      nixpkgs.lib.nixosSystem {
        inherit system;

        specialArgs = {
          inherit inputs;
          honk = self.packages.${system}.honk;
          bbdown = self.packages.${system}.bbdown;
        };

        modules = [
          ./hosts/${hostname}
          ./modules

          inputs.sops-nix.nixosModules.sops
          inputs.noctalia-greeter.nixosModules.default

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.jeff = import ./home/jeff;
            home-manager.extraSpecialArgs = { 
              inherit inputs; 
              inherit (self.packages.${system}) honk bbdown;
            };
          }
        ] ++ extraModules;
      };
  in
  {
    packages.${system} = {
      bbdown = pkgs.callPackage ./packages/bbdown.nix {};
      honk = pkgs.callPackage ./packages/honk.nix {};
    };

    nixosConfigurations = {
      yoga = mkHost "yoga" [];
    };
  };
}
