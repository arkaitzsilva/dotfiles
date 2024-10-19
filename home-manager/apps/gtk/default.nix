{ pkgs, ... }: {
  imports = [
    ./firefox.nix 
  ];

  home.packages = with pkgs; [
    libreoffice-still
    vscode
    gedit
    gimp
    inkscape
    amule
    deluge
    qalculate-gtk
    brave
  ];
}