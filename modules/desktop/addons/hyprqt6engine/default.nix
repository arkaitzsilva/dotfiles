{
  config,
  pkgs,
  lib,
  defaults,
  inputs,
  ...
}:
with lib;
with lib.shelf; let
  cfg = config.shelf.desktop.addons.hyprqt6engine;

  colorSchemeVariant = defaults.colorSchemeVariant;

  hyprqt6enginePkg = inputs.hyprqt6engine.packages.${pkgs.stdenv.hostPlatform.system}.hyprqt6engine;

  kvTheme = if colorSchemeVariant == "nord-dark" then "KvNxNordDark" else "";
in {
  options.shelf.desktop.addons.hyprqt6engine = with types; {
    enable = mkBoolOpt false "Whether to enable hyprqt6engine platform theme.";
  };

  config = mkIf cfg.enable {
    shelf.home.sessionVariables = {
      QT_QPA_PLATFORM = "wayland";
      QT_PLUGIN_PATH = "${hyprqt6enginePkg}/lib/qt-6";
    };

    shelf.home.packages = [
      inputs.kvantum-themes.packages.${pkgs.stdenv.hostPlatform.system}.kvantum-theme-nx-nord.KvNxNordDark
    ];

    shelf.home.extraOptions.qt = {
      enable = true;
      style.name = "${defaults.qtStyle}";
      platformTheme = {
        name = "${defaults.qtPlatformTheme}";
        package = hyprqt6enginePkg;
      };
    };

    shelf.home.configFile."Kvantum/kvantum.kvconfig".text = ''
      [General]
      theme=${kvTheme}
    '';

    shelf.home.configFile."hypr/hyprqt6engine.conf".source = "${defaults.configFolder}/hypr/hyprqt6engine.conf";
  };
}
