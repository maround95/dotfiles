{ ... }:
{
  flake.modules.nixos.ollama = { pkgsFor, ... }: {
    services.ollama = {
      enable = true;
      package = (pkgsFor "unstable-small").ollama-cuda;
    };
  };
}
