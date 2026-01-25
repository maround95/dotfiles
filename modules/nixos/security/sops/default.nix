{
  lib,
  config,
  ...
}:
with lib;
with lib.custom;
let
  cfg = config.custom.security.sops;
in
{
  options.custom.security.sops = with types; {
    enable = mkBoolOpt false "Enable system-level sops-nix.";
  };

  config = mkIf cfg.enable {
    sops = {
      validateSopsFiles = false;

      age = {
        # ssh keys imported will be added to /run/secrets.d/keys.txt
        sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
        keyFile = "/var/lib/sops-nix/key.txt";
        generateKey = true;
      };
    };
  };
}
