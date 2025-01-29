{
  options,
  config,
  lib,
  namespace,
  ...
}:
with lib;
with lib.custom;
let
  cfg = config.custom.archetypes.desktop;
in
{
  options.custom.archetypes.desktop = with types; {
    enable = mkBoolOpt false "Whether or not to enable the desktop archetype.";
  };

  config = mkIf cfg.enable {
    custom = {

      suites = {
        common = enabled;
        desktop = enabled;
        development = enabled;
      };

    };
  };
}
