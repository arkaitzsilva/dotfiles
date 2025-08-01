{
  config,
  pkgs,
  lib,
  defaults,
  ...
}:
with lib;
with lib.shelf; let
  cfg = config.shelf.apps.standalone.yazi;
in {
  options.shelf.apps.standalone.yazi = {
    enable = mkBoolOpt false "Whether to enable yazi filemanager.";
  };

  config = mkIf cfg.enable {
    environment = {
      sessionVariables = {
        YAZI_CONFIG_HOME = "$HOME/.config/yazi";
      };
      
      systemPackages = with pkgs; [];    
    };

    programs.yazi = {
      enable = true;
      plugins = { };
    };

    shelf.home.configFile."yazi/yazi.toml".source = "${defaults.configFolder}/yazi/yazi.toml";
  };
}
