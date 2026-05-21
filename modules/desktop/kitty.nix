{
  programs.kitty = {
    enable = true;
    font = {
      name = "JetBrainsMono Nerd Font";
      size = 11;
    };

    settings = {
      # Startup Configuration
      startup_session = "session.conf";
      
      # Sincronização dinâmica de tema gerenciada pelo Noctalia Shell
      include = "current-theme.conf";
      
      # Fonts
      bold_font = "auto";
      italic_font = "auto";
      bold_italic_font = "auto";

      # Window Behavior and Background
      confirm_os_window_close = "0";
      window_padding_width = "25";
      background_opacity = "0.7";

      # Cursor Behavior and Style
      cursor_shape = "beam";
      cursor_beam_thickness = "4";
      
      # Trail animation 
      cursor_trail = "1"; # Increasing it from 1 to 3 will make the trail a little longer and more visible.
      # cursor_trail_decay = "0.1 0.4"; # Controls the time (in seconds) it takes for the tip and end of the trail to disappear.
      cursor_trail_start_threshold = "0";
      
      # Blink
      cursor_blink_interval = "0.5";
      cursor_stop_blinking_after = "0";
      cursor_shape_unfocused = "unchanged";
    };
  };

  # Generates the default session to auto-start fastfetch inside the terminal
  xdg.configFile."kitty/session.conf".text = ''
    launch --hold fastfetch
  '';
}
