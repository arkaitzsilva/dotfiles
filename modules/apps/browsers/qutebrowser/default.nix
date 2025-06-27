{
  config,
  pkgs,
  lib,
  defaults,
  ...
}:
with lib;
with lib.shelf; let
  cfg = config.shelf.apps.browsers.qutebrowser;
in {
  options.shelf.apps.browsers.qutebrowser = {
    enable = mkBoolOpt false "Whether to enable qutebrowser.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      qutebrowser
    ];

    shelf.home.configFile."qutebrowser/config.py".source = "${defaults.configFolder}/qutebrowser/config.py";
  };
}
