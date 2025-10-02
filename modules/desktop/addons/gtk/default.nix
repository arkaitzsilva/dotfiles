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

  gtkCompileColorSchemeVariant = if colorSchemeVariant == "nord-dark"
    then "nord"
    else "";

  gtkColorSchemeVariant = if colorSchemeVariant == "nord-dark"
    then "Colloid-Dark-Compact-Nord"
    else "Colloid-Dark-Compact";

  colloid-gtk-theme = pkgs.colloid-gtk-theme.override {
    themeVariants = [ "all" ];
    #colorVariants = [ "" ];
    sizeVariants = [ "compact" ];
    tweaks = [ gtkCompileColorSchemeVariant "rimless" "normal" ];
  };

  preferDark = if colorSchemeVariant == "nord-dark"
    then "dark"
    else "light";

  cfg = config.shelf.desktop.addons.gtk;
in {
  options.shelf.desktop.addons.gtk = {
    enable = mkBoolOpt false "Whether to enable gtk theme.";
  };

  config = mkIf cfg.enable {
    shelf.home.packages = with pkgs; [
      adwaita-icon-theme
      inputs.luv-icon-theme.packages.${system}.default
    ];

    services.gnome.gnome-keyring.enable = true;

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
        name = "Noto Sans";
        size = 11;
      };

      gtk3.extraConfig = {
        gtk-application-prefer-dark-theme = 1;
      };

      gtk4.extraConfig = {
        gtk-application-prefer-dark-theme = 1;
      };
    };

    # shelf.home.configFile."gtk-3.0/settings.ini".source = "${defaults.configFolder}/gtk-3.0/settings.ini";
    # shelf.home.configFile."gtk-4.0/settings.ini".source = "${defaults.configFolder}/gtk-4.0/settings.ini";
  };
}
