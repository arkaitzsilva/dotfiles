{
  config,
  pkgs,
  lib,
  defaults,
  inputs,
  ...
}:
with lib;
with lib.shelf; let
  cfg = config.shelf.desktop.addons.walker;
in {
  options.shelf.desktop.addons.walker = with types; {
    enable = mkBoolOpt false "Whether to enable walker launcher.";
  };

  # imports = with inputs; [ walker.homeManagerModules.default ];

  config = mkIf cfg.enable {
    shelf.home.packages = with pkgs; [];

    shelf.home.services.walker = {
      enable = true;
      systemd.enable = true;
    };

    shelf.home.configFile."walker/config.toml".source = "${defaults.configFolder}/walker/config.toml";
  };
}
