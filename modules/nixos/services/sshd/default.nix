{
  config,
  lib,
  namespace,
  ...
}:
with lib;
with lib.custom;
let
  cfg = config.custom.services.sshd;
in
{
  options.custom.services.sshd = with types; {
    enable = mkBoolOpt false "Whether to enable ssh server.";
  };

  config = mkIf cfg.enable {
    services.openssh = {
      enable = true;
    };
  };
}
