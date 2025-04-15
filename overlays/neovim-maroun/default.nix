{inputs, ...}: _: prev: {
  nvim-maroun = inputs.nvim-maroun.packages.${prev.system}.nvim;
}
