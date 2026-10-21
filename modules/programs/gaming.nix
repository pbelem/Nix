{ pkgs, pkgsUnstable, ...}:

{
  home.packages = [
    # Gaming & Performance
    pkgs.heroic                          # Launcher for Epic Games, GOG, and Amazon games
    pkgs.lutris                          # Game management platform for Linux
    pkgs.prismlauncher                   # Custom Minecraft launcher with mod support
    pkgs.protonplus                      # Tool for managing Proton-GE and Wine-GE versions
    pkgs.mangohud                        # Performance overlay for games and Vulkan/OpenGL apps
    pkgsUnstable.osu-lazer-bin
  ];
}
