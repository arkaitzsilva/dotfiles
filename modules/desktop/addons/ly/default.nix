{
  config,
  pkgs,
  lib,
  ...
}:

with lib;
with lib.shelf;

let
  lyPkg = pkgs.ly.overrideAttrs (old: {
    postInstall = (old.postInstall or "") + ''
      mkdir -p $out/etc/ly/lang
      cp -v res/lang/*.ini $out/etc/ly/lang/
    '';
  });

  cfg = config.shelf.desktop.addons.ly;
in
{
  options.shelf.desktop.addons.ly = {
    enable = mkBoolOpt false "Whether to enable ly.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      brightnessctl
    ];
    
    environment.etc."ly/lang".source = "${lyPkg}/etc/ly/lang";
   
    services.displayManager = {
      ly = {
        enable = true;
        package = lyPkg;
        settings = {
          save = true;
          allow_empty_password = false;
          animation = "matrix";
          cmatrix_min_codepoint = "0x30";
          cmatrix_max_codepoint = "0x32";
          brightness_down_key = "F5";
          brightness_down_cmd = "${pkgs.brightnessctl}/bin/brightnessctl -q -n s 10%-";
          brightness_up_key = "F6";
          brightness_up_cmd = "${pkgs.brightnessctl}/bin/brightnessctl -q -n s 10%+";
          lang = "es";
          hide_version_string = true;
        };
        x11Support = false;
      };
    };
  };
}
