{
  lib,
  config,
  pkgs,
  namespace,
  ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.services.docker;
in
{
  options.${namespace}.services.docker = with types; {
    enable = mkBoolOpt false "Enable Docker.";
  };

  config = mkIf cfg.enable {
    virtualisation.docker.enable = true;

    environment.systemPackages = with pkgs; [ docker-compose ];
  };
}
