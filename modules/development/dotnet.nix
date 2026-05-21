{ config, pkgs, ... }:

let
  # Combines multiple .NET SDK versions into a single package to prevent environment conflicts
  dotnet-sdk = with pkgs; dotnetCorePackages.combinePackages [
    dotnetCorePackages.sdk_8_0
    dotnetCorePackages.sdk_9_0
  ];
in
{
  home.packages = [
    dotnet-sdk
    pkgs.netcoredbg # Managed code debugger for CLI/Neovim (essential for C# DAP)
  ];

  # Forces development tools and LSPs to look into the correct Nix Store path for .NET
  home.sessionVariables = {
    DOTNET_ROOT = "${dotnet-sdk}";
  };
}
