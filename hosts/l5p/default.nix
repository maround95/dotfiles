{ pkgs, lib, configLib, inputs, ... }: {
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
  ] ++ (map configLib.relativeToRoot [ 
    "hosts/common/core"
    "hosts/common/optional/keybinds"
  ]);

  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.x86_64-linux.hyprland-debug;
    xwayland.enable = true;
  };
  services.desktopManager.plasma6.enable = true;
  programs.sway.enable = true;

  services.tlp.enable = lib.mkForce false;

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
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --asterisks --time --time-format '%I:%M %p | %a • %h | %F' --cmd Hyprland";
        user = "maroun";
      };
    };
  };

  networking.hostName = "l5p"; # Define your hostname.

  home-manager = {
    # Explanation: https://nix-community.github.io/home-manager/index.xhtml#sec-install-nixos-module
    useUserPackages = true;
    useGlobalPkgs = true;
  };

  home-manager.users.maroun = configLib.relativeToRoot "home/maroun/l5p.nix";

  programs.nix-ld.enable = true;
  system.stateVersion = "24.05";
}
