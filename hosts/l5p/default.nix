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

  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;

  # Plasma
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;
  services.displayManager.sddm.wayland.enable = true;

  networking.hostName = "l5p"; # Define your hostname.

  home-manager.users.maroun = import ../../home/maroun/l5p.nix;

  programs.nix-ld.enable = true;
  system.stateVersion = "24.05";
}
