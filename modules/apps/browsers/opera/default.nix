{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.shelf; let
  cfg = config.shelf.apps.browsers.opera;
in {
  options.shelf.apps.browsers.opera = {
    enable = mkBoolOpt false "Whether to enable opera browser.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      opera
    ];
  };
}
