{
  config,
  pkgs,
  lib,
  defaults,
  ...
}:
with lib;
with lib.shelf; let
  cfg = config.shelf.apps.standalone.ranger;
in {
  options.shelf.apps.standalone.ranger = {
    enable = mkBoolOpt false "Whether to enable ranger file manager.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      w3m
    ];

    shelf.home.programs = {
      ranger = {
        enable = true;
      };
    };

    shelf.home.configFile."ranger/rc.conf".source = "${defaults.configFolder}/ranger/rc.conf";
  };
}
