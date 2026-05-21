{ config, pkgs, lib, noctalia, ... }:

{
  imports = [
    # Imports the home module directly passed from the flake inputs
    noctalia.homeModules.default
  ];

  programs.noctalia-shell = {
    enable = true;
    # Dynamically parses the JSON configuration file within the same directory
    settings = builtins.fromJSON (builtins.readFile ./noctalia.json);
  };
}
