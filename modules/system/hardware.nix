{ config, pkgs, pkgsUnstable, ... }:

{
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    package = pkgsUnstable.mesa;
    package32 = pkgsUnstable.pkgsi686Linux.mesa;
    extraPackages = with pkgs; [
      rocmPackages.clr
      rocmPackages.clr.icd
    ];
  };

  hardware.i2c.enable = true;
  hardware.enableAllFirmware = true; 
  hardware.enableRedistributableFirmware = true;
  hardware.cpu.amd.updateMicrocode = true;

  services.xserver.videoDrivers = [ "amdgpu" ];

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };
  
  services.udev.extraRules = ''
    KERNEL=="hidraw*", ATTRS{idVendor}=="0483", ATTRS{idProduct}=="5750", MODE="0666"
    KERNEL=="i2c-[0-9]*", GROUP="i2c", MODE="0660"
  '';

  services.udev.extraHwdb = ''
    evdev:input:b0003v*
      KEYBOARD_KEY_70039=esc
      KEYBOARD_KEY_70029=capslock
  '';
}
