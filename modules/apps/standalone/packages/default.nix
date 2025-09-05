{
  config,
  pkgs,
  lib,
  shelf,
  ...
}:
with lib;
with lib.shelf; let
  cfg = config.shelf.apps.standalone.packages;
in {
  options.shelf.apps.standalone.packages = {
    enable = mkBoolOpt false "Whether to enable standalone apps.";
  };

  config = mkIf cfg.enable {
    shelf.home.packages = with pkgs; [
      zathura
    ];
  };
}
