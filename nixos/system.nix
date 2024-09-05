{ pkgs, ... }: {
  nixpkgs.config.allowUnfree = true;
  
  nix.settings.experimental-features = ["nix-command" "flakes"];

  environment.systemPackages = with pkgs; [
    home-manager
    git
    wget
    curl
    neovim
  ];

  services = {
    printing.enable = true;
    openssh.enable = true;
  };

  networking.networkmanager.enable = true;

  boot.loader.grub = {
    enable = true;
    device = "/dev/sda"; 
  };

  virtualisation = {
    docker.enable = true;
    libvirtd.enable = true;
  };

  programs = {
    dconf.enable = true;
    virt-manager.enable = true;
    gnupg.agent.enable = true;
  };

  system.stateVersion = "24.11";
}
