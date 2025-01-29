{ config, ... }:
{
  home.file.".config/wallust/templates/zellij.kdl".text =
    # kdl
    ''
      themes {
        wallust {
          fg "{{foreground}}"
          bg "{{background}}"
          black "{{background}}"
          red "{{color1}}"
          green "{{color2}}"
          yellow "{{color3}}"
          orange "{{color11}}"
          blue "{{color4}}"
          magenta "{{color5}}"
          cyan "{{color6}}"
          white "{{color15}}"
        }
      }
    '';

  custom.wallust.settings.templates.zellij =
    let
      out = config.home.homeDirectory + "/.config/zellij/themes/wallust.kdl";
    in
    {
      template = "zellij.kdl";
      target = out;
    };
}
