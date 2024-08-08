{
  lib,
  config,
  namespace,
  ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.services.kanata;
in
{
  options.${namespace}.services.kanata = with types; {
    enable = mkBoolOpt false "Enable kanata service.";
  };

  config = mkIf cfg.enable {
    ${namespace}.user.extraGroups = [ "uinput" ];
    services.kanata = {
      enable = true;

      # Share the same config for all keyboards.
      keyboards."all".configFile = ./kanata.cfg;
    };
  };
}
