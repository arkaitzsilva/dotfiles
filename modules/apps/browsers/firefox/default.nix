{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.shelf; let
  cfg = config.shelf.browsers.firefox;
in {
  options.shelf.browsers.firefox = with types; {
    enable = mkBoolOpt false "Whether to enable firefox.";
    extensions = mkOption {
      type = nullOr (listOf package);
      description = ''
        make a description later
      '';
    };

    shelf.home.extraOptions.programs.firefox = {
      enable = true;
    };
  };
}