{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
with lib;
with lib.shelf; let
  cfg = config.shelf.desktop.addons.quickshell;

  quickshellPkg = inputs.quickshell.packages.${pkgs.stdenv.hostPlatform.system}.quickshell;
in {
  options.shelf.desktop.addons.quickshell = with types; {
    enable = mkBoolOpt false "Whether to enable quickshell toolkit.";
  };

  config = mkIf cfg.enable {
    shelf.home.packages = [
      quickshellPkg
    ];
  };
}
