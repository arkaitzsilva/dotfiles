{ pkgs, ... }: {
  home.packages = with pkgs; [
    htop
    neofetch
    cryfs
    cmatrix
    unzip
    unrar
    jq
    gifsicle
    pass
    gettext
  ];
}