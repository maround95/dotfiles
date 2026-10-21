{ ... }:
{
  flake.modules.nixos.udev = { ... }: {
    # Fix Logitech G502 receiver preventing sleep.
    services.udev.extraRules = ''
      ACTION=="add", SUBSYSTEM=="usb", DRIVERS=="usb", ATTRS{idVendor}=="046d", ATTRS{idProduct}=="c547", ATTR{power/wakeup}="disabled"
    '';
  };
}
