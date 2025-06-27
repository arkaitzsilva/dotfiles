{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.shelf; let
  cfg = config.shelf.desktop.addons.sddm;
in {
  options.shelf.desktop.addons.sddm = {
    enable = mkBoolOpt false "Whether to enable SDDM.";
  };

  config = mkIf cfg.enable {
    services.displayManager.sddm = {
      enable = true;
      wayland.enable = true;
    };
  };
}
