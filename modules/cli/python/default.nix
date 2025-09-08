{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.shelf; let
  cfg = config.shelf.cli.python;
in {
  options.shelf.cli.python = {
    enable = mkBoolOpt false "Whether to enable Python dev environment.";
  };

  config = mkIf cfg.enable {
    shelf.home.packages = with pkgs; [
      python3
      uv
      ruff
      ty
    ];
  };
}
