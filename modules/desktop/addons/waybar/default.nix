{
  config,
  pkgs,
  lib,
  default,
  ...
}:
with lib;
with lib.shelf; let
  cfg = config.shelf.desktop.addons.waybar;
in {
  options.shelf.desktop.addons.waybar = {
    enable = mkBoolOpt false "Whether to enable waybar.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      waybar
    ];

    shelf.home.configFile."waybar/config".source = "${default.configFolder}/waybar/config";
    shelf.home.configFile."waybar/style.css".source = "${default.configFolder}/waybar/style.css";
  };
}
