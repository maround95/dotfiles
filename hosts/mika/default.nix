{ inputs, ... }: {
  imports = [
    inputs.disko.nixosModules.disko
    inputs.lanzaboote.nixosModules.lanzaboote

    ./hardware-configuration.nix
    ./disko.nix
    ./configuration.nix
  ];

  networking.hostName = "mika"; # Define your hostname.
  home-manager.users.maroun = import ./home.nix;

  programs.nix-ld.enable = true;
  system.stateVersion = "24.05";
}
