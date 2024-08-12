{
  lib,
  config,
  namespace,
  ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.security.sudo;
in
{
  options.${namespace}.security.sudo = with types; {
    enable = mkBoolOpt false "Enable sudo.";
  };

  config = mkIf cfg.enable {
    security.sudo = {
      enable = true;
      wheelNeedsPassword = true;
    };
  };
}
