  programs.obs-studio = {
    enable = true;  # Software for recording and live streaming
    plugins = with pkgs.obs-studio-plugins; [
      obs-pipewire-audio-capture 
      obs-vkcapture 
      wlrobs    # Improved screenshot capture for Wayland/Hyprland environments
    ];
  };
