{
  options,
  config,
  lib,
  pkgs,
  namespace,
  ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.desktop.sway;
  dePriority = mkOverride 3;
in
{
  options.${namespace}.desktop.sway = with types; {
    enable = mkBoolOpt false "Enable Sway.";
  };

  config = mkIf cfg.enable {

    ${namespace}.desktop = {
      extras.wayland = enabled;

      display-manager = {
        defaultSession = dePriority "sway";
        defaultSessionCmd = dePriority "sway";
      };
    };

    programs.sway.enable = true;

  };
}
