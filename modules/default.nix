# modules/default.nix
{ ... }:
{
  imports = [
    ./core.nix
    ./noctalia-greeter.nix
    ./fonts.nix
    ./niri.nix
    ./clash-verge-rev.nix
    ./dae.nix
    ./kanata.nix
  ];
}
