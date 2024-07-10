{ lib, config, inputs, ... }:
{
  imports = with inputs.hardware.nixosModules; [
    common-cpu-amd
    common-cpu-amd-pstate
    common-cpu-amd-zenpower

    common-gpu-amd
    common-gpu-nvidia-nonprime # prime configuration in hybrid

    common-pc-laptop
    common-pc-laptop-ssd
  ] ++ [
    ./hybrid.nix
    ./edid
  ];

  system.nixos.tags = lib.mkIf (config.specialisation != { }) [ "Hybrid" ];

  # Paraphrased from Arch Wiki:
  # With >=v545 the fbdev parameter tells the NVIDIA driver to provide its own framebuffer device
  # instead of efifb/vesafb, which do not work with simpledrm (enabled on nix).
  boot.kernelParams = [ "nvidia-drm.fbdev=1" ];

  # acpi_call kernel module
  boot.kernelModules = [ "acpi_call" ];
  boot.extraModulePackages = [ config.boot.kernelPackages.acpi_call ];

  hardware = {
    amdgpu.initrd.enable = false;

    nvidia = {
      # package = config.boot.kernelPackages.nvidiaPackages.beta;
      modesetting.enable = lib.mkDefault true;
      powerManagement.enable = lib.mkDefault true;

      prime = {
        amdgpuBusId = "PCI:6:0:0"; # Because of the extra m.2 drive
        nvidiaBusId = "PCI:1:0:0";
      };
    };
  };

  specialisation.dgpu.configuration = {
    system.nixos.tags = [ "dGPU" ];
    imports = [ ./dgpu.nix ];
    disabledModules = [ ./hybrid.nix ];
  };
}
