{
  config,
  pkgs,
  lib,
  ...
}:
with lib; with lib.shelf; let
  cfg = config.shelf.desktop.addons.xdg-desktop-portal;

  # Build xdg-desktop-portal-gtk disabling gnome wallpaper feature preventing gnome-desktop/gt4 dependencies installation
  gtkPortalPkg = pkgs.xdg-desktop-portal-gtk.overrideAttrs (old: {
    buildInputs = with pkgs; [
      glib
      gtk3
      xdg-desktop-portal
      gsettings-desktop-schemas
    ];

    # Disable xdg-desktop-portal-gtk gnome features
    mesonFlags = (old.mesonFlags or []) ++ [
      "-Dwallpaper=disabled"
    ];
  });
in {
  options.shelf.desktop.addons.xdg-desktop-portal = {
    enable = mkBoolOpt false "Whether to enable xdg-desktop-portal.";
  };

  config = mkIf cfg.enable {
    xdg.portal = {
      enable = true;
      extraPortals = with pkgs; [
        gtkPortalPkg
        xdg-desktop-portal-wlr
      ];

      config.hyprland = {
        default = [ "gtk" ];
        "org.freedesktop.impl.portal.ScreenCast" = [ "wlr" ];
        "org.freedesktop.impl.portal.RemoteDesktop" = [ "wlr" ];
      };
    };

    shelf.home.packages = with pkgs; [
      slurp
    ];
  };
}
