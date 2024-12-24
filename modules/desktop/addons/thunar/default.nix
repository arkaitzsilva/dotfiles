{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.shelf; let
  cfg = config.shelf.desktop.addons.thunar;
in {
  options.shelf.desktop.addons.thunar = {
    enable = mkBoolOpt false "Whether to enable thunar.";
  };

  config = mkIf cfg.enable {
    services = {
      tumbler.enable = true;
    };

    programs.thunar.enable = true;
    programs.thunar.plugins = with pkgs.xfce; [
      thunar-archive-plugin
      thunar-volman
    ];
  };
}
