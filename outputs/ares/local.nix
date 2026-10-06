{ pkgs, ... }:
{

  networking.hostName = "ares";
  system.stateVersion = "24.11";

  custom.primaryUser = "maroun";
  custom.hardware.networking.wifi.backend = "wpa_supplicant";
  custom.desktop.preferred = "hyprland";
  custom.desktop.displayManager.greetd.user = "maroun";

  # From old generated hardware-configuration.nix for Ares.
  boot.initrd.availableKernelModules = [
    "nvme"
    "xhci_pci"
    "ahci"
    "usbhid"
    "usb_storage"
    "sd_mod"
  ];

  boot.kernelModules = [ "kvm-amd" ];

  hardware = {
    enableRedistributableFirmware = true;
    cpu.amd.updateMicrocode = true;
  };

  services.usbmuxd.enable = true;

  environment.systemPackages = with pkgs; [
    libimobiledevice
    ifuse
  ];
}
