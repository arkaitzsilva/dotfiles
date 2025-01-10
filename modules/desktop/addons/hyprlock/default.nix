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
  cfg = config.shelf.desktop.addons.hyprlock;
in {
  options.shelf.desktop.addons.hyprlock = with types; {
    enable = mkBoolOpt false "Whether to enable hyprlock.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      hyprlock
    ];

    shelf.home.configFile."hypr/hyprlock.conf".source = "${default.configFolder}/hypr/hyprlock.conf";
  };
}
