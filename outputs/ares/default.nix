{
  inputs,
  config,
  ...
}:
{
  flake.nixosConfigurations.ares = config.flake.lib.core.mkNixosOutput {
    name = "ares";
    system = "x86_64-linux";
    mainChannel = "unstable";
    target = {
      host = "ares";
      platform = "linux";
      kind = "system";
    };
    modules = [
      config.flake.modules.nixos.platform-linux
      config.flake.modules.nixos.desktop-default-session
      config.flake.modules.nixos.profile-common
      config.flake.modules.nixos.profile-laptop
      config.flake.modules.nixos.profile-development
      config.flake.modules.nixos.profile-desktop-hyprland
      config.flake.modules.nixos.misc
      config.flake.modules.nixos.homeManager

      # Ares-specific extras from the old host config.
      config.flake.modules.nixos.steam
      config.flake.modules.nixos.ollama
      config.flake.modules.nixos.sshd
      config.flake.modules.nixos.plasma
      config.flake.modules.nixos.sway

      inputs.disko.nixosModules.disko
      ./disko_config.nix

      ./l5p-16ach6h
      ./local.nix
      ./home/maroun.nix
      ./home/root.nix
    ];
  };
}
