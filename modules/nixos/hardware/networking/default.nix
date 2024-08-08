{
  options,
  config,
  lib,
  namespace,
  ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.hardware.networking;
in
{
  options.${namespace}.hardware.networking = with types; {
    enable = mkBoolOpt false "Whether to enable networking.";
  };

  config = mkIf cfg.enable {
    ${namespace}.user.extraGroups = [ "networkmanager" ];

    networking = {
      hosts = {
        "127.0.0.1" = [ "local.test" ];
      };

      networkmanager = {
        enable = true;
        dhcp = "internal";
      };

      firewall.enable = true;
    };
  };
}
