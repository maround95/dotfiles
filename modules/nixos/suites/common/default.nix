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
  cfg = config.custom.suites.common;
in
{
  options.custom.suites.common = with types; {
    enable = mkBoolOpt false "Whether or not to enable common configuration.";
  };

  config = mkIf cfg.enable {

    custom = {

      cli-apps = {
        flake = enabled;
      };

      hardware = {
        audio = enabled;
        bluetooth = enabled;
        networking = enabled;
      };

      nix = enabled;

      security = {
        polkit = enabled;
        sops = enabled;
        sudo = enabled;
      };

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
        nix-ld = enabled;
      };

    };
  };
}
