{ inputs, flakeModules, pkgs, ... }:
let
  system = pkgs.stdenv.hostPlatform.system;
in
{
  imports = [
    flakeModules.nixos.libvirt
    flakeModules.nixos.docker
  ];

  environment.systemPackages = with pkgs; [
    inputs.fenix.packages.${system}.minimal.toolchain
    distrobox
    gcc
    python3
  ];
}
