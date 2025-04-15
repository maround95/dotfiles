{
  options,
  config,
  lib,
  pkgs,
  namespace,
  ...
}:
with lib;
with lib.custom;
let
  cfg = config.custom.desktop.extras.wayland;
in
{
  options.custom.desktop.extras.wayland = with types; {
    enable = mkBoolOpt false "Enable Wayland Extras.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      wdisplays
      wl-clipboard
      wayland-utils # wayland-info
    ];

    environment.sessionVariables = {
      NIXOS_OZONE_WL = "1";
    };
  };
}
