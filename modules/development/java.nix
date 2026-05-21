{ config, pkgs, ... }:

{
  programs.java = {
    enable = true;
    # Uses OpenJDK 21 as the default system-wide Java Development Kit
    package = pkgs.jdk25;
  };

  home.packages = with pkgs; [
    maven     # Build automation tool primarily for Java projects
    gradle    # High-performance build automation tool supporting Kotlin/Java DSL
  ];
}
