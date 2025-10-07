{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.shelf; let
  tuigreet = "${pkgs.tuigreet}/bin/tuigreet";
  hyprland-uwsm = "${lib.getExe config.programs.uwsm.package} start hyprland-uwsm.desktop";

  cfg = config.shelf.desktop.addons.greetd;
in {
  options.shelf.desktop.addons.greetd = {
    enable = mkBoolOpt false "Whether to enable greetd.";
  };

  config = mkIf cfg.enable {
    services.greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${tuigreet} --time --remember --remember-session --asterisks --cmd \"${hyprland-uwsm}\"";
          user = "greeter";
        };
      };
    };

    systemd.services.greetd.serviceConfig = {
      Type = "idle";
      StandardInput = "tty";
      StandardOutput = "tty";
      StandardError= "journal";
      TTYReset = true;
      TTYVHangup = true;
      TTYVTDisallocate = true;
    };
  };
}
