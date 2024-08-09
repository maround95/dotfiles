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
in
{
  options.${namespace}.desktop.hyprland = with types; {
    enable = mkBoolOpt false "Enable Hyprland.";
    xwayland = mkBoolOpt false "Enable Hyprland XWayland support.";
  };

  config = mkIf cfg.enable {

    ${namespace}.desktop.display-manager = {
      defaultSession = "hyprland";
      defaultSessionCmd = "Hyprland";
    };

    programs.hyprland = {
      inherit package;

      enable = true;
      xwayland.enable = true;
    };

  };
}
