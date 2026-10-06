{ pkgs, ... }:
{
  networking.hostName = "nova";
  system.stateVersion = "26.11";

  custom.primaryUser = "maroun";
  custom.hardware.networking.wifi.backend = "wpa_supplicant";
  custom.desktop.preferred = "hyprland";
  custom.desktop.displayManager.greetd.user = "maroun";

  i18n.supportedLocales = [
    "en_US.UTF-8/UTF-8"
    "de_DE.UTF-8/UTF-8"
  ];

  programs.gamemode.enable = true;
  zramSwap.memoryPercent = 25;

  # From old generated hardware-configuration.nix for Nova.
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
