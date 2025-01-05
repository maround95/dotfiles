{
  config,
  lib,
  namespace,
  ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.suites.desktop;
in
{
  options.${namespace}.suites.desktop = with types; {
    enable = mkBoolOpt false "Whether or not to enable common desktop configuration.";
  };

  config = mkIf cfg.enable {

    ${namespace} = {

      apps = {
        brave = enabled;
        firefox = enabled;
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
