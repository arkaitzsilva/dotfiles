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
      inputs.swww.packages.${pkgs.system}.swww
      inputs.hyprland-qtutils.packages.${pkgs.system}.default
    ];

    programs.hyprland.enable = true;

    shelf.desktop.addons = {
      greetd = enabled;
      foot = enabled;
      ranger = enabled;
    };

    shelf.cli = {
      packages = enabled;      
    };

    shelf.apps = {    
      standalone = enabled;
      qt = {
        obs-studio = enabled;
      };
    };

    shelf.home.configFile."hypr/hyprland.conf".source = "${default.configFolder}/hypr/hyprland.conf";
    shelf.home.configFile."hypr/keybindings.conf".source = "${default.configFolder}/hypr/keybindings.conf";
    shelf.home.configFile."hypr/wallpapers".source = "${default.configFolder}/hypr/wallpapers/${default.wallpaperResolution}";
  };
}
