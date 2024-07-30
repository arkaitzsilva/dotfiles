{
  pkgs,
  inputs,
  ...
}: let
  username = "alienware";
in {
  imports = [
    /etc/nixos/hardware-configuration.nix
    ./system.nix
    ./audio.nix
    ./locale.nix
    ./hyprland.nix
    ./thunar.nix
  ];

  programs.zsh.enable = true;

  hyprland.enable = true;

  users.users.${username} = {
    isNormalUser = true;
    initialPassword = username;
    shell = pkgs.zsh;
    extraGroups = [
      "wheel"
      "networkmanager"
    ];
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.${username} = {
      home.username = username;
      home.homeDirectory = "/home/${username}";
      imports = [
        ../home-manager/zsh.nix
        ../home-manager/foot.nix
        ../home-manager/theme.nix
        ../home-manager/packages.nix
        ../home-manager/dconf.nix
        ../home-manager/settings.nix
        ../home-manager/hyprland.nix
        ../home-manager/wofi.nix
        ../home-manager/wlogout.nix
        ../home-manager/git.nix
        ./home.nix
      ];
    };
  };
}
