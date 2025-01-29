{
  lib,
  config,
  namespace,
  ...
}:
with lib;
with lib.custom;
let
  cfg = config.custom.services.kdeconnect;
in
{
  options.custom.services.kdeconnect = with types; {
    enable = mkBoolOpt false "Enable KDE connect.";
  };

  config = mkIf cfg.enable {
    # networking.timeServers = options.networking.timeServers.default ++ [ "0.arch.pool.ntp.org" ];
    programs.kdeconnect.enable = true;

    networking.firewall = rec {
      allowedTCPPortRanges = [ { from = 1714; to = 1764; } ];
      allowedUDPPortRanges = allowedTCPPortRanges;
    };
  };
}
