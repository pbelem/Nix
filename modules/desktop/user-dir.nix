{ config, inputs, pkgs, ... }:

{
  xdg.userDirs = {
    enable = true;
    createDirectories = true;
    setSessionVariables = false;
  };

  systemd.user.tmpfiles.rules = [
    # Syntax: d (directory) path mode user group age argument
    "d ${config.home.homeDirectory}/Docker 0755 - - - -"
    "d ${config.home.homeDirectory}/AppImages 0755 - - - -"
    "d ${config.home.homeDirectory}/Workspace 0755 - - - -"
    "d ${config.home.homeDirectory}/Syncthing 0755 - - - -"
    "d ${config.home.homeDirectory}/Localsend 0755 - - - -"
    
    # Subfolders 
    "d ${config.home.homeDirectory}/Videos/OBS 0755 - - - -"
    "d ${config.home.homeDirectory}/Videos/KdenLive 0755 - - - -"
    "d ${config.home.homeDirectory}/Videos/Wallpapers 0755 - - - -"
    "d ${config.home.homeDirectory}/Pictures/Screenshots 0755 - - - -"
  ];

  home.file."Pictures/Wallpapers".source = inputs.wallpapers;
}
