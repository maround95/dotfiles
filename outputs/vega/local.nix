{ config, ... }:
{

  networking.hostName = "vega";
  system.stateVersion = "24.11";

  custom.primaryUser = "maroun";
  custom.hardware.networking.wifi.backend = "wpa_supplicant";
  custom.desktop.preferred = "hyprland";
  custom.desktop.displayManager.greetd.user = "maroun";

  # From old generated hardware-configuration.nix for Vega.
  boot.initrd.availableKernelModules = [
    "xhci_pci"
    "ahci"
    "usbhid"
    "usb_storage"
    "sd_mod"
  ];

  boot.kernelModules = [ "kvm-amd" ];

  hardware = {
    nvidia = {
      open = false;
      package = config.boot.kernelPackages.nvidiaPackages.beta;
    };

    enableRedistributableFirmware = true;
    cpu.amd.updateMicrocode = true;
  };
}
