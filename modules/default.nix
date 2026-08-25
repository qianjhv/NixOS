# modules/default.nix
{ ... }:
{
  imports = [
    ./core.nix
    ./noctalia-greeter.nix
    ./fonts.nix
    ./niri.nix
    ./dae.nix
    ./kanata.nix
  ];
}
