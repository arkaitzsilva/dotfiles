{ pkgs, inputs, ... }: let
  colloid-gtk-theme = pkgs.colloid-gtk-theme.override {
    themeVariants = [ "teal" ];
    #colorVariants = [ "" ];
    sizeVariants = [ "compact" ];
    tweaks = [ "rimless" "normal" ];
  };
in {
  environment.systemPackages = with pkgs; [
    colloid-gtk-theme
    adwaita-icon-theme
    cantarell-fonts
    
    inputs.swww.packages.${pkgs.system}.swww
    hyprpicker
    cliphist
    brightnessctl
    playerctl
    viewnior
    zathura
    mpv
  ];
}