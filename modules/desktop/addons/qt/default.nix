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
    environment = {
      systemPackages = with pkgs; [
        #qt6Packages.qtwayland
        qt6Packages.qtstyleplugin-kvantum
        #libsForQt5.kdialog
        #libsForQt5.xdg-desktop-portal-kde
      ];
      sessionVariables = {
        QT_QPA_PLATFORM = "wayland";
        QT_STYLE_OVERRIDE = "kvantum qutebrowser";
        QT_PLUGIN_PATH = "${pkgs.qt6Packages.qtstyleplugin-kvantum}/lib/qt-6/plugins";
      };
    };

    shelf.home.extraOptions.qt = {
      enable = true;
      style = {
        package = pkgs.catppuccin-kvantum;
        name = "kvantum";
      };
    };

    shelf.home.configFile."kdeglobals".text = ''
      [Icons]
      Theme=Luv-Dark
    '';

    shelf.home.configFile."xdg-desktop-portal/hyprland-portals.conf".source = "${defaults.configFolder}/xdg-desktop-portal/hyprland-portals.conf";

    shelf.home.configFile."Kvantum".source = "${defaults.configFolder}/Kvantum";
  };
}
