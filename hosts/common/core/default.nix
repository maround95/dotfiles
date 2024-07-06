{ inputs, outputs, configLib, ... }: {
  imports = [
    ./zsh.nix
  ];

  home-manager.extraSpecialArgs = { inherit inputs outputs; };

  nixpkgs = {
    # you can add global overlays here
    overlays = builtins.attrValues outputs.overlays;
  };

  hardware.enableRedistributableFirmware = true;
}
