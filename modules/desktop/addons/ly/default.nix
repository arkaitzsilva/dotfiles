{ config, pkgs, lib, ... }:

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
    environment.etc."ly/lang".source = "${lyPkg}/etc/ly/lang";
    
    services.displayManager.ly = {
      enable = true;
      package = lyPkg;
      settings = {
        animation = "matrix";
        brightness_down_key = null;
        brightness_up_key = null;
        bigclock = "en"; # TODO: Hora no sale bien de inicio, al de 30 segundos se actualiza.
        lang = "es";
        battery_id = "BAT1";
        hide_version_string = true;
      };
    };
  };
}
