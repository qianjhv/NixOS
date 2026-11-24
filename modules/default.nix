# modules/default.nix
{ ... }:
{
  imports = [
    ./core.nix
    ./noctalia-greeter.nix
    ./fonts.nix
    ./umbriel.nix
    # ./niri.nix
    ./clash-verge-rev.nix
    # ./dae.nix
    ./honk.nix
    ./kanata.nix
  ];
}
