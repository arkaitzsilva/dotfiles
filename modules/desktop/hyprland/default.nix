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

  hyprlandPkg = inputs.hyprnix.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
in {
  options.shelf.desktop.hyprland = {
    enable = mkBoolOpt false "Whether to enable Hyprland WM, with desktop addons.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [
      hyprlandPkg
    ];

    programs.uwsm.enable = true;

    services.displayManager.sessionPackages = [
      hyprlandPkg
    ];
  
    shelf.home.packages = with pkgs; [
      inputs.hyprnix.packages.${pkgs.stdenv.hostPlatform.system}.hyprpicker

      wl-clipboard
      cliphist
      brightnessctl
      playerctl
    ];

    shelf.desktop.addons = {
      ly = enabled;
      stasis = enabled;
      awww = enabled;
      xdg-desktop-portal = enabled;
      flatpak = enabled;
      quickshell = enabled;
      qt = enabled;
      theme = enabled;
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
        btop = enabled;
      };
    };

    shelf.home.configFile."hypr/hyprland.conf".source = "${defaults.configFolder}/hypr/hyprland.conf";
    shelf.home.configFile."hypr/keybindings.conf".source = "${defaults.configFolder}/hypr/keybindings.conf";
    shelf.home.configFile."hypr/monitors.conf".source = "${defaults.configFolder}/hypr/devices/monitors_${defaults.hostName}.conf";
    shelf.home.configFile."hypr/theme.conf".source = "${defaults.configFolder}/hypr/color-scheme-variants/${defaults.colorSchemeVariant}.conf";
  };
}
