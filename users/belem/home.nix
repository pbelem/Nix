{ config, pkgs, lib, pkgsUnstable, noctalia, inputs, ... }:

{
  imports = [
    ../../modules/cli
    ../../modules/desktop
    ../../modules/development
    ../../modules/programs
  ];

  programs.home-manager.enable = true;

  nixpkgs.config = {
    allowUnfree = true;
    permittedInsecurePackages = [
      # "nodejs-20.20.2"
      # "nodejs-slim-20.20.2"
      "electron-41.10.7"
    ];
  };

  nixpkgs.overlays = [
    (final: prev: {
      nodejs_20 = prev.nodejs_20.overrideAttrs (old: {
        doCheck = false;
      });
      nodejs = prev.nodejs.overrideAttrs (old: {
        doCheck = false;
      });
    })
  ];  

  # Basic user settings
  home.username = "belem";
  home.homeDirectory = "/home/belem";
  home.stateVersion = "25.11";
}
