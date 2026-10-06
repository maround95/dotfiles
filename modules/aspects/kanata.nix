{ ... }:
{
  flake.modules.nixos.kanata = { ... }: {
    custom.primaryUserExtraGroups = [ "uinput" ];

    services.kanata = {
      enable = true;

      # Share the same config for all keyboards.
      keyboards."all".configFile = ./kanata.cfg;
    };
  };

  flake.modules.darwin.kanata = { lib, pkgs, ... }:
    let
      parentAppDir = "/Applications/.Nix-Karabiner";
    in
    {
      environment.systemPackages = with pkgs; [
        kanata
      ];

      system.activationScripts.preActivation.text = ''
        rm -rf ${parentAppDir}
        mkdir -p ${parentAppDir}
        # Kernel extensions must reside inside of /Applications, they cannot be symlinks.
        cp -r ${pkgs.karabiner-elements.driver}/Applications/.Karabiner-VirtualHIDDevice-Manager.app ${parentAppDir}
      '';

      # Activate the Karabiner virtual HID system extension.
      launchd.user.agents.activate_karabiner_system_ext = {
        serviceConfig = {
          ProgramArguments = [
            "${parentAppDir}/.Karabiner-VirtualHIDDevice-Manager.app/Contents/MacOS/Karabiner-VirtualHIDDevice-Manager"
            "activate"
          ];
          RunAtLoad = true;
        };
      };

      launchd.daemons.Karabiner-DriverKit-VirtualHIDDevice-Daemon = {
        command = ''"${pkgs.kanata.passthru.darwinDriver}/Library/Application Support/org.pqrs/Karabiner-DriverKit-VirtualHIDDevice/Applications/Karabiner-VirtualHIDDevice-Daemon.app/Contents/MacOS/Karabiner-VirtualHIDDevice-Daemon"'';
        serviceConfig = {
          ProcessType = "Interactive";
          Label = "org.pqrs.Karabiner-DriverKit-VirtualHIDDevice-Daemon";
          KeepAlive = true;
        };
      };

      launchd.daemons.kanata-internal = {
        # Also add the kanata binary to System Settings -> Privacy & Security -> Input Monitoring.
        command = "${lib.getExe pkgs.kanata} --cfg ${./kanata_internal.cfg}";
        serviceConfig = {
          ProcessType = "Interactive";
          Label = "org.nixos.kanata.internal";
          KeepAlive = true;
          StandardOutPath = "/tmp/kanata-internal.out.log";
          StandardErrorPath = "/tmp/kanata-internal.err.log";
        };
      };

      launchd.daemons.kanata-external = {
        # Also add the kanata binary to System Settings -> Privacy & Security -> Input Monitoring.
        command = "${lib.getExe pkgs.kanata} --cfg ${./kanata_external.cfg}";
        serviceConfig = {
          ProcessType = "Interactive";
          Label = "org.nixos.kanata.external";
          KeepAlive = true;
          StandardOutPath = "/tmp/kanata-external.out.log";
          StandardErrorPath = "/tmp/kanata-external.err.log";
        };
      };
    };
}
