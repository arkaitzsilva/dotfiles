{
  config,
  pkgs,
  lib,
  default,
  ...
}:
with lib;
with lib.shelf; let
  cfg = config.shelf.desktop.addons.foot;
in {
  options.shelf.desktop.addons.foot = with types; {
    enable = mkBoolOpt false "Whether to enable foot.";
  };

  config = mkIf (cfg.enable || config.shelf.system.defaultShell == pkgs.zsh) {
    environment.systemPackages = with pkgs; [];

    shelf.home.programs.foot = {
      enable = true;
    };
    
    shelf.home.configFile."foot/foot.ini".source = "${default.configFolder}/foot/foot.ini";
    shelf.home.configFile."foot/colors".source = "${default.configFolder}/foot/color-scheme-variants/${default.colorSchemeVariant}";
  };
}
