{
  config,
  pkgs,
  lib,
  inputs,
  defaults,
  ...
}:
with lib; with lib.shelf; let
  cfg = config.shelf.desktop.hyprland;

  hyprlandPkg = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.default;

  hyprPluginPkgs = inputs.hyprland-plugins.packages.${pkgs.stdenv.hostPlatform.system};
  hypr-plugin-dir = pkgs.symlinkJoin {
    name = "hyrpland-plugins";
    paths = with hyprPluginPkgs; [
      hyprfocus
    ];
  };
in {
  options.shelf.desktop.hyprland = {
    enable = mkBoolOpt false "Whether to enable Hyprland WM, with desktop addons.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      inputs.hyprland.packages.${stdenv.hostPlatform.system}.default
    ];

    environment.sessionVariables = { HYPR_PLUGIN_DIR = hypr-plugin-dir; };

    security.polkit.enable = true;

    programs.uwsm = mkIf defaults.withUWSM {
      enable = true;
      waylandCompositors = {
        hyprland = {
          prettyName = "Hyprland";
          comment = "Hyprland compositor managed by UWSM";
          binPath = "/run/current-system/sw/bin/hyprland";
        };
      };
    };

    services.displayManager.sessionPackages = mkIf (!defaults.withUWSM) [
      hyprlandPkg
    ];

    xdg.portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
        xdg-desktop-portal-wlr
      ];
      config.hyprland = {
        default = [ "wlr" "gtk" ];
        "org.freedesktop.impl.portal.FileChooser" = [ "gtk" ];
        "org.freedesktop.impl.portal.Notification" = [ "gtk" ];
        "org.freedesktop.impl.portal.Secret" = [ "gnome-keyring" ];
      };

    };
 
    shelf.home.packages = with pkgs; [
      hyprpicker
      xwayland
      wl-clipboard
      cliphist
      brightnessctl
      playerctl
    ];

    shelf.desktop.addons = {
      ly = enabled;
      awww = enabled;
      stasis = enabled;
      flatpak = enabled;
      gtk = enabled;
    };

    shelf.cli = {
      packages = enabled;      
      oh-my-posh = enabled;
    };

    shelf.apps = {    
      standalone = {
        packages = enabled;
        foot = enabled;
        mpv = enabled;
        yazi = enabled;
        helix = enabled;
      };
    };

    shelf.home.configFile."hypr/hyprland.conf".source = "${defaults.configFolder}/hypr/hyprland.conf";
    shelf.home.configFile."hypr/keybindings.conf".source = "${defaults.configFolder}/hypr/keybindings.conf";
    shelf.home.configFile."hypr/device.conf".source = "${defaults.configFolder}/hypr/devices/device_${defaults.hostName}.conf";
    shelf.home.configFile."hypr/theme.conf".source = "${defaults.configFolder}/hypr/color-scheme-variants/${defaults.colorSchemeVariant}.conf";
  };
}
