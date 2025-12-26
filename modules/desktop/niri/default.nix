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

  niriPkg = inputs.niri.packages.${pkgs.stdenv.hostPlatform.system}.niri;
in {
  options.shelf.desktop.niri = {
    enable = mkBoolOpt false "Whether to enable Niri WM, with desktop addons.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [ niriPkg ];

    security.polkit.enable = true;

    services = {
      displayManager.sessionPackages = [ niriPkg ];
      gnome.gnome-keyring.enable = true;
      upower.enable = true;
    };

    systemd.packages = [ niriPkg ];

    xdg.portal = {
      enable = true;
      xdgOpenUsePortal = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-gnome
        xdg-desktop-portal-gtk
      ];
      config.niri = {
        default = [ "gnome" "gtk" ];
        "org.freedesktop.impl.portal.Access" = [ "gtk" ];
        "org.freedesktop.impl.portal.FileChooser" = [ "gtk" ];
        "org.freedesktop.impl.portal.Notification" = [ "gtk" ];
        "org.freedesktop.impl.portal.Secret" = [ "gnome-keyring" ];
      };
    };

    shelf.home.extraOptions.systemd.user.services.polkit-gnome-authentication-agent-1 = {
      Unit = {
        Description = "polkit-gnome-authentication-agent-1";
        After = [ "graphical-session.target" ];
        Wants = [ "graphical-session.target" ];
      };

      Service = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };

      Install = {
        WantedBy = [ "graphical-session.target" ];
      };
    };

    shelf.home.packages = with pkgs; [
      xwayland-satellite
      wl-clipboard
      cliphist
      brightnessctl
      playerctl
    ];

    shelf.desktop.addons = {
      ly = enabled;
      awww = enabled;
      stasis = enabled;
      flatpak = enabled;
      gtk = enabled;
    };

    shelf.cli = {
      packages = enabled;      
      oh-my-posh = enabled;
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
    shelf.home.configFile."niri/device.kdl".source = "${defaults.configFolder}/niri/devices/device_${defaults.hostName}.kdl";
    shelf.home.configFile."niri/theme.kdl".source = "${defaults.configFolder}/niri/color-scheme-variants/${defaults.colorSchemeVariant}.kdl";
  };
}
