{
  config,
  pkgs,
  lib,
  inputs,
  options,
  default,
  hostName,
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
      wofi      
      inputs.hyprfocus.packages.${pkgs.system}.hyprfocus
      inputs.swww.packages.${pkgs.system}.swww
    ];

    programs.hyprland.enable = true;

    shelf.desktop.addons = {
      greetd = enabled;
      foot = enabled;
      gtk = enabled;
      thunar = enabled;
      matugen = enabled;      
    };

    shelf.cli = {
      utils = enabled;      
    };

    shelf.apps = {
      browsers = {
        brave = enabled;
        opera = enabled;
      };      
      standalone = enabled;
      gtk = enabled;
    };

    shelf.home.configFile."hypr/hyprland.conf".source = default.configFolder + /hypr/hyprland.conf;
    shelf.home.configFile."hypr/keybindings.conf".source = default.configFolder + /hypr/keybindings.conf;
    shelf.home.configFile."hypr/wallpapers".source = default.configFolder + /hypr/wallpapers/768p;
  };
  
}
