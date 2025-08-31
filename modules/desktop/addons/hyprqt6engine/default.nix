{
  config,
  pkgs,
  lib,
  defaults,
  ...
}:
with lib;
with lib.shelf; let
  cfg = config.shelf.desktop.addons.hyprqt6engine;
in {
  options.shelf.desktop.addons.hyprqt6engine = with types; {
    enable = mkBoolOpt false "Whether to enable hyprland qt6 theme engine.";
  };

  config = mkIf cfg.enable {    
    shelf.home.packages = with pkgs; [];

    environment.sessionVariables = {
      QT_QPA_PLATFORMTHEME = "hyprqt6engine";
    };

    shelf.home.configFile."hypr/hyprqt6engine.conf".source = "${defaults.configFolder}/hypr/hyprqt6engine.conf";
  };
}
