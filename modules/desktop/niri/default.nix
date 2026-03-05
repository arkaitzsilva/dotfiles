{
  config,
  pkgs,
  lib,
  inputs,
  defaults,
  ...
}:
with lib; with lib.shelf; let
  cfg = config.shelf.desktop.niri;

  niriPkg = inputs.niri.packages.${pkgs.stdenv.hostPlatform.system}.niri;
in {
  options.shelf.desktop.niri = {
    enable = mkBoolOpt false "Whether to enable Niri WM, with desktop addons.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [ niriPkg ];

    services = {
      displayManager.sessionPackages = [ niriPkg ];
      upower.enable = true;
    };

    systemd.packages = [ niriPkg ];

    shelf.home.packages = with pkgs; [
      xwayland-satellite
      wl-clipboard
      cliphist
      brightnessctl
      playerctl
    ];

    shelf.desktop.addons = {
      ly = enabled;
      xdg-desktop-portal = enabled;
      awww = enabled;
      stasis = enabled;
      flatpak = enabled;
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

    shelf.home.configFile."niri/config.kdl".source = "${defaults.configFolder}/niri/config.kdl";

    shelf.home.configFile."niri/animations.kdl".source = "${defaults.configFolder}/niri/animations.kdl";
    shelf.home.configFile."niri/outputs.kdl".source = "${defaults.configFolder}/niri/devices/outputs_${defaults.hostName}.kdl";
    shelf.home.configFile."niri/keybindings.kdl".source = "${defaults.configFolder}/niri/keybindings.kdl";
    shelf.home.configFile."niri/theme.kdl".source = "${defaults.configFolder}/niri/color-scheme-variants/${defaults.colorSchemeVariant}.kdl";
  };
}
