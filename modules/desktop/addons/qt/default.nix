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
    environment.sessionVariables = {
      QT_QPA_PLATFORM = "wayland";
    };

    shelf.home.packages = with pkgs; [
      inputs.luv-icon-theme.packages.${system}.default
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

      # Configure hyprland desktop portal as default and KDE filechooser.
      config.common = {
        default = [ "hyprland" ];
        "org.freedesktop.impl.portal.FileChooser" = [ "kde" ];
      };
    };
      
    shelf.home.extraOptions.qt = {
      enable = true;
      style.name = "kvantum";
      platformTheme.name = "hyprqt6engine";
    };

    shelf.home.configFile."Kvantum".source = "${defaults.configFolder}/Kvantum/color-scheme-variants/${defaults.colorSchemeVariant}";
    shelf.home.configFile."hypr/hyprqt6engine.conf".source = "${defaults.configFolder}/hypr/hyprqt6engine.conf";

    shelf.home.dataFile."color-schemes".source = "${defaults.dataFolder}/color-schemes/color-scheme-variants/${defaults.colorSchemeVariant}";
  };
}
