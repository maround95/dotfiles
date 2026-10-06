{
  inputs,
  config,
  ...
}:
{
  flake.nixosConfigurations.nova = config.flake.lib.core.mkNixosOutput {
    name = "nova";
    system = "x86_64-linux";
    mainChannel = "unstable";
    target = {
      host = "nova";
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
      # config.flake.modules.nixos.ollama
      config.flake.modules.nixos.sshd
      config.flake.modules.nixos.plasma
      config.flake.modules.nixos.sway

      config.flake.modules.nixos.zram-swap

      inputs.disko.nixosModules.disko
      ./disko_config.nix

      ./FA401EA
      ./local.nix
      ./home/maroun.nix
      ./home/root.nix
    ];
  };
}
