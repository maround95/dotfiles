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
  cfg = config.custom.desktop.plasma;
  dePriority = mkOverride 2;
in
{
  options.custom.desktop.plasma = with types; {
    enable = mkBoolOpt false "Enable Plasma 6 DE.";
  };

  config = mkIf cfg.enable {

    custom.desktop = {
      extras.wayland = enabled;

      display-manager = {
        defaultSession = dePriority "plasma";
        defaultSessionCmd = dePriority "startplasma-wayland";
      };
    };

    services.desktopManager.plasma6.enable = true;
  };
}
