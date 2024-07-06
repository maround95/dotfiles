{ pkgs, inputs, ... }:
{
  programs.wezterm = {
    enable = true;
    package = inputs.wezterm.packages.${pkgs.system}.default;
    enableZshIntegration = true;
    enableBashIntegration = true;
    extraConfig = ''
      return {
        color_scheme = 'tokyonight-day',
        enable_tab_bar = false,
      }
    '';
  };
}
