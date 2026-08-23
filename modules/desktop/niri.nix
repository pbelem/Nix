{ config, pkgs, inputs, ... }:

{
  xdg.configFile."niri/config.kdl".text = ''
    input {
        keyboard {
            xkb {
                layout "us"
                variant "intl"
                // Remapeamento nativo do Caps Lock para Escape
                options "caps:escape"
            }
        }
        touchpad {
            natural-scroll false
        }
        mouse {
            accel-profile "flat"
        }
    }

    output "DP-1" {
        mode "2560x1440@180.00"
        position x=1080 y=0
        scale 1.0
    }

    output "DP-2" {
        mode "1920x1080@240.00"
        position x=0 y=0
        scale 1.0
        transform "270"
    }

    layout {
        gaps 10
        center-focused-column "never"

        preset-column-widths {
            proportion 0.33333
            proportion 0.5
            proportion 1.0
        }

        default-column-width { proportion 1.0; }

        focus-ring {
            enable
            width 2
            active-color "#ffb86b"
            inactive-color "#44475a"
        }
        border {
            off
        }
    }

    spawn-at-startup "bash" "-c" "sleep 1 && uwsm app -- noctalia-shell"
    spawn-at-startup "soteria"

    environment {
        XCURSOR_SIZE "32"
        XDG_CURRENT_DESKTOP "Niri"
        XDG_SESSION_TYPE "wayland"
        XDG_SESSION_DESKTOP "Niri"
        LIBVA_DRIVER_NAME "radeonsi"
        QT_QPA_PLATFORM "wayland;xcb"
        QT_QPA_PLATFORMTHEME "qt6ct"
        QT_WAYLAND_DISABLE_WINDOWDECORATION "1"
        QT_AUTO_SCREEN_SCALE_FACTOR "1"
        GDK_SCALE "1"
        MOZ_ENABLE_WAYLAND "1"
        OZONE_PLATFORM "wayland"
        NIXOS_OZONE_WL "1"
    }

    animations {
        workspace-switch {
            spring damping-ratio=1.0 stiffness=1000 epsilon=0.0001
        }
        window-open {
            duration-ms 200
            curve "ease-out-expo"
        }
    }

    window-rule {
        geometry-corner-radius 20
        clip-to-geometry true
    }

    binds {
        // --- Applications ---
        Super+Return { spawn "uwsm" "app" "--" "kitty"; }
        Super+Delete { close-window; }
        Super+E { spawn "uwsm" "app" "--" "kitty" "-e" "yazi"; }
        Super+B { spawn "uwsm" "app" "--" "zen-beta"; }

        // --- Windows & Workspaces ---
        Super+Home { maximize-column; }
        
        Super+End { move-column-to-workspace "minimized"; }
        Super+Alt+End { focus-workspace "minimized"; }

        Super+Left { focus-column-left; }
        Super+Right { focus-column-right; }
        Super+Up { focus-window-or-workspace-up; }
        Super+Down { focus-window-or-workspace-down; }
        
        Super+H { focus-column-left; }
        Super+L { focus-column-right; }
        Super+K { focus-window-or-workspace-up; }
        Super+J { focus-window-or-workspace-down; }

        Super+Page_Down { focus-workspace-down; }
        Super+Page_Up { focus-workspace-up; }
        Super+Alt+Page_Down { move-column-to-workspace-down; }
        Super+Alt+Page_Up { move-column-to-workspace-up; }

        Super+Shift+1 { move-column-to-workspace 1; }
        Super+Shift+2 { move-column-to-workspace 2; }
        Super+Shift+3 { move-column-to-workspace 3; }
        Super+Shift+4 { move-column-to-workspace 4; }
        Super+Shift+5 { move-column-to-workspace 5; }
        Super+Shift+6 { move-column-to-workspace 6; }
        Super+Shift+7 { move-column-to-workspace 7; }
        Super+Shift+8 { move-column-to-workspace 8; }
        Super+Shift+9 { move-column-to-workspace 9; }
        Super+Shift+0 { move-column-to-workspace 10; }

        Super+1 { focus-workspace 1; }
        Super+2 { focus-workspace 2; }
        Super+3 { focus-workspace 3; }
        Super+4 { focus-workspace 4; }
        Super+5 { focus-workspace 5; }
        Super+6 { focus-workspace 6; }
        Super+7 { focus-workspace 7; }
        Super+8 { focus-workspace 8; }
        Super+9 { focus-workspace 9; }
        Super+0 { focus-workspace 10; }

        // --- Noctalia Shell (IPC Calls) ---
        Super+Space { spawn "noctalia-shell" "ipc" "call" "launcher" "toggle"; }
        Super+I { spawn "noctalia-shell" "ipc" "call" "settings" "toggle"; }
        Super+Period { spawn "noctalia-shell" "ipc" "call" "launcher" "emoji"; }
        Super+W { spawn "noctalia-shell" "ipc" "call" "wallpaper" "random"; }
        Super+V { spawn "noctalia-shell" "ipc" "call" "launcher" "clipboard"; }
        
        // --- Screenshot (Grim + Slurp via Bash) ---
        Print { spawn "bash" "-c" "grim -g \"$(slurp)\" - | wl-copy"; }
        
        // --- Media & Continuous Binds ---
        Super+F12 { spawn "noctalia-shell" "ipc" "call" "brightness" "increase"; }
        Super+F11 { spawn "noctalia-shell" "ipc" "call" "brightness" "decrease"; }
        Super+F10 { spawn "noctalia-shell" "ipc" "call" "volume" "increase"; }
        Super+F9 { spawn "noctalia-shell" "ipc" "call" "volume" "decrease"; }
        Super+Insert { spawn "noctalia-shell" "ipc" "call" "volume" "muteInput"; }
    }
  '';
}