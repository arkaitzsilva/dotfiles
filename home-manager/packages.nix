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

    #GNOME
    gnome-secrets

    # Fonts
    noto-fonts
    noto-fonts-color-emoji
    noto-fonts-monochrome-emoji
    google-fonts
    font-awesome
  ];
}
