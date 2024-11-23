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
    themeVariants = [ "teal" ];
    #colorVariants = [ "" ];
    sizeVariants = [ "compact" ];
    tweaks = [ "rimless" "normal" ];
  };

  cfg = config.shelf.desktop.addons.gtk;

  schema = pkgs.gsettings-desktop-schemas;
  datadir = "${schema}/share/gsettings-schemas/${schema.name}";

  reload-theme = pkgs.writeShellScriptBin "reload-theme" ''
    export XDG_DATA_DIRS=${datadir}:$XDG_DATA_DIRS

    gsettings set org.gnome.desktop.interface gtk-theme ""
    sleep 0.1
    gsettings set org.gnome.desktop.interface gtk-theme colloid-gtk-theme
  '';
in {
  options.shelf.desktop.addons.gtk = {
    enable = mkBoolOpt false "Whether to enable gtk theme.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      colloid-gtk-theme
      adwaita-icon-theme
    ];

    services.gnome.gnome-keyring.enable = true;

    programs.dconf.enable = true;

    shelf.home.extraOptions.gtk = {
      enable = true;
      theme = with pkgs; {
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
        name = "Noto Sans";
        size = 10;
      };
    };

  };
}
