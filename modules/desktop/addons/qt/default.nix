{
  config,
  pkgs,
  lib,
  defaults,
  ...
}:
with lib;
with lib.shelf; let
  cfg = config.shelf.desktop.addons.qt;
in {
  options.shelf.desktop.addons.qt = {
    enable = mkBoolOpt false "Whether to enable QT.";
  };

  config = mkIf cfg.enable {
    environment.sessionVariables = {
      QT_QPA_PLATFORM = "wayland";
      QT_STYLE_OVERRIDE = "kvantum";
      QT_PLUGIN_PATH = "${pkgs.qt6Packages.qtstyleplugin-kvantum}/lib/qt-6/plugins";
    };

    shelf.home.packages = with pkgs; [
      qt6Packages.qtstyleplugin-kvantum
      # qt6Packages.qttranslations
    ];

    shelf.home.extraOptions.qt = {
      enable = true;
      style = {
        package = pkgs.catppuccin-kvantum;
        name = "kvantum";
      };
    };

    shelf.home.configFile."xdg-desktop-portal/hyprland-portals.conf".source = "${defaults.configFolder}/xdg-desktop-portal/hyprland-portals.conf";
    shelf.home.configFile."Kvantum".source = "${defaults.configFolder}/Kvantum";
  };
}
