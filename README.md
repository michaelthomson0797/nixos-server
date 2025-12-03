# Nixos Server
- This is my nix config to initialize the nodes on my home k3s server.

```

nix run github:nix-community/nixos-anywhere -- --build-on-remote --generate-hardware-config nixos-generate-config ./hardware-configuration.nix --flake .#patrick root@192.168.2.100

nix run github:nix-community/nixos-anywhere -- --build-on-remote --generate-hardware-config nixos-generate-config ./hardware-configuration.nix --flake .#spongebob root@192.168.2.101
```
