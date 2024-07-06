## Home manager on non-NixOS
```
# Install nix in single-user mode.
bash <(curl -L https://nixos.org/nix/install) --no-daemon

# Nix shell with tools
nix-shell

# Home manager first generation
home-manager switch --flake .#flakeName
```
