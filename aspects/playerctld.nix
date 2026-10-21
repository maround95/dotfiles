{ ... }:
{
  flake.modules.nixos.playerctld = { ... }: {
    services.playerctld.enable = true;
  };
}
