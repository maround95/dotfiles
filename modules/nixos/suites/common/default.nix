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
  cfg = config.${namespace}.suites.common;
in
{
  options.${namespace}.suites.common = with types; {
    enable = mkBoolOpt false "Whether or not to enable common configuration.";
  };

  config = mkIf cfg.enable {

    ${namespace} = {

      cli-apps = {
        flake = enabled;
      };

      hardware = {
        audio = enabled;
        networking = enabled;
      };

      nix = enabled;

      services = {
        kanata = enabled;
        ntp = enabled;
      };

      system = {
        boot.systemd-boot = enabled;
        boot.systemd-initrd = enabled;
        boot.secureboot = enabled;
        console = enabled;
        fonts = enabled;
        latest-kernel = enabled;
        locale = enabled;
        time = enabled;
        xkb = enabled;
      };

      tools = {
        misc = enabled;
      };

    };
  };
}
