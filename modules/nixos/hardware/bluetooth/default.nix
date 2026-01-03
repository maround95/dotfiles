{
  config,
  lib,
  namespace,
  ...
}:
with lib;
with lib.custom;
let
  cfg = config.custom.hardware.bluetooth;
in
{
  options.custom.hardware.bluetooth = with types; {
    enable = mkBoolOpt false "Whether to enable bluetooth.";
  };

  config = mkIf cfg.enable {
    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;

      settings = {
          General = {
              Experimental = true;
              KernelExperimental = true;
            };
        };
    };

    services.blueman.enable = true;
  };
}
