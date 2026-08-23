{ pkgs, ... }:

{
  programs.obs-studio = {
    enable = true; # Software for recording and live streaming

    package = pkgs.obs-studio.override {
      browserSupport = true;
    };

    plugins = with pkgs.obs-studio-plugins; [
      obs-pipewire-audio-capture
      obs-vkcapture
      wlrobs # Legacy screen capture for Wayland (prefer the native PipeWire source)
    ];
  };

    home.packages = [
      pkgs.libva # Implementation for VA-API (Video Acceleration API)
      pkgs.libva-utils # Collection of utilities and examples for VA-API
    ];
}
