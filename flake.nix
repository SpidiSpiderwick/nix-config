
{
  description = "My WIP NixServer";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    flake-utils.url = "github:numtide/flake-utils";
    sops-nix.url = "github:Mic92/sops-nix";
    nextcloudPreconfigured.url = "git+https://codeberg.org/Triton171/nixos-nextcloud-preconfigured?ref=main";
  };


  outputs = { self, nixpkgs, flake-utils, sops-nix, nextcloudPreconfigured, ... }: {
    nixosConfigurations = {
      appa = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/appa.nix
          sops-nix.nixosModules.sops
        ];
        specialArgs = { inherit nextcloudPreconfigured ;};
      };
    };
  };
}