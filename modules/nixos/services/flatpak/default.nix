{
  lib,
  config,
  pkgs,
  ...
}:
with lib;
with lib.custom;
let
  cfg = config.custom.services.flatpak;
in
{
  options.custom.services.flatpak = with types; {
    enable = mkBoolOpt false "Enable flatpak service.";
  };

  config = mkIf cfg.enable {
    services.flatpak.enable = true;
    systemd.services.flathub-repo = {
      wantedBy = [ "multi-user.target" ];
      path = [ pkgs.flatpak ];
      script = ''
        flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
      '';
    };
  };
}
