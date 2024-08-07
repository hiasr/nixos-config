#!/bin/bash

# Install Nix
sh <(curl -L https://nixos.org/nix/install) --daemon
source /etc/profile

# Install Home Manager
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update
nix-shell '<home-manager>' -A install

# Enable experimental
mkdir -p ~/.config/nix/
echo "experimental-features = nix-command flakes" > ~/.config/nix/nix.conf

# Install environment
home-manager --flake .#rubenh@thonk switch -b backup
