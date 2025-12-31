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
  colorSchemeVariant = defaults.colorSchemeVariant;

  gtkColorSchemeVariant = if colorSchemeVariant == "nord-dark" then "Materia-nord-compact"
    else "";

  gtkThemePkg = if colorSchemeVariant == "nord-dark"
    then inputs.gtk-themes.packages.${pkgs.stdenv.hostPlatform.system}.gtk-theme-materia.Materia-nord-compact
    else pkgs.colloid-gtk-theme;

  iconThemePkg = inputs.icon-themes.packages.${pkgs.stdenv.hostPlatform.system}.icon-theme-luv.Luv-Dark;

  cursorThemePkg = inputs.cursor-themes.packages.${pkgs.stdenv.hostPlatform.system}.cursor-theme-nx.nx-snow;

  preferDark = if colorSchemeVariant == "nord-dark"
    then "prefer-dark"
    else "light";

  cfg = config.shelf.desktop.addons.gtk;
in {
  options.shelf.desktop.addons.gtk = {
    enable = mkBoolOpt false "Whether to enable gtk theme.";
  };

  config = mkIf cfg.enable {
    shelf.home.themePackages = with pkgs; [
      adwaita-icon-theme

      iconThemePkg
      cursorThemePkg
      gtkThemePkg
    ];

    programs.dconf.enable = true;

    shelf.home.extraOptions.dconf = {
      enable = true;
      settings = {
        "org/gnome/desktop/interface" = {
          color-scheme = preferDark;
        };
      };
    };

    shelf.home.extraOptions.gtk = {
      enable = true;
      theme = {
        name = gtkColorSchemeVariant;
        package = gtkThemePkg;
      };

      iconTheme = {
        name = "Luv-Dark";
        package = iconThemePkg;
      };

      cursorTheme = {
        name = "nx-snow";
        package = cursorThemePkg;
        size = 24;
      };

      font = {
        name = "Noto Sans";
        size = 10;
      };

      gtk3.extraConfig = {
        gtk-application-prefer-dark-theme = 1;
      };

      gtk4 = {
        extraConfig = {
          gtk-application-prefer-dark-theme = 1;
        };
        extraCss = ''
          @import url("file://${gtkThemePkg}/share/themes/${gtkColorSchemeVariant}/gtk-4.0/gtk.css");
        '';
      };
    };
  };
}
