{
  config,
  pkgs,
  lib,
  inputs,
  defaults,
  ...
}:
with lib;
with lib.shelf; let
  cfg = config.shelf.desktop.addons.flatpak;

  colorSchemeVariant = defaults.colorSchemeVariant;

  mkRoSymBind = path: {
    device = path;
    fsType = "fuse.bindfs";
    options = [
      "ro"
      "resolve-symlinks"
      "x-gvfs-hide"
    ];
  };

  aggregated = pkgs.buildEnv {
    name = "system-fonts-and-icons";
    paths =
      config.fonts.packages
      ++ config.shelf.home.themePackages;
    pathsToLink = [
      "/share/fonts"
      "/share/icons"
    ];
  };
in {
  options.shelf.desktop.addons.flatpak = {
    enable = mkBoolOpt false "Whether to enable flatpak.";
  };

  config = mkIf cfg.enable {
    # Flatpak
    shelf.home.sessionVariables = {
      XDG_DATA_DIRS = "$XDG_DATA_DIRS:/usr/share:/var/lib/flatpak/exports/share:$HOME/.local/share/flatpak/exports/share";
    };

    services.flatpak.enable = true;

    system.fsPackages = [ pkgs.bindfs ];

    fileSystems = {
      "/usr/share/fonts" = mkRoSymBind "${aggregated}/share/fonts";
      "/usr/share/icons" = mkRoSymBind "${aggregated}/share/icons";
    };

    # Declarative Flatpak
    shelf.home.extraImports = [
      inputs.declarative-flatpak.homeModules.default
    ];

    shelf.home.services.flatpak = {
      enable = true;
      remotes = {
        flathub = "https://flathub.org/repo/flathub.flatpakrepo";
      };
      packages = [
        "flathub:app/com.brave.Browser/x86_64/stable"
        "flathub:app/com.visualstudio.code/x86_64/stable"
        "flathub:app/org.mozilla.firefox/x86_64/stable"
        "flathub:app/org.torproject.torbrowser-launcher/x86_64/stable"
        "flathub:app/org.deluge_torrent.deluge/x86_64/stable"
        "flathub:app/com.obsproject.Studio/x86_64/stable"
        "flathub:app/org.inkscape.Inkscape/x86_64/stable"
        "flathub:app/org.gimp.GIMP/x86_64/stable"
      ]
      ++ (
        if colorSchemeVariant == "nord-dark" then
          [ "flathub:runtime/org.gtk.Gtk3theme.Materia-nord-compact/x86_64/3.22" ]
        else
          []
      );
    };
  };
}
