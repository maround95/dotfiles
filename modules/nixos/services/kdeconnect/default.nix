{
  lib,
  config,
  namespace,
  ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.services.kdeconnect;
in
{
  options.${namespace}.services.kdeconnect = with types; {
    enable = mkBoolOpt false "Enable KDE connect.";
  };

  config = mkIf cfg.enable {
    # networking.timeServers = options.networking.timeServers.default ++ [ "0.arch.pool.ntp.org" ];
    programs.kdeconnect.enable = true;
  };
}
