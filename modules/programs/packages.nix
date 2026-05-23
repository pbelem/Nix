{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Browsers and Communication
    discord                         # Voice, video, and text communication platform
    telegram-desktop                # Desktop client for the Telegram messaging platform
    zapzap                          # WhatsApp desktop client for Linux
    rustdesk                        # Open-source remote desktop and screen sharing tool

    # Security
    keepassxc                       # Offline password manager
    soteria                         # Polkit authentication agent written in GTK

    # Software Development
    dbeaver-bin                     # Universal database management tool
    mise                            # Development environment and runtime manager
    nixd                            # Language server for Nix development
    nil                             # Alternative Nix language server with IDE support

    # System Status & Ricing
    btop                            # Resource monitor with a modern terminal UI
    cmatrix                         # Matrix-style terminal animation effect
    cava                            # Audio visualizer for the terminal

    # Wayland/Hyprland Tools
    brightnessctl                   # Command-line brightness control utility
    wl-clipboard                    # Clipboard utilities for Wayland environments
    wlsunset                        # Adjusts screen color temperature based on time of day
    hyprshot                        # Screenshot utility designed for Hyprland

    # Gaming & Performance
    heroic                          # Launcher for Epic Games, GOG, and Amazon games
    lutris                          # Game management platform for Linux
    prismlauncher                   # Custom Minecraft launcher with mod support
    protonplus                      # Tool for managing Proton-GE and Wine-GE versions
    bottles                         # Wine environment manager for running Windows apps
    mangohud                        # Performance overlay for games and Vulkan/OpenGL apps

    # Media, Documents & Streaming
    gimp                            # Advanced image editing and graphic design tool
    upscayl                         # AI-powered image upscaling application
    mpv                             # Lightweight and powerful media player
    vlc                             # Versatile multimedia player supporting many formats
    imv                             # Minimalist image viewer for Wayland and X11
    onlyoffice-desktopeditors       # Complete open-source office productivity suite
    xarchiver                       # Lightweight graphical archive manager
    zathura                         # Minimalist keyboard-driven document viewer
    
    # Zathura Backends (Plugins)
    zathura            # Minimalist keyboard-driven document viewer
    zathuraPkgs.zathura_pdf_mupdf # PDF backend for Zathura using MuPDF
    zathuraPkgs.zathura_djvu      # DjVu document support for Zathura
    zathuraPkgs.zathura_cb        # Comic book archive support for Zathura
  ];
}
