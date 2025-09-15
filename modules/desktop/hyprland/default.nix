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
  hyprPluginPkgs = inputs.hyprland-plugins.packages.${pkgs.stdenv.hostPlatform.system};
in {
  options.shelf.desktop.hyprland = {
    enable = mkBoolOpt false "Whether to enable Hyprland, with other desktop addons.";
  };

  config = mkIf cfg.enable {
    programs.hyprland.enable = true;

    shelf.home.extraOptions.wayland.windowManager.hyprland = {
      enable = true;
      package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
      plugins = with hyprPluginPkgs; [
        hyprfocus
      ];
      extraConfig = ''
        ${builtins.readFile "${defaults.configFolder}/hypr/hyprland.conf"}
      '';
    };

    shelf.home.packages = with pkgs; [
      wl-clipboard
      cliphist
      brightnessctl
      playerctl
    ];

    shelf.desktop.addons = {
      greetd = enabled;
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
        yazi = enabled;
        helix = enabled;
        zellij = disabled;
      };
    };

    shelf.home.configFile."hypr/keybindings.conf".source = "${defaults.configFolder}/hypr/keybindings.conf";
    shelf.home.configFile."hypr/device.conf".source = "${defaults.configFolder}/hypr/devices/${defaults.hostName}.conf";
    shelf.home.configFile."hypr/theme.conf".source = "${defaults.configFolder}/hypr/color-scheme-variants/${defaults.colorSchemeVariant}.conf";
  };
}
