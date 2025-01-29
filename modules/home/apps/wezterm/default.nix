{ inputs, system, ... }:
{
  programs.wezterm = {
    enable = false;
    package = inputs.wezterm.packages.${system}.default;
    enableZshIntegration = true;
    enableBashIntegration = true;
    extraConfig = ''
      return {
        color_scheme = 'tokyonight-storm',
        enable_tab_bar = false,
        window_decorations = 'NONE',
        },
      }
    '';
  };
}
