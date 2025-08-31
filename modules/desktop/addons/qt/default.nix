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

    environment.systemPackages = with pkgs; [
      kdePackages.xdg-desktop-portal-kde
    ];

    shelf.home.packages = with pkgs; [
      inputs.luv-icon-theme.packages.${system}.default

      qt6Packages.qtwayland

      kdePackages.kdialog
      # kdePackages.xdg-desktop-portal-kde
    ];

    shelf.home.extraOptions.qt = {
      enable = true;
      style.name = "kvantum";
      platformTheme.name = "hyprqt6engine";
    };

    shelf.home.configFile."xdg-desktop-portal/hyprland-portals.conf".source = "${defaults.configFolder}/xdg-desktop-portal/hyprland-portals.conf";
    shelf.home.configFile."Kvantum".source = "${defaults.configFolder}/Kvantum/color-scheme-variants/${defaults.colorSchemeVariant}";
    shelf.home.configFile."hypr/hyprqt6engine.conf".source = "${defaults.configFolder}/hypr/hyprqt6engine.conf";
    shelf.home.dataFile."color-schemes".source = "${defaults.dataFolder}/color-schemes/color-scheme-variants/${defaults.colorSchemeVariant}";
  };
}
