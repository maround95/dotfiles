{ pkgs, lib, config, ... }:
with lib;
with lib.custom;
with lib.home-manager;
let
  cfg = config.custom.desktop.waybar;
  configFilesMapping = mkHomeFileLinksFromDir ./config ".config/waybar";
in {
  options.custom.desktop.waybar = with types; {
    enable = mkBoolOpt false "Enable waybar.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [waybar];
    home.file = configFilesMapping;
  };
}
