{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.shelf; let
  tuigreet = "${pkgs.tuigreet}/bin/tuigreet";
  niri-session = "${pkgs.niri}/share/wayland-sessions";

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
          command = "${tuigreet} --time --remember --remember-session --asterisks --sessions ${niri-session}";
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
