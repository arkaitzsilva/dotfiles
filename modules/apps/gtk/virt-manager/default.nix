{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.shelf; let
  cfg = config.shelf.apps.gtk.virt-manager;
in {
  options.shelf.apps.gtk.virt-manager = {
    enable = mkBoolOpt false "Whether to enable virt-manager.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [];

    programs.virt-manager.enable = true;

    virtualisation.libvirtd.enable = true;
  };
}
