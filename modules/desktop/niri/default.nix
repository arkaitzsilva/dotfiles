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
in {
  options.shelf.desktop.niri = {
    enable = mkBoolOpt false "Whether to enable Niri WM, with other desktop addons.";
  };

  config = mkIf cfg.enable {
    services.upower.enable = true;

    programs.niri = {
      enable = true;
      package = # inputs.niri.packages.${pkgs.stdenv.hostPlatform.system}.default;
        inputs.niri.packages.${pkgs.stdenv.hostPlatform.system}.default.overrideAttrs (old: {
          # To avoid tests failure
          preCheck = ''
            export XDG_RUNTIME_DIR="$(mktemp -d)"
            ulimit -n 4096
          '';
        });
    };

    shelf.home.packages = with pkgs; [
      xwayland-satellite
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
      };
    };

    shelf.home.configFile."niri/config.kdl".source = "${defaults.configFolder}/niri/config.kdl";
    shelf.home.configFile."niri/keybindings.kdl".source = "${defaults.configFolder}/niri/keybindings.kdl";
    shelf.home.configFile."niri/device.kdl".source = "${defaults.configFolder}/niri/devices/${defaults.hostName}.kdl";
    shelf.home.configFile."niri/theme.kdl".source = "${defaults.configFolder}/niri/color-scheme-variants/${defaults.colorSchemeVariant}.kdl";
  };
}
