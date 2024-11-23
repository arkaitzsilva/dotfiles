{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.shelf; let
  cfg = config.shelf.cli.utils;
in {
  options.shelf.cli.utils = {
    enable = mkBoolOpt false "Whether to enable util apps.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      neofetch
      htop
      gifsicle
      cryfs
    ];
  };
}
