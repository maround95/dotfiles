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
  cfg = config.custom.system.latest-kernel;
in
{
  options.custom.system.latest-kernel = with types; {
    enable = mkBoolOpt false "Whether to use the latest kernel.";
  };

  config = mkIf cfg.enable { boot.kernelPackages = pkgs.linuxPackages_latest; };
}
