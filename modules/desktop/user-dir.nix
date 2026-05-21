{ config, inputs, pkgs, ... }:

{
  xdg.userDirs = {
    enable = true;
    createDirectories = true;
  };

  systemd.user.tmpfiles.rules = [
    # Syntax: d (directory) path mode user group age argument
    "d ${config.home.homeDirectory}/Docker 0755 - - - -"
    "d ${config.home.homeDirectory}/AppImages 0755 - - - -"
    "d ${config.home.homeDirectory}/Workspace 0755 - - - -"

    # Subfolders 
    "d ${config.home.homeDirectory}/Videos/OBS 0755 - - - -"
    "d ${config.home.homeDirectory}/Videos/KdenLive 0755 - - - -"
    "d ${config.home.homeDirectory}/Syncthing/KeePassXC 0755 - - - -"
  ];

  home.file."Pictures/Wallpapers".source = inputs.wallpapers;
}
