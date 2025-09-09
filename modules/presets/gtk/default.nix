{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.shelf; let
  cfg = config.shelf.presets.gtk;
in {
  options.shelf.presets.gtk = {
    enable = mkBoolOpt false "Whether to enable the gtk app suite.";
  };

  config = mkIf cfg.enable {
    shelf.home.packages = with pkgs; [];

    shelf.apps.standalone = {
      yazi = enabled;
      helix = enabled;
    };

    shelf.desktop.addons = {
      gtk = enabled;
    };    

    shelf.apps = {
      gtk = {
        packages = enabled;
        gedit = enabled;
        vscode = enabled;      
      };

      browsers = {
        nyxt = enabled;
        brave = enabled;
      };
    };    
  };
}
