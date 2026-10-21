{ flakeModules, ... }:
{
  imports = [
    flakeModules.nixos.wayland
    flakeModules.nixos.hyprland
    flakeModules.nixos.greetd
    flakeModules.nixos.playerctld
    flakeModules.nixos.kdeconnect
    # flakeModules.nixos.flatpak
    flakeModules.nixos.avahi
  ];
}
