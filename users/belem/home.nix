{ config, pkgs, lib, pkgsUnstable, noctalia, inputs, ... }:

{
  imports = [
    ../../modules/cli
    ../../modules/desktop
    ../../modules/development
    ../../modules/programs
  ];

  # Basic user settings
  home.username = "belem";
  home.homeDirectory = "/home/belem";
  home.stateVersion = "25.11";
}
