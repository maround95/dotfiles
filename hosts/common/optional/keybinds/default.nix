{ config, options, pkgs, lib, ... }:

with lib;

let
  bindings = config.my.keybinds.bindings;
  consoleKeymap = pkgs.callPackage ./console-keymap.nix { inherit pkgs bindings; };

  bindingsSubmodule = { config, name, ... }: {
    options = {
      keycode = mkOption {
        type = types.int;
        description = "Linux UAPI Keycode";
      };
      xkbKeycode = mkOption {
        type = types.int;
        default = config.keycode + 8;
        description = "XKB Keycode";
      };
      xkbSymHex = mkOption {
        type = types.nullOr types.str;
        default = null;
        description = "XKB Symbol code in hex (0x) format.";
      };
      unicodeCP = mkOption {
        type = types.nullOr types.str;
        default = null;
        description = "Unicode code point sent by terminal/console";
      };
      unicodeString = mkOption {
        type = types.nullOr types.str;
        default = if config.unicodeCP == null then null else (builtins.fromJSON ''"\u${config.unicodeCP}"'');
        readOnly = true;
        description = "String containing the unicode character if present";
      };
      escapeSequence = mkOption {
        type = types.nullOr types.str;
        default = null;
        description = "Escape sequence sent by terminal/console";
      };
    };
  };
in {
  options.my.keybinds = {
    bindings = lib.mkOption {
      type = types.attrsOf (types.submodule bindingsSubmodule);
      description = "Bindings which should happen at the console/xkb keymap level";
      readOnly = true;
    };
  };

  # Enable kanata
  config.services.kanata = {
    enable = true;

    # Share the same config for all keyboards.
    keyboards."all".configFile = ./kanata.cfg;
  };

  config.my.keybinds.bindings = { "zellij" = { keycode = 120; unicodeCP = "0e00"; xkbSymHex = "0x1008FF4A"; }; };

  # Use custom console keymap.
  config.console = {
    earlySetup = true;
    # packages = [ consoleKeymap.package ];
    # keyMap = consoleKeymap.keymapName;
    useXkbConfig = true;
  };

}
