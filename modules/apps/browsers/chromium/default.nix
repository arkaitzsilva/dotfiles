{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.shelf; let
  cfg = config.shelf.apps.browsers.chromium;
in {
  options.shelf.apps.browsers.chromium = {
    enable = mkBoolOpt false "Whether to enable chromium browser.";
  };

  config = mkIf cfg.enable {
    shelf.home.programs.chromium = {
      enable = true;
      package = pkgs.ungoogled-chromium;
      commandLineArgs = [
        "--enable-features=UseOzonePlatform"
        "--ozone-platform=wayland"
        "--force-dark-mode"
        "--password-store=basic"
      ];
    };
  };
}
