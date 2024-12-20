{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.shelf; let
  cfg = config.shelf.apps.gtk.basics;
in {
  options.shelf.apps.gtk.basics = {
    enable = mkBoolOpt false "Whether to enable gtk apps.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      vscode
      deluge
      inkscape
      gimp
    ];
  };
}
