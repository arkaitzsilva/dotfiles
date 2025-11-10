{
  config,
  pkgs,
  lib,
  defaults,
  ...
}:
with lib;
with lib.shelf; let
  cfg = config.shelf.desktop.addons.swww;
in {
  options.shelf.desktop.addons.swww = with types; {
    enable = mkBoolOpt false "Whether to enable swww.";
  };

  config = mkIf cfg.enable {
    shelf.home.packages = with pkgs; [
      swww
    ];

    shelf.home.dataFile."backgrounds".source = "${defaults.dataFolder}/backgrounds/${defaults.wallpaperResolution}";
  };
}
