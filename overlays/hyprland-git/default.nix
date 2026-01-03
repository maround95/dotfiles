{inputs, ...}: _: prev: let
  system = prev.stdenv.hostPlatform.system;
in {
  hyprland-git = inputs.hyprland.packages.${system}.hyprland;
}
