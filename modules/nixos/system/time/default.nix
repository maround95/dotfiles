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
  cfg = config.${namespace}.system.time;
in
{
  options.${namespace}.system.time = with types; {
    enable = mkBoolOpt false "Whether to manage timezone configuration.";
    timezone = mkOpt str "Asia/Jerusalem" "Timezone to set for system";
  };

  config = mkIf cfg.enable { time.timeZone = cfg.timezone; };
}
