{ ... }:
{
  flake.modules.homeManager.profile-user = ./user.nix;
  flake.modules.homeManager.profile-base = ./base.nix;
  flake.modules.homeManager.profile-shell-maroun = ./shell-maroun.nix;
  flake.modules.homeManager.profile-shell-root = ./shell-root.nix;
  flake.modules.homeManager.profile-desktop-hyprland = ./desktop-hyprland.nix;
  flake.modules.homeManager.profile-desktop-darwin = ./desktop-darwin.nix;
  flake.modules.homeManager.profile-wsl = ./wsl.nix;
}
