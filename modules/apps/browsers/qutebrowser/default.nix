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
    shelf.home.packages = with pkgs; [
      qutebrowser
    ];

    shelf.home.configFile."qutebrowser/theme.py".source = "${defaults.configFolder}/qutebrowser/color-scheme-variants/${defaults.colorSchemeVariant}.py";
    shelf.home.configFile."qutebrowser/config.py".source = "${defaults.configFolder}/qutebrowser/config.py";
  };
}
