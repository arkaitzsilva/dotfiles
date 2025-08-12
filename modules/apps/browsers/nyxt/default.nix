{
  config,
  pkgs,
  lib,
  defaults,
  ...
}:
with lib;
with lib.shelf; let
  cfg = config.shelf.apps.browsers.nyxt;
in {
  options.shelf.apps.browsers.nyxt = {
    enable = mkBoolOpt false "Whether to enable nyxt browser.";
  };

  config = mkIf cfg.enable {
    shelf.home.packages = with pkgs; [
      nyxt
    ];

    # shelf.home.configFile."nyxt/auto-config.3.lisp".source = "${defaults.configFolder}/nyxt/auto-config.3.lisp";
    # shelf.home.configFile."nyxt/stylesheet.lisp".source = "${defaults.configFolder}/nyxt/color-scheme-variants/${defaults.colorSchemeVariant}.lisp";
  };
}
