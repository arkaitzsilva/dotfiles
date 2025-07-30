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
  cfg = config.shelf.desktop.addons.quickshell;
in {
  options.shelf.desktop.addons.quickshell = with types; {
    enable = mkBoolOpt false "Whether to enable quickshell.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; with inputs; [
      quickshell.packages.${pkgs.system}.default
    ];

    #shelf.home.configFile."quickshell".source = "${defaults.configFolder}/quickshell";
  };
}
