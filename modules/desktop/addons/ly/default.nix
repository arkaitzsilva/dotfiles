{
  config,
  pkgs,
  lib,
  defaults,
  ...
}:

with lib;
with lib.shelf;

let
  cfg = config.shelf.desktop.addons.ly;

  lyPkg = pkgs.ly.overrideAttrs (old: {
    postInstall = (old.postInstall or "") + ''
      mkdir -p $out/etc/ly/lang
      cp -v res/lang/*.ini $out/etc/ly/lang/
    '';
  });
in
{
  options.shelf.desktop.addons.ly = {
    enable = mkBoolOpt false "Whether to enable ly.";
  };

  config = mkIf cfg.enable {
    environment.etc."ly/lang".source = "${lyPkg}/etc/ly/lang";
   
    services.displayManager = {
      ly = {
        enable = true;
        package = lyPkg;
        settings = {
          animation = "matrix";
          cmatrix_min_codepoint = "0x30";
          cmatrix_max_codepoint = "0x32";
          brightness_down_key = null;
          brightness_up_key = null;
          lang = "es";
          hide_version_string = true;
        };
        x11Support = false;
      };
    };
  };
}
