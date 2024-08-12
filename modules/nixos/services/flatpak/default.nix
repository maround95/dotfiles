{
  lib,
  config,
  namespace,
  ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.services.flatpak;
in
{
  options.${namespace}.services.flatpak = with types; {
    enable = mkBoolOpt false "Enable flatpak service.";
  };

  config = mkIf cfg.enable {
    services.flatpak = {
      enable = true;
    };
  };
}
