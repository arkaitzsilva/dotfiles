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
  cfg = config.shelf.desktop.addons.swww;
in {
  options.shelf.desktop.addons.swww = with types; {
    enable = mkBoolOpt false "Whether to enable swww.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; with inputs; [
      swww.packages.${pkgs.system}.default
    ];

    shelf.home.dataFile."wallpapers".source = "${defaults.dataFolder}/wallpapers/${defaults.wallpaperResolution}";
  };
}
