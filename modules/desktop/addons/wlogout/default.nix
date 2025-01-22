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
  cfg = config.shelf.desktop.addons.wlogout;
in {
  options.shelf.desktop.addons.wlogout = with types; {
    enable = mkBoolOpt false "Whether to enable wlogout.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      wlogout
    ];

    shelf.home.configFile."wlogout/layout".source = "${default.configFolder}/wlogout/layout";
    shelf.home.configFile."wlogout/style.css".source = "${default.configFolder}/wlogout/style.css";
    shelf.home.configFile."wlogout/icons".source = "${default.configFolder}/wlogout/icons";
  };
}
