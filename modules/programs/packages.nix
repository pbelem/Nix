{ pkgs, pkgsUnstable, ... }:

{
  home.packages = [
    # Browsers and Communication
    pkgsUnstable.brave-origin            # Privacy-oriented browser for Desktop and Laptop computers (Origin variant)
    pkgs.vesktop                         # Discord with audio fix for linux 
    pkgs.telegram-desktop                # Desktop client for the Telegram messaging platform
    pkgs.rustdesk                        # Open-source remote desktop and screen sharing tool

    # Security
    pkgs.proton-pass                     # password manager
    pkgs.soteria                         # Polkit authentication agent written in GTK
    pkgs.proton-vpn                      # Quick and open source VPN service

    # System Status & Ricing
    pkgs.btop                            # Resource monitor with a modern terminal UI
    pkgs.cmatrix                         # Matrix-style terminal animation effect
    pkgs.cava                            # Audio visualizer for the terminal

    # Wayland/Hyprland Tools
    pkgs.brightnessctl                   # Command-line brightness control utility
    pkgs.wl-clipboard                    # Clipboard utilities for Wayland environments
    pkgs.wlsunset                        # Adjusts screen color temperature based on time of day
    pkgs.hyprshot                        # Screenshot utility designed for Hyprland

    # Gaming & Performance
    pkgs.heroic                          # Launcher for Epic Games, GOG, and Amazon games
    pkgs.lutris                          # Game management platform for Linux
    pkgs.prismlauncher                   # Custom Minecraft launcher with mod support
    pkgs.protonplus                      # Tool for managing Proton-GE and Wine-GE versions
    pkgs.bottles                         # Wine environment manager for running Windows apps
    pkgs.mangohud                        # Performance overlay for games and Vulkan/OpenGL apps

    pkgs.gnome-boxes                     # Simple GNOME 3 application to access remote or virtual systems

    # Media, Documents & Streaming
    pkgs.gimp                            # Advanced image editing and graphic design tool
    pkgs.upscayl                         # AI-powered image upscaling application
    pkgs.mpv                             # Lightweight and powerful media player
    pkgs.vlc                             # Versatile multimedia player supporting many formats
    pkgs.imv                             # Minimalist image viewer for Wayland and X11
    pkgs.onlyoffice-desktopeditors       # Complete open-source office productivity suite
    pkgs.xarchiver                       # Lightweight graphical archive manager
    pkgs.thunar                          # Xfce file manager
    pkgs.rclone                          # Command line program to sync files and directories to and from major cloud storage
    pkgs.restic                          # Backup program that is fast, efficient and secure
    pkgs.zathura                         # Minimalist keyboard-driven document viewer
    
    # Zathura Backends (Plugins)
    pkgs.zathura            # Minimalist keyboard-driven document viewer
    pkgs.zathuraPkgs.zathura_pdf_mupdf # PDF backend for Zathura using MuPDF
    pkgs.zathuraPkgs.zathura_djvu      # DjVu document support for Zathura
    pkgs.zathuraPkgs.zathura_cb        # Comic book archive support for Zathura
  ];
}
