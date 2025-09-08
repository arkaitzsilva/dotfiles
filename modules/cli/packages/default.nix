{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.shelf; let
  cfg = config.shelf.cli.packages;
in {
  options.shelf.cli.packages = {
    enable = mkBoolOpt false "Whether to enable package apps.";
  };

  config = mkIf cfg.enable {
    shelf.home.packages = with pkgs; [
      neofetch
      htop
      cryfs
      git
      wget
      cmatrix
      tree
      zip
    ];
  };
}
