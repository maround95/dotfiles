{ pkgs, configLib, inputs, ... }: {
  imports = [
    inputs.disko.nixosModules.disko
    inputs.lanzaboote.nixosModules.lanzaboote

    ./hardware-configuration.nix
    ./configuration.nix

    (../common/disks/standard_luks_btrfs.nix)
    {
      _module.args = {
        disk = "/dev/nvme1n1";
        withSwap = false;
      };
    }
  ]
  ++ (map configLib.relativeToRoot [ "hosts/common/core" ]);

  #programs.hyprland.enable = true;
  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true;

  virtualisation.libvirtd = {
    enable = true;
    qemu.ovmf.packages = [
      pkgs.pkgsCross.aarch64-multiplatform.OVMF.fd
      pkgs.OVMF.fd
    ];
  };
  programs.virt-manager.enable = true;

  services = {
    pipewire = {
      enable = true;
      audio.enable = true;
      pulse.enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      jack.enable = true;
    };
  };

  # Plasma
  # services.displayManager.sddm.enable = true;
  # services.displayManager.sddm.wayland.enable = true;

  services.greetd = {
    enable = true;
    restart = true;

    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --asterisks --time --time-format '%I:%M %p | %a • %h | %F' --cmd startplasma-wayland";
        user = "maroun";
      };
    };
  };
  services.desktopManager.plasma6.enable = true;

  networking.hostName = "l5p"; # Define your hostname.

  home-manager.users.maroun = import ../../home/maroun/l5p.nix;

  programs.nix-ld.enable = true;
  system.stateVersion = "24.05";
}
