{
  lib,
  config,
  namespace,
  ...
}:
with lib;
with lib.custom;
let
  cfg = config.custom.system.console;
in
{
  options.custom.system.console = with types; {
    enable = mkBoolOpt false "Whether to configure console settings.";
  };

  config = mkIf cfg.enable {
    console = {
      earlySetup = true;
      useXkbConfig = true;
    };
  };
}
