{
  lib,
  config,
  pkgs,
  namespace,
  ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.security.polkit;
in
{
  options.${namespace}.security.polkit = with types; {
    enable = mkBoolOpt false "Enable Polkit.";
  };

  config = mkIf cfg.enable {
    security.polkit.enable = true;
  };
}
