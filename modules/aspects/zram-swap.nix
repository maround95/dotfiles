{ ... }:
{
  flake.modules.nixos.zram-swap = { lib, ... }: {
    zramSwap = {
      enable = true;
      memoryPercent = lib.mkDefault 50;
      algorithm = "zstd";
    };

    boot.kernel.sysctl."vm.swappiness" = 150;
  };
}
