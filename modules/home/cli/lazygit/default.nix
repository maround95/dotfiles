{...}: {
  programs.lazygit = {
    enable = true;
    settings = {
      keybinding.universal = {
        confirmInEditor = "<c-space>";
      };
    };
  };
}
