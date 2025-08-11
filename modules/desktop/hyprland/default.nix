{
  config,
  pkgs,
  lib,
  defaults,
  ...
}:
with lib; with lib.shelf; let
  cfg = config.shelf.desktop.hyprland;

  hypr-plugin-dir = pkgs.symlinkJoin {
    name = "hyprland-plugins";
    paths = with pkgs.hyprlandPlugins; [
      hyprfocus
    ];
  };
in {
  options.shelf.desktop.hyprland = {
    enable = mkBoolOpt false "Whether to enable Hyprland, with other desktop addons.";
  };

  config = mkIf cfg.enable {
    environment.sessionVariables = {
      HYPR_PLUGIN_DIR = hypr-plugin-dir;
    };

    programs.hyprland.enable = true;

    shelf.home.packages = with pkgs; [
      wl-clipboard
      cliphist
      brightnessctl
      playerctl
    ];

    shelf.desktop.addons = {
      greetd = enabled;
      swww = enabled;
      theme = enabled;
      qt = enabled;
      quickshell = enabled;
    };

    shelf.cli = {
      packages = enabled;      
    };

    shelf.apps = {    
      standalone = {
        packages = enabled;
        foot = enabled;
        yazi = enabled;
        helix = enabled;
        mpv = enabled;
      };

      qt = {
        packages = enabled;
        obs-studio = enabled;
      };

      browsers = {
        qutebrowser = enabled;
      };
    };

    shelf.home.configFile."hypr/hyprland.conf".source = "${defaults.configFolder}/hypr/hyprland.conf";
    shelf.home.configFile."hypr/keybindings.conf".source = "${defaults.configFolder}/hypr/keybindings.conf";
    shelf.home.configFile."hypr/device.conf".source = "${defaults.configFolder}/hypr/devices/${defaults.hostName}.conf";
    shelf.home.configFile."hypr/theme.conf".source = "${defaults.configFolder}/hypr/color-scheme-variants/${defaults.colorSchemeVariant}.conf";
  };
}
