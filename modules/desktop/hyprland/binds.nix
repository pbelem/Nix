{ pkgs, ... }:

let
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
in 
{
  wayland.windowManager.hyprland.settings = {
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
      /* "${mod}, L, exec, ${ipc} sessionMenu toggle" */
      "${mod}, W, exec, ${ipc} wallpaper random"
      "${mod}, V, exec, ${ipc} launcher clipboard"

      # --- Others ---
      ", Print, exec, hyprshot -m region --clipboard-only"
    ];

    bindel = [
      "${mod}, F12, exec, ${ipc} brightness increase"
      "${mod}, F11, exec, ${ipc} brightness decrease"
      "${mod}, F10, exec, ${ipc} volume increase"
      "${mod}, F9, exec, ${ipc} volume decrease"
    ];

    bindl = [
      "${mod}, INSERT, exec, ${ipc} volume muteInput"
    ];

    bindm = [
      "${mod}, mouse:272, movewindow"
      "${mod}, mouse:273, resizewindow"
    ];
  };
}
