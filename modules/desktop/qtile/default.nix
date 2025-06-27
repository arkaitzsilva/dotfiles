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
  cfg = config.shelf.desktop.qtile;
in {
  options.shelf.desktop.qtile = {
    enable = mkBoolOpt false "Whether to enable Qtile WM, with other desktop addons.";
  };

  config = mkIf cfg.enable {
    environment = {
      systemPackages = with pkgs; [
        brightnessctl
        playerctl
        inputs.swww.packages.${pkgs.system}.swww
      ];
      variables = {
        XKB_DEFAULT_LAYOUT = "es";
      };
    };

    services.xserver.windowManager.qtile = {
      enable = true;
      package = inputs.qtile.${pkgs.system}.default;
      extraPackages = python3Packages: with python3Packages; [
        qtile-extras
      ];
    };

    shelf.desktop.addons = {
      sddm = enabled;
      foot = enabled;
      neovim = enabled;
      qutebrowser = enabled;
      ranger = enabled;
    };

    shelf.cli = {
      packages = enabled;
    };

    shelf.apps = {
      standalone = enabled;
    };

    shelf.home.dataFile."backgrounds".source = "${defaults.dataFolder}/backgrounds/${defaults.wallpaperResolution}";
    shelf.home.configFile."qtile".source = "${defaults.configFolder}/qtile";
    #shelf.home.configFile."qtile/config.py".source = "${defaults.configFolder}/qtile/config.py";
  };
}
