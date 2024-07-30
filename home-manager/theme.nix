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
    #package = pkgs.fluent-icon-theme;
  };

  cursorTheme = {
    name = "Adwaita";
    size = 24;
    package = pkgs.adwaita-icon-theme;
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
      meslo-lgs-nf

      # Icons
      #iconTheme.package
      cursorTheme.package
      
      # GTK
      theme.package
    ];

    sessionVariables = {
      XCURSOR_THEME = cursorTheme.name;
      XCURSOR_SIZE = "${toString cursorTheme.size}";
    };

    pointerCursor =
      cursorTheme
      // {
        gtk.enable = true;
      };
  };

  gtk = {
    enable = true;
    inherit iconTheme cursorTheme font;
    theme.name = theme.name;    
  };
}
