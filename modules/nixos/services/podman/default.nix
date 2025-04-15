{
  lib,
  config,
  pkgs,
  ...
}:
with lib;
with lib.custom;
let
  cfg = config.custom.services.podman;
in
{
  options.custom.services.podman = with types; {
    enable = mkBoolOpt false "Enable the Podman Service.";
  };

  config = mkIf cfg.enable {
    virtualisation = {
      containers.enable = true;
      podman = {
        enable = true;

        dockerCompat = false;

        defaultNetwork.settings.dns_enabled = true;
      };
    };

    environment.systemPackages = with pkgs; [
      dive
      podman-tui
      podman-compose
    ];
  };
}
