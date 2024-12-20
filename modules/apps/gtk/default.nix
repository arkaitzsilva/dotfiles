{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.shelf; let
  cfg = config.shelf.apps.gtk;
in {
  options.shelf.apps.gtk = {
    enable = mkBoolOpt false "Whether to enable gtk apps.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      gedit
      vscode
      deluge
      inkscape
      gimp
    ];
  };
}
