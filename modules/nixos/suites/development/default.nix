{
  config,
  lib,
  namespace,
  ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.suites.development;
in
{
  options.${namespace}.suites.development = with types; {
    enable = mkBoolOpt false "Whether or not to enable common development configuration.";
  };

  config = mkIf cfg.enable {
    ${namespace} = {

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
