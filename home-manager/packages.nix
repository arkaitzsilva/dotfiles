{ pkgs, ... }: {
  home.packages = with pkgs; [
    # CLI
    htop
    neofetch
    cryfs
    cmatrix
    
    # Other
    firefox
    google-chrome
    vscode
    gedit
    gimp
    inkscape
  ];
}
