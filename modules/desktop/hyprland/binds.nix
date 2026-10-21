{ pkgs, lib, ... }:

let
  hl = import ./lib.nix { inherit lib; };
  inherit (hl) mkBind exec close toggleFloat fullscreen focusDir focusWs moveToWs
    dragWindow resizeWindow hyprctlDispatch;

  mod = "SUPER";
  ipc = "noctalia msg";

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
      (mkBind { key = "${mod} + RETURN"; action = exec "uwsm app -- kitty"; })
      (mkBind { key = "${mod} + DELETE"; action = close; })
      (mkBind { key = "${mod} + E"; action = exec "uwsm app -- kitty -e yazi"; })
      (mkBind { key = "${mod} + B"; action = exec "uwsm app -- zen-beta"; })

      # --- Windows & Workspaces ---
      (mkBind { key = "${mod} + T"; action = toggleFloat; })
      (mkBind { key = "${mod} + Home"; action = fullscreen "fullscreen"; })

      # Minimize to special workspace
      (mkBind { key = "${mod} + End"; action = exec "${toggle-minimize}"; })
      # togglespecialworkspace: native lua signature unconfirmed, bridged via hyprctl
      (mkBind { key = "${mod} + ALT + End"; action = hyprctlDispatch "togglespecialworkspace minimized"; })

      # Move focus
      (mkBind { key = "${mod} + left"; action = focusDir "left"; })
      (mkBind { key = "${mod} + right"; action = focusDir "right"; })
      (mkBind { key = "${mod} + up"; action = focusDir "up"; })
      (mkBind { key = "${mod} + down"; action = focusDir "down"; })

      # Workspace navigation (relative)
      (mkBind { key = "${mod} + Page_Down"; action = focusWs "+1"; })
      (mkBind { key = "${mod} + Page_Up"; action = focusWs "-1"; })
      (mkBind { key = "${mod} + ALT + Page_Down"; action = moveToWs "+1"; })
      (mkBind { key = "${mod} + ALT + Page_Up"; action = moveToWs "-1"; })

      # Move the active window to a specific workspace (1-10)
      (mkBind { key = "${mod} + SHIFT + 1"; action = moveToWs "1"; })
      (mkBind { key = "${mod} + SHIFT + 2"; action = moveToWs "2"; })
      (mkBind { key = "${mod} + SHIFT + 3"; action = moveToWs "3"; })
      (mkBind { key = "${mod} + SHIFT + 4"; action = moveToWs "4"; })
      (mkBind { key = "${mod} + SHIFT + 5"; action = moveToWs "5"; })
      (mkBind { key = "${mod} + SHIFT + 6"; action = moveToWs "6"; })
      (mkBind { key = "${mod} + SHIFT + 7"; action = moveToWs "7"; })
      (mkBind { key = "${mod} + SHIFT + 8"; action = moveToWs "8"; })
      (mkBind { key = "${mod} + SHIFT + 9"; action = moveToWs "9"; })
      (mkBind { key = "${mod} + SHIFT + 0"; action = moveToWs "10"; })

      # Absolute workspaces
      (mkBind { key = "${mod} + 1"; action = focusWs "1"; })
      (mkBind { key = "${mod} + 2"; action = focusWs "2"; })
      (mkBind { key = "${mod} + 3"; action = focusWs "3"; })
      (mkBind { key = "${mod} + 4"; action = focusWs "4"; })
      (mkBind { key = "${mod} + 5"; action = focusWs "5"; })
      (mkBind { key = "${mod} + 6"; action = focusWs "6"; })
      (mkBind { key = "${mod} + 7"; action = focusWs "7"; })
      (mkBind { key = "${mod} + 8"; action = focusWs "8"; })
      (mkBind { key = "${mod} + 9"; action = focusWs "9"; })
      (mkBind { key = "${mod} + 0"; action = focusWs "10"; })

      # --- Noctalia Shell (IPC Calls) ---
      (mkBind { key = "${mod} + SPACE"; action = exec "${ipc} panel-toggle launcher"; })
      (mkBind { key = "${mod} + I"; action = exec "${ipc} settings-toggle"; })
      (mkBind { key = "${mod} + period"; action = exec "${ipc} panel-toggle launcher /emo"; })
      # (mkBind { key = "${mod} + L"; action = exec "${ipc} panel-toggle session"; })
      (mkBind { key = "${mod} + W"; action = exec "${ipc} wallpaper-random"; })
      (mkBind { key = "${mod} + V"; action = exec "${ipc} panel-toggle clipboard"; })

      # --- Others ---
      (mkBind { key = "Print"; action = exec "hyprshot -m region --clipboard-only"; })

      # --- Multimedia (formerly bindel: repeat + works when locked) ---
      (mkBind { key = "${mod} + F12"; action = exec "${ipc} brightness-up"; flags = { repeating = true; locked = true; }; })
      (mkBind { key = "${mod} + F11"; action = exec "${ipc} brightness-down"; flags = { repeating = true; locked = true; }; })
      (mkBind { key = "${mod} + F10"; action = exec "${ipc} volume-up"; flags = { repeating = true; locked = true; }; })
      (mkBind { key = "${mod} + F9"; action = exec "${ipc} volume-down"; flags = { repeating = true; locked = true; }; })

      # --- formerly bindl: works when locked, no repeat ---
      (mkBind { key = "${mod} + INSERT"; action = exec "${ipc} mic-mute"; flags = { locked = true; }; })

      # --- formerly bindm: mouse move/resize ---
      (mkBind { key = "${mod} + mouse:272"; action = dragWindow; })
      (mkBind { key = "${mod} + mouse:273"; action = resizeWindow; })
    ];
  };
}
