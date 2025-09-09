{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.shelf; let
  cfg = config.shelf.apps.gtk.packages;
in {
  options.shelf.apps.gtk.packages = {
    enable = mkBoolOpt false "Whether to enable gtk apps.";
  };

  config = mkIf cfg.enable {
    shelf.home.packages = with pkgs; [
      deluge
      # inkscape
      # gimp
    ];
  };
}
