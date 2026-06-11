{ ... }:

{
  wayland.windowManager.hyprland.settings = {
    monitor = [
      "DP-1, 2560x1440@180.00, 1080x0, 1"
      "DP-2, 1920x1080@240.00, 0x0, 1, transform, 3"
    ];
    workspace = [
      "1, monitor:DP-2, default:true"
      "2, monitor:DP-1"
    ];
  };
}

