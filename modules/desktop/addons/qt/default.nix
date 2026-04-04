{
  config,
  pkgs,
  lib,
  defaults,
  inputs,
  ...
}:
with lib;
with lib.shelf; let
  cfg = config.shelf.desktop.addons.qt;

  hyprqt6enginePkg = inputs.hyprqt6engine.packages.${pkgs.stdenv.hostPlatform.system}.hyprqt6engine;
in {
  options.shelf.desktop.addons.qt = with types; {
    enable = mkBoolOpt false "Whether to enable hyprqt6engine qt platform theme & style.";
  };

  config = mkIf cfg.enable {
    shelf.home.sessionVariables = {
      QT_QPA_PLATFORM = "wayland";
      QT_PLUGIN_PATH = "${hyprqt6enginePkg}/lib/qt-6";
    };

    shelf.home.extraOptions.qt = {
      enable = true;
      style.name = "kvantum";
      platformTheme = {
        name = "hyprqt6engine";
        package = hyprqt6enginePkg;
      };
    };

    shelf.home.configFile."hypr/hyprqt6engine.conf".source = "${defaults.configFolder}/hypr/hyprqt6engine.conf";
  };
}
