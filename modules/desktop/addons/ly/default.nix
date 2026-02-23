{
  config,
  pkgs,
  lib,
  ...
}:

with lib;
with lib.shelf;

let
  cfg = config.shelf.desktop.addons.ly;
in
{
  options.shelf.desktop.addons.ly = {
    enable = mkBoolOpt false "Whether to enable Ly display manager.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      brightnessctl
    ];

    # Workarount to start Hyprland (uwsm-managed) with Ly on NixOS
    systemd.services."display-manager".environment = {
      XDG_CURRENT_DESKTOP = "X-NIXOS-SYSTEMD-AWARE";
    };
    
    environment.etc = {
      "ly/lang".source = "${pkgs.ly}/etc/ly/lang";
    };
  
    services.displayManager = {
      ly = {
        enable = true;
        settings = {
          save = true;
          allow_empty_password = false;
          animation = "matrix";
          cmatrix_min_codepoint = "0x30";
          cmatrix_max_codepoint = "0x32";
          brightness_down_key = "F5";
          # brightness_down_cmd = "${pkgs.brightnessctl}/bin/brightnessctl -q -n s 10%-";
          brightness_up_key = "F6";
          # brightness_up_cmd = "${pkgs.brightnessctl}/bin/brightnessctl -q -n s 10%+";
          lang = "es";
          hide_version_string = true;
          xsessions = "";
        };
        x11Support = false;
      };
    };
  };
}
