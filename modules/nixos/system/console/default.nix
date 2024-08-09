{
  lib,
  config,
  namespace,
  ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.system.console;
in
{
  options.${namespace}.system.console = with types; {
    enable = mkBoolOpt false "Whether to configure console settings.";
  };

  config = mkIf cfg.enable {
    console = {
      earlySetup = true;
      useXkbConfig = true;
    };
  };
}
