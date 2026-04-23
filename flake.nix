{
  description = "NixOS 25.05 + Noctalia (from unstable)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
#    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    noctalia-qs = {
      url = "github:noctalia-dev/noctalia-qs";
      inputs.nixpkgs.follows = "unstable";
    };
  };

  outputs = { self, nixpkgs, unstable, home-manager, noctalia-qs, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      pkgsUnstable = unstable.legacyPackages.${system};
    in {
      nixosConfigurations.Desktop-NixOS = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit pkgsUnstable noctalia-qs; };
        modules = [
          ./configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.belem = import ./home.nix;
            home-manager.extraSpecialArgs = { inherit pkgsUnstable noctalia-qs; };
          }
        ];
      };
    };
}