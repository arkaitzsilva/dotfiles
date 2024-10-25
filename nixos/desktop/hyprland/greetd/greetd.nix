{ pkgs, ... }: let
  tuigreet = "${pkgs.greetd.tuigreet}/bin/tuigreet";
  hyprland-session = "${pkgs.hyprland}/share/wayland-sessions";
in {
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${tuigreet} --time --remember --remember-session --sessions ${hyprland-session} --asterisks";
        user = "greeter";
      };
    };
  };

  systemd.services.greetd = {
    serviceConfig.Type = "idle";
  };
}
