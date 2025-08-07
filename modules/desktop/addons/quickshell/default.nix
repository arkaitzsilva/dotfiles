{
  config,
  pkgs,
  lib,
  defaults,
  ...
}:
with lib;
with lib.shelf; let
  cfg = config.shelf.desktop.addons.quickshell;
in {
  options.shelf.desktop.addons.quickshell = with types; {
    enable = mkBoolOpt false "Whether to enable quickshell.";
  };

  config = mkIf cfg.enable {
    services.upower = enabled;
    
    shelf.home.packages = with pkgs; [
      quickshell
    ];
    
    #shelf.home.configFile."quickshell".source = "${defaults.configFolder}/quickshell";
  };
}
