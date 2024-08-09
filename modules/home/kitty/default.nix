self@{ lib, ... }:
let
  # Zellij tmux mode os binding
  zjBinding = self.osConfig.my.keybinds.bindings.zellij or null;
  zjXKBSymHex = toString zjBinding.xkbSymHex;
  zjUnicodeBind = toString zjBinding.unicodeString;
in
{

  programs.kitty = {
    enable = true;
    theme = "Catppuccin-Macchiato";
    settings = {
      font_family = "FiraCode Nerd Font";
      font_size = 12;
      resize_in_steps = true;

      scrollback_lines = 10000;
      enable_audio_bell = false;
      update_check_interval = 0;
      cursor_blink_interval = 0; # Disable blinking cursor
    };

    keybindings = { } // lib.optionalAttrs (zjBinding != null) {
      ${zjXKBSymHex} = "send_text all ${zjUnicodeBind}";
    };
  };

}
