{ pkgs, ... }: {
  nixpkgs.config.allowUnfree = true;
  
  nix.settings.experimental-features = ["nix-command" "flakes"];

  environment.systemPackages = with pkgs; [
    home-manager
    git
    wget
    curl
  ];

  networking.networkmanager.enable = true;

  boot.loader.grub = {
    enable = true;
    device = "/dev/sda"; 
  };

  system.stateVersion = "24.11";
}
