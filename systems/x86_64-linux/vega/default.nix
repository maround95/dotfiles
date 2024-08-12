{
  inputs,
  namespace,
  lib,
  ...
}:
with lib.${namespace};
{
  imports =
    with inputs.hardware.nixosModules;
    [
      common-cpu-amd
      common-cpu-amd-pstate
      common-cpu-amd-zenpower

      common-gpu-amd
      common-gpu-nvidia-nonprime
    ]
    ++ [
      inputs.disko.nixosModules.disko

      ./disko_config.nix
    ];


  ${namespace} = {
    archetypes.desktop = enabled;

    services = {
      sshd = enabled;
    };

  };

  ## From generated hardware-configuration.nix
  boot.initrd.availableKernelModules = [
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

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
}
