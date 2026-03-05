# Build xdg-desktop-portal-gtk disabling gnome wallpaper feature preventing gnome-desktop/gt4 dependencies installation
final: prev: {
  xdg-desktop-portal-gtk =
    prev.xdg-desktop-portal-gtk.overrideAttrs (oldAttrs: {
      buildInputs = with prev; [
        glib
        gtk3
        xdg-desktop-portal
        gsettings-desktop-schemas
      ];

      # Disable gnome features
      mesonFlags = (oldAttrs.mesonFlags or []) ++ [
        "-Dwallpaper=disabled"
      ];
    });
}
