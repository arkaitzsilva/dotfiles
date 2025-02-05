{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.shelf; let
  cfg = config.shelf.desktop.addons.nautilus;
in {
  options.shelf.desktop.addons.nautilus = {
    enable = mkBoolOpt false "Whether to enable nautilus.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      nautilus
    ];

    services = {
      gvfs.enable = true;
      tumbler.enable = true;
    };
  };
}
