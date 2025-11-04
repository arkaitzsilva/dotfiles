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
  cfg = config.shelf.desktop.addons.hyprqt6engine;
in {
  options.shelf.desktop.addons.hyprqt6engine = {
    enable = mkBoolOpt false "Whether to enable hyprqt6engine.";
  };

  config = mkIf cfg.enable {
    shelf.home.sessionVariables = {
      QT_QPA_PLATFORM = "wayland";
      # QT_DEBUG_PLUGINS = 1;
      QT_PLUGIN_PATH = "${inputs.hyprqt6engine.packages.${pkgs.stdenv.hostPlatform.system}.default}/lib/qt-6";
    };

    shelf.home.packages = with pkgs; [
      qt6Packages.qtwayland
      inputs.luv-icon-theme.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];
     
    shelf.home.extraOptions.qt = {
      enable = true;
      style.name = "kvantum";
      platformTheme = {
        name = "hyprqt6engine";
        package = inputs.hyprqt6engine.packages.${pkgs.stdenv.hostPlatform.system}.default;
      };
    };

    shelf.home.configFile."Kvantum".source = "${defaults.configFolder}/Kvantum/color-scheme-variants/${defaults.colorSchemeVariant}";
    shelf.home.configFile."hypr/hyprqt6engine.conf".source = "${defaults.configFolder}/hypr/hyprqt6engine.conf";
    
    # shelf.home.dataFile."color-schemes".source = "${defaults.dataFolder}/color-schemes/color-scheme-variants/${defaults.colorSchemeVariant}";
  };
}
