{
  config,
  pkgs,
  lib,
  defaults,
  ...
}:
with lib;
with lib.shelf; let
  cfg = config.shelf.apps.gtk.antigravity;
in {
  options.shelf.apps.gtk.antigravity = {
    enable = mkBoolOpt false "Whether to enable antigravity.";
  };

  config = mkIf cfg.enable {
    shelf.home.packages = with pkgs; [
      antigravity
    ];
  };
}
