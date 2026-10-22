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

  # https://github.com/krishna4a6av/Wallpapers
  home.file."Pictures/Wallpapers-krishna4a6av".source = inputs.wallpapers-krishna4a6av;
  # https://github.com/dharmx/walls
  home.file."Pictures/Wallpapers-dharmx".source = inputs.wallpapers-dharmx;
  # https://github.com/MiRou-lilg/wallpapers-portrait-vertical
  home.file."Pictures/Wallpapers-Portrait-MiRou-lilg".source = inputs.wallpapers-MiRou-lilg;
}
