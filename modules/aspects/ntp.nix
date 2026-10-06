{ ... }:
{
  flake.modules.nixos.ntp = { ... }: {
    services.ntp.enable = true;
  };
}
