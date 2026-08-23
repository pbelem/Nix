{ config, pkgs, pkgsUnstable,  ... }:

{
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
    systemd-boot.memtest86.enable = true;
    #time.hardwareClockInLocalTime = true;
  };

  boot = {
    kernelPackages = pkgs.linuxPackages_zen;
    kernelParams = [ "amdgpu.dc=1" ];
    kernelModules = [ "i2c-dev" "ddcci-backlight" ];
    extraModulePackages = with config.boot.kernelPackages; [ ddcci-driver ];
    
    kernel.sysctl = {
      "vm.swappiness" = 180;
      "vm.page-cluster" = 0;
      "vm.watermark_boost_factor" = 0;
      "vm.watermark_scale_factor" = 125;
    };
  };

  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 50;
    priority = 180;
    swapDevices = 1;
  };
  # kill processes when out of memory instaed of crashing
  systemd.oomd.enable = true;
}
