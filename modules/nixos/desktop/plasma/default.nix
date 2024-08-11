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
  cfg = config.${namespace}.desktop.plasma;
  dePriority = mkOverride 2;
in
{
  options.${namespace}.desktop.plasma = with types; {
    enable = mkBoolOpt false "Enable Plasma 6 DE.";
  };

  config = mkIf cfg.enable {

    ${namespace}.desktop = {
      extras.wayland = enabled;

      display-manager = {
        defaultSession = dePriority "plasma";
        defaultSessionCmd = dePriority "startplasma-wayland";
      };
    };

    services.desktopManager.plasma6.enable = true;
  };
}
