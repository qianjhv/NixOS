# modules/default.nix
{ ... }:
{
  imports = [
    ./core.nix
    ./noctalia-greeter.nix
    ./fonts.nix
    ./niri.nix
    # ./umbriel.nix
    ./clash-verge-rev.nix
    # ./dae.nix
    ./honk.nix
    ./kanata.nix
  ];
}
