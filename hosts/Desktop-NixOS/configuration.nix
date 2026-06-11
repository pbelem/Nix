{ ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/system/base.nix
    ../../modules/system/boot.nix
    ../../modules/system/hardware.nix
    ../../modules/system/networking.nix
    ../../modules/system/services.nix
    ../../modules/system/desktop.nix
    ../../modules/system/gaming.nix
    ../../modules/system/users.nix
  ];

  system.stateVersion = "25.11";
}

