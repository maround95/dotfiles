{
  lib,
  config,
  pkgs,
  ...
}:
with lib;
with lib.custom;
let
  cfg = config.custom.services.docker;
in
{
  options.custom.services.docker = with types; {
    enable = mkBoolOpt false "Enable Docker.";
  };

  config = mkIf cfg.enable {
    virtualisation.containers.enable = true;
    virtualisation.docker.enable = true;

    custom.user.extraGroups = [ "docker" ];

    environment.systemPackages = with pkgs; [ docker-compose ];
  };
}
