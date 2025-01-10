{
  config,
  pkgs,
  lib,
  default,
  inputs,
  ...
}:
with lib;
with lib.shelf; let
  cfg = config.shelf.desktop.addons.hypridle;
in {
  options.shelf.desktop.addons.hypridle = with types; {
    enable = mkBoolOpt false "Whether to enable hypridle.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      hypridle
    ];

    shelf.home.configFile."hypr/hypridle.conf".source = "${default.configFolder}/hypr/hypridle.conf";
  };
}
