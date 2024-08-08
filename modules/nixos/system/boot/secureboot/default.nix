{
  inputs,
  options,
  config,
  pkgs,
  lib,
  namespace,
  ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.system.boot.secureboot;
in
{
  imports = [ inputs.lanzaboote.nixosModules.lanzaboote ];

  options.${namespace}.system.boot.secureboot = with types; {
    enable = mkBoolOpt false "Whether to enable secureboot management and signing.";
  };

  config = mkIf cfg.enable {
    boot.lanzaboote.enable = true;
    boot.loader.systemd-boot.enable = mkForce false;
    boot.lanzaboote.pkiBundle = "/etc/secureboot";

    environment.systemPackages = with pkgs; [ sbctl ];
  };
}
