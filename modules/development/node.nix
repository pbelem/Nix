{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    nodejs_20       # LTS Node.js runtime environment
    yarn            # Fast and secure dependency management alternative to npm
  ];

  home.sessionVariables = {
    # Relocates globally installed npm packages to a writable subdirectory in user space
    NPM_CONFIG_PREFIX = "${config.home.homeDirectory}/.npm-global";
  };

  # Extends the system PATH so your shell can execute tools installed via 'npm i -g'
  home.sessionPath = [
    "${config.home.homeDirectory}/.npm-global/bin"
  ];
}
