{ ... }:

final: prev: {
  # This should have a fix for neovim cursor flickering in zellij
  zellij-unstable = prev.zellij.overrideAttrs (old: rec {
    version = "0.41.0";
    pname = "zellij";

    src = prev.fetchFromGitHub {
      owner = "zellij-org";
      repo = "zellij";
      rev = "47caeb66a6c5b8b229c1227ce823defcdccf31b8";
      sha256 = "fkyi5iIZEZXPq6a4qn3xS88qgecN3gZLLv00PoTVDlA=";
    };

    cargoDeps = old.cargoDeps.overrideAttrs (
      prev.lib.const {
        inherit src;
        outputHash = "sha256-M9wQy0nO6ro09laJXMP0N6R6B2vxNVCStyh2CovGUHA=";
      }
    );
  });
}
