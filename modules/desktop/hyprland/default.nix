{ config, pkgs, inputs, lib, ... }:

let
  hl = import ./lib.nix { inherit lib; };

  env = {
    XCURSOR_SIZE = "32";
    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_TYPE = "wayland";
    XDG_SESSION_DESKTOP = "Hyprland";
    LIBVA_DRIVER_NAME = "radeonsi";
    QT_QPA_PLATFORM = "wayland;xcb";
    QT_QPA_PLATFORMTHEME = "qt6ct";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    QT_AUTO_SCREEN_SCALE_FACTOR = "1";
    GDK_SCALE = "1";
    MOZ_ENABLE_WAYLAND = "1";
    OZONE_PLATFORM = "wayland";
    NIXOS_OZONE_WL = "1";
  };
in
  {
  imports = [
    ./binds.nix
    ./monitors.nix
    ./theme.nix
  ];

  xdg.configFile."hypr/hyprland.lua".force = true;

  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;

    configType = "lua";

    settings = {
      env = lib.mapAttrsToList (name: value: { _args = [ name value ]; }) env;

      on = [
        (hl.mkOn {
          event = "hyprland.start";
          body = ''
            ${hl.exec "sleep 1 && uwsm app -- noctalia"}
            ${hl.exec "soteria"}
          '';
        })
      ];

      window_rule = [
        {
          match = { class = "dev.noctalia.Noctalia"; };
          float = true;
          size = [ 1080 920 ];
        }
      ];

      layer_rule = [
        {
          name = "noctalia";
          match = {
            namespace = "^noctalia-(bar-.+|notification|dock|panel|attached-panel|osd|window-switcher)$";
          };
          no_anim = true;
          ignore_alpha = 0.5;
          blur = true;
          blur_popups = true;
        }
      ];

      config = {
        input = {
          kb_layout = "us";
          kb_variant = "intl";
          follow_mouse = 1;
          sensitivity = 0;
          touchpad.natural_scroll = false;
        };

        dwindle.preserve_split = true;

        misc = {
          disable_hyprland_logo = true;
          disable_splash_rendering = true;
          force_default_wallpaper = 0;
          vrr = 1;
        };
      };
    };
  };
}
