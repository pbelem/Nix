{ pkgs, ... }:

{
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; 
    dedicatedServer.openFirewall = true; 
    extest.enable = true;
  };

  environment.systemPackages = [
    pkgs.mangohud
  ];

  environment.sessionVariables = {
    MANGOHUD_CONFIG = "cpu_temp,gpu_temp,ram,vram,fps,frame_timing=1,position=top-left";
  };

  # Vpn service for minecraft java
  services.zerotierone = {
    enable = true;
    joinNetworks = [ "3b19b3a716413850" ];
  };

  programs.gamemode.enable = true;
  programs.gamescope.enable = true;
}

