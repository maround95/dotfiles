{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.custom;
let
  cfg = config.custom.system.udev;
in
{
  options.custom.system.udev = with types; {
    enable = mkBoolOpt true "Use custom udev settings";
  };

  config = mkIf cfg.enable {

    # Fix Logitech G502 reciever preventing sleep
    services.udev.extraRules = ''
      ACTION=="add", SUBSYSTEM=="usb", DRIVERS=="usb", ATTRS{idVendor}=="046d", ATTRS{idProduct}=="c547", ATTR{power/wakeup}="disabled"
    '';
  };
}
