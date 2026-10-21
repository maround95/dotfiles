{ ... }:
{
  flake.modules.nixos.sshd = { ... }: {
    services.openssh.enable = true;
  };
}
