{
  lib,
  config,
  pkgs,
  namespace,
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
    virtualisation.docker.enable = true;

    environment.systemPackages = with pkgs; [ docker-compose ];
  };
}
