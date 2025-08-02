{
  config,
  pkgs,
  lib,
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
    environment.systemPackages = with pkgs; [ ];
  };
}
