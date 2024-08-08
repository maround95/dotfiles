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
  cfg = config.${namespace}.system.xkb;
in
{
  options.${namespace}.system.xkb = with types; {
    enable = mkBoolOpt false "Whether to manage xkb configuration.";
  };

  config = mkIf cfg.enable {
    services.xserver.xkb = {
      layout = "us";
    };
  };
}
