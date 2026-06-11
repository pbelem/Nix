{ ... }:

{
  wayland.windowManager.hyprland.settings = {
    general = {
      gaps_in = 5;
      gaps_out = 10;
      border_size = 2;
      "col.active_border" = "rgba(ffb86bff) rgba(ff79c6ff) 45deg";
      "col.inactive_border" = "rgba(44475aff)";
      resize_on_border = true;
      layout = "dwindle";
    };

    decoration = {
      rounding = 20;
      rounding_power = 2;
      blur = {
        enabled = true;
        size = 3;
        passes = 2;
        vibrancy = 0.1696;
        new_optimizations = true;
      };
    };

    animations = {
      enabled = true;
      bezier = [
        "md3_decel, 0.05, 0.7, 0.1, 1"
        "menu_decel, 0.1, 1, 0, 1"
        "menu_accel, 0.38, 0.04, 1, 0.07"
      ];
      animation = [
        "windows, 1, 3, md3_decel, popin 60%"
        "border, 1, 10, default"
        "fade, 1, 3, md3_decel"
        "workspaces, 1, 7, menu_decel, slide"
      ];
    };
  };
}

