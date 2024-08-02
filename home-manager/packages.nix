{ pkgs, ... }: {
  home.packages = with pkgs; [
    # CLI
    htop
    neofetch
    cryfs
    cmatrix
    unzip
    unrar
    
    # Other
    firefox
    google-chrome
    vscode
    gedit
    gimp
    inkscape
  ];
}
