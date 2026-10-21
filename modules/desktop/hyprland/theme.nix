{ ... }:

{
  wayland.windowManager.hyprland.settings = {
    config = {
      general = {
        gaps_in = 5;
        gaps_out = 10;
        border_size = 2;
        resize_on_border = true;
        layout = "dwindle";
        col = {
          active_border = {
            colors = [ "rgba(ffb86bff)" "rgba(ff79c6ff)" ];
            angle = 45;
          };
          inactive_border = "rgba(44475aff)";
        };
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

      animations.enabled = true;
    };

    curve = map (c: {
      _args = [ c.name { type = "bezier"; points = c.points; } ];
    }) [
      { name = "md3_decel";  points = [ [ 0.05 0.7 ] [ 0.1 1.0 ] ]; }
      { name = "menu_decel"; points = [ [ 0.1 1.0 ]  [ 0.0 1.0 ] ]; }
      { name = "menu_accel"; points = [ [ 0.38 0.04 ] [ 1.0 0.07 ] ]; }
    ];

    animation = [
      { leaf = "windows";    enabled = true; speed = 3;  bezier = "md3_decel";  style = "popin 60%"; }
      { leaf = "border";     enabled = true; speed = 10; bezier = "default"; }
      { leaf = "fade";       enabled = true; speed = 3;  bezier = "md3_decel"; }
      { leaf = "workspaces"; enabled = true; speed = 7;  bezier = "menu_decel"; style = "slide"; }
    ];
  };
}
