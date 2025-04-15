{
  lib,
  config,
  inputs,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.custom.security.sops;
  secretsPath = "${lib.custom.rootPathStr}/secrets";
in {
  imports = [inputs.sops-nix.nixosModules.default];

  options.custom.security.sops = with types; {
    enable = mkBoolOpt false "Enable sops-nix.";
  };

  config = mkIf cfg.enable {
    warnings =
      if !builtins.pathExists secretsPath
      then ["sops-nix is enabled, but there are no secrets."]
      else [];

    sops = {
      defaultSopsFile = "${secretsPath}/secrets.yaml";
      validateSopsFiles = false;

      age = {
        # ssh keys imported will be added to /run/secrets.d/keys.txt
        sshKeyPaths = ["/etc/ssh/ssh_host_ed25519_key"];
        keyFile = "/var/lib/sops-nix/key.txt";
        generateKey = true;
      };

      secrets = {
        id_github = {
          path = "/home/${config.custom.user.name}/.ssh/id_github";
          mode = "0600";
          owner = "${config.custom.user.name}";
        };

        id_github_pub = {
          path = "/home/${config.custom.user.name}/.ssh/id_github.pub";
          owner = "${config.custom.user.name}";
        };

        # for optional secrets use:
        # non_existent = lib.mkIf (builtins.pathExists lib.custom.rootPath/secrets/helloworld)
      };
    };
  };
}
