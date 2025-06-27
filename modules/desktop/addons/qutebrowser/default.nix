{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.shelf; let
  cfg = config.shelf.desktop.addons.qutebrowser;
in {
  options.shelf.desktop.addons.qutebrowser = {
    enable = mkBoolOpt false "Whether to enable qutebrowser.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      qutebrowser
    ];
  };
}
