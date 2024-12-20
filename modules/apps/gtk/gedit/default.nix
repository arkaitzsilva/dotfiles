{
  config,
  pkgs,
  lib,
  default,
  ...
}:
with lib;
with lib.shelf; let
  cfg = config.shelf.apps.gtk.gedit;
in {
  options.shelf.apps.gtk.gedit = {
    enable = mkBoolOpt false "Whether to enable gedit.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      gedit
    ];

    shelf.home.dataFile."gedit/styles/catppuccin-mocha.xml".source = "${default.dataFolder}/gedit/styles/catppuccin-mocha.xml";
  };
}
