{ pkgs, ... }: {
  imports = [
    ./fonts.nix
    ./cli.nix
  ];

  home.packages = with pkgs; [
    viewnior
    zathura
    mpv
  ];
}
