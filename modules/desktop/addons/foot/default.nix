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
    shelf.home.configFile."foot/catppuccin-mocha".source = "${default.configFolder}/foot/catppuccin-mocha";
    shelf.home.configFile."foot/catppuccin-macchiato".source = "${default.configFolder}/foot/catppuccin-macchiato";
    shelf.home.configFile."foot/catppuccin-frappe".source = "${default.configFolder}/foot/catppuccin-frappe";
    shelf.home.configFile."foot/catppuccin-latte".source = "${default.configFolder}/foot/catppuccin-latte";
  };
}
