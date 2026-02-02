{
  config,
  pkgs,
  lib,
  defaults,
  ...
}:
with lib;
with lib.shelf; let
  cfg = config.shelf.desktop.addons.stasis;
in {
  options.shelf.desktop.addons.stasis = {
    enable = mkBoolOpt false "Whether to enable stasis idle manager.";
  };

  config = mkIf cfg.enable {
    shelf.home.packages = with pkgs; [
      stasis
      libinput # Stasis needs this library to detect user input (also add `ìnput` group to the user).
      playerctl # For enhanced media player detection.
      pulseaudio # `ignore_remote_media true` config needs `pactl` command to detect local media.
    ];

    shelf.home.extraOptions.systemd.user.services.stasis = {
      Unit = {
        Description = "Stasis Wayland Idle Manager";
        PartOf = [ "graphical-session.target" ];
        After = [ "graphical-session.target" ];
        ConditionEnvironment = "WAYLAND_DISPLAY";
      };

      Service = {
        Type = "simple";
        ExecStart = "${pkgs.stasis}/bin/stasis";
        Restart = "on-failure";
      };

      Install = {
        WantedBy = [ "graphical-session.target" ];
      };
    };

    shelf.home.configFile."stasis/stasis.rune".source = "${defaults.configFolder}/stasis/stasis.rune";
  };
}
