{
  config,
  pkgs,
  lib,
  default,
  ...
}:
with lib;
with lib.shelf; let
  colloid-gtk-theme = pkgs.colloid-gtk-theme.override {
    themeVariants = [ "all" ];
    #colorVariants = [ "" ];
    sizeVariants = [ "compact" ];
    tweaks = [ "catppuccin" "rimless" "normal" ];
  };

  cfg = config.shelf.desktop.addons.gtk;
in {
  options.shelf.desktop.addons.gtk = {
    enable = mkBoolOpt false "Whether to enable gtk theme.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      colloid-gtk-theme
      adwaita-icon-theme
      libdbusmenu-gtk3
    ];

    services.gnome.gnome-keyring.enable = true;

    programs.dconf.enable = true;

    shelf.home.extraOptions.gtk = {
      enable = true;
      theme = with pkgs; {
        name = "Colloid-Purple-Dark-Compact-Catppuccin";
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
        size = 10;
      };
    };

    shelf.home.extraOptions.dconf = {
      enable = true;
      settings = {
        "org/gnome/desktop/interface" = {
          color-scheme = "prefer-dark";
        };
      };
    };
  };
}
