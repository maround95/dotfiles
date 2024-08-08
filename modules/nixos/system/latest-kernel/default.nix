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
  cfg = config.${namespace}.system.latest-kernel;
in
{
  options.${namespace}.system.latest-kernel = with types; {
    enable = mkBoolOpt false "Whether to use the latest kernel.";
  };

  config = mkIf cfg.enable { boot.kernelPackages = pkgs.linuxPackages_latest; };
}
