{
  config,
  pkgs,
  lib,
  inputs,
  options,
  defaults,
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
      
      inputs.swww.packages.${pkgs.system}.default
      inputs.hyprland-qtutils.packages.${pkgs.system}.default
      inputs.quickshell.packages.${pkgs.system}.default
    ];

    programs.hyprland.enable = true;

    shelf.desktop.addons = {
      greetd = enabled;
      gtk = enabled;
      foot = enabled;
      thunar = enabled;
      wlogout = enabled;
      hyprlock = enabled;
      hypridle = enabled;
      hyprshell = enabled;
    };

    shelf.cli = {
      packages = enabled;      
    };

    shelf.apps = {
      browsers = {
        firefox = enabled;
        brave = enabled;
        opera = enabled;
        google-chrome = enabled;
        qutebrowser = enabled;
      };      
      standalone = {
        packages = enabled;
        neovim = enabled;
        ranger = enabled;
      };
      gtk = {
        packages = enabled;
        gedit = enabled;
        discord = enabled;
        virt-manager = enabled;
      };
      qt = {
        obs-studio = enabled;
      };
    };

    shelf.home.dataFile."backgrounds".source = "${defaults.dataFolder}/backgrounds/${defaults.wallpaperResolution}";

    shelf.home.configFile."hypr/hyprland.conf".source = "${defaults.configFolder}/hypr/hyprland.conf";
    shelf.home.configFile."hypr/keybindings.conf".source = "${defaults.configFolder}/hypr/keybindings.conf";
    shelf.home.configFile."hypr/colors.conf".source = "${defaults.configFolder}/hypr/color-scheme-variants/${defaults.colorSchemeVariant}.conf";
    shelf.home.configFile."hypr/device.conf".source = "${defaults.configFolder}/hypr/devices/${defaults.hostName}.conf";
    #shelf.home.configFile."hypr/scripts".source = "${defaults.configFolder}/hypr/scripts";

    # shelf.home.extraOptions.wayland.windowManager.hyprland = {
    #   enable = true;
    #   plugins = [
    #     inputs.hyprfocus.packages.${pkgs.system}.hyprfocus
    #   ];
    #   extraConfig = ''
    #     ${builtins.readFile "${defaults.configFolder}/hypr/hyprland.conf"}
    #   '';
    # };
  };
}
