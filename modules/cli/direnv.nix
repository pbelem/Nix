{
  programs.direnv = {
    enable = true;
    # Enables optimized integration for Nix and Nix Flakes (essential!)
    nix-direnv.enable = true;
    enableZshIntegration = true;
  };
}
