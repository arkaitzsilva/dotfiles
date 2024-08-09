{ pkgs, ... }: let
  colloid-gtk-theme = pkgs.colloid-gtk-theme.override {
    themeVariants = [ "teal" ];
    #colorVariants = [ "" ];
    sizeVariants = [ "compact" ];
    tweaks = [ "rimless" "normal" ];
  };

  theme = {
    name = "Colloid-Teal-Dark-Compact";
    package = colloid-gtk-theme;
  };

  iconTheme = {
    name = "Luv-Dark";
  };

  cursorTheme = {
    name = "Luv-Dark";
    size = 24;
  };

  font = {
    name = "Cantarell";
    package = pkgs.cantarell-fonts;
    size = 10;
  };

in {
  home = {
    packages = with pkgs; [
      # Fonts
      font.package

      # Icons
      adwaita-icon-theme
      
      # GTK
      theme.package
    ];

    sessionVariables = {
      XCURSOR_THEME = cursorTheme.name;
      XCURSOR_SIZE = "${toString cursorTheme.size}";
    };
  };

  gtk = {
    enable = true;
    inherit iconTheme cursorTheme font;
    theme.name = theme.name;    
  };
}
