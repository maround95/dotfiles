{ inputs, ... }:
{
  flake.modules.homeManager.workmux =
    { config, lib, pkgs, ... }:
    let
      system = pkgs.stdenv.hostPlatform.system;
      workmux = inputs.workmux.packages.${system}.default;
      workmuxExe = lib.getExe' workmux "workmux";
    in
    {
      home.packages = [ workmux ];

      xdg.configFile."workmux/config.yaml".source = ./config.yaml;

      programs.zsh.initContent = lib.mkAfter ''
        workmux-dashboard() {
          exec </dev/tty
          exec <&1
          tmux new-session -c "$PWD" -s "workmux-dashboard-$$" "${workmuxExe} dashboard"
          zle reset-prompt >/dev/null 2>&1 || true
        }
        zle -N workmux-dashboard
        bindkey -M viins '^Bw' workmux-dashboard
        bindkey -M vicmd '^Bw' workmux-dashboard
      '';
    };
}
