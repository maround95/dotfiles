{
  lib,
  config,
  namespace,
  ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.services.ntp;
in
{
  options.${namespace}.services.ntp = with types; {
    enable = mkBoolOpt false "Enable NTP support.";
  };

  config = mkIf cfg.enable {
    # networking.timeServers = options.networking.timeServers.default ++ [ "0.arch.pool.ntp.org" ];
    services.ntp.enable = true;
  };
}
