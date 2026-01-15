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

  hyprlandPkg = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;

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
      hyprlandPkg
      # uwsm
    ];

    programs.uwsm.enable = true;

    services.displayManager.sessionPackages = [
      hyprlandPkg
    ];

    # Workarount to start Hyprland (uwsm-managed) with Ly on NixOS
    systemd.services."display-manager".environment = {
      XDG_CURRENT_DESKTOP = "X-NIXOS-SYSTEMD-AWARE";
    };
  
    shelf.home.sessionVariables = {
      HYPR_PLUGIN_DIR = hypr-plugin-dir;
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
      auto-cpufreq = enabled;
      stasis = enabled;
      awww = enabled;
      xdg-desktop-portal = enabled;
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
    shelf.home.configFile."hypr/monitors.conf".source = "${defaults.configFolder}/hypr/devices/monitors_${defaults.hostName}.conf";
    shelf.home.configFile."hypr/theme.conf".source = "${defaults.configFolder}/hypr/color-scheme-variants/${defaults.colorSchemeVariant}.conf";
  };
}
