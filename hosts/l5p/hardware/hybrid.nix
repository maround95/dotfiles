{ inputs, ... }:
{
  # Disable nvidia by default in hybrid mode. Toggled explicitly on the command line.
  imports = [
    inputs.hardware.nixosModules.common.gpu.nvidia.disable
  ];

  hardware.nvidia.prime.offload.enable = true;
}
