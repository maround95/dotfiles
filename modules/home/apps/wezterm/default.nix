{ ... }:
{
  programs.wezterm = {
    enable = false;
    enableZshIntegration = true;
    enableBashIntegration = true;
    extraConfig = ''
      return {
        color_scheme = 'tokyonight-storm',
        enable_tab_bar = false,
        window_decorations = 'NONE',
      }
    '';
  };
}
