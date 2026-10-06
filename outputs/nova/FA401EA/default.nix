{
  config,
  inputs,
  pkgs,
  ...
}:
{
  imports = with inputs.hardware.nixosModules; [
    common-cpu-amd
    common-cpu-amd-pstate
    common-cpu-amd-zenpower

    common-gpu-amd

    common-pc-laptop
    common-pc-laptop-ssd
  ];

  boot.extraModulePackages = with config.boot.kernelPackages; [ ];

  hardware = {
    amdgpu.initrd.enable = true;
  };

  services.asusd.enable = true;
  environment.systemPackages = with pkgs; [ asusctl ];

}
