{
  lib,
  config,
  namespace,
  ...
}:
with lib;
with lib.custom;
let
  cfg = config.custom.services.ntp;
in
{
  options.custom.services.ntp = with types; {
    enable = mkBoolOpt false "Enable NTP support.";
  };

  config = mkIf cfg.enable {
    # networking.timeServers = options.networking.timeServers.default ++ [ "0.arch.pool.ntp.org" ];
    services.ntp.enable = true;
  };
}
