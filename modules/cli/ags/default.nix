{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
with lib;
with lib.shelf; let
  cfg = config.shelf.cli.ags;
in {
  options.shelf.cli.ags = {
    enable = mkBoolOpt false "Whether to enable ags.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      inputs.ags.packages.${system}.agsFull
      gettext
    ];
  };
}
