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
  matugenEnabled = config.shelf.desktop.addons.matugen.enable;
in {
  options.shelf.desktop.addons.foot = with types; {
    enable = mkBoolOpt false "Whether to enable foot.";
  };

  config = mkIf (cfg.enable || config.shelf.system.defaultShell == pkgs.zsh) {
    environment.systemPackages = with pkgs; [];

    shelf.home.programs.foot = {
      enable = true;
    };
    
    shelf.home.configFile."foot/foot.ini".source = if matugenEnabled then
      "${config.programs.matugen.theme.files}/.config/foot/foot.ini"
    else
      "${default.configFolder}/foot/foot.ini";
  };
}
