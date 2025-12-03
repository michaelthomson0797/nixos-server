{
  description = "Michael's NixOS Homelab Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    nixpkgs,
    disko,
    ...
  }: let
    nodes = [
      "patrick"
      "spongebob"
      "larry"
    ];
    k3sToken = "FILL THIS IN";
    publicKey = "FILL THIS IN";
    serverAddr = "https://192.168.2.100:6443";
  in {
    nixosConfigurations = builtins.listToAttrs (map (name: {
        name = name;
        value = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs;
            meta = {
              hostname = name;
              k3sToken = k3sToken;
              publicKey = publicKey;
              serverAddr = serverAddr;
            };
          };
          system = "x86_64-linux";
          modules = [
            disko.nixosModules.disko
            ./hosts/${name}/configuration.nix
          ];
        };
      })
      nodes);
  };
}
