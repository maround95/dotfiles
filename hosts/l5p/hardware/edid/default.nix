{ pkgs, ... }:

let
  # This file was obtained from the display while "DDG" mode was enabled.
  chip_edid = pkgs.runCommandNoCC "chip_edid" { compressFirmware = false; } ''
    mkdir -p $out/lib/firmware/edid
    cp ${./16ach6h.bin} $out/lib/firmware/edid/16ach6h.bin
  '';
in
{
  # remove once this the firmware loader is back in nixpkgs linux builds
  boot = {
    kernelPatches = [{
      name = "edid-loader-fix-config";
      patch = null;
      extraConfig = ''
        FW_LOADER y
      '';
    }];
  };

  hardware.firmware = [ chip_edid ];

  # For some reason, the internal display is sometimes eDP-1, and sometimes it's eDP-2
  boot.kernelParams = [ "drm.edid_firmware=eDP-1:edid/16ach6h.bin,eDP-2:edid/16ach6h.bin" ];
}
