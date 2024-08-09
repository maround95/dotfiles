self@{ pkgs, inputs, ... }:
let 
  # Zellij tmux mode os binding
  zjBinding = self.osConfig.my.keybinds.bindings.zellij or null;
  zjKeycodeStr = toString zjBinding.xkbKeycode;
  zjUnicodeBind = toString zjBinding.unicodeString;
in {
  programs.wezterm = {
    enable = false;
    package = inputs.wezterm.packages.${pkgs.system}.default;
    enableZshIntegration = true;
    enableBashIntegration = true;
    extraConfig = ''
      return {
        color_scheme = 'tokyonight-storm',
        enable_tab_bar = false,
        window_decorations = 'NONE',

        keys = {
          ${ if zjBinding == null then "" else ''
            { key = 'raw:${zjKeycodeStr}', action = wezterm.action.SendString '${zjUnicodeBind}', },
          ''}
        },
      }
    '';
  };
}
