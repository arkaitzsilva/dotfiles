{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.shelf; let
  cfg = config.shelf.apps.browsers.opera;
in {
  options.shelf.apps.browsers.opera = {
    enable = mkBoolOpt false "Whether to enable opera browser.";
  };

  config = mkIf cfg.enable {
    nixpkgs.overlays = [
      (final: prev: {
        opera = prev.opera.overrideAttrs (oldAttrs: {
          postFixup = (oldAttrs.postFixup or "") + ''
            wrapProgram $out/bin/opera \
              --add-flags "--lang=es"
          '';
        });
      })
    ];

    environment.systemPackages = with pkgs; [
      opera
    ];
  };
}
