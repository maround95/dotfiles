{ ... }:
{
  flake.modules.nixos.podman = { pkgs, ... }: {
    virtualisation = {
      containers.enable = true;

      podman = {
        enable = true;
        dockerCompat = false;
        defaultNetwork.settings.dns_enabled = true;
      };
    };

    users.groups.podman = { };

    custom.primaryUserExtraGroups = [ "podman" ];

    environment.systemPackages = with pkgs; [
      dive
      podman-tui
      podman-compose
    ];
  };
}
