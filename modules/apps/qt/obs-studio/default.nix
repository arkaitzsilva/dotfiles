{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.shelf; let
  cfg = config.shelf.apps.qt.obs-studio;
in {
  options.shelf.apps.qt.obs-studio = {
    enable = mkBoolOpt false "Whether to enable standalone OBS Studio.";
  };

  config = mkIf cfg.enable {
    shelf.home.packages = with pkgs; [
      obs-studio
    ];
  };
}
