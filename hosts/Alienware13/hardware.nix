{
  config,
  lib,
  pkgs,
  modulesPath,
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
    loader = {
      efi.canTouchEfiVariables = true;
      grub = {
        enable = true;
        devices = [ "nodev" ];
        efiSupport = true;
        useOSProber = true;
        splashImage = null;
        gfxmodeEfi = "3200x1800";
        font = "${pkgs.terminus_font_ttf}/share/fonts/truetype/TerminusTTF.ttf";
        fontSize = 32;
      };
    };

    kernelModules = [
      "kvm-intel"
      "dell_smbios"
      "dell_wmi"
      "dell_laptop"
      "dell_rbtn"
      "dell_smm_hwmon"
      "ec_sys"
    ];

    kernelParams = [
      "i915.enable_guc=2"
    ];

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
    };
  };
  
  hardware.firmware = with pkgs; [
    linux-firmware
  ];

  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  hardware.graphics = {
    enable = true;
  };

  # Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = [
    "modesetting"
    "nvidia"
  ];

  hardware.nvidia = {
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
    package = config.boot.kernelPackages.nvidiaPackages.mkDriver {
      version = "580.142";
      sha256_64bit = "sha256-IJFfzz/+icNVDPk7YKBKKFRTFQ2S4kaOGRGkNiBEdWM=";
      sha256_aarch64 = lib.fakeSha256;
      openSha256 = lib.fakeSha256;
      settingsSha256 = lib.fakeSha256;
      persistencedSha256 = lib.fakeSha256;
    };


    prime = {
      offload = {
        enable = true;
        enableOffloadCmd = true;
      };
      # Make sure to use the correct Bus ID values for your system!
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:3:0:0";
    };
  };

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

  services.tlp = {
    enable = true;
    settings = {
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "balance_power";

      CPU_MIN_PERF_ON_AC = 0;
      CPU_MAX_PERF_ON_AC = 100;

      CPU_MIN_PERF_ON_BAT = 0;
      CPU_MAX_PERF_ON_BAT = 50;

      CPU_BOOST_ON_AC = 1;
      CPU_BOOST_ON_BAT = 1;

      INTEL_GPU_BOOST_FREQ_ON_AC = 1;
      INTEL_GPU_MIN_FREQ_ON_AC = 600;

      INTEL_GPU_BOOST_FREQ_ON_BAT = 1;
      INTEL_GPU_MIN_FREQ_ON_BAT = 400;
    };
  };
}
