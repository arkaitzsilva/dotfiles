{
  config,
  pkgs,
  lib,
  shelf,
  defaults,
  ...
}:
with lib;
with lib.shelf; let
  cfg = config.shelf.apps.standalone.zellij;
  zshEnabled = config.shelf.cli.zsh.enable || config.shelf.system.defaultShell == pkgs.zsh;
in {
  options.shelf.apps.standalone.zellij = {
    enable = mkBoolOpt false "Whether to enable zellij.";
  };

  config = mkIf cfg.enable {
    shelf.home.programs.zellij = {
      enable = true;
      # enableZshIntegration = zshEnabled;
    };

    shelf.home.configFile."zellij/config.kdl".source = "${defaults.configFolder}/zellij/config.kdl";
    shelf.home.configFile."zellij/themes/theme.kdl".source = "${defaults.configFolder}/zellij/color-scheme-variants/${defaults.colorSchemeVariant}.kdl";
  };
}
