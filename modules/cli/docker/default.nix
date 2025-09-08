{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.shelf; let
  cfg = config.shelf.cli.docker;
in {
  options.shelf.cli.docker = {
    enable = mkBoolOpt false "Whether to enable docker.";
  };

  config = mkIf cfg.enable {
    virtualisation.docker.enable = true;
  };
}
