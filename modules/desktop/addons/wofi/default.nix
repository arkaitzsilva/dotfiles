{
  config,
  pkgs,
  lib,
  default,
  ...
}:
with lib;
with lib.shelf; let
  cfg = config.shelf.desktop.addons.wofi;
in {
  options.shelf.desktop.addons.wofi = {
    enable = mkBoolOpt false "Whether to enable wofi.";
  };

  config = mkIf cfg.enable {
    shelf.home.configFile."wofi/style.css".source = "${default.configFolder}/wofi/style.css";
    
    shelf.home.programs.wofi = {
      enable = true;
    
      settings = {
        width = 500;
        height = 400;
        location = "center";
        show = "drun";
        prompt = "Buscar...";
        filter_rate = 100;
        allow_markup = true;
        no_actions = true;
        halign = "fill";
        orientation = "vertical";
        content_halign = "fill";
        insensitive = true;
        allow_images = true;
        image_size = 32;
        gtk_dark = true;
      };      
    };
  };
}
