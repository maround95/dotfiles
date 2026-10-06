{
  inputs,
  config,
  ...
}:
{
  flake.nixosConfigurations.zeus = config.flake.lib.core.mkNixosOutput {
    name = "zeus";
    system = "x86_64-linux";
    mainChannel = "unstable";
    target = {
      host = "zeus";
      platform = "linux";
      kind = "system";
    };
    modules = [
      config.flake.modules.nixos.platform-linux
      config.flake.modules.nixos.desktop-default-session
      config.flake.modules.nixos.profile-common
      config.flake.modules.nixos.profile-development-docker
      config.flake.modules.nixos.profile-desktop-hyprland
      config.flake.modules.nixos.misc
      config.flake.modules.nixos.homeManager

      # Zeus-specific extras from the old host config.
      config.flake.modules.nixos.plasma
      config.flake.modules.nixos.sshd

      inputs.hardware.nixosModules.common-cpu-intel
      inputs.hardware.nixosModules.common-gpu-intel

      config.flake.modules.nixos.zram-swap

      inputs.disko.nixosModules.disko
      ./disko_config.nix

      ./local.nix
      ./home/maroun.nix
      ./home/root.nix
    ];
  };
}
