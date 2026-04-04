{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.shelf; let
  cfg = config.shelf.desktop.addons.quickshell;
in {
  options.shelf.desktop.addons.quickshell = with types; {
    enable = mkBoolOpt false "Whether to enable quickshell toolkit.";
  };

  config = mkIf cfg.enable {
    shelf.home.packages = with pkgs; [
      quickshell
    ];
  };
}
