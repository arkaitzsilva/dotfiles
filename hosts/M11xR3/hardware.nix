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

    extraModprobeConfig = lib.mkIf (!defaults.enableDiscreteGraphics) ''
      blacklist nouveau
      options nouveau modeset=0
    '';

    blacklistedKernelModules = lib.mkIf (!defaults.enableDiscreteGraphics) [
      "nouveau"
      "nvidia"
      "nvidia_drm"
      "nvidia_modeset"
    ];  
  };

  services.udev.extraRules = lib.mkIf (!defaults.enableDiscreteGraphics) ''
    # Remover dispositivos VGA/3D de NVIDIA
    ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x03[0-9]*", ATTR{power/control}="auto", ATTR{remove}="1"
  '';

  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  hardware.graphics = lib.mkIf (defaults.enableDiscreteGraphics) {
    enable = true;
  };

  services.xserver.videoDrivers = lib.mkIf (defaults.enableDiscreteGraphics) [
    "nvidia"
  ];

  hardware.nvidia = lib.mkIf (defaults.enableDiscreteGraphics) {
    # Modesetting is required.
    modesetting.enable = true;

    # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
    # Enable this if you have graphical corruption issues or application crashes after waking
    # up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead 
    # of just the bare essentials.
    powerManagement.enable = false;

    # Fine-grained power management. Turns off GPU when not in use.
    # Experimental and only works on modern Nvidia GPUs (Turing or newer).
    powerManagement.finegrained = false;

    # Use the NVidia open source kernel module (not to be confused with the
    # independent third-party "nouveau" open source driver).
    # Support is limited to the Turing and later architectures. Full list of 
    # supported GPUs is at: 
    # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus 
    # Only available from driver 515.43.04+
    open = false;

    # Enable the Nvidia settings menu,
	  # accessible via `nvidia-settings`.
    nvidiaSettings = false;

    # Optionally, you may need to select the appropriate driver version for your specific GPU.
    package = config.boot.kernelPackages.nvidiaPackages.stable;

    prime = {
      sync.enable = true;
      
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp7s0.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp13s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
