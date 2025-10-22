{
  description = "NixOS configurations for all my machines";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    sops-nix.url = "github:Mic92/sops-nix";
    
    nextcloudPreconfigured.url = "git+https://codeberg.org/Triton171/nixos-nextcloud-preconfigured?ref=main";
    
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, sops-nix, ... }@inputs: 
    let
      system = "x86_64-linux";
      
      # Overlay for unstable packages
      overlays = [
        (final: prev: {
          unstable = import nixpkgs-unstable {
            inherit system;
            config.allowUnfree = true;
          };
        })
      ];
      
      # Common special args passed to all modules
      specialArgs = {
        inherit inputs;
      };
      
    in {
      nixosConfigurations = {
        # Server configuration
        appa = nixpkgs.lib.nixosSystem {
          inherit system specialArgs;
          modules = [
            { nixpkgs.overlays = overlays; }
            ./hosts/appa
            sops-nix.nixosModules.sops
          ];
        };
        
        # Future laptop configuration (uncomment when ready)
        # laptop = nixpkgs.lib.nixosSystem {
        #   inherit system specialArgs;
        #   modules = [
        #     { nixpkgs.overlays = overlays; }
        #     ./hosts/laptop
        #     sops-nix.nixosModules.sops
        #     home-manager.nixosModules.home-manager
        #   ];
        # };
      };
    };
}