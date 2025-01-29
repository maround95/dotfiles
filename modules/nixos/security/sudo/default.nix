{
  lib,
  config,
  namespace,
  ...
}:
with lib;
with lib.custom;
let
  cfg = config.custom.security.sudo;
in
{
  options.custom.security.sudo = with types; {
    enable = mkBoolOpt false "Enable sudo.";
  };

  config = mkIf cfg.enable {
    security.sudo = {
      enable = true;
      wheelNeedsPassword = false;
    };
  };
}
