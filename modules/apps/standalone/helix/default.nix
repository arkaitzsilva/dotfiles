{
  config,
  pkgs,
  lib,
  defaults,
  ...
}:
with lib;
with lib.shelf; let
  cfg = config.shelf.apps.standalone.helix;
in {
  options.shelf.apps.standalone.helix = {
    enable = mkBoolOpt false "Whether to enable helix editor.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      helix
      qt6Packages.qtdeclarative # qmlls server included
    ];

    shelf.home.configFile."helix/config.toml".source = "${defaults.configFolder}/helix/config.toml";
    shelf.home.configFile."helix/languages.toml".source = "${defaults.configFolder}/helix/languajes.toml";
  };
}
