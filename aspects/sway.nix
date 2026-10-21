{ ... }:
{
  flake.modules.nixos.sway = { ... }: {
    programs.sway.enable = true;

    custom.desktop.sessions.sway = {
      name = "sway";
      cmd = "sway";
    };
  };
}
