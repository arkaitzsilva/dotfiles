{ pkgs, inputs, ... }: let
  username = "alienware";
  description = "Alienware";
in {
  imports = [
    /etc/nixos/hardware-configuration.nix
    ./system.nix
    ./locale.nix
    ./desktop/hyprland
  ];

  users.users.${username} = {
    description = description;
    isNormalUser = true;
    initialPassword = username;
    extraGroups = [
      "wheel"
      "networkmanager"
      "docker"
      "libvirtd"
    ];
  };

  home-manager = {
    backupFileExtension = "backup";
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = {inherit inputs;};
    users.${username} = {
      home.username = username;
      home.homeDirectory = "/home/${username}";
      imports = [
        ./home.nix
      ];
    };
  };
}
