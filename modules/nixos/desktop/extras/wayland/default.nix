{
  options,
  config,
  lib,
  pkgs,
  namespace,
  ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.desktop.extras.wayland;
in
{
  options.${namespace}.desktop.extras.wayland = with types; {
    enable = mkBoolOpt false "Enable Wayland Extras.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      wl-clipboard
    ];

    environment.sessionVariables = {
      NIXOS_OZONE_WL = "1";
    };
  };
}
