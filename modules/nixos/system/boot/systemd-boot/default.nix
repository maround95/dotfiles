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
  cfg = config.${namespace}.system.boot.systemd-boot;
in
{
  options.${namespace}.system.boot.systemd-boot = with types; {
    enable = mkBoolOpt false "Whether to enable systemd-boot.";
  };

  config = mkIf cfg.enable {
    boot.loader.systemd-boot.enable = mkDefault true;
    boot.loader.systemd-boot.configurationLimit = 8;
    boot.loader.efi.canTouchEfiVariables = true;
  };
}
