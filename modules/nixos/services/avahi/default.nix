{
  lib,
  config,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.custom.services.avahi;
in {
  options.custom.services.avahi = with types; {
    enable = mkBoolOpt false "Enable Avahi Daemon.";
  };

  config = mkIf cfg.enable {
    services.avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };
  };
}
