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
    environment.systemPackages = with pkgs; [];

    shelf.home.programs.chromium = {
      enable = true;
      package = pkgs.brave;
      commandLineArgs = [
        "--ozone-platform-hint=wayland"
        "--force-dark-mode"
      ];
    };
  };
}
