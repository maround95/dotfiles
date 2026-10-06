{ ... }:
{
  flake.modules.nixos.sops = { inputs, ... }: {
    imports = [
      inputs.sops-nix.nixosModules.default
    ];

    sops = {
      validateSopsFiles = false;

      age = {
        sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
        keyFile = "/var/lib/sops-nix/key.txt";
        generateKey = true;
      };
    };
  };

  flake.modules.darwin.sops = { inputs, ... }: {
    imports = [
      inputs.sops-nix.darwinModules.default
    ];
  };

  flake.modules.homeManager.sops = { inputs, ... }: {
    imports = [
      inputs.sops-nix.homeModules.default
    ];
  };
}
