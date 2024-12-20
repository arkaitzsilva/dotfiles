{
  config,
  pkgs,
  lib,
  inputs,
  options,
  default,
  ...
}:
with lib;
with lib.shelf; let
  cfg = config.shelf.desktop.hyprland;
in {
  options.shelf.desktop.hyprland = {
    enable = mkBoolOpt false "Whether to enable Hyprland, with other desktop addons.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      hyprpicker
      cliphist
      brightnessctl
      playerctl
      slurp
      wayshot
      swappy
      wl-clipboard
      inputs.swww.packages.${pkgs.system}.swww
    ];

    services = {
      tumbler.enable = true;
    };

    programs.hyprland.enable = true;

    shelf.desktop.addons = {
      greetd = enabled;
      foot = enabled;
      gtk = enabled;
      wofi = enabled;
      thunar = enabled; 
      dunst = enabled;
    };

    shelf.cli = {
      utils = enabled;      
    };

    shelf.apps = {
      browsers = {
        firefox = enabled;
        brave = enabled;
        opera = enabled;
      };      
      standalone = enabled;
      gtk = {
        basics = enabled;
        gedit = enabled;
      };
    };

    shelf.home.configFile."hypr/colors.conf".source = "${default.configFolder}/hypr/colors.conf";
    shelf.home.configFile."hypr/keybindings.conf".source = "${default.configFolder}/hypr/keybindings.conf";
    shelf.home.configFile."hypr/wallpapers".source = "${default.configFolder}/hypr/wallpapers/${default.wallpaperResolution}";
    shelf.home.configFile."hypr/scripts".source = "${default.configFolder}/hypr/scripts";

    shelf.home.extraOptions.wayland.windowManager.hyprland = {
      enable = true;
      plugins = [
        inputs.hyprfocus.packages.${pkgs.system}.hyprfocus
      ];
      extraConfig = ''
        ${builtins.readFile "${default.configFolder}/hypr/hyprland.conf"}
      '';
    };
  };
}
