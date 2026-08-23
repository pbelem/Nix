{ pkgs, ... }:

{
  users.users.belem = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
      "docker"
      "video"
      "i2c"
      "audio"
      "input"
      "render"
    ];
    shell = pkgs.zsh;
    # change after first login
    initialPassword = "mudar123";
  };

  users.defaultUserShell = pkgs.zsh;
  programs.zsh.enable = true;
}

