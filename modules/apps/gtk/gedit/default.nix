{
  config,
  pkgs,
  lib,
  defaults,
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
    shelf.home.packages = with pkgs; [
      gedit
      libgedit-gtksourceview
    ];

    shelf.home.dataFile."libgedit-gtksourceview-300/styles/theme.xml".source = "${defaults.dataFolder}/libgedit-gtksourceview-300/styles/${defaults.colorSchemeVariant}.xml";
  };
}
