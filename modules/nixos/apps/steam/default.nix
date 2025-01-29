{
  config,
  lib,
  pkgs,
  namespace,
  ...
}:
with lib;
with lib.custom;
let
  cfg = config.custom.apps.steam;
in
{
  options.custom.apps.steam = with types; {
    enable = mkBoolOpt false "Whether or not to enable Steam.";
  };

  config = mkIf cfg.enable {
    programs.steam.enable = true;
    environment.sessionVariables = {
      STEAM_EXTRA_COMPAT_TOOLS_PATHS = "$HOME/.steam/root/compatibilitytools.d";
    };

    # programs.steam.remotePlay.openFirewall = true;
    # hardware.steam-hardware.enable = true;
    # Enable GameCube controller support.
    # services.udev.packages = [pkgs.dolphinEmu];
    # environment.systemPackages = with pkgs; [ steam ];
  };
}
