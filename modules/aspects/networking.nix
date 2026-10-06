{ ... }:
{
  flake.modules.nixos.networking =
    {
      lib,
      config,
      pkgs,
      ...
    }:
    let
      cfg = config.custom.hardware.networking;
    in
    {
      options.custom.hardware.networking.wifi.backend = lib.mkOption {
        type = lib.types.enum [
          "wpa_supplicant"
          "iwd"
        ];
        default = "iwd";
        description = "Wi-Fi backend used by NetworkManager.";
      };

      config = {
        custom.primaryUserExtraGroups = [ "networkmanager" ];

        networking = {
          wireless = {
            iwd.enable = cfg.wifi.backend == "iwd";
            userControlled = cfg.wifi.backend == "wpa_supplicant";
            allowAuxiliaryImperativeNetworks = true;
          };

          hosts."127.0.0.1" = [ "local.test" ];

          networkmanager = {
            enable = true;
            wifi.backend = cfg.wifi.backend;
            dhcp = "internal";
          };

          firewall = {
            enable = true;
            # backend = lib.mkOption {
            #   type = lib.types.enum [
            #     "iptables"
            #     "nftables"
            #     "firewalld"
            #   ];
            #   default =
            #     if config.services.firewalld.enable then
            #       "firewalld"
            #     else if config.networking.nftables.enable then
            #       "nftables"
            #     else
            #       "iptables";
            #   defaultText = lib.literalExpression ''
            #     if config.services.firewalld.enable then
            #       "firewalld"
            #     else if config.networking.nftables.enable then
            #       "nftables"
            #     else
            #       "iptables"
            #   '';
            #   description = ''
            #     Underlying implementation for the firewall service.
            #   '';
            # };
          };
        };

        environment.systemPackages = with pkgs; [
          ifmetric
          tcpdump
          socat
          stun
        ];
      };
    };
}
