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
    environment.sessionVariables = {
      HYPR_PLUGIN_DIR = hypr-plugin-dir;
    };

    programs.hyprland = {
      enable = true;
      package = inputs.hyprland.packages.${pkgs.system}.hyprland;
      portalPackage = inputs.hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland;
    };

    shelf.home.packages = with pkgs; [
      wl-clipboard
      cliphist
      brightnessctl
      playerctl
    ];

    shelf.desktop.addons = {
      greetd = enabled;
      hyprqt6engine = enabled;
      swww = enabled;
    };

    shelf.cli = {
      packages = enabled;      
    };

    shelf.apps = {    
      standalone = {
        packages = enabled;
        foot = enabled;
        mpv = enabled;
      };
    };

    shelf.home.configFile."hypr/hyprland.conf".source = "${defaults.configFolder}/hypr/hyprland.conf";
    shelf.home.configFile."hypr/keybindings.conf".source = "${defaults.configFolder}/hypr/keybindings.conf";
    shelf.home.configFile."hypr/device.conf".source = "${defaults.configFolder}/hypr/devices/${defaults.hostName}.conf";
    shelf.home.configFile."hypr/theme.conf".source = "${defaults.configFolder}/hypr/color-scheme-variants/${defaults.colorSchemeVariant}.conf";
  };
}
