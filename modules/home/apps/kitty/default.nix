self@{ lib, ... }:
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

  };

}
