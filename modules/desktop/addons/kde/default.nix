{
  config,
  pkgs,
  lib,
  inputs,
  defaults,
  ...
}:
with lib;
with lib.shelf; let
  cfg = config.shelf.desktop.addons.kde;
in {
  options.shelf.desktop.addons.kde = {
    enable = mkBoolOpt false "Whether to enable KDE integration.";
  };

  config = mkIf cfg.enable {
    shelf.home.sessionVariables = {};
    
    shelf.home.packages = with pkgs; [
      kdePackages.kdialog
    ];
    
    xdg.portal = {
      enable = true;

      extraPortals = lib.mkForce (with pkgs; [
        xdg-desktop-portal-hyprland
        kdePackages.xdg-desktop-portal-kde
      ]);

      configPackages = lib.mkForce [];
      config.common = {
        default = [ "hyprland" ];
        "org.freedesktop.impl.portal.FileChooser" = [ "kde" ];
      };
    };
  };
}
