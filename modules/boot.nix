{ pkgs, ... }:

{
  boot = {
    loader = {
      grub = {
        enable = true;
        efiSupport = true;
        device = "nodev";
        useOSProber = true; 
      };
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot"; 
      };
    };
    kernelPackages = pkgs.linuxPackages;
    initrd.kernelModules = [

    ];
    kernelParams = [  ];
  };
}
