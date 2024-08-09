{
  options,
  config,
  lib,
  namespace,
  ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.archetypes.laptop;
in
{
  options.${namespace}.archetypes.laptop = with types; {
    enable = mkBoolOpt false "Whether or not to enable the laptop archetype.";
  };

  config = mkIf cfg.enable {
    services.logind.lidSwitch = "ignore";

    services.tlp.enable = mkForce false;

    ${namespace} = {

      suites = {
        common = enabled;
        desktop = enabled;
        development = enabled;
      };

      services = {
        # TODO:
        # tlp = enabled;
      };

    };
  };
}
