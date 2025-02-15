{
  inputs,
  config,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.custom;
let
  cfg = config.custom.system.boot.secureboot;
in
{
  imports = [ inputs.lanzaboote.nixosModules.lanzaboote ];

  options.custom.system.boot.secureboot = with types; {
    enable = mkBoolOpt false "Whether to enable secureboot management and signing.";
  };

  config = mkIf cfg.enable {
    boot.loader.systemd-boot.enable = mkForce false;
    boot.lanzaboote.enable = true;
    boot.lanzaboote.pkiBundle = "/etc/secureboot";
    boot.lanzaboote.settings = config.custom.system.boot.systemd-boot.settings;

    environment.systemPackages = with pkgs; [ sbctl ];
  };
}
