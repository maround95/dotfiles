{
  inputs,
  config,
  ...
}:
{
  flake.nixosConfigurations.vega = config.flake.lib.core.mkNixosOutput {
    name = "vega";
    system = "x86_64-linux";
    mainChannel = "unstable";
    target = {
      host = "vega";
      platform = "linux";
      kind = "system";
    };
    modules = [
      config.flake.modules.nixos.platform-linux
      config.flake.modules.nixos.desktop-default-session
      config.flake.modules.nixos.profile-common
      config.flake.modules.nixos.profile-development
      config.flake.modules.nixos.profile-desktop-hyprland
      config.flake.modules.nixos.misc
      config.flake.modules.nixos.homeManager

      # Vega-specific extras from the old host config.
      config.flake.modules.nixos.plasma
      config.flake.modules.nixos.sshd

      inputs.hardware.nixosModules.common-cpu-amd
      inputs.hardware.nixosModules.common-cpu-amd-pstate
      inputs.hardware.nixosModules.common-cpu-amd-zenpower
      inputs.hardware.nixosModules.common-gpu-amd
      inputs.hardware.nixosModules.common-gpu-nvidia-nonprime

      inputs.disko.nixosModules.disko
      ./disko_config.nix

      ./local.nix
      ./home/maroun.nix
      ./home/root.nix
    ];
  };
}
