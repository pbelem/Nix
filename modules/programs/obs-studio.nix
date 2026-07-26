{ pkgs, ... }:

{
  programs.obs-studio = {
    enable = true; # Software for recording and live streaming
                
    package = pkgs.obs-studio.override {
      BrowserSupport = true;
    };

    plugins = with pkgs.obs-studio-plugins; [
      obs-pipewire-audio-capture
      obs-vkcapture
      wlrobs # Legacy screen capture for Wayland (prefer the native PipeWire source)
    ];
  };
}
