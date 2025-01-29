{
  options,
  config,
  lib,
  pkgs,
  namespace,
  ...
}:
with lib;
with lib.custom;
let
  cfg = config.custom.desktop.sway;
  dePriority = mkOverride 3;
in
{
  options.custom.desktop.sway = with types; {
    enable = mkBoolOpt false "Enable Sway.";
  };

  config = mkIf cfg.enable {

    custom.desktop = {
      extras.wayland = enabled;

      display-manager = {
        defaultSession = dePriority "sway";
        defaultSessionCmd = dePriority "sway";
      };
    };

    programs.sway.enable = true;

  };
}
