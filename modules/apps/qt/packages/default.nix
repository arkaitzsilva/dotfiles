{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.shelf; let
  cfg = config.shelf.apps.qt.packages;
in {
  options.shelf.apps.qt.packages = {
    enable = mkBoolOpt false "Whether to enable qt apps.";
  };

  config = mkIf cfg.enable {
    shelf.home.packages = with pkgs; [
      qbittorrent
    ];
  };
}
