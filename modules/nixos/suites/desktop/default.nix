{
  config,
  lib,
  namespace,
  ...
}:
with lib;
with lib.custom;
let
  cfg = config.custom.suites.desktop;
in
{
  options.custom.suites.desktop = with types; {
    enable = mkBoolOpt false "Whether or not to enable common desktop configuration.";
  };

  config = mkIf cfg.enable {

    custom = {

      apps = {
        brave = enabled;
        # firefox = enabled;
      };

      desktop = {

        display-manager = {
          greetd = enabled;
        };

        hyprland = enabled;
      };

      services = {
        kdeconnect = enabled;
        flatpak = enabled;
      };

    };
  };
}
