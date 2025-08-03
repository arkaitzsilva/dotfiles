{
  config,
  pkgs,
  lib,
  defaults,
  ...
}:
with lib;
with lib.shelf; let
  cfg = config.shelf.apps.standalone.yazi;
in {
  options.shelf.apps.standalone.yazi = {
    enable = mkBoolOpt false "Whether to enable yazi file manager.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ ];

    shelf.home.programs.yazi = {
      enable = true;
    };

    shelf.home.configFile."yazi/yazi.toml".source = "${defaults.configFolder}/yazi/yazi.toml";
    shelf.home.configFile."yazi/theme.toml".source = "${defaults.configFolder}/yazi/color-scheme-variants/${defaults.colorSchemeVariant}.toml";
  };
}
