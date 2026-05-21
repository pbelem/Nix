  programs.zsh = {
    enable = true;
    shellAliases = {
      btw = "echo 'i use nixos, btw'";
      please = "sudo";
    };
    loginExtra = ''
      if [ -z "$WAYLAND_DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then
        exec uwsm start hyprland-uwsm.desktop
      fi
    '';
  };
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
    options = [
      "--cmd cd"
    ];
  };
  programs.eza = {
    enable = true;
    enableZshIntegration = true;
    git = true; 
    icons = "auto"; 
  };

  programs.bat = {
    enable = true;
    config = {
      theme = "base16"; # Remove the solid background and inherit Kitty's transparency.
      style = "plain";  # Optional: Remove the side borders for an even cleaner look.
    };
  };

  home.shellAliases = {
    ls = "eza";
    ll = "eza -l";
    la = "eza -la";
    tree = "eza --tree";
    cat = "bat -p"; 
  };

}
