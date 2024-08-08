{ pkgs, ... }:

let
  # This file was obtained from the display while "Discrete" mode was enabled.
  l5p_edid = pkgs.runCommandNoCC "l5p_edid" {} ''
    mkdir -p $out/lib/firmware/edid
    cp ${./16ach6h.bin} $out/lib/firmware/edid/16ach6h.bin
  '';
in
{
  hardware.display.edid.packages = [ l5p_edid ];

  # For some reason, the internal display is sometimes eDP-1, and sometimes it's eDP-2
  hardware.display.outputs."eDP-1".edid = "16ach6h.bin";
  hardware.display.outputs."eDP-2".edid = "16ach6h.bin";
}
