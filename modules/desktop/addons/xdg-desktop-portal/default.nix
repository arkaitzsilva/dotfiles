{
  config,
  pkgs,
  lib,
  defaults,
  ...
}:
with lib; with lib.shelf; let
  cfg = config.shelf.desktop.addons.xdg-desktop-portal;
in {
  options.shelf.desktop.addons.xdg-desktop-portal = {
    enable = mkBoolOpt false "Whether to enable xdg-desktop-portal.";
  };

  config = mkIf cfg.enable {
    xdg.portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-luminous
        xdg-desktop-portal-termfilechooser
      ];

      config.niri = {
        default = [ "luminous" ];
        "org.freedesktop.impl.portal.FileChooser" = [ "termfilechooser" ];
      };
    };

    shelf.home.configFile."xdg-desktop-portal-termfilechooser/config" = {
      force = true;
      text = ''
        [filechooser]
        cmd=${pkgs.xdg-desktop-portal-termfilechooser}/share/xdg-desktop-portal-termfilechooser/yazi-wrapper.sh
        default_dir=$XDG_DOWNLOAD_DIR
        env=TERMCMD='foot --app-id xdg-desktop-portal-termfilechooser --title "Terminal File Chooser"'
        open_mode = suggested
        save_mode = last
      '';
    };

    shelf.home.configFile."xdg-desktop-portal-luminous/config.toml".source = "${defaults.configFolder}/xdg-desktop-portal-luminous/color-scheme-variants/${defaults.colorSchemeVariant}.toml";
  };
}
