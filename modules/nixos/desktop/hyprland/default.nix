{
  options,
  config,
  lib,
  pkgs,
  namespace,
  inputs,
  ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.desktop.hyprland;
  package = inputs.hyprland.packages.${pkgs.system}.hyprland-debug;
  dePriority = mkOverride 1;
in
{
  options.${namespace}.desktop.hyprland = with types; {
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

    ${namespace} = {

      # Enable home-manager Hyprland config.
      home.extraOptions.${namespace}.desktop.hyprland = {
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
