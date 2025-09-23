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
  cfg = config.shelf.desktop.addons.qt;
in {
  options.shelf.desktop.addons.qt = {
    enable = mkBoolOpt false "Whether to enable QT.";
  };

  config = mkIf cfg.enable {
    shelf.home.sessionVariables = {
      QT_QPA_PLATFORM = "wayland";
      QT_DEBUG_PLUGINS = 1;
      QT_PLUGIN_PATH = "${inputs.hyprqt6engine.packages.${pkgs.system}.default}/lib/qt-6";
    };

    shelf.home.packages = with pkgs; [
      inputs.luv-icon-theme.packages.${pkgs.system}.default
      qt6Packages.qtwayland
      kdePackages.kdialog
    ];
    
    shelf.home.extraOptions.systemd.user.services.plasma-xdg-desktop-portal-kde.Service = {
      ExecStart = "${pkgs.kdePackages.xdg-desktop-portal-kde}/libexec/xdg-desktop-portal-kde";
      BusName = "org.freedesktop.impl.portal.desktop.kde";
      Restart = "no";
      Environment = [
        "QT_QPA_PLATFORMTHEME="
      ];
    };

    shelf.home.extraOptions.xdg.portal = {
      enable = true;

      # Force to load only the desired desktop portals.
      extraPortals = lib.mkForce (with pkgs; [
        xdg-desktop-portal-hyprland
        kdePackages.xdg-desktop-portal-kde
      ]);

      configPackages = lib.mkForce [];

      # Configure hyprland desktop portal as default with KDE file chooser.
      config.common = {
        default = [ "hyprland" ];
        "org.freedesktop.impl.portal.FileChooser" = [ "kde" ];
      };
    };
      
    shelf.home.extraOptions.qt = {
      enable = true;
      style.name = "kvantum";
      platformTheme = {
        name = "hyprqt6engine";
        package = inputs.hyprqt6engine.packages.${pkgs.system}.default;
      };
    };

    shelf.home.configFile."Kvantum".source = "${defaults.configFolder}/Kvantum/color-scheme-variants/${defaults.colorSchemeVariant}";
    shelf.home.configFile."hypr/hyprqt6engine.conf".source = "${defaults.configFolder}/hypr/hyprqt6engine.conf";
    
    shelf.home.dataFile."color-schemes".source = "${defaults.dataFolder}/color-schemes/color-scheme-variants/${defaults.colorSchemeVariant}";
  };
}
