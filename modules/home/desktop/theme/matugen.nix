{}
# { config, lib, pkgs, namespace, inputs, ... }:
# with lib;
# with lib.${namespace};
# let
#   cfg = config.${namespace}.programs.matugen;
#   templates = cfg.config.templates;
#   package = inputs.matugen.packages.${pkgs.system}.default;
#
#   configToml = pkgs.formats.toml.generate "config.toml" {
#     config = cfg.config;
#   };
# in {
#
#   options.${namespace}.programs.matugen = {
#     enable = mkBoolOpt true "Enable Matugen and integrations.";
#     config = mkOption {
#       description = "Mutagen config to be serialized to toml.";
#       type = lib.types.attrs;
#       default = {};
#     };
#   };
#
#   # config.home.packages = [ package ];
#
#   # config.home.configFile."matugen/config.toml".source = configToml;
#
#   # ${templates}.kitty.input_path = "${inputs.matugen-templates}/templates/kitty-colors.conf";
#   # ${templates}.kitty.output_path = config.home.configFile."kitty/colors.conf";
#   # config.programs.kitty.extraConfig = "include colors.conf";
#
#   # programs.matugen = {
#   #   enable = true;
#   #   variant = "dark";
#   #   jsonFormat = "hex";
#   #
#   #   config = {
#   #     reload_apps = true;
#   #     set_wallpaper = true;
#   #     wallpaper_tool = "Swww";
#   #     prefix = "@";
#   #     swww_options = [
#   #       "--transition-type"
#   #       "fade"
#   #       "--transition-step"
#   #       "90"
#   #       "--transition-duration"
#   #       "2"
#   #       "--transition-fps"
#   #       "90"
#   #     ];
#   #   };
#   #
#   #   # templates = {
#   #   #   ags = {
#   #   #     input_path = "./templates/ags.scss";
#   #   #     output_path = "~/.config/ags/scss/colors.scss";
#   #   #   };
#   #   #
#   #   #   kitty = {
#   #   #     input_path = "./templates/kitty.conf";
#   #   #     output_path = "~/.config/kitty/colors.conf";
#   #   #   };
#   #   #
#   #   #   gtk = {
#   #   #     input_path = "./templates/gtk.css";
#   #   #     output_path = "~/.config/gtk-4.0/gtk.css";
#   #   #   };
#   #   #
#   #   #   hypr = {
#   #   #     input_path = "./templates/hypr.conf";
#   #   #     output_path = "~/.config/hypr/colors.conf";
#   #   #   };
#   #   #
#   #   #   yazi = {
#   #   #     input_path = "./templates/yazi.toml";
#   #   #     output_path = "~/.config/yazi/theme.toml";
#   #   #   };
#   #   # };
#   # };
#
# }
