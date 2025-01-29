{
  lib,
  config,
  namespace,
  ...
}:
with lib;
with lib.custom;
let
  cfg = config.custom.services.flatpak;
in
{
  options.custom.services.flatpak = with types; {
    enable = mkBoolOpt false "Enable flatpak service.";
  };

  config = mkIf cfg.enable {
    services.flatpak = {
      enable = true;
    };
  };
}
