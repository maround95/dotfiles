{
  inputs,
  namespace,
  lib,
  pkgs,
  ...
}:
with lib.${namespace};
{
  imports = [
    inputs.disko.nixosModules.disko
    ./disko_config.nix

    ./l5p-16ach6h
  ];


  ${namespace} = {
    archetypes.laptop = enabled;

    programs = {
      steam = enabled;
    };

    services = {
      ollama = enabled;
      sshd = enabled;
    };

  };

  networking.firewall.enable = lib.mkForce false;

  ## From generated hardware-configuration.nix
  boot.initrd.availableKernelModules = [
    "nvme"
    "xhci_pci"
    "ahci"
    "usbhid"
    "usb_storage"
    "sd_mod"
  ];
  boot.kernelModules = [ "kvm-amd" ];
  ##

  hardware = {
    enableRedistributableFirmware = true;
    cpu.amd.updateMicrocode = true;
  };

  boot.kernelPackages = lib.mkForce pkgs.linuxPackages_cachyos;
  chaotic.scx.enable = true; # by default uses scx_rustland scheduler
  chaotic.scx.scheduler = "scx_bpfland";

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
}
