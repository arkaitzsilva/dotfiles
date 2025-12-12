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
      pulseaudio # `ignore_remote_media true` config needs `pactl` command to detect local media.
    ];

    shelf.home.extraOptions.systemd.user.services.stasis = {
      Unit = {
        Description = "Stasis Wayland Idle Manager";
        After = [ "graphical-session.target" ];
        Wants = [ "graphical-session.target" ];
      };

      Service = {
        Type = "simple";
        ExecStart = "${stasisPkg}/bin/stasis";
        Restart = "always";
        RestartSec = 5;
        Environment = [];
      };

      Install = {
        WantedBy = [ "default.target" ];
      };
    };

    shelf.home.configFile."stasis/stasis.rune".source = "${defaults.configFolder}/stasis/stasis.rune";
  };
}
