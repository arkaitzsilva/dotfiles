{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.shelf; let
  cfg = config.shelf.apps.browsers.firefox;
in {
  options.shelf.apps.browsers.firefox = {
    enable = mkBoolOpt false "Whether to enable firefox browser.";
  };

  config = mkIf cfg.enable {
    shelf.home.programs.firefox = {
      enable = true;
      package = pkgs.firefox;
    };
  };
}
