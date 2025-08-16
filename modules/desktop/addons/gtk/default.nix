{
  config,
  pkgs,
  lib,
  defaults,
  ...
}:
with lib;
with lib.shelf; let
  colloid-gtk-theme = pkgs.colloid-gtk-theme.override {
    themeVariants = [ "all" ];
    #colorVariants = [ "" ];
    sizeVariants = [ "compact" ];
    tweaks = [ "nord" "rimless" "normal" ];
  };

  cfg = config.shelf.desktop.addons.gtk;
in {
  options.shelf.desktop.addons.gtk = {
    enable = mkBoolOpt false "Whether to enable gtk theme.";
  };

  config = mkIf cfg.enable {
    shelf.home.packages = with pkgs; [
      colloid-gtk-theme
      adwaita-icon-theme
    ];

    services.gnome.gnome-keyring.enable = true;

    programs.dconf.enable = true;

    shelf.home.extraOptions.dconf = {
      enable = true;
      settings = {
        "org/gnome/desktop/interface" = {
          color-scheme = "prefer-dark";
        };
      };
    };

    shelf.home.extraOptions.gtk = {
      enable = true;
      theme = {
        name = "Colloid-Dark-Compact-Nord";
        package = colloid-gtk-theme;
      };

      iconTheme = {
        name = "Luv-Dark";
      };

      cursorTheme = {
        name = "nx-snow";
        size = 24;
      };

      font = {
        name = "Noto Sans";
        size = 10;
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
