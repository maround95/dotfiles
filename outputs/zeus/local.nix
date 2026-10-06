{ ... }:
{
  networking.hostName = "zeus";
  system.stateVersion = "25.11";

  custom.primaryUser = "maroun";
  custom.hardware.networking.wifi.backend = "wpa_supplicant";
  custom.desktop.preferred = "hyprland";
  custom.desktop.displayManager.greetd.user = "maroun";

  # From old generated hardware-configuration.nix for Zeus.
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
}
