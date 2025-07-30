{
  config,
  pkgs,
  lib,
  defaults,
  inputs,
  ...
}:
with lib;
with lib.shelf; let
  cfg = config.shelf.desktop.addons.theme;
in {
  options.shelf.desktop.addons.theme = with types; {
    enable = mkBoolOpt false "Whether to enable theme settings.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ ];

    shelf.home.dataFile."icons/nx-snow".source = "${defaults.dataFolder}/icons/nx-snow";
  };
}
