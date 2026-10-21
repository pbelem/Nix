{ ... }:

{
  wayland.windowManager.hyprland.settings = {
    # hl.monitor({ output, mode, position, scale, transform })
    monitor = [
      { output = "DP-1"; mode = "2560x1440@180.00"; position = "1080x0"; scale = 1; }
      { output = "DP-2"; mode = "1920x1080@240.00"; position = "0x0"; scale = 1; transform = 1; }
    ];

    # hl.workspace_rule({ workspace, monitor, default })
    workspace_rule = [
      { workspace = "1"; monitor = "DP-2"; default = true; }
      { workspace = "2"; monitor = "DP-1"; }
    ];
  };
}
