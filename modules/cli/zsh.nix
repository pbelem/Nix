{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "docker" "dotnet" ];
    };
    
    shellAliases = {
      # Custom
      btw = "echo 'i use nixos, btw'";
      please = "sudo";
      screenshot = "wl-paste >"; # "screenshot example.png" to save a screenshot
      # Legacy
      nrs = "sudo nixos-rebuild switch --flake /etc/nixos#Desktop-NixOS";  # -b backup
      nrhm = "nix run home-manager/release-26.05 -- switch --flake /etc/nixos#belem"; # -b backup
      # System
      nel = "sudo nix-env --list-generations --profile /nix/var/nix/profiles/system";
      ned = "sudo nix-env \
      --profile /nix/var/nix/profiles/system \
      --delete-generations"; # + generation number as an argument
      # Flake 
      nfu = "nix flake update /etc/nixos"; # updates flake.lock, but it doesn't rebuild anything
      # Home manager
      hml = "nix run home-manager generations"; # "/nix/store/p7bh5rbfvjf9x5msz8jr1s712lmj67vn-home-manager-generation/activate" to activate
      hmd = "nix run home-manager remove-generations"; # + generation number as an argument
      # Nix Helper
      nhos = "nh os boot";
      nhhs = "nh home switch";
      nhck = "nh clean all --keep"; # + generation number as an argument
    };
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
      theme = "base16"; # Inherit terminal opacity and remove solid background
      style = "plain";  # Strips down borders and line numbers for a clean look
    };
  };

  home.shellAliases = {
    ll = "eza -l";
    la = "eza -la";
    tree = "eza --tree";
    cat = "bat -p"; 
  };
}
