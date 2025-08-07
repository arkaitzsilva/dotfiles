{
  config,
  pkgs,
  lib,
  defaults,
  ...
}:
with lib;
with lib.shelf; let
  cfg = config.shelf.apps.standalone.foot;
in {
  options.shelf.apps.standalone.foot = with types; {
    enable = mkBoolOpt false "Whether to enable foot.";
  };

  config = mkIf (cfg.enable || config.shelf.system.defaultShell == pkgs.zsh) {
    shelf.home.programs.foot = {
      enable = true;
    };
    
    shelf.home.configFile."foot/foot.ini".source = "${defaults.configFolder}/foot/foot.ini";
    shelf.home.configFile."foot/theme".source = "${defaults.configFolder}/foot/color-scheme-variants/${defaults.colorSchemeVariant}";
  };
}
