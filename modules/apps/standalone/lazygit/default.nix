{
  config,
  pkgs,
  lib,
  defaults,
  ...
}:
with lib;
with lib.shelf; let
  cfg = config.shelf.apps.standalone.lazygit;
in {
  options.shelf.apps.standalone.lazygit = {
    enable = mkBoolOpt false "Whether to enable lazygit.";
  };

  config = mkIf cfg.enable {
    shelf.home.sessionVariables = {
      LG_CONFIG_FILE = "$HOME/.config/lazygit/config.yml,$HOME/.config/lazygit/theme.yml";
    };

    shelf.home.programs.lazygit = {
      enable = true;
    };

    shelf.home.configFile."lazygit/config.yml".source = "${defaults.configFolder}/lazygit/config.yml";
    shelf.home.configFile."lazygit/theme.yml".source = "${defaults.configFolder}/lazygit/color-scheme-variants/${defaults.colorSchemeVariant}.yml";
  };
}
