{ config, pkgs, lib, noctalia, inputs, ... }:

{
  imports = [
    inputs.noctalia.homeModules.default
  ];

  programs.noctalia = {
    enable = true;
    # settings = builtins.fromJSON (builtins.readFile ./noctalia.json);
  };
}
