{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.shelf; let
  cfg = config.shelf.apps.browsers.brave;
in {
  options.shelf.apps.browsers.brave = {
    enable = mkBoolOpt false "Whether to enable brave browser.";
  };

  config = mkIf cfg.enable {
    shelf.home.programs.chromium = {
      enable = true;
      package = pkgs.brave;
      commandLineArgs = [
        "--enable-features=UseOzonePlatform"
        "--ozone-platform=wayland"
        "--force-dark-mode"
        "--password-store=basic"
      ];
    };
  };
}
