{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.shelf; let
  cfg = config.shelf.cli.flatpak;
in {
  options.shelf.cli.flatpak = {
    enable = mkBoolOpt false "Whether to enable flatpak.";
  };

  config = mkIf cfg.enable {
    shelf.home.packages = with pkgs; [];

    services.flatpak.enable = true;

    shelf.home.sessionVariables = {
      XDG_DATA_DIRS="$XDG_DATA_DIRS:/usr/share:/var/lib/flatpak/exports/share:$HOME/.local/share/flatpak/exports/share";
    };
  };
}
