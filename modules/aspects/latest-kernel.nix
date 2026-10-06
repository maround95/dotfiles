{ ... }:
{
  flake.modules.nixos.latest-kernel = { pkgs, ... }: {
    boot.kernelPackages = pkgs.linuxPackages_latest;
  };
}
