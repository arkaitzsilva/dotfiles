{ pkgs, ... }: {
  home.packages = with pkgs; [
    # CLI
    htop
    neofetch
    cryfs
    cmatrix
    unzip
    unrar
    
    # GTK
    firefox
    brave
    vscode
    gedit
    gimp
    inkscape
    amule
    deluge
  ];
}
