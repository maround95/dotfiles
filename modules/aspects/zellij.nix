{ ... }:
{
  flake.modules.homeManager.zellij = { ... }: {
    programs = {
      zsh.shellAliases.zj = "zellij";

      zellij = {
        enable = true;
        enableBashIntegration = false;
        enableZshIntegration = false;
      };
    };

    xdg.configFile."zellij/config.kdl".source = ./zellij/config.kdl;
    xdg.configFile."zellij/layouts/default.kdl".source = ./zellij/layouts/default.kdl;
    xdg.configFile."zellij/layouts/default.swap.kdl".source = ./zellij/layouts/default.swap.kdl;
  };
}
