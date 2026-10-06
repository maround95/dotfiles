{ ... }:
{
  flake.modules.nixos.libvirt = { pkgs, ... }: {
    custom.primaryUserExtraGroups = [ "libvirtd" ];

    virtualisation.libvirtd.enable = true;
    virtualisation.spiceUSBRedirection.enable = true;

    programs.virt-manager.enable = true;
    programs.dconf.enable = true;

    environment.systemPackages = with pkgs; [
      spice
      win-spice
      spice-gtk
    ];
  };
}
