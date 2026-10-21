{ ... }:
{
  flake.modules.nixos.plasma = { ... }: {
    services.desktopManager.plasma6.enable = true;

    custom.desktop.sessions.plasma = {
      name = "plasma";
      cmd = "startplasma-wayland";
    };
  };
}
