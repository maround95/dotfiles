{
  config,
  lib,
  pkgs,
  namespace,
  inputs,
  ...
}:
with lib;
with lib.custom;
let
  cfg = config.custom.apps.librewolf;
in
{
  options.custom.apps.librewolf = with types; {
    enable = mkBoolOpt true "Whether or not to enable LibreWolf.";
  };

  config = mkIf cfg.enable {
    programs.librewolf = {
      enable = true;
      settings = {
        "privacy.clearOnShutdown.history" = false;
        "privacy.clearOnShutdown.cookies" = false;
        "network.cookie.lifetimePolicy" = 0;
      };
    };
  };
}
