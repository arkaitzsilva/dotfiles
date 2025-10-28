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
      inputs.luv-icon-theme.packages.${pkgs.system}.default
      kdePackages.kdialog
    ];
    
    # shelf.home.extraOptions.systemd.user.services.plasma-xdg-desktop-portal-kde.Service = {
    #   ExecStart = "${pkgs.kdePackages.xdg-desktop-portal-kde}/libexec/xdg-desktop-portal-kde";
    #   BusName = "org.freedesktop.impl.portal.desktop.kde";
    #   Restart = "no";
    #   Environment = [
    #     "QT_QPA_PLATFORMTHEME="
    #   ];
    # };

    shelf.home.extraOptions.xdg.portal = {
      enable = true;

      # Force to load only the desired desktop portals.
      extraPortals = lib.mkForce (with pkgs; [
        xdg-desktop-portal-hyprland
        kdePackages.xdg-desktop-portal-kde
      ]);

      # configPackages = lib.mkForce [];
    };

    shelf.home.configFile."xdg-desktop-portal/xdg-desktop-portal.conf".source = "${defaults.configFolder}/xdg-desktop-portal/xdg-desktop-portal.conf";
    
  };
}
