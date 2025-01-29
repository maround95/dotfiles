{
  config,
  lib,
  namespace,
  ...
}:
with lib;
with lib.custom;
let
  cfg = config.custom.suites.development;
in
{
  options.custom.suites.development = with types; {
    enable = mkBoolOpt false "Whether or not to enable common development configuration.";
  };

  config = mkIf cfg.enable {
    custom = {

      services = {
        docker = enabled;
        libvirt = enabled;
      };

      tools = {
        git = enabled;
      };
    };
  };
}
