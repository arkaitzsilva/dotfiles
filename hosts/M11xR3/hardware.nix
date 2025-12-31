{
  config,
  lib,
  pkgs,
  modulesPath,
  defaults,
  ...
}:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  fileSystems."/" =
    { 
      device = "/dev/disk/by-label/NIXROOT";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-label/NIXBOOT";
      fsType = "vfat";
      options = [ "fmask=0022" "dmask=0022" ];
    };

  swapDevices = [
    {
      device = "/.swapfile";
      size = 16*1024;
    }
  ];

  boot = {
    loader.grub.device = "/dev/sda";

    # kernelPackages = pkgs.linuxPackages_lqx;

    kernelModules = [
      "kvm-intel"
    ];

    kernelParams = [];

    initrd = {
      availableKernelModules = [
        "ehci_pci"
        "ahci"
        "firewire_ohci"
        "xhci_pci"
        "usb_storage"
        "sd_mod"
        "sdhci_pci"
      ];

      kernelModules = [];
    };

    extraModprobeConfig = ''
      blacklist nouveau
      options nouveau modeset=0
    '';

    blacklistedKernelModules = [
      "nouveau"
      "nvidia"
      "nvidia_drm"
      "nvidia_modeset"
    ];  
  };

  services.udev.extraRules = ''
    # Remover dispositivos VGA/3D de NVIDIA
    ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x03[0-9]*", ATTR{power/control}="auto", ATTR{remove}="1"
  '';

  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp7s0.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp13s0.useDHCP = lib.mkDefault true;

  nixpkgs.config.nvidia.acceptLicense = true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  time.hardwareClockInLocalTime = true;
}
