{ pkgs, ... }:

{
  services.xserver = {
    xkb.layout = "us";
    xkb.variant = "intl";
  };

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
    config.hyprland.default = [ "hyprland" "gtk" ];
  };

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    MOZ_ENABLE_WAYLAND = "1";
    QT_QPA_PLATFORM = "wayland";
    SDL_VIDEODRIVER = "wayland";
    _JAVA_AWT_WM_NONREPARENTING = "1"; # Java on Wayland
    XDG_CURRENT_DESKTOP = "Hyprland";
    GTK_IM_MODULE = "cedilla";
    QT_IM_MODULE = "cedilla";
    MANGOHUD_CONFIG = "cpu_temp,gpu_temp,ram,vram,fps,frame_timing=1,position=top-left";
  };

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    withUWSM = true;
  };

  programs.dconf.enable = true;

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    fira-code
    fira-code-symbols
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    monocraft
  ];
}
