{
  description = "NixOS 25.11 + Noctalia (from unstable)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";
    
    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "unstable";
    };
    
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

outputs = { self, nixpkgs, unstable, home-manager, noctalia, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      pkgsUnstable = unstable.legacyPackages.${system};
    in {
      nixosConfigurations.Desktop-NixOS = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit pkgsUnstable noctalia inputs; }; 
        modules = [
          ./configuration.nix
          home-manager.nixosModules.home-manager
          inputs.nix-flatpak.nixosModules.nix-flatpak
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.belem = import ./home.nix;
            home-manager.extraSpecialArgs = { inherit pkgsUnstable noctalia inputs; };
          }
        ];
      };
    };
}