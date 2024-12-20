{
  config,
  pkgs,
  lib,
  default,
  ...
}:
with lib;
with lib.shelf; let
  cfg = config.shelf.desktop.addons.dunst;
in {
  options.shelf.desktop.addons.dunst = with types; {
    enable = mkBoolOpt false "Whether to enable dunst.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [];

    shelf.home.services.dunst = {
      enable = true;
    };
    
    shelf.home.configFile."dunst/dunstrc".source = "${default.configFolder}/dunst/dunstrc";      
  };
}
