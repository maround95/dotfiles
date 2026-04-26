{
  inputs,
  lib,
  ...
}:
with lib;
with lib.custom;
{
  imports =
    with inputs.hardware.nixosModules;
    [
      common-cpu-intel

      common-gpu-intel
    ]
    ++ [
      inputs.disko.nixosModules.disko

      ./disko_config.nix
    ];

  custom = {
    archetypes.desktop = enabled;

    desktop = {
      plasma = enabled;
      sway = disabled;
    };

    services = {
      ollama = disabled;
      sshd = enabled;
      podman.enable = lib.mkForce false;
      docker = enabled;
    };

    system.time.timezone = "Europe/Berlin";
    hardware.networking.wifi.backend = "wpa_supplicant";
  };

  ## From generated hardware-configuration.nix
  boot.initrd.availableKernelModules = [
    "xhci_pci"
    "thunderbolt"
    "nvme"
    "ahci"
    "usbhid"
    "usb_storage"
    "sd_mod"
  ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];
  boot.blacklistedKernelModules = [
    "nouveau"
    "nvidia"
    "nvidia_drm"
    "nvidia_modeset"
  ];

  hardware = {
    enableRedistributableFirmware = true;
    cpu.intel.updateMicrocode = true;
  };

  system.stateVersion = "25.11";
}
