{
  lib,
  config,
  namespace,
  inputs,
  ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.security.sops;
  secretsPath = "${lib.${namespace}.rootPathStr}/secrets";
in
{
  imports = [ inputs.sops-nix.nixosModules.default ];

  options.${namespace}.security.sops = with types; {
    enable = mkBoolOpt false "Enable sops-nix.";
  };

  config = mkIf cfg.enable {
    warnings =
      if !builtins.pathExists secretsPath then
        [ "sops-nix is enabled, but there are no secrets." ]
      else
        [ ];

    sops = {
      defaultSopsFile = "${secretsPath}/secrets.yaml";
      validateSopsFiles = false;

      age = {
        # ssh keys imported will be added to /run/secrets.d/keys.txt
        sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
        keyFile = "/var/lib/sops-nix/key.txt";
        generateKey = true;
      };

      secrets = {
        hello = { };
        example_key = { };
      };
    };

  };
}
