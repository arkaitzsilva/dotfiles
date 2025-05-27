{
  config,
  pkgs,
  lib,
  default,
  ...
}:
with lib;
with lib.shelf; let
  cfg = config.shelf.desktop.addons.nyxt;
in {
  options.shelf.desktop.addons.nyxt = {
    enable = mkBoolOpt false "Whether to enable nyxt browser.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      nyxt
    ];

    shelf.home.configFile."nyxt/init.lisp".source = "${default.configFolder}/nyxt/init.lisp";
    shelf.home.configFile."nyxt/stylesheet.lisp".source = "${default.configFolder}/nyxt/stylesheet.lisp";
  };
}
