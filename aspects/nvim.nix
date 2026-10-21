{ inputs, ... }:
{
  flake.modules.homeManager.nvim =
    {
      pkgs,
      config,
      ...
    }:
    let
      system = pkgs.stdenv.hostPlatform.system;
      themeToNvim = {
        nightfox = "nightfox";
        "rose-pine" = "rose-pine";
      };
      nvimColorscheme = themeToNvim.${config.custom.theme.colorscheme} or "nightfox";
      mvim = inputs.nvim-maroun.lib.mkMvim {
        inherit system;
        categories.colorscheme = nvimColorscheme;
      };

    in
    {
      home.packages = [
        pkgs.vim
        mvim
      ];
      home.sessionVariables.EDITOR = "mvim";

      programs.zsh.shellAliases.v = "mvim";
    };
}
