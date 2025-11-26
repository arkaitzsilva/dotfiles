{ config, pkgs, lib, ... }:

with lib;
with lib.shelf;

let
  brightnessctl-bin = "${pkgs.brightnessctl}/bin/brightnessctl";

  ly-fixed = pkgs.ly.overrideAttrs (old: {
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
    environment.etc."ly/lang".source = "${ly-fixed}/etc/ly/lang";
    
    services.displayManager.ly = {
      enable = true;
      package = ly-fixed;
      settings = {
        animation = "matrix";
        brightness_down_cmd = "${brightnessctl-bin} -q -n s 10%-";
        brightness_up_cmd = "${brightnessctl-bin} -q -n s +10%";
        bigclock = "en";
        lang = "es";
        battery_id = "BAT1";
      };
    };
  };
}
