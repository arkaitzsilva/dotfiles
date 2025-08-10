{
  config,
  pkgs,
  lib,
  defaults,
  ...
}:
with lib;
with lib.shelf; let
  cfg = config.shelf.desktop.addons.astal;
in {
  options.shelf.desktop.addons.qt = {
    enable = mkBoolOpt false "Whether to enable Astal.";
  };

  config = mkIf cfg.enable {
    shelf.home.packages = with pkgs; [];
  };
}
