{
  lib,
  config,
  pkgs,
  namespace,
  ...
}:
with lib;
with lib.custom;
let
  cfg = config.custom.security.polkit;
in
{
  options.custom.security.polkit = with types; {
    enable = mkBoolOpt false "Enable Polkit.";
  };

  config = mkIf cfg.enable {
    security.polkit.enable = true;
  };
}
