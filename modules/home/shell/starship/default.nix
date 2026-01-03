{
  programs.starship = {
    enable = true;
    settings = {
      custom.zellij = {
        command = "echo $ZELLIJ_SESSION_NAME";
        when = ''test -n "$ZELLIJ_SESSION_NAME"'';
        symbol = " ";
      };
    };
  };
}
