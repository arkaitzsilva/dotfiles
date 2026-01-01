{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.shelf; let
  aggregated = pkgs.buildEnv {
    name = "system-fonts";
    paths = config.fonts.packages;
    pathsToLink = [
      "/share/fonts"
    ];
  };
in {  
  options.fonts.defaultFontPkg = mkOption {
    type = types.package;
    readOnly = true;
    description = "Main font package selected by the fonts module, available for other modules.";
  };

  config = {
    fonts.defaultFontPkg = pkgs.noto-fonts;

    fileSystems."/usr/share/fonts" = lib.shelf.mkRoSymBind "${aggregated}/share/fonts";

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
