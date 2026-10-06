{ ... }:
{
  flake.modules.nixos.profile-common = ./common.nix;
  flake.modules.nixos.profile-laptop = ./laptop.nix;
  flake.modules.nixos.profile-development = ./development.nix;
  flake.modules.nixos.profile-development-docker = ./development-docker.nix;
  flake.modules.nixos.profile-desktop-hyprland = ./desktop-hyprland.nix;
}
