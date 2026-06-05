{ config, pkgs, lib, pkgsUnstable, noctalia, inputs, ... }:

{
  imports = [
    ../../modules/cli
    ../../modules/desktop
    ../../modules/development
    ../../modules/programs
  ];

  nixpkgs.config = {
    allowUnfree = true;
    permittedInsecurePackages = [
      "nodejs-20.20.2"
      "nodejs-slim-20.20.2"
    ];
  };

  # Basic user settings
  home.username = "belem";
  home.homeDirectory = "/home/belem";
  home.stateVersion = "25.11";
}
