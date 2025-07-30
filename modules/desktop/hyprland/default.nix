{
  config,
  pkgs,
  lib,
  inputs,
  options,
  defaults,
  ...
}:
with lib; with lib.shelf; let
  cfg = config.shelf.desktop.hyprland;

  hyprPluginPkgs = inputs.hyprland-plugins.packages.${pkgs.system};
  hypr-plugin-dir = pkgs.symlinkJoin {
    name = "hyprland-plugins";
    paths = with hyprPluginPkgs; [
      hyprfocus
    ];
  };
in {
  options.shelf.desktop.hyprland = {
    enable = mkBoolOpt false "Whether to enable Hyprland, with other desktop addons.";
  };

  config = mkIf cfg.enable {
    environment = {
      sessionVariables = {
        #HYPR_PLUGIN_DIR = toString hypr-plugin-dir;
        #HYPR_PLUGIN_DIR = "${pkgs.hyprlandPlugins.hyprfocus}/lib/hyprland/plugins";
      };

      systemPackages = with pkgs; [
        hyprlandPlugins.hyprfocus
 
        wl-clipboard
        cliphist
        brightnessctl

        inputs.swww.packages.${pkgs.system}.default
      ];
    };

    programs.hyprland.enable = true;

    shelf.desktop.addons = {
      greetd = enabled;
      theme = enabled;
      qt = enabled;
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
    
    shelf.home.dataFile."wallpapers".source = "${defaults.dataFolder}/wallpapers/${defaults.wallpaperResolution}";
  };
}
