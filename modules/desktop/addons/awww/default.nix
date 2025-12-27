{
  config,
  pkgs,
  lib,
  defaults,
  inputs,
  ...
}:
with lib;
with lib.shelf; let
  cfg = config.shelf.desktop.addons.awww;
in {
  options.shelf.desktop.addons.awww = with types; {
    enable = mkBoolOpt false "Whether to enable awww.";
  };

  config = mkIf cfg.enable {
    shelf.home.packages = with pkgs; [
      inputs.awww.packages.${stdenv.hostPlatform.system}.awww
    ];

    shelf.home.sessionVariables = {
      AWWW_TRANSITION = "wave";
      AWWW_TRANSITION_FPS = 60;
      AWWW_TRANSITION_STEP = 50;
    };

    shelf.home.dataFile."backgrounds".source = "${defaults.dataFolder}/backgrounds/${defaults.wallpaperResolution}";
  };
}
