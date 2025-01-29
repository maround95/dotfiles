{
  config,
  lib,
  system,
  inputs,
  ...
}:
with lib;
with lib.custom;
let
  cfg = config.custom.desktop.hyprland;
  package = inputs.hyprland.packages.${system}.hyprland-debug;
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
          defaultSessionCmd = dePriority "Hyprland";
        };
      };
    };

  };
}
