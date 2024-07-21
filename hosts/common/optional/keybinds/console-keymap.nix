# Linux's uapi event codes: https://github.com/torvalds/linux/blob/master/include/uapi/linux/input-event-codes.h#L75
# XF86 keysyms: https://cgit.freedesktop.org/xorg/proto/x11proto/tree/XF86keysym.h
{ pkgs, bindings, ... }:

let
  keymapName = "maroun";

  generateUnicodeDirectives = binding: ''
    echo "keycode ${toString binding.keycode} = U+${binding.unicodeCP}" >> $out/share/keymaps/${keymapName}.map
  '';
  generateEscapeSequenceDirectives = _: throw "NotImplemented!!";

  generateDirectives = _: binding:
    if !builtins.isNull binding.unicodeCP then generateUnicodeDirectives binding
    else if !builtins.isNull binding.escapeSequence then generateEscapeSequenceDirectives binding
    else throw "Could not generate directives";

  directives = pkgs.lib.concatLines (pkgs.lib.mapAttrsToList generateDirectives bindings);
in
{
  inherit keymapName;

  package = pkgs.stdenv.mkDerivation {
    name = "${keymapName}-console-keymap";

    buildCommand = ''
      mkdir -p $out/share/keymaps

      ### Use the default US keymap ###
      zcat ${pkgs.kbd}/share/keymaps/i386/qwerty/us.map.gz > $out/share/keymaps/${keymapName}.map

      ### Append custom keymap lines ###
      # Zellij - [Console kc: 120, Console default sym: None]
      # Zellij - [XKB kc: 128, XKB default sym: XF86LaunchA (0x1008FF4A)]
      # Zellij - output utf-8 PUA (0e00); zellij can bind unicode chars but not escape sequences

      #echo "keycode 120 = U+0e00" >> $out/share/keymaps/${keymapName}.map
      ${directives}

      ### Compress the final keymap ###
      gzip $out/share/keymaps/${keymapName}.map
    '';
  };
}
