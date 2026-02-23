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
  cfg = config.shelf.desktop.addons.kvantum;

  colorSchemeVariant = defaults.colorSchemeVariant;

  kvThemeName = if colorSchemeVariant == "nord-dark" then "KvNxNordDark" else "Kvantum";
  kvThemePkg = inputs.kvantum-themes.packages.${pkgs.stdenv.hostPlatform.system}.kvantum-theme-nx-nord.KvNxNordDark;
in {
  options.shelf.desktop.addons.kvantum = with types; {
    enable = mkBoolOpt false "Whether to enable kvantum qt style.";
  };

  config = mkIf cfg.enable {
    shelf.home.packages = [
      kvThemePkg
    ];

    shelf.home.configFile."Kvantum/kvantum.kvconfig".text = ''
      [General]
      theme=${kvThemeName}
    '';

    shelf.home.configFile."Kvantum/${kvThemeName}".source = "${kvThemePkg}/share/Kvantum/${kvThemeName}";
  };
}
