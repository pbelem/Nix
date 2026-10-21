{ pkgs, pkgsUnstable, ... }:

{
  programs.obs-studio = {
    enable = true; # Software for recording and live streaming

    package = pkgsUnstable.obs-studio.override {
      browserSupport = true;
    };

    plugins = with pkgsUnstable.obs-studio-plugins; [
      obs-pipewire-audio-capture
      obs-vkcapture
      wlrobs # Legacy screen capture for Wayland (prefer the native PipeWire source)
    ];
  };
}
