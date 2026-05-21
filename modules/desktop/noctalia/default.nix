{ config, pkgs, lib, noctalia, ... }:

{
  imports = [
    noctalia.homeModules.default
  ];

  programs.noctalia-shell = {
    enable = true;
    settings = builtins.fromJSON (builtins.readFile ./noctalia.json);
  };
}
