{ ... }:
{
  flake.modules.homeManager.readline = { ... }: {
    home.file.".inputrc".text = ''
      set editing-mode vi
    '';

    home.file.".haskeline".text = ''
      editMode: Vi
    '';
  };
}
