{
  config,
  pkgs,
  lib,
  defaults,
  ...
}:
with lib;
with lib.shelf; let
  cfg = config.shelf.desktop.addons.qt;
in {
  options.shelf.desktop.addons.qt = {
    enable = mkBoolOpt false "Whether to enable QT.";
  };

  config = mkIf cfg.enable {
    environment = {
      systemPackages = with pkgs; [
        libsForQt5.qtstyleplugin-kvantum
        kdePackages.qtstyleplugin-kvantum
      ];
      variables = {
        QT_QPA_PLATFORM = "wayland";
        QT_STYLE_OVERRIDE = "kvantum";
      };
    };

    shelf.home.extraOptions.qt = {
      enable = true;
      style = {
        package = pkgs.catppuccin-kvantum;
        name = "kvantum";
      };
    };

    shelf.home.configFile."kdeglobals".text = ''
      [Icons]
      Theme=Luv-Dark
    '';

    shelf.home.configFile."Kvantum".source = "${defaults.configFolder}/Kvantum";
  };
}