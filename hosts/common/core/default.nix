{ inputs, outputs, configLib, ... }: {
  imports = [
    ./zsh.nix
  ];

  home-manager.extraSpecialArgs = { inherit inputs outputs; };

  nixpkgs = {
    # you can add global overlays here
    overlays = builtins.attrValues outputs.overlays;
    config = {
      allowUnfree = true;
    };
  };

  hardware.enableRedistributableFirmware = true;
}
