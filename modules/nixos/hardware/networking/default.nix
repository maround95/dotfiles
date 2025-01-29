{
  options,
  config,
  lib,
  namespace,
  ...
}:
with lib;
with lib.custom;
let
  cfg = config.custom.hardware.networking;
in
{
  options.custom.hardware.networking = with types; {
    enable = mkBoolOpt false "Whether to enable networking.";
  };

  config = mkIf cfg.enable {
    custom.user.extraGroups = [ "networkmanager" ];

    networking = {
      wireless.iwd.enable = true;

      hosts = {
        "127.0.0.1" = [ "local.test" ];
      };

      networkmanager = {
        wifi.backend = "iwd";
        enable = true;
        dhcp = "internal";
      };

      firewall.enable = true;
    };
  };
}
