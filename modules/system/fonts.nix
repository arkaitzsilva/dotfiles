{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.shelf; let
  aggregated = if config.shelf.desktop.addons.flatpak.enable then pkgs.buildEnv {
    name = "system-fonts";
    paths = config.fonts.packages;
    pathsToLink = [ "/share/fonts" ];
  } else null;
in {  
  options.fonts.defaultFontPkg = mkOption {
    type = types.package;
    readOnly = true;
    description = "Default font package selected by the fonts module, available for other modules.";
  };

  config = {
    fonts.defaultFontPkg = pkgs.noto-fonts;

    fileSystems = lib.mkMerge [
      (if config.shelf.desktop.addons.flatpak.enable then
        { "/usr/share/fonts" = lib.shelf.mkRoSymBind "${aggregated}/share/fonts"; }
      else
        {})
    ];

    fonts = {
      packages = with pkgs; [
        noto-fonts
        noto-fonts-cjk-sans
        noto-fonts-color-emoji
        noto-fonts-monochrome-emoji
      ];

      fontconfig = {
        enable = true;

        defaultFonts = {
          sansSerif = [ "Noto Sans" ];
          serif     = [ "Noto Serif" ];
          monospace = [ "Noto Mono" ];
          emoji     = [ "Noto Color Emoji" ];
        };
      };
    };
  };
}
