{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.shelf; let
  cfg = config.shelf.apps.standalone;
in {
  options.shelf.apps.standalone = {
    enable = mkBoolOpt false "Whether to enable window manager apps.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      viewnior
      zathura
      mpv
    ];
  };
}
