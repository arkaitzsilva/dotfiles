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
    environment.systemPackages = with pkgs; [ ];

    programs.yazi = {
      enable = true;
      plugins = {
        
      };
    };

    # shelf.home.configFile."yazi/yazi...".source = "${defaults.configFolder}/yazi/..."";
  };
}
