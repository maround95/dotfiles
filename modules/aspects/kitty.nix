{ ... }:
{
  flake.modules.homeManager.kitty = { ... }: {
    programs.kitty = {
      enable = true;

      settings = {
        font_family = "FiraCode Nerd Font";
        font_size = 13;
        resize_in_steps = true;

        scrollback_lines = 10000;
        enable_audio_bell = false;
        update_check_interval = 0;
        cursor_blink_interval = 0;
        cursor_trail = 0;

        disable_ligatures = "cursor";

        mouse_hide_wait = -2.0;
        macos_option_as_alt = true;
      };
    };
  };
}
