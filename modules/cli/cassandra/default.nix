{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.shelf; let
  cfg = config.shelf.cli.cassandra;
in {
  options.shelf.cli.cassandra = {
    enable = mkBoolOpt false "Whether to enable apache cassandra nosql database.";
  };

  config = mkIf cfg.enable {
    services.cassandra = {
      enable = true;
    };
  };
}
