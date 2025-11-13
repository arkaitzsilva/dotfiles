{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.shelf; let
  cfg = config.shelf.apps.browsers.tor;
in {
  options.shelf.apps.browsers.tor = {
    enable = mkBoolOpt false "Whether to enable tor browser.";
  };

  config = mkIf cfg.enable {
    shelf.home.packages = with pkgs; [
      tor-browser
    ];
  };
}
