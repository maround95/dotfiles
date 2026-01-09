{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.custom;
let
  cfg = config.custom.desktop.hyprland;
  package = pkgs.hyprland-git; # overlay
  dePriority = mkOverride 1;
in
{
  options.custom.desktop.hyprland = with types; {
    enable = mkBoolOpt false "Enable Hyprland.";
    enableHome = mkBoolOpt true "Enable Hyprland via home-manager.";
    enableXWayland = mkBoolOpt true "Enable Hyprland XWayland support.";
  };

  config = mkIf cfg.enable {

    programs.hyprland = {
      inherit package;

      enable = true;
      xwayland.enable = cfg.enableXWayland;
    };

    custom = {

      # Enable home-manager Hyprland config.
      home.extraOptions.custom.desktop.hyprland = {
        enable = cfg.enableHome;
        enableXWayland = cfg.enableXWayland;
      };

      desktop = {
        extras.wayland = enabled;

        display-manager = {
          defaultSession = dePriority "hyprland";
          defaultSessionCmd = dePriority "start-hyprland";
        };
      };
    };

  };
}
