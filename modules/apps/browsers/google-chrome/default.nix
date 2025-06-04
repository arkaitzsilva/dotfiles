{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.shelf; let
  cfg = config.shelf.apps.browsers.google-chrome;
in {
  options.shelf.apps.browsers.google-chrome = {
    enable = mkBoolOpt false "Whether to enable google-chrome browser.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      google-chrome
    ];
  };
}
