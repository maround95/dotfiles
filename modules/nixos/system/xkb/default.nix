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
  cfg = config.custom.system.xkb;
in
{
  options.custom.system.xkb = with types; {
    enable = mkBoolOpt false "Whether to manage xkb configuration.";
  };

  config = mkIf cfg.enable {
    services.xserver.xkb = {
      layout = "us";
    };
  };
}
