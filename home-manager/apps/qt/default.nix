{ pkgs, ... }: {
  imports = [
    ./obs-studio.nix
  ];

  home.packages = with pkgs; [];
}