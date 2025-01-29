{
  options,
  config,
  lib,
  pkgs,
  namespace,
  ...
}:
with lib;
with lib.custom;
let
  cfg = config.custom.cli-apps.flake;
in
{
  options.custom.cli-apps.flake = with types; {
    enable = mkBoolOpt false "Whether or not to enable flake cli app.";
  };

  config = mkIf cfg.enable { environment.systemPackages = with pkgs; [ snowfallorg.flake ]; };
}
