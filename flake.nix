{
  description = "NixOS 25.11 + Noctalia (from unstable)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";
    hyprland.url = "github:hyprwm/Hyprland";
    niri.url = "github:sodiboo/niri-flake";

    nixvim = {
      url = "github:nix-community/nixvim/nixos-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia = {
      url = "github:noctalia-dev/noctalia";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
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
    niri,
    nixvim,
    zen-browser,
    ...
  }@inputs:
  let
    system = "x86_64-linux";

    nixpkgsConfig = {
      allowUnfree = true;
      permittedInsecurePackages = [
        "nodejs-20.20.2"
        "electron-41.10.7"
      ];
    };

    nodeOverlay = final: prev: {
      nodejs_20 = prev.nodejs_22;
      nodejs-slim_20 = prev.nodejs-slim_22;
    };

    pkgs = import nixpkgs {
      inherit system;
      config = nixpkgsConfig;
      overlays = [ nodeOverlay ];
    };

    pkgsUnstable = import unstable {
      inherit system;
      config = nixpkgsConfig;
      overlays = [ nodeOverlay ];
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
        niri.nixosModules.niri
      ];
    };

    homeConfigurations.belem =
      home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = {
          inherit inputs pkgsUnstable noctalia;
        };
        modules = [
          nixvim.homeModules.nixvim
          ./users/belem/home.nix
        ];
      };
  };
}
