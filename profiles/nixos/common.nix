{ flakeModules, pkgs, ... }:
{
  imports = [
    flakeModules.generic.primary-user
    flakeModules.nixos.primary-user

    flakeModules.nixos.nix
    flakeModules.nixos.sudo
    flakeModules.nixos.polkit
    flakeModules.nixos.sops

    flakeModules.nixos.boot-systemd-boot
    flakeModules.nixos.boot-systemd-initrd
    flakeModules.nixos.boot-secureboot

    flakeModules.nixos.audio
    flakeModules.nixos.bluetooth
    flakeModules.nixos.networking
    flakeModules.nixos.udev

    flakeModules.nixos.kanata
    flakeModules.nixos.ntp

    flakeModules.nixos.console
    flakeModules.nixos.env
    flakeModules.nixos.fonts
    flakeModules.nixos.latest-kernel
    flakeModules.nixos.xkb

    flakeModules.nixos.git
    flakeModules.nixos.zsh
    flakeModules.nixos.nix-ld
    flakeModules.nixos.misc-tools
  ];

  time.timeZone = "Europe/Berlin";
  i18n.defaultLocale = "en_US.UTF-8";

  environment.systemPackages = with pkgs; [
    curl
  ];
}
