{
  description = "NixOS 25.11 + Noctalia (from unstable)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";
    hyprland.url = "github:hyprwm/Hyprland";

    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "unstable";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nvf = {
      url = "github:NotAShelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixCats = {
      url = "github:BirdeeHub/nixCats-nvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs = {
        nixpkgs.follows = "unstable";
        home-manager.follows = "home-manager";
      };
    };

    wallpapers = {
      url = "github:krishna4a6av/Wallpapers";
      flake = false;
    };
  };

  outputs = {
    self,
    nixpkgs,
    unstable,
    home-manager,
    noctalia,
    nix-flatpak,
    hyprland,
    nvf,
    nixCats,
    zen-browser,
    ...
  }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      pkgsUnstable = import unstable {
        inherit system;
        config.allowUnfree = true;
      };
    in {
      nixosConfigurations.Desktop-NixOS = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit inputs pkgsUnstable noctalia;
        };
        modules = [
          ./hosts/Desktop-NixOS/configuration.nix
          nix-flatpak.nixosModules.nix-flatpak
        ];
      };

      homeConfigurations.belem =
        home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = {
            inherit inputs pkgsUnstable noctalia nixCats;
          };
          modules = [
            nvf.homeManagerModules.default
            nixCats.homeModule
            ./users/belem/home.nix
          ];
        };
    };
}
