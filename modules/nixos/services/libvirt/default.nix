{
  options,
  config,
  lib,
  pkgs,
  namespace,
  ...
}:
with lib;
with lib.custom;
let
  cfg = config.custom.services.libvirt;
in
{
  options.custom.services.libvirt = with types; {
    enable = mkBoolOpt false "Whether to enable virtualization via libvirt.";
    aarch64-ovmf = mkBoolOpt false "Whether to add aarch64 ovmf firmware.";
  };

  config = mkIf cfg.enable {
    custom.user.extraGroups = [ "libvirtd" ];

    virtualisation.libvirtd = {
      enable = true;
      qemu.ovmf.packages = [
        pkgs.OVMF.fd
      ] ++ optional cfg.aarch64-ovmf pkgs.pkgsCross.aarch64-multiplatform.OVMF.fd;
    };

    virtualisation.spiceUSBRedirection.enable = true;

    programs.virt-manager.enable = true;
    environment.systemPackages = with pkgs; [
      spice
      win-spice
      spice-gtk
    ];

    # Ensuring dconf is enabled
    programs.dconf.enable = true;
  };
}
