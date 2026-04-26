{ config, pkgs, pkgsUnstable, noctalia, ... }:

{
  imports = [
    noctalia.homeModules.default
  ];

  # Activate Noctalia shell
  programs.noctalia-shell = {
    enable = true;
    # Optional: choose a theme, plugins, etc.
    # settings = {
    #   theme = "Catppuccin-Macchiato";
    # };
  };

  # ------------------------------------------------------------
  # User Specific Packages (Productivity & Media)
  # ------------------------------------------------------------
  home.packages = with pkgs; [
    # Communication
    brave
    discord
    telegram-desktop
    zapzap

    # Terminal, File Management & CLI Tools
    kitty
    fzf
    zoxide
    jq
    fd
    ripgrep
    (yazi.override {
      _7zz = _7zz-rar; # Support for RAR extraction
    })

    # Yazi Preview Dependencies
    ffmpeg
    poppler-utils
    imagemagick

    # Software Development
    vscodium
    mise
    nixd
    nil

    # Gaming & Performance
    heroic
    lutris
    prismlauncher
    protonplus
    bottles
    mangohud

    # Media, Documents & Streaming
    obs-studio
    mpv
    imv
    libreoffice
    localsend
    zathura
    zathuraPkgs.zathura_pdf_mupdf
    zathuraPkgs.zathura_djvu
    zathuraPkgs.zathura_cb
  ];

  # Git configuration (name and email)
  programs.git = {
    enable = true;
    userName = "pbelem";
    userEmail = "belem@tuta.io";
    extraConfig = {
      init.defaultBranch = "main";
    };
  };

  # Basic user settings
  home.username = "belem";
  home.homeDirectory = "/home/belem";
  home.stateVersion = "25.11";

  # Zsh with automatic Hyprland login via uwsm
  programs.zsh = {
    enable = true;
    shellAliases = {
      btw = "echo 'i use nixos, btw'";
    };
    loginExtra = ''
      if [ -z "$WAYLAND_DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then
        exec uwsm start hyprland-uwsm.desktop
      fi
    '';
  };
}
