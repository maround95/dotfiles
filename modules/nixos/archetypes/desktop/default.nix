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
  cfg = config.${namespace}.archetypes.desktop;
in
{
  options.${namespace}.archetypes.desktop = with types; {
    enable = mkBoolOpt false "Whether or not to enable the desktop archetype.";
  };

  config = mkIf cfg.enable {
    ${namespace} = {

      suites = {
        common = enabled;
        desktop = enabled;
        development = enabled;
      };

    };
  };
}
