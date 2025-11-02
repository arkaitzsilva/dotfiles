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
  cfg = config.shelf.desktop.addons.qt6ct;
in {
  options.shelf.desktop.addons.qt6ct = {
    enable = mkBoolOpt false "Whether to enable qt6ct.";
  };

  config = mkIf cfg.enable {
    shelf.home.sessionVariables = {
      QT_QPA_PLATFORM = "wayland";
      # QT_DEBUG_PLUGINS = 1;
    };

    shelf.home.packages = with pkgs; [
      qt6Packages.qtwayland
    ];
     
    shelf.home.extraOptions.qt = {
      enable = true;
      style.name = "kvantum";
      platformTheme.name = "qtct";
    };

    shelf.home.configFile."Kvantum".source = "${defaults.configFolder}/Kvantum/color-scheme-variants/${defaults.colorSchemeVariant}";
    # shelf.home.configFile."hypr/hyprqt6engine.conf".source = "${defaults.configFolder}/hypr/hyprqt6engine.conf";
    
    # shelf.home.dataFile."color-schemes".source = "${defaults.dataFolder}/color-schemes/color-scheme-variants/${defaults.colorSchemeVariant}";
  };
}
