{ pkgs, ... }: let
  theme = {
    name = "Colloid-Teal-Dark-Compact";
  };

  iconTheme = {
    name = "Luv-Dark";
  };

  cursorTheme = {
    name = "Luv-Dark";
    size = 24;
  };

  font = {
    name = "Noto Sans";
    size = 10;
  };

in {
  home = {
    sessionVariables = {
      XCURSOR_THEME = cursorTheme.name;
      XCURSOR_SIZE = "${toString cursorTheme.size}";
    };
  };

  fonts.fontconfig.enable = true;

  gtk = {
    enable = true;
    inherit iconTheme cursorTheme font;
    theme.name = theme.name;    
  };
}
