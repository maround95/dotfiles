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
  cfg = config.custom.system.time;
in
{
  options.custom.system.time = with types; {
    enable = mkBoolOpt false "Whether to manage timezone configuration.";
    timezone = mkOpt str "Asia/Jerusalem" "Timezone to set for system";
  };

  config = mkIf cfg.enable { time.timeZone = cfg.timezone; };
}
