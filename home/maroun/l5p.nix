{ ... }:
{

  imports = [
    ./common/core

    # ./common/optional/wezterm.nix # wezterm has too many problems; Borders, rendering with zellij...
    ./common/optional/kitty.nix
    ./common/optional/zellij
  ];

}
