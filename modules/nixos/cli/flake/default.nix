{
  options,
  config,
  lib,
  pkgs,
  namespace,
  ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.cli-apps.flake;
in
{
  options.${namespace}.cli-apps.flake = with types; {
    enable = mkBoolOpt false "Whether or not to enable flake cli app.";
  };

  config = mkIf cfg.enable { environment.systemPackages = with pkgs; [ snowfallorg.flake ]; };
}
