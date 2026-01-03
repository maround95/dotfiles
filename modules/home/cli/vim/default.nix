{
  config,
  pkgs,
  ...
}:
let
  themeToNvim = {
    "nightfox" = "nightfox";
    "rose-pine" = "rose-pine";
  };
  nvimColorscheme = themeToNvim.${config.custom.theme.colorscheme} or "nightfox";

  nixCatsUtils = pkgs.mvimPackages.mvim.utils;
  mvim = pkgs.mvimPackages.mvim.override (prev: {
    packageDefinitions = prev.packageDefinitions // {
      mvim = nixCatsUtils.mergeCatDefs prev.packageDefinitions.mvim (_: {
        categories = {
          colorscheme = nvimColorscheme;
        };
      });
    };
  });
in
{
  home.packages = [
    pkgs.vim
    mvim
  ];
  home.sessionVariables.EDITOR = "mvim";

  programs.zsh.shellAliases.v = "mvim";
}
