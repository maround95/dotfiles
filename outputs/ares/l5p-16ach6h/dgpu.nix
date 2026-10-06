{ lib, ... }:
{
  hardware.nvidia.prime.offload.enable = lib.mkForce false;
}
