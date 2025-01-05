{
  config,
  lib,
  pkgs,
  namespace,
  ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.apps.librewolf;
in
{
  options.${namespace}.apps.librewolf = with types; {
    enable = mkBoolOpt false "Whether or not to enable LibreWolf.";
  };

  config = mkIf cfg.enable { environment.systemPackages = with pkgs; [ librewolf ]; };
}
