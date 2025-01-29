{
  lib,
  config,
  namespace,
  ...
}:
with lib;
with lib.custom;
let
  cfg = config.custom.services.kanata;
in
{
  options.custom.services.kanata = with types; {
    enable = mkBoolOpt false "Enable kanata service.";
  };

  config = mkIf cfg.enable {
    custom.user.extraGroups = [ "uinput" ];
    services.kanata = {
      enable = true;

      # Share the same config for all keyboards.
      keyboards."all".configFile = ./kanata.cfg;
    };
  };
}
