{
  lib,
  config,
  pkgs,
  ...
}:
with lib;
with lib.custom;
let
  cfg = config.custom.services.kanata;
  parentAppDir = "/Applications/.Nix-Karabiner";
in
{
  options.custom.services.kanata = with types; {
    enable = mkBoolOpt false "Enable kanata service.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      kanata
    ];

    system.activationScripts.preActivation.text = ''
      rm -rf ${parentAppDir}
      mkdir -p ${parentAppDir}
      # Kernel extensions must reside inside of /Applications, they cannot be symlinks
      cp -r ${pkgs.karabiner-elements.driver}/Applications/.Karabiner-VirtualHIDDevice-Manager.app ${parentAppDir}
    '';

    # activate extension
    launchd.user.agents.activate_karabiner_system_ext = {
      serviceConfig.ProgramArguments = [
        "${parentAppDir}/.Karabiner-VirtualHIDDevice-Manager.app/Contents/MacOS/Karabiner-VirtualHIDDevice-Manager"
        "activate"
      ];
      serviceConfig.RunAtLoad = true;
    };

    launchd.daemons.Karabiner-DriverKit-VirtualHIDDevice-Daemon = {
      command = "\"${pkgs.kanata.passthru.darwinDriver}/Library/Application Support/org.pqrs/Karabiner-DriverKit-VirtualHIDDevice/Applications/Karabiner-VirtualHIDDevice-Daemon.app/Contents/MacOS/Karabiner-VirtualHIDDevice-Daemon\"";
      serviceConfig.ProcessType = "Interactive";
      serviceConfig.Label = "org.pqrs.Karabiner-DriverKit-VirtualHIDDevice-Daemon";
      serviceConfig.KeepAlive = true;
    };

    launchd.daemons.kanata-internal = {
      # also need to add kanata binary to System Settings -> Privacy & Security -> Input Monitoring
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
      # also need to add kanata binary to System Settings -> Privacy & Security -> Input Monitoring
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
