{
  config,
  pkgs,
  lib,
  inputs,
  defaults,
  ...
}:
with lib; with lib.shelf; let
  cfg = config.shelf.desktop.addons.xdg-desktop-portal;
  
  xdphPkg = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
in {
  options.shelf.desktop.addons.xdg-desktop-portal = {
    enable = mkBoolOpt false "Whether to enable xdg-desktop-portal.";
  };

  config = mkIf cfg.enable {
    xdg.portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdphPkg
        xdg-desktop-portal-luminous
        lxqt.xdg-desktop-portal-lxqt
      ];

      config.hyprland = {
        default = [
          "hyprland"
          "liminous"
        ];
        "org.freedesktop.impl.portal.FileChooser" = [ "lxqt" ];
      };
    };

    systemd.user.services."xdg-desktop-portal-lxqt".serviceConfig = {
      Environment = ''
        QT_QPA_PLATFORMTHEME=${defaults.qtPlatformTheme}
      '';
    };

    shelf.home.configFile."xdg-desktop-portal-luminous/config.toml".source = "${defaults.configFolder}/xdg-desktop-portal-luminous/color-scheme-variants/${defaults.colorSchemeVariant}.toml";
  };
}
