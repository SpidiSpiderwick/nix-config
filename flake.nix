
{
  description = "My WIP NixServer";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    flake-utils.url = "github:numtide/flake-utils";
    sops-nix.url = "github:Mic92/sops-nix";
  };

  outputs = { self, nixpkgs, flake-utils, ... }: {
    nixosConfigurations = {
      appa = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/appa.nix
          sops-nix.nixosModules.sops
        ];
        specialArgs = { inherit pkgs system; };
      };
    };
  };
}