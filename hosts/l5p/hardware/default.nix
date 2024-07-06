{ lib, config, inputs, ... }:
{
  imports = with inputs.hardware.nixosModules; [
    common.cpu.amd
    common.cpu.amd.pstate
    common.cpu.amd.zenpower

    common.gpu.amd
    common.gpu.nvidia.prime

    common.pc.laptop
    common.pc.laptop.ssd
  ] ++ [
    ./edid
  ];

  # Paraphrased from Arch Wiki:
  # With >=v545 the fbdev parameter tells the NVIDIA driver to provide its own framebuffer device
  # instead of efifb/vesafb, which do not work until simpledrm.
  boot.kernelParams = [ "nvidia-drm.fbdev=1" ];

  hardware = {
    amdgpu.initrd.enable = true;

    nvidia = {
      modesetting.enable = true;
      powerManagement.enable = true;

      prime = {
        amdgpuBusId = "PCI:6:0:0"; # Because of the extra m.2 drive
        nvidiaBusId = "PCI:1:0:0";
      };
    };
  };

  config = lib.mkIf (config.specialisation != { }) {
    system.nixos.tags = [ "Hybrid" ];
    imports = [ ./hybrid.nix ];
  };

  specialisation.dgpu.configuration = {
    system.nixos.tags = [ "dGPU" ];
    imports = [ ./dgpu.nix ];
  };
}
