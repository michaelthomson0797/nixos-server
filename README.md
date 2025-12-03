# Nixos Server
- This is my nix config for the nodes on my home server.

## Initializing the nodes
```sh
cd <path to flake>

nix run github:nix-community/nixos-anywhere -- --build-on-remote --generate-hardware-config nixos-generate-config ./hosts/patrick/hardware-configuration.nix --flake .#patrick root@192.168.2.100

nix run github:nix-community/nixos-anywhere -- --build-on-remote --generate-hardware-config nixos-generate-config ./hosts/spongebob/hardware-configuration.nix --flake .#spongebob root@192.168.2.101

nix run github:nix-community/nixos-anywhere -- --build-on-remote --generate-hardware-config nixos-generate-config ./hosts/larry/hardware-configuration.nix --flake .#larry root@192.168.2.42
```
