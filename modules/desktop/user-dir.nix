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

  # Wallpaper Repository Automation
  home.activation = {
    cloneWallpapers = lib.hm.dag.entryAfter ["writeBoundary"] ''
      # Define the target directory dynamically
      WALLPAPER_DIR="${config.home.homeDirectory}/Pictures/Wallpapers"
      
      # Check if the directory already exists as a git repository
      if [ ! -d "$WALLPAPER_DIR/.git" ]; then
        echo "Cloning the Krishna wallpaper repository..."
        # Remove the folder if it exists but is not a repository
        rm -rf "$WALLPAPER_DIR"
        ${pkgs.git}/bin/git clone https://github.com/krishna4a6av/Wallpapers "$WALLPAPER_DIR"
      else
        # Update existing files silently
        echo "Wallpaper repository already exists. Pulling updates..."
        cd "$WALLPAPER_DIR" && ${pkgs.git}/bin/git pull --quiet
      fi
    '';
  };
