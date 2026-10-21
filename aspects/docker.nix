{ ... }:
{
  flake.modules.nixos.docker = { pkgs, ... }: {
    virtualisation = {
      containers.enable = true;
      docker.enable = true;
    };

    custom.primaryUserExtraGroups = [ "docker" ];

    environment.systemPackages = with pkgs; [
      docker-compose
    ];
  };
}
