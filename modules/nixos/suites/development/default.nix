{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.custom.suites.development;
in {
  options.custom.suites.development = with types; {
    enable = mkBoolOpt false "Whether or not to enable common development configuration.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [fenix.minimal.toolchain gcc python3 distrobox];
    custom = {
      services = {
        libvirt = enabled;
        podman = enabled;
      };

      tools = {
        git = enabled;
      };
    };
  };
}
