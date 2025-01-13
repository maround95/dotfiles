{ config, lib, pkgs, namespace, inputs, ... }:
with lib;
with lib.${namespace};
let
  package = inputs.matugen.packages.${pkgs.system}.default;

  cfg = {
    reload_apps = true;
    set_wallpaper = true;
    wallpaper_tool = "Swww";
    prefix = "@";
    swww_options = [
      "--transition-type"
      "fade"
      "--transition-step"
      "90"
      "--transition-duration"
      "2"
      "--transition-fps"
      "90"
    ];
  };

  templates = {
    kitty = {
      input_path = "${inputs.matugen-templates}/templates/kitty-colors.conf";
      output_path = "${config.xdg.configHome}/kitty/colors.conf";
    };
  };

  configToml = pkgs.writers.writeTOML "config.toml" {
    config = cfg;
    inherit templates;
  };

in {

  config.home.packages = [ package ];
  config.xdg.configFile."matugen/config.toml".source = configToml;

  config.programs.kitty.extraConfig = "include colors.conf";
}
