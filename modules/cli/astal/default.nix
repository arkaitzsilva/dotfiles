{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
with lib;
with lib.shelf; let
  cfg = config.shelf.cli.astal;
in {
  options.shelf.cli.astal = {
    enable = mkBoolOpt false "Whether to enable astal.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      inputs.astal.packages.${system}.default
    ];
  };
}
