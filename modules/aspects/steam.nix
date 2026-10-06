{ ... }:
{
  flake.modules.nixos.steam = { ... }: {
    programs.steam.enable = true;

    environment.sessionVariables = {
      STEAM_EXTRA_COMPAT_TOOLS_PATHS = "$HOME/.steam/root/compatibilitytools.d";
    };
  };
}
