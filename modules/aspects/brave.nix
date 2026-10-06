{ ... }:
{
  flake.modules.homeManager.brave = { pkgs, ... }: {
    programs.brave = {
      enable = true;
      package = pkgs.brave;

      extensions = [
        { id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; } # uBlock Origin
        { id = "iaddfgegjgjelgkanamleadckkpnjpjc"; } # Auto Quality for YouTube
        { id = "dbepggeogbaibhgnhhndojpepiihcmeb"; } # Vimium
        { id = "annfbnbieaamhaimclajlajpijgkdblo"; } # Dark Theme
      ];
    };
  };
}
