{ ... }:
{
  flake.modules.nixos.fonts = { config, lib, pkgs, ... }: {
    options.custom.system.fonts = {
      packages = lib.mkOption {
        type = lib.types.listOf lib.types.package;
        default = [ ];
        description = "Extra font packages to install.";
      };

      default = lib.mkOption {
        type = lib.types.str;
        default = "FiraCode Nerd Font";
        description = "Default preferred font name.";
      };
    };

    config = {
      environment.variables.LOG_ICONS = "true";
      environment.systemPackages = [ pkgs.font-manager ];

      fonts.packages = with pkgs; [
        nerd-fonts.fira-code
        noto-fonts
        noto-fonts-cjk-sans
        noto-fonts-cjk-serif
      ] ++ config.custom.system.fonts.packages;
    };
  };
}
