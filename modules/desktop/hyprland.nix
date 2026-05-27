{ config, pkgs, inputs, ... }:

{
  xdg.configFile."hypr/hyprland.conf".force = true;
  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;

    settings = let
      mod = "SUPER";
      ipc = "noctalia-shell ipc call";

      toggle-minimize = pkgs.writeShellScript "toggle-minimize" ''
        active_ws=$(${pkgs.hyprland}/bin/hyprctl activewindow -j | ${pkgs.jq}/bin/jq -r '.workspace.name')
        
        if [ "$active_ws" = "special:minimized" ]; then
            ${pkgs.hyprland}/bin/hyprctl dispatch movetoworkspace +0
        else
            ${pkgs.hyprland}/bin/hyprctl dispatch movetoworkspacesilent special:minimized
        fi
      '';
    in {
      monitor = [
        "DP-1, 1920x1080@240.00, auto, 1"
      ];

      exec-once = [
        "sleep 1 && uwsm app -- noctalia-shell"
        "soteria"
      ];

      env = [
        "XCURSOR_SIZE,32"
        "XDG_CURRENT_DESKTOP,Hyprland"
        "XDG_SESSION_TYPE,wayland"
        "XDG_SESSION_DESKTOP,Hyprland"
        "LIBVA_DRIVER_NAME,radeonsi"
        "QT_QPA_PLATFORM,wayland;xcb"
        "QT_QPA_PLATFORMTHEME,qt6ct"
        "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
        "QT_AUTO_SCREEN_SCALE_FACTOR,1"
        "GDK_SCALE,1"
        "MOZ_ENABLE_WAYLAND,1"
        "OZONE_PLATFORM,wayland"
        "NIXOS_OZONE_WL,1"
      ];

      input = {
        kb_layout = "us";
        kb_variant = "intl";
        follow_mouse = 1;
        sensitivity = 0;
        touchpad = {
          natural_scroll = false;
        };
      };

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

      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      misc = {
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
        force_default_wallpaper = 0;
        vfr = true;
        vrr = 1;
      };

      bind = [
        # --- Applications ---
        "${mod}, RETURN, exec, uwsm app -- kitty"
        "${mod}, DELETE, killactive"
        "${mod}, E, exec, uwsm app -- kitty -e yazi"
        "${mod}, B, exec, uwsm app -- zen-beta"

        # --- Windows & Workspaces ---
        "${mod}, T, togglefloating"
        "${mod}, Home, fullscreen, 0"
        
        # Minimize to special workspace
        "${mod}, End, exec, ${toggle-minimize}"
        "${mod} ALT, End, togglespecialworkspace, minimized"

        # Move focus
        "${mod}, left, movefocus, l"
        "${mod}, right, movefocus, r"
        "${mod}, up, movefocus, u"
        "${mod}, down, movefocus, d"
        "${mod}, l, movefocus, l"
        "${mod}, h, movefocus, r"
        "${mod}, k, movefocus, u"
        "${mod}, j, movefocus, d"

        # Workspace Navigation
        "${mod}, Page_Down, workspace, +1"
        "${mod}, Page_Up, workspace, -1"
        "${mod} ALT, Page_Down, movetoworkspace, +1"
        "${mod} ALT, Page_Up, movetoworkspace, -1"

        # Move the active window to a specific workspace (1-10)
        "${mod} SHIFT, 1, movetoworkspace, 1"
        "${mod} SHIFT, 2, movetoworkspace, 2"
        "${mod} SHIFT, 3, movetoworkspace, 3"
        "${mod} SHIFT, 4, movetoworkspace, 4"
        "${mod} SHIFT, 5, movetoworkspace, 5"
        "${mod} SHIFT, 6, movetoworkspace, 6"
        "${mod} SHIFT, 7, movetoworkspace, 7"
        "${mod} SHIFT, 8, movetoworkspace, 8"
        "${mod} SHIFT, 9, movetoworkspace, 9"
        "${mod} SHIFT, 0, movetoworkspace, 10"

        # Absolute Workspaces
        "${mod}, 1, workspace, 1"
        "${mod}, 2, workspace, 2"
        "${mod}, 3, workspace, 3"
        "${mod}, 4, workspace, 4"
        "${mod}, 5, workspace, 5"
        "${mod}, 6, workspace, 6"
        "${mod}, 7, workspace, 7"
        "${mod}, 8, workspace, 8"
        "${mod}, 9, workspace, 9"
        "${mod}, 0, workspace, 10"

        # --- Noctalia Shell (IPC Calls) ---
        "${mod}, SPACE, exec, ${ipc} launcher toggle"
        "${mod}, I, exec, ${ipc} settings toggle"
        "${mod}, period, exec, ${ipc} launcher emoji"
        "${mod}, L, exec, ${ipc} sessionMenu toggle"
        "${mod}, W, exec, ${ipc} wallpaper random"
        "${mod}, V, exec, ${ipc} launcher clipboard"

        # --- Others ---
        ", Print, exec, hyprshot -m region --clipboard-only"
      ];

      # Continuous Binds (for holding down brightness/volume keys)
      bindel = [
        "${mod}, F12, exec, ${ipc} brightness increase"
        "${mod}, F11, exec, ${ipc} brightness decrease"
        "${mod}, F10, exec, ${ipc} volume increase"
        "${mod}, F9, exec, ${ipc} volume decrease"
      ];

      # Lock Binds (work even when the PC is locked)
      bindl = [
        "${mod}, INSERT, exec, ${ipc} volume muteInput"
      ];

      # Mouse Binds
      bindm = [
        "${mod}, mouse:272, movewindow"
        "${mod}, mouse:273, resizewindow"
      ];
    };
  };
}
