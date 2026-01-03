{
  programs.zsh.shellAliases.zq = "zoxide query";

  programs.zoxide = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
  };
}
