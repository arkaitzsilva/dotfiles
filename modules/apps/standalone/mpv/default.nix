{
  config,
  pkgs,
  lib,
  defaults,
  ...
}:
with lib;
with lib.shelf; let
  cfg = config.shelf.apps.standalone.mpv;
in {
  options.shelf.apps.standalone.mpv = {
    enable = mkBoolOpt false "Whether to enable mpv player.";
  };

  config = mkIf cfg.enable {
    shelf.home.packages = with pkgs; [
      mpv
      ffmpeg
      yt-dlp
    ];

    shelf.home.configFile."mpv/mpv.conf".source = "${defaults.configFolder}/mpv/${defaults.hostName}-mpv.conf";
  };
}
