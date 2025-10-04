{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.shelf; let
  cfg = config.shelf.presets.qt;
in {
  options.shelf.presets.qt = {
    enable = mkBoolOpt false "Whether to enable the qt app suite.";
  };

  config = mkIf cfg.enable {
    shelf.desktop.addons = {
      kde = enabled;
      quickshell = enabled;
    };    

    shelf.apps = {
      qt = {
        packages = enabled;
        obs-studio = enabled;
      };

      browsers = {
        qutebrowser = enabled;
        brave = enabled;
      };
    };    
  };
}
