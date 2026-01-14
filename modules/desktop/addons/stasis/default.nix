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
  cfg = config.shelf.desktop.addons.stasis;

  stasisPkg = inputs.stasis.packages.${pkgs.stdenv.hostPlatform.system}.stasis;
in {
  options.shelf.desktop.addons.stasis = {
    enable = mkBoolOpt false "Whether to enable stasis idle manager.";
  };

  config = mkIf cfg.enable {
    shelf.home.packages = with pkgs; [
      stasisPkg
      libinput # Stasis needs this library to detect user input (also add `ìnput` group to the user).
      playerctl # For enhanced media player detection.
      pulseaudio # `ignore_remote_media true` config needs `pactl` command to detect local media.
    ];

    shelf.home.extraOptions.systemd.user.services.stasis = {
      Unit = {
        Description = "Stasis Wayland Idle Manager";
        Requires = [ "niri.service" ];
        After = [ "niri.service" ];
      };

      Service = {
        Type = "simple";
        ExecStart = "${stasisPkg}/bin/stasis";
        Restart = "on-failure";
        RestartSec = 1;
      };

      Install = {
        WantedBy = [ "niri.service" ];
      };
    };

    shelf.home.configFile."stasis/stasis.rune".source = "${defaults.configFolder}/stasis/stasis.rune";
  };
}
