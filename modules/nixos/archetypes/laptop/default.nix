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
  cfg = config.custom.archetypes.laptop;
in
{
  options.custom.archetypes.laptop = with types; {
    enable = mkBoolOpt false "Whether or not to enable the laptop archetype.";
  };

  config = mkIf cfg.enable {
    # services.logind.lidSwitch = "ignore";
    services.logind.settings.Login.HandleLidSwitch = "ignore";

    services.tlp.enable = mkForce false;

    custom = {

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
